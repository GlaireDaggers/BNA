using System;

namespace BNA.Math
{
	[CRepr]
	public struct Vec3
	{
		public static readonly Vec3 Zero = .(0, 0, 0);
		public static readonly Vec3 One = .(1, 1, 1);

		public float x;
		public float y;
		public float z;

		public this(float x, float y, float z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("({0}, {1}, {2})", x, y, z);
		}

		public static operator Vec4(Vec3 val)
		{
			return Vec4(val.x, val.y, val.z, 0f);
		}

		public static Vec3 operator +(Vec3 lhs, Vec3 rhs)
		{
			return Vec3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z);
		}

		public static Vec3 operator -(Vec3 lhs, Vec3 rhs)
		{
			return Vec3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z);
		}

		public static Vec3 operator *(Vec3 lhs, float rhs)
		{
			return Vec3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs);
		}

		public static Vec3 operator *(Vec3 lhs, Vec3 rhs)
		{
			return Vec3(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z);
		}

		public static Vec3 operator /(Vec3 lhs, float rhs)
		{
			return Vec3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs);
		}

		public static Vec3 operator /(Vec3 lhs, Vec3 rhs)
		{
			return Vec3(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z);
		}
	}
}
