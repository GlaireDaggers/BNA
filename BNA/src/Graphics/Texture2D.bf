using System;
using System.Diagnostics;
using BNA.bindings;
using BNA.Utils;

namespace BNA.Graphics
{
	public class Texture2D : Texture
	{
		private struct TexReaderContext
		{
			public uint8[] bytes;
			public int pos;
		}

		private static int32 Image_ReadFunc(void* context, uint8* data, int32 size)
		{
			let ctx = (TexReaderContext*)context;
			let bytesRemaining = ctx.bytes.Count - ctx.pos;
			int bytesRead = size;

			if(size > bytesRemaining)
				bytesRead = bytesRemaining;

			if(bytesRead <= 0) return 0;

			//let targetSpan = Span<uint8>(data, bytesRead);
			//ctx.bytes.CopyTo(targetSpan, ctx.pos);

			// for some reason, attempting to construct a span and then CopyTo it is triggering an access violation,
			// so I'll just manually copy the bytes instead I guess
			for(int i = 0; i < bytesRead; i++)
			{
				data[i] = ctx.bytes[ctx.pos + i];
			}

			ctx.pos += bytesRead;

			return (.)bytesRead;
		}

		private static void Image_SkipFunc(void* context, int32 pos)
		{
			let ctx = (TexReaderContext*)context;
			ctx.pos += pos;
		}

		private static int32 Image_EOFFunc(void* context)
		{
			let ctx = (TexReaderContext*)context;
			return ctx.pos >= ctx.bytes.Count ? 1 : 0;
		}

		public static void SetTextureDataYUV(int yW, int yH, int uvW, int uvH, uint8[] data, Texture2D y, Texture2D u, Texture2D v)
		{
			Debug.Assert(y.Format == .ALPHA8 && u.Format == .ALPHA8 && v.Format == .ALPHA8, "All textures passed to SetTextureDataYUV must be alpha8 format!");
			Debug.Assert(y._device == u._device && y._device == v._device, "All textures passed to SetTextureDataYUV must belong to the same GraphicsDevice!" );

			FNA3D_binding.SetTextureDataYUV(y._device, y._handle, u._handle, v._handle, (.)yW, (.)yH, (.)uvW, (.)uvH, data.CArray(), (.)data.Count);
		}

		public static Result<Texture2D> Load(GraphicsDevice graphicsDevice, StringView path, bool mipmap = true)
		{
			let imageBytes = ResourceUtility.ReadAllBytes(path);
			if( imageBytes == null ) return .Err;

			let result = Load(graphicsDevice, imageBytes, mipmap);
			delete imageBytes;

			return result;
		}

		public static Result<Texture2D> Load(GraphicsDevice graphicsDevice, uint8[] imageBytes, bool mipmap = true)
		{
			var ctx = TexReaderContext();
			ctx.bytes = imageBytes;
			ctx.pos = 0;

			int32 w = 0, h = 0, l = 0;
			let mem = FNA3D_binding.Image_Load(=> Image_ReadFunc, => Image_SkipFunc, => Image_EOFFunc, &ctx, &w, &h, &l, -1, -1, 0);

			// image could not be loaded
			if( mem == null )
			{
				return .Err;
			}

			// *slaps top of mip pyramid* this bad boy can fit so many mips
			int mipCount = mipmap ? (int)(Math.Log(Math.Max(w, h))) + 1 : 1;

			let memSpan = Span<uint8>(mem, l);
			var texture = new Texture2D(graphicsDevice, (.)w, (.)h, .Color, 1);
			texture.SetData(memSpan);

			// pro-gamer move right here: create a new temporary render buffer, blit the texture into it, and then call ResolveTarget on that to get a new mip-mapped texture
			// because I'm too lazy to do it myself and tbh I bet the hardware does a better job

			if(mipCount > 1)
			{
				let texture2 = new Texture2D(graphicsDevice, (.)w, (.)h, .Color, mipCount, true);
				let buffer = new ColorRenderBuffer(graphicsDevice, texture2);

				let viewport = graphicsDevice.GetViewport();

				graphicsDevice.SetViewport(.(0, 0, (.)w, (.)h));
				graphicsDevice.PushCurrentRenderTarget();
				graphicsDevice.Blit(texture, buffer);
				graphicsDevice.PopCurrentRenderTarget();
				graphicsDevice.SetViewport(viewport);

				graphicsDevice.ResolveTarget(buffer);

				delete texture;
				texture = texture2;

				delete buffer;
			}

			return texture;
		}

		public readonly int Width;
		public readonly int Height;
		public readonly SurfaceFormat Format;
		public readonly int MipCount;

		public this(GraphicsDevice graphicsDevice, int width, int height, SurfaceFormat format = .Color, int mipCount = 1, bool isRenderTarget = false)
			: base(graphicsDevice)
		{
			Width = width;
			Height = height;
			Format = format;
			MipCount = mipCount;
			_handle = FNA3D_binding.CreateTexture2D(_device, format, (.)width, (.)height, (.)mipCount, isRenderTarget ? 1 : 0);
		}

		public ~this()
		{
			Dispose();
		}

		public void SetData(uint8[] data, int level = 0)
		{
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, 0, 0, (.)Width, (.)Height, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(uint8[] data, int x, int y, int w, int h, int level = 0)
		{
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, (.)level, data.CArray(), (.)data.Count);
		}

		public void SetData(Span<uint8> data, int level = 0)
		{
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, 0, 0, (.)Width, (.)Height, (.)level, data.Ptr, (.)data.Length);
		}

		public void SetData(Span<uint8> data, int x, int y, int w, int h, int level = 0)
		{
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, (.)level, data.Ptr, (.)data.Length);
		}

		public void SetData(Color[] data, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, 0, 0, (.)Width, (.)Height, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void SetData(Color[] data, int x, int y, int w, int h, int level = 0)
		{
			Debug.Assert(Format == .Color, "Cannot assign Color[] data to non-RGBA32 texture! Use one of the raw uint8[] SetData overloads instead!");
			FNA3D_binding.SetTextureData2D(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, (.)level, data.CArray(), (.)data.Count * sizeof(Color));
		}

		public void GetData(uint8[] dest, int level = 0)
		{
			FNA3D_binding.GetTextureData2D(_device, _handle, Format, 0, 0, (.)Width, (.)Height, (.)level, dest.CArray(), (.)dest.Count);
		}

		public void GetData(uint8[] dest, int x, int y, int w, int h, int level = 0)
		{
			FNA3D_binding.GetTextureData2D(_device, _handle, Format, (.)x, (.)y, (.)w, (.)h, (.)level, dest.CArray(), (.)dest.Count);
		}
	}
}
