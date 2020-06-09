using System;

namespace BNA
{
	public struct GameTime
	{
		public readonly double ElapsedTime;
		public readonly double TotalTime;

		public this(double elapsedTime, double totalTime)
		{
			ElapsedTime = elapsedTime;
			TotalTime = totalTime;
		}

		public static GameTime operator +(GameTime gameTime, double elapsedTime)
		{
			return .(elapsedTime, gameTime.TotalTime + elapsedTime);
		}
	}
}
