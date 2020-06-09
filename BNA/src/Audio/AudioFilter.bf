using System;
using BNA.bindings;

namespace BNA.Audio
{
	public abstract class AudioFilter
	{
		protected Filter _handle;
		protected float[] _params ~ delete _;

		protected AudioBus _attached;
		protected uint32 _filterSlot;

		protected void UpdateParams()
		{
			if(_attached == null) return;

			// this sucks and I hate it.
			for(int i = 0; i < _params.Count; i++)
			{
				SoLoud_binding.Soloud_setFilterParameter(_attached.[Friend]_audioHandle, (.)_attached.[Friend]_busVoice, _filterSlot, (.)i, _params[i]);
			}
		}
	}
}
