using BNA.bindings;

namespace BNA.Audio.Filters
{
	public enum BandFilterType
	{
		LowPass = 0,
		HighPass = 1,
		BandPass = 2
	}

	public class BandPassFilter : AudioFilter
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

		public BandFilterType FilterType
		{
			get
			{
				return (.)_params[1];
			}
			set
			{
				_params[1] = (.)value;
				UpdateParams();
			}
		}

		public int Frequency
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

		public float Resonance
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
			_handle = SoLoud_binding.BiquadResonantFilter_create();

			_params = new float[4];
			_params[0] = 1f;
			_params[1] = (.)BandFilterType.LowPass;
			_params[2] = 1000f;
			_params[3] = 2f;
		}

		public ~this()
		{
			SoLoud_binding.BiquadResonantFilter_destroy(_handle);
		}
	}
}
