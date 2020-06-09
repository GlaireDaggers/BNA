using System;
using BNA.bindings;

namespace BNA.Graphics
{
	public abstract class RenderBuffer : IDisposable
	{
		public readonly int Width;
		public readonly int Height;
		public readonly int MultiSampleCount;

		protected FNA3D_DeviceHandle* _deviceHandle;
		protected FNA3D_Renderbuffer* _handle;

		protected this(GraphicsDevice graphicsDevice, int width, int height, int multisampleCount)
		{
			_deviceHandle = graphicsDevice.[Friend]_deviceHandle;
			Width = width;
			Height = height;
			MultiSampleCount = multisampleCount;
		}

		public virtual void Dispose()
		{
			if(_handle != null)
			{
				FNA3D_binding.AddDisposeRenderbuffer(_deviceHandle, _handle);
			}

			_handle = null;
			_deviceHandle = null;
		}
	}

	public sealed class ColorRenderBuffer : RenderBuffer
	{
		public readonly SurfaceFormat Format;
		public readonly Texture Texture;

		private RenderTargetBinding _targetBinding;

		public this(GraphicsDevice graphicsDevice, Texture2D texture, int multisampleCount = 1)
			: base(graphicsDevice, texture.Width, texture.Height, multisampleCount)
		{
			Format = texture.Format;
			Texture = texture;
			_handle = FNA3D_binding.GenColorRenderbuffer(_deviceHandle, (.)texture.Width, (.)texture.Height, texture.Format, (.)multisampleCount, Texture.[Friend]_handle);

			_targetBinding = RenderTargetBinding();
			_targetBinding.colorBuffer = _handle;
			_targetBinding.type = RenderTargetBinding.TYPE_2D;
			_targetBinding.dimensions.twod.width = (.)texture.Width;
			_targetBinding.dimensions.twod.height = (.)texture.Height;
			_targetBinding.levelCount = (.)texture.MipCount;
			_targetBinding.multiSampleCount = (.)multisampleCount;
			_targetBinding.texture = Texture.[Friend]_handle;
		}

		public this(GraphicsDevice graphicsDevice, TextureCube texture, CubemapFace face, int multisampleCount = 1)
			: base(graphicsDevice, texture.Size, texture.Size, multisampleCount)
		{
			Format = texture.Format;
			Texture = texture;
			_handle = FNA3D_binding.GenColorRenderbuffer(_deviceHandle, (.)texture.Size, (.)texture.Size, texture.Format, (.)multisampleCount, Texture.[Friend]_handle);

			_targetBinding = RenderTargetBinding();
			_targetBinding.colorBuffer = _handle;
			_targetBinding.type = RenderTargetBinding.TYPE_CUBE;
			_targetBinding.dimensions.cube.size = (.)texture.Size;
			_targetBinding.dimensions.cube.face = face;
			_targetBinding.levelCount = (.)texture.MipCount;
			_targetBinding.multiSampleCount = (.)multisampleCount;
			_targetBinding.texture = Texture.[Friend]_handle;
		}

		public ~this()
		{
			Dispose();
		}
	}

	public sealed class DepthStencilRenderBuffer : RenderBuffer
	{
		public readonly DepthFormat Format;

		public this(GraphicsDevice graphicsDevice, DepthFormat format, int width, int height, int multisampleCount = 1)
			: base(graphicsDevice, width, height, multisampleCount)
		{
			Format = format;
			_handle = FNA3D_binding.GenDepthStencilRenderbuffer(_deviceHandle, (.)width, (.)height, format, (.)multisampleCount);
		}

		public ~this()
		{
			Dispose();
		}
	}
}
