using System;

namespace BNA.Math
{
	[CRepr]
	public struct Vec3
	{
		public static readonly Vec3 Zero = .(0, 0, 0);
		public static readonly Vec3 One = .(1, 1, 1);

		public static readonly Vec3 Up = .(0f, 1f, 0f);
	 	public static readonly Vec3 Backward = .(0f, 0f, 1f);

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


		public static float Dot(Vec3 value1, Vec3 value2)
		{
		    return value1.x * value2.x + value1.y * value2.y + value1.z * value2.z;
		}

		public static Vec3 Cross(Vec3 vector1, Vec3 vector2)
		{
		    var x = vector1.y * vector2.z - vector2.y * vector1.z;
		    var y = -(vector1.x * vector2.z - vector2.x * vector1.z);
		    var z = vector1.x * vector2.y - vector2.x * vector1.y;
			return Vec3(x,y,z);
		}


		public static Vec3 Normalize(Vec3 value)
		{
		    float factor = (float)Math.Sqrt((value.x * value.x) + (value.y * value.y) + (value.z * value.z));
		    factor = 1f / factor;
			return Vec3(value.x * factor, value.y * factor, value.z * factor);
		}

		public static Vec3 Transform(Vec3 position, ref Matrix4x4 matrix)
		{
		    var x = (position.x * matrix.M11) + (position.y * matrix.M21) + (position.z * matrix.M31) + matrix.M41;
		    var y = (position.x * matrix.M12) + (position.y * matrix.M22) + (position.z * matrix.M32) + matrix.M42;
		    var z = (position.x * matrix.M13) + (position.y * matrix.M23) + (position.z * matrix.M33) + matrix.M43;
		    return Vec3(x,y,z);
		}

	}
}
