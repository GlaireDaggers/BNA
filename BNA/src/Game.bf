using System;
using System.Collections;
using System.Diagnostics;
using BNA.Utils;
using BNA.Graphics;
using BNA.Math;
using BNA.Platform;
using BNA.Input;
using BNA.Audio;

namespace BNA
{
	public abstract class Game : IDisposable
	{
		public GameWindow Window { get; private set; };

		public GraphicsDevice GraphicsDevice { get; private set; };
		public SpriteBatch SpriteBatch { get; private set; }

		public Audio Audio { get; private set; }

		public Keyboard Keyboard => _platform.Keyboard;
		public Mouse Mouse => _platform.Mouse;
		public readonly GamepadCollection Gamepads;

		public Event<GamepadAddedHandler> OnGamepadAdded;
		public Event<GamepadRemovedHandler> OnGamepadRemoved;

		private GamePlatform _platform;

		private List<GamepadDevice> _gamepads = new List<GamepadDevice>() ~ delete _;

		private bool _isRunning;
		private GameTime _time;

		private Stopwatch _sw = new Stopwatch() ~ delete _;

		public this(StringView title, int width, int height, bool fullscreen)
		{
			_platform = GamePlatform.Create();
			Window = _platform.CreateWindow(title, width, height, 0, fullscreen);

			let bounds = Window.ClientBounds;
			GraphicsDevice = new GraphicsDevice(bounds.w, bounds.h, .Color, 1, .D24S8, .PlatformContents, .Default, .Default, Window, Window.IsFullscreen);
			SpriteBatch = new SpriteBatch(GraphicsDevice);

			Audio = new Audio();

			_time = .(0.0, 0.0);

			Gamepads = GamepadCollection(_gamepads);
		}

		public ~this()
		{
			Dispose();
		}

		public virtual void Dispose()
		{
			if(SpriteBatch != null)
				delete SpriteBatch;

			if(GraphicsDevice != null)
				delete GraphicsDevice;

			if(Window != null)
				delete Window;

			if(_platform != null)
				delete _platform;

			if(Audio != null)
				delete Audio;

			GraphicsDevice = null;
			Window = null;
			SpriteBatch = null;
			_platform = null;
			Audio = null;
		}

		public void Run()
		{
			_isRunning = true;

			GamepadAddedHandler gamepadAddedHandler = scope (gamepad) => {
				_gamepads.Add(gamepad);
				OnGamepadAdded(gamepad);
			};
			_platform.OnGamepadAdded.Add( gamepadAddedHandler );

			GamepadRemovedHandler gamepadRemovedhandler = scope (gamepad) => {
				_gamepads.Remove(gamepad);
				OnGamepadRemoved(gamepad);
			};
			_platform.OnGamepadRemoved.Add( gamepadRemovedhandler );

			WindowClosedHandler onClosed = scope [&] () => {
				_isRunning = false;
			};

			WindowResizedHandler onResized = scope [&] (bounds) => {
				GraphicsDevice.ResetBackbuffer(bounds.w, bounds.h, GraphicsDevice.BackbufferFormat, GraphicsDevice.MultiSampleCount, GraphicsDevice.DepthStencilFormat,
					GraphicsDevice.RenderTargetUsage, GraphicsDevice.PresentInterval, GraphicsDevice.Orientation, Window, GraphicsDevice.IsFullscreen);
			};

			WindowOrientationChangedHandler onOrientationChanged = scope [&] (orientation) => {
				GraphicsDevice.Orientation = orientation;
			};

			Window.OnClosed.Add( onClosed );
			Window.OnWindowResized.Add( onResized );
			Window.OnWindowOrientationChanged.Add( onOrientationChanged );

			Initialize();
			LoadContent();

			_sw.Start();
			double prevSec = _sw.Elapsed.TotalSeconds;

			while(_isRunning)
			{
				double time = _sw.Elapsed.TotalSeconds;
				double elapsed = time - prevSec;
				prevSec = time;

				_time += elapsed;
				
				_platform.Update();
				Window.PumpEvents();

				Audio.Update();

				GraphicsDevice.BeginFrame();
				{
					Update(_time);
					Draw(_time);
				}
				GraphicsDevice.Present();
			}

			_sw.Stop();

			UnloadContent();
			Teardown();

			Window.OnClosed.Remove( onClosed );
			Window.OnWindowResized.Remove( onResized );
			Window.OnWindowOrientationChanged.Remove( onOrientationChanged );

			_platform.OnGamepadAdded.Remove( gamepadAddedHandler );
			_platform.OnGamepadRemoved.Remove( gamepadRemovedhandler );
		}

		public void Exit()
		{
			_isRunning = false;
		}

		protected virtual void Initialize()
		{
		}

		protected virtual void LoadContent()
		{
		}

		protected virtual void Teardown()
		{
		}

		protected virtual void UnloadContent()
		{
		}

		protected virtual void Update(GameTime time)
		{
		}

		protected virtual void Draw(GameTime time)
		{
			GraphicsDevice.Clear(.Target | .DepthBuffer | .Stencil, Color(0, 0, 0));
		}
	}
}
