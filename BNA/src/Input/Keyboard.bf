using System;
using System.Collections;

namespace BNA.Input
{
	public typealias KeyPressedHandler = delegate void(Key key);
	public typealias KeyReleasedHandler = delegate void(Key key);

	public sealed class Keyboard
	{
		public KeyboardState CurrentState => _curState;

		public Event<KeyPressedHandler> OnKeyPressed;
		public Event<KeyReleasedHandler> OnKeyReleased;

		private KeyboardState _prevState;
		private KeyboardState _curState;

		public this()
		{
			_prevState = .();
			_curState = .();
		}

		private void BeginUpdate()
		{
			_prevState = _curState;
		}

		private void SetKeyState(Key key, bool pressed)
		{
			_curState[key] = pressed;

			if(pressed)
				OnKeyPressed(key);
			else
				OnKeyReleased(key);
		}

		public bool GetKey(Key key)
		{
			return _curState[key];
		}

		public bool GetKeyDown(Key key)
		{
			return _curState[key] && !_prevState[key];
		}

		public bool GetKeyUp(Key key)
		{
			return !_curState[key] && _prevState[key];
		}
	}
}
