using System;
using System.Diagnostics;

namespace BNA.Utils
{
	public static class Trace
	{
		public static void Log(String fmt, params Object[] args)
		{
			let msg = scope String()..Append("[INFO] ")..AppendF(fmt, params args);

			Console.WriteLine(msg);
			Debug.WriteLine(msg);
		}

		public static void LogWarn(String fmt, params Object[] args)
		{
			let msg = scope String()..Append("[WARN] ")..AppendF(fmt, params args);

			Console.ForegroundColor = .Yellow;
			Console.WriteLine(msg);
			Console.ResetColor();

			Debug.WriteLine(msg);
		}

		public static void LogErr(String fmt, params Object[] args)
		{
			let msg = scope String()..Append("[ERROR] ")..AppendF(fmt, params args);

			Console.ForegroundColor = .Red;
			Console.WriteLine(msg);
			Console.ResetColor();

			Debug.WriteLine(msg);
		}
	}
}
