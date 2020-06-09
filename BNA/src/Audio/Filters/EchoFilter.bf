using BNA.bindings;

namespace BNA.Audio.Filters
{
	public class EchoFilter : AudioFilter
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

		public float Decay
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

		public float Filter
		{
			get
			{
				return _params[3];
			}
			set
			{
				_params[3] = value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.EchoFilter_create();

			_params = new float[4];
			_params[0] = 1f;
			_params[1] = 0f;
			_params[2] = 0.7f;
			_params[3] = 0f;
		}

		public ~this()
		{
			SoLoud_binding.EchoFilter_destroy(_handle);
		}
	}
}
