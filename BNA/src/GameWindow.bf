using System;
using BNA.Graphics;
using BNA.Math;
using BNA.Platform;

namespace BNA
{
	public typealias WindowClosedHandler = delegate void();
	public typealias WindowResizedHandler = delegate void(Rect);
	public typealias WindowOrientationChangedHandler = delegate void(DisplayOrientation);

	public abstract class GameWindow : IDisposable
	{
		public abstract bool AllowUserResizing { get; set; }
		public abstract Rect ClientBounds { get; }
		public abstract Int2 Position { get; }
		public abstract DisplayOrientation Orientation { get; }
		public abstract void* Handle { get; }
		public abstract StringView Title { get; set; }
		public abstract bool IsBorderless { get; set; }
		public abstract bool IsFullscreen { get; set; }
		public abstract bool LockMouse { get; set; }

		public Event<WindowClosedHandler> OnClosed;
		public Event<WindowResizedHandler> OnWindowResized;
		public Event<WindowOrientationChangedHandler> OnWindowOrientationChanged;

		public virtual void PumpEvents() { }
		public virtual void Dispose() { }

		public ~this()
		{
			Dispose();
		}
	}
}
