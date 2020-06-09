using System;
using System.Collections;

namespace BNA.Input
{
	public typealias GamepadButtonPressedHandler = delegate void(Button);
	public typealias GamepadButtonReleasedHandler = delegate void(Button);

	public sealed struct GamepadCollection : IEnumerable<GamepadDevice>
	{
		public int Count => _list.Count;

		private List<GamepadDevice> _list;

		public this(List<GamepadDevice> list)
		{
			_list = list;
		}

		public GamepadDevice this[int index]
		{
			get
			{
				return _list[index];
			}
		}

		public List<GamepadDevice>.Enumerator GetEnumerator()
		{
			return _list.GetEnumerator();
		}
	}

	public abstract class GamepadDevice
	{
		public GamepadState CurrentState => _curState;

		public Event<GamepadButtonPressedHandler> OnButtonPressed;
		public Event<GamepadButtonReleasedHandler> OnButtonReleased;

		public virtual StringView Name => "Gamepad";

		protected GamepadState _prevState;
		protected GamepadState _curState;

		public this()
		{
			_prevState = .();
			_curState = .();
		}

		protected void BeginUpdate()
		{
			_prevState = _curState;
		}

		protected void SetButton(Button btn, bool value)
		{
			if(value && !_curState[btn])
				OnButtonPressed(btn);
			else if(!value && _curState[btn])
				OnButtonReleased(btn);

			_curState[btn] = value;
		}

		protected void SetAxis(Axis axis, float value)
		{
			_curState[axis] = value;
		}

		public bool GetButton(Button btn)
		{
			return _curState[btn];
		}

		public bool GetButtonDown(Button btn)
		{
			return _curState[btn] && !_prevState[btn];
		}

		public bool GetButtonUp(Button btn)
		{
			return !_curState[btn] && _prevState[btn];
		}

		public float GetAxis(Axis axis)
		{
			return _curState[axis];
		}

		public virtual void Vibrate(float magnitude, int duration)
		{
		}

		public virtual void StopVibration()
		{
		}
	}
}
