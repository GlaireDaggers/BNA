using System;

namespace BNA.Math
{
	public static class MathUtils
	{
		public const float DEG2RAD = Math.PI_f / 180f;


		public static float Clamp(float value, float min, float max)
		{
			float v = value;
		    // First we check to see if we're greater than the max
		    v = (v > max) ? max : v;

		    // Then we check to see if we're less than the min.
		    v = (v < min) ? min : v;

		    // There's no check to see if min > max.
		    return v;
		}

		public static float Lerp(float value1, float value2, float amount)
		{
		    return value1 + (value2 - value1) * amount;
		}

	}
}
