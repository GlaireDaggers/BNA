namespace BNA.Input
{
	public struct KeyboardState
	{
		public bool[(int)Key.MAX_VALUE] Keys;

		public bool this[Key key]
		{
			get
			{
				return Keys[(int)key];
			}
			set mut
			{
				Keys[(int)key] = value;
			}
		}
	}
}
