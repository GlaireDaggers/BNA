using System;

namespace BNA.Math
{
	[CRepr]
	public struct Vec2
	{
		public static readonly Vec2 Zero = Vec2(0f, 0f);
		public static readonly Vec2 One = Vec2(1f, 1f);

		public float x;
		public float y;

		public this(float x, float y)
		{
			this.x = x;
			this.y = y;
		}

		public static Vec2 operator +(Vec2 lhs, Vec2 rhs)
		{
			return Vec2(lhs.x + rhs.x, lhs.y + rhs.y);
		}

		public static Vec2 operator -(Vec2 lhs, Vec2 rhs)
		{
			return Vec2(lhs.x - rhs.x, lhs.y - rhs.y);
		}

		public static Vec2 operator *(Vec2 lhs, float rhs)
		{
			return Vec2(lhs.x * rhs, lhs.y * rhs);
		}

		public static Vec2 operator *(Vec2 lhs, Vec2 rhs)
		{
			return Vec2(lhs.x * rhs.x, lhs.y * rhs.y);
		}

		public static Vec2 operator /(Vec2 lhs, float rhs)
		{
			return Vec2(lhs.x / rhs, lhs.y / rhs);
		}

		public static Vec2 operator /(Vec2 lhs, Vec2 rhs)
		{
			return Vec2(lhs.x / rhs.x, lhs.y / rhs.y);
		}
	}
}
