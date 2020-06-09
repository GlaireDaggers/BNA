using System;
using BNA.Input;
using SDL2;

namespace BNA.Platform
{
	public sealed class SDLGamepad : GamepadDevice
	{
		public readonly int32 JoystickID;
		public readonly SDL.SDL_GameController* Handle;

		public override StringView Name => _name;

		private String _name = new String() ~ delete _;
		private SDL.SDL_Haptic* _haptic;
		private bool _rumbleSupported;

		public this(int32 index)
		{
			Handle = SDL.GameControllerOpen(index);
			JoystickID = SDL.JoystickInstanceID(SDL.GameControllerGetJoystick(Handle));

			_name.Set(StringView(SDL.GameControllerName(Handle)));

			_haptic = SDL.HapticOpenFromJoystick(SDL.GameControllerGetJoystick(Handle));
			_rumbleSupported = SDL.HapticRumbleInit(_haptic) == 0;
		}

		public ~this()
		{
			SDL.HapticClose(_haptic);
			SDL.GameControllerClose(Handle);
		}

		public void HandleEvent(SDL.ControllerButtonEvent event)
		{
			let button = (Button)event.button;
			SetButton(button, event.state == 0 ? false : true);
		}

		public void HandleEvent(SDL.ControllerAxisEvent event)
		{
			let axis = (Axis)event.axis;
			SetAxis(axis, event.axisValue / (float)int16.MaxValue);
		}

		public override void Vibrate(float magnitude, int duration)
		{
			if(_rumbleSupported)
				SDL.HapticRumblePlay(_haptic, magnitude, (.)duration);
		}

		public override void StopVibration()
		{
			if(_rumbleSupported)
				SDL.HapticRumbleStop(_haptic);
		}
	}
}
