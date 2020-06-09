using System;
using System.Diagnostics;
using BNA.bindings;

namespace BNA.Graphics
{
	public class Texture3D : Texture
	{
		public readonly int Width;
		public readonly int Height;
		public readonly int Depth;
		public readonly SurfaceFormat Format;

		public this(GraphicsDevice graphicsDevice, int width, int height, int depth, SurfaceFormat format = .Color, int mipCount = 1)
			: base(graphicsDevice)
		{
			Width = width;
			Height = height;
			Depth = depth;
			Format = format;
			_handle = FNA3D_binding.CreateTexture3D(_device, format, (.)width, (.)height, (.)depth, (.)mipCount);
		}

		public ~this()
		{
			Dispose();
		}

		public void SetData(uint8[] data, int level = 0)
		{
			FNA3D_binding.SetTextureData3D(_device, _handle, Format, 0, 0, 0, (.)Width, (.)Height, (.)Depth, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(uint8[] data, int x, int y, int z, int w, int h, int d, int level = 0)
		{
			FNA3D_binding.SetTextureData3D(_device, _handle, Format, (.)x, (.)y, (.)z, (.)w, (.)h, (.)d, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(Color[] data, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureData3D(_device, _handle, Format, 0, 0, 0, (.)Width, (.)Height, (.)Depth, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void SetData(Color[] data, int x, int y, int z, int w, int h, int d, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureData3D(_device, _handle, Format, (.)x, (.)y, (.)z, (.)w, (.)h, (.)d, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void GetData(uint8[] dest, int level = 0)
		{
			FNA3D_binding.GetTextureData3D(_device, _handle, Format, 0, 0, 0, (.)Width, (.)Height, (.)Depth, (.)level, dest.CArray(), (.)dest.Count);
		}

		public void GetData(uint8[] dest, int x, int y, int z, int w, int h, int d, int level = 0)
		{
			FNA3D_binding.GetTextureData3D(_device, _handle, Format, (.)x, (.)y, (.)z, (.)w, (.)h, (.)d, (.)level, dest.CArray(), (.)dest.Count);
		}
	}
}
