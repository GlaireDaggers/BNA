using System;
using System.Collections;
using System.IO;

namespace BNA.Utils
{
	public static class ResourceUtility
	{
		public static uint8[] ReadAllBytes(StringView path)
		{
			let fileStream = scope FileStream();
			let result = fileStream.Open(path, .Read, .Read);
			if(result case .Ok)
			{
				let fileBytes = new uint8[(.)fileStream.Length];
				if( fileStream.TryRead(.(fileBytes)) case .Err )
				{
					delete fileBytes;
					return null;
				}

				return fileBytes;
			}

			return null;
		}
	}
}
