using BNA.bindings;

namespace BNA.Audio.Filters
{
	public class ReverbFilter : AudioFilter
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

		public float RoomSize
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

		public float Damp
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

		public float Width
		{
			get
			{
				return _params[4];
			}
			set
			{
				_params[4] = value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.FreeverbFilter_create();

			// this sucks ass and I hate that it was designed like this.
			_params = new float[5];
			_params[0] = 1f;
			_params[1] = 0f;
			_params[2] = 0.5f;
			_params[3] = 0.5f;
			_params[4] = 1f;
		}

		public ~this()
		{
			SoLoud_binding.FreeverbFilter_destroy(_handle);
		}
	}
}
