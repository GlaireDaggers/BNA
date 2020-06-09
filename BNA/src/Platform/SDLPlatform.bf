using System;
using System.Collections;
using BNA.Input;
using SDL2;

namespace BNA.Platform
{
	public class SDLPlatform : GamePlatform
	{
		public static this()
		{
			SDL.Init(.Everything);
		}

		Dictionary<int32,SDLGamepad> gamepads = new Dictionary<int32, SDLGamepad>() ~ delete _;

		SDLWindow.SDLEventHandler winHandler = new (event) => {
			if(event.type == .KeyDown)
			{
				Keyboard.[Friend]SetKeyState( (.)( event.key.keysym.scancode ), true );
			}
			else if(event.type == .KeyUp)
			{
				Keyboard.[Friend]SetKeyState( (.)( event.key.keysym.scancode ), false );
			}
			else if(event.type == .MouseButtonDown)
			{
				Mouse.[Friend]SetButtonState( (.)(event.button.button), true );
			}
			else if(event.type == .MouseButtonUp)
			{
				Mouse.[Friend]SetButtonState( (.)(event.button.button), false );
			}
			else if(event.type == .MouseWheel)
			{
				Mouse.[Friend]SetScroll(event.wheel.x, event.wheel.y);
			}
			else if(event.type == .MouseMotion)
			{
				Mouse.[Friend]SetPosition(event.motion.x, event.motion.y, event.motion.xrel, event.motion.yrel);
			}
			else if(event.type == .ControllerDeviceadded)
			{
				let gamepad = new SDLGamepad(event.cdevice.which);
				gamepads.Add(gamepad.JoystickID, gamepad);
				OnGamepadAdded(gamepad);
			}
			else if(event.type == .ControllerDeviceremoved)
			{
				let gamepad = gamepads[event.cdevice.which];
				OnGamepadRemoved(gamepad);
				gamepads.Remove(gamepad.JoystickID);
				delete gamepad;
			}
			else if(event.type == .ControllerButtondown || event.type == .ControllerButtonup)
			{
				let gamepad = gamepads[event.cbutton.which];
				gamepad.HandleEvent(event.cbutton);
			}
			else if(event.type == .ControllerAxismotion)
			{
				let gamepad = gamepads[event.caxis.which];
				gamepad.HandleEvent(event.caxis);
			}
		};

		public override GameWindow CreateWindow(StringView title, int width, int height, int display = 0, bool fullscreen = false)
		{
			let win = new SDLWindow(title, width, height, display, fullscreen);
			win.OnWinEvent.Add( winHandler );
			return win;
		}

		public ~this()
		{
			for(let gamepad in gamepads.Values)
			{
				delete gamepad;
			}
			gamepads.Clear();

			delete winHandler;
		}

		public override void Update()
		{
			Mouse.[Friend]BeginUpdate();
			Keyboard.[Friend]BeginUpdate();

			for(let gamepad in gamepads.Values)
			{
				gamepad.[Friend]BeginUpdate();
			}
		}
	}
}
