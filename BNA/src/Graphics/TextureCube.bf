using System;
using System.Diagnostics;
using BNA.bindings;

namespace BNA.Graphics
{
	public class TextureCube : Texture
	{
		public readonly int Size;
		public readonly SurfaceFormat Format;
		public readonly int MipCount;

		public this(GraphicsDevice graphicsDevice, int size, SurfaceFormat format = .Color, int mipCount = 1)
			: base(graphicsDevice)
		{
			Size = size;
			Format = format;
			MipCount = mipCount;
			_handle = FNA3D_binding.CreateTextureCube(_device, format, (.)size, (.)mipCount, 0);
		}

		public ~this()
		{
			Dispose();
		}

		public void SetData(uint8[] data, CubemapFace face, int level = 0)
		{
			FNA3D_binding.SetTextureDataCube(_device, _handle, Format, 0, 0, (.)Size, (.)Size, face, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(uint8[] data, CubemapFace face, int x, int y, int w, int h, int level = 0)
		{
			FNA3D_binding.SetTextureDataCube(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, face, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(Color[] data, CubemapFace face, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureDataCube(_device, _handle, Format, 0, 0, (.)Size, (.)Size, face, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void SetData(Color[] data, CubemapFace face, int x, int y, int w, int h, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureDataCube(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, face, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void GetData(uint8[] dest, CubemapFace face, int level = 0)
		{
			FNA3D_binding.GetTextureDataCube(_device, _handle, Format, 0, 0, (.)Size, (.)Size, face, (.)level, dest.CArray(), (.)dest.Count);
		}

		public void GetData(uint8[] dest, CubemapFace face, int x, int y, int w, int h, int level = 0)
		{
			FNA3D_binding.GetTextureDataCube(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, face, (.)level, dest.CArray(), (.)dest.Count);
		}
	}
}
