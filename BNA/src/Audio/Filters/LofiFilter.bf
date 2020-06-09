using BNA.bindings;

namespace BNA.Audio.Filters
{
	public class LofiFilter : AudioFilter
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

		public int Samplerate
		{
			get
			{
				return (.)_params[1];
			}
			set
			{
				_params[1] = value;
				UpdateParams();
			}
		}

		public int BitDepth
		{
			get
			{
				return (.)_params[2];
			}
			set
			{
				_params[2] = value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.LofiFilter_create();

			_params = new float[3];
			_params[0] = 1f;
			_params[1] = 4000;
			_params[2] = 3;
		}

		public ~this()
		{
			SoLoud_binding.LofiFilter_destroy(_handle);
		}
	}
}
