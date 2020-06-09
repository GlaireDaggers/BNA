using System;
using System.Diagnostics;
using BNA.bindings;
using BNA.Math;

namespace BNA.Audio
{
	public enum SoundEffectInaudibleBehavior
	{
		Continue,
		Pause,
		Stop
	}

	public enum AttenuationModel
	{
		None,
		InverseDistance,
		LinearDistance,
		ExponentialDistance
	}

	public struct SoundEffectInstance
	{
		public float Volume
		{
			get
			{
				return SoLoud_binding.Soloud_getVolume(_audio, _handle);
			}
			set
			{
				SoLoud_binding.Soloud_setVolume(_audio, _handle, value);
			}
		}

		public float Pitch
		{
			get
			{
				return SoLoud_binding.Soloud_getRelativePlaySpeed(_audio, _handle);
			}
			set
			{
				SoLoud_binding.Soloud_setRelativePlaySpeed(_audio, _handle, value);
			}
		}

		public float Pan
		{
			get
			{
				return SoLoud_binding.Soloud_getPan(_audio, _handle);
			}
			set
			{
				SoLoud_binding.Soloud_setPan(_audio, _handle, value);
			}
		}

		public bool Paused
		{
			get
			{
				return SoLoud_binding.Soloud_getPause(_audio, _handle) != 0;
			}
			set
			{
				SoLoud_binding.Soloud_setPause(_audio, _handle, value ? 1 : 0);
			}
		}

		public bool Looping
		{
			get
			{
				return SoLoud_binding.Soloud_getLooping(_audio, _handle) != 0;
			}
			set
			{
				SoLoud_binding.Soloud_setLooping(_audio, _handle, value ? 1 : 0);
			}
		}

		public double LoopPoint
		{
			get
			{
				return SoLoud_binding.Soloud_getLoopPoint(_audio, _handle);
			}
			set
			{
				SoLoud_binding.Soloud_setLoopPoint(_audio, _handle, value);
			}
		}

		public bool ProtectVoice
		{
			get
			{
				return SoLoud_binding.Soloud_getProtectVoice(_audio, _handle) != 0;
			}
			set
			{
				SoLoud_binding.Soloud_setProtectVoice(_audio, _handle, value ? 1 : 0);
			}
		}

		public bool IsPlaying
		{
			get
			{
				return SoLoud_binding.Soloud_getPause(_audio, _handle) == 0;
			}
		}

		public Vec3 Position
		{
			get
			{
				return .(0,0,0);
			}
		}

		private int32 _handle;
		private Soloud _audio;

		public this(Audio audio, int32 handle)
		{
			_audio = audio.[Friend]_handle;
			_handle = handle;
		}

		public void Stop()
		{
			SoLoud_binding.Soloud_stop(_audio, _handle);
		}

		public void SetInaudibleBehavior(SoundEffectInaudibleBehavior behavior = .Pause)
		{
			SoLoud_binding.Soloud_setInaudibleBehavior(_audio, _handle, behavior == .Continue ? 1 : 0, behavior == .Stop ? 1 : 0);
		}

		public void SetPosition(Vec3 position)
		{
			SoLoud_binding.Soloud_set3dSourcePosition(_audio, _handle, position.x, position.y, position.z);
		}

		public void SetVelocity(Vec3 velocity)
		{
			SoLoud_binding.Soloud_set3dSourceVelocity(_audio, _handle, velocity.x, velocity.y, velocity.z);
		}

		public void SetMinMaxDistance(float minDistance, float maxDistance)
		{
			SoLoud_binding.Soloud_set3dSourceMinMaxDistance(_audio, _handle, minDistance, maxDistance);
		}

		public void SetAttenuation(AttenuationModel attenuationModel, float attenuationFactor = 1.0f)
		{
			SoLoud_binding.Soloud_set3dSourceAttenuation(_audio, _handle, (.)attenuationModel, attenuationFactor);
		}

		public void SetDopplerFactor(float dopplerFactor)
		{
			SoLoud_binding.Soloud_set3dSourceDopplerFactor(_audio, _handle, dopplerFactor);
		}
	}
}
