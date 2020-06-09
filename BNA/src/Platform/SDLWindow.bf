using System;

using SDL2;

using BNA.Math;
using BNA.Graphics;
using BNA.bindings;

namespace BNA.Platform
{
	public class SDLWindow : GameWindow
	{
		public typealias SDLEventHandler = delegate void(SDL.Event event);

		public Event<SDLEventHandler> OnWinEvent;

		public override bool AllowUserResizing
		{
			get
			{
				return ((SDL.WindowFlags)SDL.GetWindowFlags(_handle)).HasFlag(.Resizable);
			}
			set
			{
				SDL.SetWindowResizable(_handle, value ? .True : .False);
			}
		}

		public override Rect ClientBounds
		{
			get
			{
				int32 w = 0, h = 0;
				FNA3D_binding.GetDrawableSize(_handle, &w, &h);

				return Rect(0, 0, w, h);
			}
		}

		public override Int2 Position
		{
			get
			{
				int32 x, y;
				SDL.GetWindowPosition(_handle, out x, out y);

				return Int2(x, y);
			}
		}

		public override DisplayOrientation Orientation
		{
			get
			{
				let orientation = SDL.SDL_GetDisplayOrientation((.)_display);

				switch (orientation)
				{
				case .Unknown: return .Default;
				case .Landscape: return .LandscapeLeft;
				case .LandscapeFlipped: return .LandscapeRight;
				case .Portrait: return .Portrait;
				case .PortraitFlipped: return .Portrait;
				}
			}
		}

		public override void* Handle=> _handle;

		public override StringView Title
		{
			get
			{
				return _title;
			}
			set
			{
				_title.Set(value);
				SDL.SetWindowTitle(_handle, _title.CStr());
			}
		}

		public override bool IsBorderless
		{
			get
			{
				return ((SDL.WindowFlags)SDL.GetWindowFlags(_handle)).HasFlag(.Borderless);
			}
			set
			{
				SDL.SetWindowBordered(_handle, value ? .False : .True);
			}
		}

		public override bool IsFullscreen
		{
			get
			{
				let flags = ((SDL.WindowFlags)SDL.GetWindowFlags(_handle));
				return flags.HasFlag(.Fullscreen) || flags.HasFlag(.FullscreenDesktop);
			}
			set
			{
				SDL.SetWindowFullscreen(_handle, value ? (.)SDL.WindowFlags.FullscreenDesktop : 0);
			}
		}

		public override bool LockMouse
		{
			get
			{
				return SDL.GetRelativeMouseMode() == .True;
			}
			set
			{
				SDL.SetRelativeMouseMode(value ? .True : .False);
			}
		}

		private SDL.Window* _handle;
		private String _title ~ delete _;

		private int _display;
		private SDL.DisplayOrientation _prevOrientation;

		public this(StringView title, int width, int height, int display = 0, bool fullscreen = false)
		{
			this._title = new String(title);

			SDL.WindowFlags flags = (.)FNA3D_binding.PrepareWindowAttributes();

			if (fullscreen)
				flags |= .FullscreenDesktop;

			_handle = SDL.CreateWindow(_title.CStr(), .Centered, .Centered, (.)width, (.)height, (.)flags);

			_display = display;
			_prevOrientation = SDL.SDL_GetDisplayOrientation((.)_display);
		}

		public override void Dispose()
		{
			base.Dispose();

			if (_handle != null)
			{
				SDL.DestroyWindow(_handle);
				_handle = null;
			}
		}

		public override void PumpEvents()
		{
			base.PumpEvents();

			SDL.Event event = .();
			while (SDL.PollEvent(out event) != 0)
			{
				OnWinEvent(event);

				if (event.type == .WindowEvent)
				{
					switch (event.window.windowEvent)
					{
						// window closed
					case .Close:
						OnClosed.Invoke();
						break;
						// size changed - could mean the window was resized. could also mean the display orientation
						// changed.
					case .SizeChanged:
						OnWindowResized.Invoke(ClientBounds);
						let newOrientation = SDL.SDL_GetDisplayOrientation((.)_display);
						if (newOrientation != _prevOrientation)
						{
							OnWindowOrientationChanged.Invoke(Orientation);
							_prevOrientation = newOrientation;
						}
						break;
					default:
						break;
					}
				}
			}
		}
	}
}