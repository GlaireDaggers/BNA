using BNA.bindings;

namespace BNA.Audio.Filters
{
	public class BassBoostFilter : AudioFilter
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

		public float Boost
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
			_handle = SoLoud_binding.BassboostFilter_create();

			_params = new float[4];
			_params[0] = 1f;
			_params[1] = 2f;
		}

		public ~this()
		{
			SoLoud_binding.BassboostFilter_destroy(_handle);
		}
	}
}
