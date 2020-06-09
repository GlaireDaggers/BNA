using System;
using System.Collections;
using BNA.bindings;
using BNA.Math;
using BNA.Utils;

namespace BNA.Audio
{
	public sealed class Audio : IDisposable
	{
		public Vec3 ListenerPosition
		{
			get
			{
				return _position;
			}
			set
			{
				_position = value;
				SoLoud_binding.Soloud_set3dListenerPosition(_handle, value.x, value.y, value.z);
			}
		}

		public Vec3 ListenerForward
		{
			get
			{
				return _fwd;
			}
			set
			{
				_fwd = value;
				SoLoud_binding.Soloud_set3dListenerAt(_handle, value.x, value.y, value.z);
			}
		}

		public Vec3 ListenerUp
		{
			get
			{
				return _up;
			}
			set
			{
				_up = value;
				SoLoud_binding.Soloud_set3dListenerUp(_handle, value.x, value.y, value.z);
			}
		}

		public Vec3 ListenerVelocity
		{
			get
			{
				return _velocity;
			}
			set
			{
				_velocity = value;
				SoLoud_binding.Soloud_set3dListenerVelocity(_handle, value.x, value.y, value.z);
			}
		}

		public float SpeedOfSound
		{
			get
			{
				return SoLoud_binding.Soloud_get3dSoundSpeed(_handle);
			}
			set
			{
				SoLoud_binding.Soloud_set3dSoundSpeed(_handle, value);
			}
		}

		public AudioBus MasterBus => _masterBus;

		private Soloud _handle;

		private Vec3 _position;
		private Vec3 _fwd;
		private Vec3 _up;
		private Vec3 _velocity;

		private List<int32> _voiceGroups = new List<int32>() ~ delete _;

		private AudioBus _masterBus;

		public this()
		{
			_position = Vec3(0f, 0f, 0f);
			_fwd = Vec3(0f, 0f, 1f);
			_up = Vec3(0f, 1f, 0f);
			_velocity = Vec3(0f, 0f, 0f);

			_handle = SoLoud_binding.Soloud_create();
			let result = SoLoud_binding.Soloud_init(_handle);

			if( result != .OK )
			{
				Trace.LogErr("SoLoud init failed! {0}", result);
			}
			else
			{
				Trace.Log("SoLoud initialized");
			}

			_masterBus = new AudioBus(this);
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			if(_masterBus != null)
			{
				delete _masterBus;
				_masterBus = null;
			}

			if(_handle != null)
			{
				SoLoud_binding.Soloud_deinit(_handle);
				SoLoud_binding.Soloud_destroy(_handle);
				_handle = null;
			}
		}

		public void Update()
		{
			SoLoud_binding.Soloud_update3dAudio(_handle);

			// destroy any voice groups that are now empty (the contained voices were stopped)
			for(int i = _voiceGroups.Count - 1; i >= 0; i--)
			{
				if(SoLoud_binding.Soloud_isVoiceGroupEmpty(_handle, (.)_voiceGroups[i]) != 0)
				{
					SoLoud_binding.Soloud_destroyVoiceGroup(_handle, (.)_voiceGroups[i]);
					_voiceGroups.RemoveAt(i);
				}
			}
		}

		public SoundEffectInstance PlaySong(Song song, AudioBus bus = null)
		{
			let targetBus = bus ?? _masterBus;
			let busHandle = targetBus.[Friend]_bus;

			// no intro? just play the loop
			if(song.Intro == null)
			{
				let handle = SoLoud_binding.Bus_play(busHandle, song.Loop.[Friend]_handle);
				SoLoud_binding.Soloud_setLooping(_handle, (.)handle, 1);

				return SoundEffectInstance(this, (.)handle);
			}
			// otherwise create a voice group so we can precisely coordinate the intro & loop clips
			else
			{
				let vg = SoLoud_binding.Soloud_createVoiceGroup(_handle);
				SoLoud_binding.Soloud_setPause(_handle, vg, 1);

				let handle1 = SoLoud_binding.Bus_playEx(busHandle, song.Intro.[Friend]_handle, 1f, 0f, 1);
				let handle2 = SoLoud_binding.Bus_playEx(busHandle, song.Loop.[Friend]_handle, 1f, 0f, 1);

				SoLoud_binding.Soloud_addVoiceToGroup(_handle, (.)vg, (.)handle1);
				SoLoud_binding.Soloud_addVoiceToGroup(_handle, (.)vg, (.)handle2);
				
				SoLoud_binding.Soloud_setLooping(_handle, (.)handle2, 1);

				// SoLoud will read 512 samples at a time from our clip and then resample it into the destination, but it truncates any fractional offset after that block
				// this causes sound to accumulate a time drift error for each 512 block of samples
				// we can calculate this drift exactly, and then compensate for it to make sure the clips line up exactly

				let outputRate = SoLoud_binding.Soloud_getBackendSamplerate(_handle);
				let clipRate = SoLoud_binding.Soloud_getSamplerate(_handle, (.)handle1);

				let ratio = outputRate / (double)clipRate;

				let blockMix = (int)( 512 * ratio ) / ratio; // convert 512 block size, truncate, then convert back to find error
				let errorPerBlock = 512 - blockMix;

				// now we just need to find out how many blocks are in the source data, multiply by error, then convert to output samplerate
				let totalSamples = clipRate * song.Intro.Length;
				let totalBlocks = totalSamples / 512;

				let totalError = (int)( totalBlocks * errorPerBlock );

				let offset = totalError * ratio;

				// PHEW. all that just so we can calculate the correct delay.
				let delay = (uint32)(( outputRate * song.Intro.Length ) - offset);
				SoLoud_binding.Soloud_setDelaySamples(_handle, (.)handle2, (.)delay);

				// keep track of the voice group so if it goes empty later (the clips were stopped), we can destroy it
				_voiceGroups.Add(vg);

				// now unpause the voice group and return it as if it was a single sound effect instance :)
				SoLoud_binding.Soloud_setPause(_handle, vg, 0);

				return SoundEffectInstance(this, vg);
			}
		}

		public SoundEffectInstance Play(SoundEffect cue, AudioBus bus = null)
		{
			let targetBus = bus ?? _masterBus;
			let busHandle = targetBus.[Friend]_bus;

			let handle = SoLoud_binding.Bus_play(busHandle, cue.[Friend]_handle);
			return SoundEffectInstance(this, (.)handle);
		}

		public SoundEffectInstance Play(SoundEffect cue, double delaySeconds, AudioBus bus = null)
		{
			let targetBus = bus ?? _masterBus;
			let busHandle = targetBus.[Friend]_bus;

			let handle = SoLoud_binding.Bus_playEx(busHandle, cue.[Friend]_handle, 1f, 0f, 1);

			let samplerate = SoLoud_binding.Soloud_getBackendSamplerate(_handle);
			SoLoud_binding.Soloud_setDelaySamples(_handle, (.)handle, (.)(samplerate * delaySeconds));

			SoLoud_binding.Soloud_setPause(_handle, (.)handle, 0);

			return SoundEffectInstance(this, (.)handle);
		}

		public SoundEffectInstance Play3D(SoundEffect cue, Vec3 position, AudioBus bus = null)
		{
			let targetBus = bus ?? _masterBus;
			let busHandle = targetBus.[Friend]_bus;

			let handle = SoLoud_binding.Bus_play3dEx(busHandle, cue.[Friend]_handle, position.x, position.y, position.z, 0f, 0f, 0f, 1f, 1);
			SoLoud_binding.Soloud_set3dSourceAttenuation(_handle, (.)handle, (.)AttenuationModel.ExponentialDistance, 1f);
			SoLoud_binding.Soloud_update3dAudio(_handle);
			SoLoud_binding.Soloud_setPause(_handle, (.)handle, 0);

			return SoundEffectInstance(this, (.)handle);
		}

		public SoundEffectInstance Play3D(SoundEffect cue, Vec3 position, double delaySeconds, AudioBus bus = null)
		{
			let targetBus = bus ?? _masterBus;
			let busHandle = targetBus.[Friend]_bus;

			let handle = SoLoud_binding.Bus_play3dEx(busHandle, cue.[Friend]_handle, position.x, position.y, position.z, 0f, 0f, 0f, 1f, 1);
			SoLoud_binding.Soloud_set3dSourceAttenuation(_handle, (.)handle, (.)AttenuationModel.ExponentialDistance, 1f);
			SoLoud_binding.Soloud_update3dAudio(_handle);
			
			let samplerate = SoLoud_binding.Soloud_getBackendSamplerate(_handle);
			SoLoud_binding.Soloud_setDelaySamples(_handle, (.)handle, (.)(samplerate * delaySeconds));
			
			SoLoud_binding.Soloud_setPause(_handle, (.)handle, 0);

			return SoundEffectInstance(this, (.)handle);
		}
	}
}
