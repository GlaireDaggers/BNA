using System;

namespace BNA.Math
{
	[CRepr]
	public struct Vec3
	{
		public float x;
		public float y;
		public float z;

		public this(float x, float y, float z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}
