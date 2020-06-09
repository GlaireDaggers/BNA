using BNA.bindings;

namespace BNA.Audio.Filters
{
	// frankly I have no goddamn idea what this filter is supposed to do. It seems to just amplify the sound.
	public class WaveShaperFilter : AudioFilter
	{
		public float Wet
		{
			get
			{
				return _params[0];
			}
			set
			{
				_params[0] = value;
				UpdateParams();
			}
		}

		public float Amount
		{
			get
			{
				return _params[1];
			}
			set
			{
				_params[1] = value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.WaveShaperFilter_create();

			_params = new float[2];
			_params[0] = 1f;
			_params[1] = 0f;
		}

		public ~this()
		{
			SoLoud_binding.WaveShaperFilter_destroy(_handle);
		}
	}
}
