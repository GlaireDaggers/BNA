using System;
using BNA.bindings;

namespace BNA.Graphics
{
	public abstract class Texture : IDisposable
	{
		protected FNA3D_DeviceHandle* _device;
		protected FNA3D_Texture* _handle;

		protected this(GraphicsDevice graphicsDevice)
		{
			_device = graphicsDevice.[Friend]_deviceHandle;
		}

		public void Dispose()
		{
			if( _handle != null )
			{
				FNA3D_binding.AddDisposeTexture(_device, _handle);

				_device = null;
				_handle = null;
			}
		}
	}
}
