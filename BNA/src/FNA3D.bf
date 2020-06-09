using System;
using BNA.bindings;
using BNA.Utils;

namespace BNA
{
	public sealed static class FNA3D
	{
		private static void Log(char8* msg)
		{
			Trace.Log(scope String(msg));
		}

		private static void LogWarn(char8* msg)
		{
			Trace.LogWarn(scope String(msg));
		}

		private static void LogErr(char8* msg)
		{
			Trace.LogErr(scope String(msg));
		}

		private static this()
		{
			FNA3D_binding.HookLogFunctions(=> Log, => LogWarn, => LogErr);
		}
	}
}
