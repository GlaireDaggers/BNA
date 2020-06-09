using System;
using BNA.bindings;
using BNA.Utils;

namespace BNA.Audio
{
	public sealed class SoundEffect : IDisposable
	{
		public static Result<SoundEffect> Load(StringView path)
		{
			let fileBytes = ResourceUtility.ReadAllBytes(path);
			if(fileBytes == null)
				return .Err;

			let cue = new SoundEffect(false);
			let result = cue.LoadMemory(fileBytes);

			delete fileBytes;

			if(result case .Err)
			{
				delete cue;
				return .Err;
			}

			return cue;
		}

		public static Result<SoundEffect> LoadStreaming(StringView path)
		{
			let cue = new SoundEffect(true);
			let result = cue.LoadStreamingFile(path);

			if(result case .Err)
			{
				delete cue;
				return .Err;
			}

			return cue;
		}

		public double Length => _length;

		private Wav _handle;
		private bool _streaming;

		private double _length;

		public this(bool streaming)
		{
			if(streaming)
				_handle = SoLoud_binding.WavStream_create();
			else
				_handle = SoLoud_binding.Wav_create();

			_streaming = streaming;
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			if(_handle != null)
			{
				if(_streaming)
					SoLoud_binding.WavStream_destroy(_handle);
				else
					SoLoud_binding.Wav_destroy(_handle);

				_handle = null;
			}
		}

		private Result<void> LoadStreamingFile(StringView filename)
		{
			let result = SoLoud_binding.WavStream_load(_handle, filename.Ptr);
			if(result == .OK)
			{
				_length = SoLoud_binding.WavStream_getLength(_handle);
				return .Ok;
			}

			return .Err;
		}

		private Result<void> LoadMemory(uint8[] fileBytes)
		{
			let result = SoLoud_binding.Wav_loadMemEx(_handle, fileBytes.CArray(), (.)fileBytes.Count, 1, 1);
			if(result == .OK)
			{
				_length = SoLoud_binding.Wav_getLength(_handle);
				return .Ok;
			}

			return .Err;
		}
	}
}
