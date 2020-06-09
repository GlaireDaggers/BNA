using BNA.bindings;

namespace BNA.Audio.Filters
{
	public class FlangerFilter : AudioFilter
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

		public float Delay
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

		public float Frequency
		{
			get
			{
				return _params[2];
			}
			set
			{
				_params[2] = value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.FlangerFilter_create();

			_params = new float[3];
			_params[0] = 1f;
			_params[1] = 0.005f;
			_params[2] = 10f;
		}

		public ~this()
		{
			SoLoud_binding.FlangerFilter_destroy(_handle);
		}
	}
}
