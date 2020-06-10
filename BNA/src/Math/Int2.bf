using System;

namespace BNA.Math
{
	[CRepr]
	public struct Int2
	{
		public static readonly Int2 Zero = .(0, 0);

		public int32 x;
		public int32 y;

		public this(int x, int y)
		{
			this.x = (.)x;
			this.y = (.)y;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("({0}, {1})", x, y);
		}

		public static operator Vec2(Int2 val)
		{
			return Vec2(val.x, val.y);
		}

		public static Int2 operator +(Int2 lhs, Int2 rhs)
		{
			return Int2(lhs.x + rhs.x, lhs.y + rhs.y);
		}

		public static Int2 operator -(Int2 lhs, Int2 rhs)
		{
			return Int2(lhs.x - rhs.x, lhs.y - rhs.y);
		}

		public static Int2 operator *(Int2 lhs, int rhs)
		{
			return Int2(lhs.x * rhs, lhs.y * rhs);
		}

		public static Int2 operator *(Int2 lhs, Int2 rhs)
		{
			return Int2(lhs.x * rhs.x, lhs.y * rhs.y);
		}

		public static Int2 operator /(Int2 lhs, int rhs)
		{
			return Int2(lhs.x / rhs, lhs.y / rhs);
		}

		public static Int2 operator /(Int2 lhs, Int2 rhs)
		{
			return Int2(lhs.x / rhs.x, lhs.y / rhs.y);
		}
	}
}
