using System;
using System.Diagnostics;
using BNA.bindings;

namespace BNA.Audio
{
	public sealed class AudioBus
	{
		public float Volume
		{
			get
			{
				return _volume;
			}
			set
			{
				_volume = value;
				SoLoud_binding.Soloud_setVolume(_audioHandle, _busVoice, value);
			}
		}

		private Soloud _audioHandle;
		private Bus _bus;
		private int32 _busVoice;

		private float _volume;

		private AudioFilter[8] _filter;

		public this(Audio audio, AudioBus parent = null)
		{
			_audioHandle = audio.[Friend]_handle;
			_bus = SoLoud_binding.Bus_create();
			_busVoice = parent == null ? SoLoud_binding.Soloud_play(_audioHandle, _bus) :
				(.)SoLoud_binding.Bus_play(parent._bus, _bus);

			_volume = 1f;
		}

		public ~this()
		{
			SoLoud_binding.Soloud_stop(_audioHandle, _busVoice);
			SoLoud_binding.Bus_destroy(_bus);

			_audioHandle = null;
			_bus = null;
			_busVoice = 0;
		}

		public void AttachFilter(AudioFilter filter, int slot)
		{
			Debug.Assert(slot >= 0 && slot < _filter.Count, "Slot index out of valid range");
			Debug.Assert(filter != null, "Filter cannot be null (did you mean to call DetachFilter?)");
			Debug.Assert(filter.[Friend]_attached == null, "Filter was already attached to another bus");

			if(_filter[slot] != null)
				_filter[slot].[Friend]_attached = null;

			_filter[slot] = filter;
			filter.[Friend]_attached = this;
			filter.[Friend]_filterSlot = (.)slot;

			SoLoud_binding.Bus_setFilter(_bus, (.)slot, filter?.[Friend]_handle ?? null);

			filter.[Friend]UpdateParams();
		}

		public void DetachFilter(int slot)
		{
			Debug.Assert(slot >= 0 && slot < _filter.Count, "Slot index out of valid range");

			if(_filter[slot] != null)
				_filter[slot].[Friend]_attached = null;

			_filter[slot] = null;
			SoLoud_binding.Bus_setFilter(_bus, (.)slot, null);
		}
	}
}
