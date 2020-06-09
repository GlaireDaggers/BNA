using BNA.bindings;

namespace BNA.Audio.Filters
{
	public enum WaveShape
	{
		Square,
		Saw,
		Sin,
		Triangle,
		Bounce,
		Jaws,
		Humps,
		FSquare,
		FSaw
	}

	public class RobotizeFilter : AudioFilter
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

		public int Frequency
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

		public WaveShape Wave
		{
			get
			{
				return (.)_params[2];
			}
			set
			{
				_params[2] = (.)value;
				UpdateParams();
			}
		}

		public this()
		{
			_handle = SoLoud_binding.RobotizeFilter_create();

			_params = new float[3];
			_params[0] = 1f;
			_params[1] = 30;
			_params[2] = (.)WaveShape.Sin;
		}

		public ~this()
		{
			SoLoud_binding.RobotizeFilter_destroy(_handle);
		}
	}
}
