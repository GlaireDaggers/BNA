using System;
using BNA.Math;

namespace BNA.Input
{
	public struct GamepadState
	{
		public bool[(int)Button.MAX_VALUE] Buttons;
		public float[(int)Axis.MAX_VALUE] Axes;

		public bool this[Button button]
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

		public float this[Axis axis]
		{
			get
			{
				return Axes[(int)axis];
			}
			set mut
			{
				Axes[(int)axis] = value;
			}
		}
	}
}
