namespace BNA.Input
{
	// NOTE: This enumeration basically maps directly onto the SDL gamepad button enumeration
	// if you're using something other than SDL, you'll need to manually map onto this
	public enum Button
	{
		A,
		B,
		X,
		Y,
		Back,
		Guide,
		Start,
		LeftStick,
		RightStick,
		LeftShoulder,
		RightShoulder,
		DpadUp,
		DpadDown,
		DpadLeft,
		DpadRight,

		MAX_VALUE
	}

	// NOTE: this enumeration basically maps directly onto the SDL gamepad axis enumeration
	// if you're using something other than SDL, you'll need to manually map onto this
	public enum Axis
	{
		LeftStickX,
		LeftStickY,
		RightStickX,
		RightStickY,
		LeftTrigger,
		RightTrigger,

		MAX_VALUE
	}
}
