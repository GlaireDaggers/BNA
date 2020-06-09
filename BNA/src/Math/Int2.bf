using System;

namespace BNA.Math
{
	[CRepr]
	public struct Int2
	{
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
	}
}
