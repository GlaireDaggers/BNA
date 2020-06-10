using System;

namespace BNA.Math
{
	[CRepr]
	public struct Vec4
	{
		public static readonly Vec4 Zero = .(0, 0, 0, 0);
		public static readonly Vec4 One = .(1, 1, 1, 1);

		public float x;
		public float y;
		public float z;
		public float w;

		public this(float x, float y, float z, float w)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("({0}, {1}, {2}, {3})", x, y, z, w);
		}

		public static Vec4 operator +(Vec4 lhs, Vec4 rhs)
		{
			return Vec4(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w);
		}

		public static Vec4 operator -(Vec4 lhs, Vec4 rhs)
		{
			return Vec4(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w);
		}

		public static Vec4 operator *(Vec4 lhs, float rhs)
		{
			return Vec4(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs);
		}

		public static Vec4 operator *(Vec4 lhs, Vec4 rhs)
		{
			return Vec4(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w);
		}

		public static Vec4 operator /(Vec4 lhs, float rhs)
		{
			return Vec4(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs);
		}

		public static Vec4 operator /(Vec4 lhs, Vec4 rhs)
		{
			return Vec4(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w);
		}
	}
}
