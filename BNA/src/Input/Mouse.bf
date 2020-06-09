using System;
using BNA.Math;

namespace BNA.Input
{
	public typealias MouseButtonPressedHandler = delegate void(MouseButton button);
	public typealias MouseButtonReleasedHandler = delegate void(MouseButton button);

	public sealed class Mouse
	{
		public MouseState CurrentState => _curState;

		public Event<MouseButtonPressedHandler> OnMouseButtonPressed;
		public Event<MouseButtonReleasedHandler> OnMouseButtonReleased;

		private MouseState _prevState;
		private MouseState _curState;

		public this()
		{
			_prevState = .();
			_curState = .();
		}

		private void BeginUpdate()
		{
			_prevState = _curState;
			_curState.Scroll = .(0, 0);
			_curState.PositionDelta = .(0, 0);
		}

		private void SetButtonState(MouseButton button, bool value)
		{
			_curState[button] = value;

			if(value)
				OnMouseButtonPressed(button);
			else
				OnMouseButtonReleased(button);
		}

		private void SetPosition(int x, int y, int xrel, int yrel)
		{
			_curState.Position = .(x, y);
			_curState.PositionDelta = .(xrel, yrel);
		}

		private void SetScroll(int x, int y)
		{
			_curState.Scroll = .(x, y);
		}

		public Int2 GetMousePosition()
		{
			return _curState.Position;
		}

		public Int2 GetScrollDelta()
		{
			return _curState.Scroll;
		}

		public bool GetButton(MouseButton button)
		{
			return _curState[button];
		}

		public bool GetButtonDown(MouseButton button)
		{
			return _curState[button] && !_prevState[button];
		}

		public bool GetButtonUp(MouseButton button)
		{
			return !_curState[button] && _prevState[button];
		}
	}
}
