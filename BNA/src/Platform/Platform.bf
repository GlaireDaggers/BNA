using System;
using System.Collections;
using BNA.Input;

namespace BNA.Platform
{
	public typealias GamepadAddedHandler = delegate void (GamepadDevice gamepad);
	public typealias GamepadRemovedHandler = delegate void (GamepadDevice gamepad);

	public abstract class GamePlatform
	{
		public readonly Keyboard Keyboard = new Keyboard() ~ delete _;
		public readonly Mouse Mouse = new Mouse() ~ delete _;
		public Event<GamepadAddedHandler> OnGamepadAdded;
		public Event<GamepadRemovedHandler> OnGamepadRemoved;
		
		public abstract GameWindow CreateWindow(StringView title, int width, int height, int display = 0, bool fullscreen = false);
		public abstract void Update();

		public static GamePlatform Create()
		{
			return new SDLPlatform();
		}
	}
}
