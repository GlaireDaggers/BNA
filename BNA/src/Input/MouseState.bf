using BNA.Math;

namespace BNA.Input
{
	public struct MouseState
	{
		public Int2 Position;
		public Int2 PositionDelta;
		public Int2 Scroll;
		public bool[(int)MouseButton.MAX_VALUE] Buttons;

		public bool this[MouseButton button]
		{
			get
			{
				return Buttons[(int)button];
			}
			set mut
			{
				Buttons[(int)button] = value;
			}
		}
	}
}
