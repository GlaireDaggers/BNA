using System;
using BNA.bindings;

namespace BNA.Graphics
{
	public sealed class IndexBuffer : IDisposable
	{
		private FNA3D_DeviceHandle* _device;
		private FNA3D_Buffer* _buffer;

		private int _capacity;
		private int _count;
		private bool _dynamic;
		private IndexElementSize _elementType;

		public int IndicesCount => _count;

		public this(GraphicsDevice graphicsDevice, bool dynamic = false)
		{
			_device = graphicsDevice.[Friend]_deviceHandle;
			_buffer = null;

			_capacity = 0;
			_dynamic = dynamic;
			_elementType = .u16;
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			if( _buffer != null )
			{
				FNA3D_binding.AddDisposeIndexBuffer(_device, _buffer);
			}

			_device = null;
			_buffer = null;
		}

		public void Set(uint16[] data)
		{
			if(data.Count > _capacity || _elementType != .u16)
			{
				// we have to reallocate buffer in this case
				if( _buffer != null )
				{
					FNA3D_binding.AddDisposeIndexBuffer(_device, _buffer);
				}

				_buffer = FNA3D_binding.GenIndexBuffer(_device, _dynamic ? 1 : 0, .WriteOnly, (.)data.Count, .u16);
				_capacity = data.Count;
				_elementType = .u16;
			}

			_count = data.Count;

			FNA3D_binding.SetIndexBufferData(_device, _buffer, 0, data.CArray(), (.)_count * sizeof(uint16), .Discard);
		}

		public void Set(uint32[] data)
		{
			if(data.Count > _capacity || _elementType != .u32)
			{
				// we have to reallocate buffer in this case
				if( _buffer != null )
				{
					FNA3D_binding.AddDisposeIndexBuffer(_device, _buffer);
				}

				_buffer = FNA3D_binding.GenIndexBuffer(_device, _dynamic ? 1 : 0, .WriteOnly, (.)data.Count, .u32);
				_capacity = data.Count;

				_elementType = .u32;
			}

			_count = data.Count;

			FNA3D_binding.SetIndexBufferData(_device, _buffer, 0, data.CArray(), (.)_count * sizeof(uint32), .Discard);
		}
	}
}
