using System;
using System.Collections;
using BNA.bindings;
using BNA.Math;
using BNA.Utils;

namespace BNA.Graphics
{
	public sealed class GraphicsDevice : IDisposable
	{
		[Packed, Reflect]
		private struct BlitVertex
		{
			[VertexUsage(.Position)]
			public Vec4 Position;

			[VertexUsage(.TextureCoordinate)]
			public Vec4 UV;

			public this(Vec2 position, Vec2 uv)
			{
				Position = Vec4(position.x, position.y, 0.5f, 1f);
				UV = Vec4(uv.x, uv.y, 0f, 0f);
			}
		}

		private struct RenderTarget
		{
			public RenderTargetBinding* bindings;
			public int numBindings;
			public FNA3D_Renderbuffer* depthStencilBuffer;
			public DepthFormat depthFormat;

			public this()
			{
				bindings = null;
				numBindings = 0;
				depthStencilBuffer = null;
				depthFormat = .None;
			}

			public this(RenderTargetBinding* bindings, int numBindings, FNA3D_Renderbuffer* depthStencilBuffer, DepthFormat depthFormat)
			{
				this.bindings = bindings;
				this.numBindings = numBindings;
				this.depthStencilBuffer = depthStencilBuffer;
				this.depthFormat = depthFormat;
			}
		}

		public SurfaceFormat BackbufferFormat
		{
			get
			{
				return _presentationParams.backBufferFormat;
			}
			set
			{
				_presentationParams.backBufferFormat = value;
				_isDirty = true;
			}
		}

		public DepthFormat DepthStencilFormat
		{
			get
			{
				return _presentationParams.depthStencilFormat;
			}
			set
			{
				_presentationParams.depthStencilFormat = value;
				_isDirty = true;
			}
		}

		public int TargetWidth
		{
			get
			{
				let binding = _targetStack[_targetStack.Count - 1];

				if(binding.numBindings == 0)
					return BackbufferWidth;

				return binding.bindings[0].dimensions.twod.width;
			}
		}

		public int TargetHeight
		{
			get
			{
				let binding = _targetStack[_targetStack.Count - 1];

				if(binding.numBindings == 0)
					return BackbufferHeight;

				return binding.bindings[0].dimensions.twod.height;
			}
		}

		public int BackbufferWidth
		{
			get
			{
				return _presentationParams.backBufferWidth;
			}
			set
			{
				_presentationParams.backBufferWidth = (.)value;
				_isDirty = true;
			}
		}

		public int BackbufferHeight
		{
			get
			{
				return _presentationParams.backBufferHeight;
			}
			set
			{
				_presentationParams.backBufferHeight = (.)value;
				_isDirty = true;
			}
		}

		public DisplayOrientation Orientation
		{
			get
			{
				return _presentationParams.displayOrientation;
			}
			set
			{
				_presentationParams.displayOrientation = (.)value;
				_isDirty = true;
			}
		}

		public bool IsFullscreen
		{
			get
			{
				return _presentationParams.isFullScreen == 0 ? false : true;
			}
			set
			{
				_presentationParams.isFullScreen = value ? 1 : 0;
				_isDirty = true;
			}
		}

		public int MultiSampleCount
		{
			get
			{
				return _presentationParams.multiSampleCount;
			}
			set
			{
				_presentationParams.multiSampleCount = (.)value;
				_isDirty = true;
			}
		}

		public PresentInterval PresentInterval
		{
			get
			{
				return _presentationParams.presentationInterval;
			}
			set
			{
				_presentationParams.presentationInterval = value;
				FNA3D_binding.SetPresentationInterval(_deviceHandle, value);
			}
		}

		public RenderTargetUsage RenderTargetUsage
		{
			get
			{
				return _presentationParams.renderTargetUsage;
			}
			set
			{
				_presentationParams.renderTargetUsage = value;
				_isDirty = true;
			}
		}

		public Color BlendFactor
		{
			get
			{
				Color color = default;
				FNA3D_binding.GetBlendFactor(_deviceHandle, &color);
				return color;
			}
			set
			{
				Color color = value;
				FNA3D_binding.SetBlendFactor(_deviceHandle, &color);
			}
		}

		public int32 MultiSampleMask
		{
			get
			{
				return FNA3D_binding.GetMultiSampleMask(_deviceHandle);
			}
			set
			{
				FNA3D_binding.SetMultiSampleMask(_deviceHandle, value);
			}
		}

		public int32 ReferenceStencil
		{
			get
			{
				return FNA3D_binding.GetReferenceStencil(_deviceHandle);
			}
			set
			{
				FNA3D_binding.SetReferenceStencil(_deviceHandle, value);
			}
		}

		private FNA3D_DeviceHandle* _deviceHandle;
		private FNAPresentationParameters _presentationParams;

		private bool _isDirty;

		private Effect _blit;
		private VertexBuffer _blitQuadVertexBuffer;
		private IndexBuffer _blitQuadIndexBuffer;

		private Viewport _viewport;

		private List<RenderTarget> _targetStack = new List<RenderTarget>() ~ delete _;

		private BlendState _blendState;
		private DepthStencilState _dsState;

		public this( int backbufferWidth, int backbufferHeight, SurfaceFormat backbufferFormat, int multiSampleCount, DepthFormat depthStencilFormat, RenderTargetUsage renderTargetUsage,
			PresentInterval presentInverval, DisplayOrientation orientation, GameWindow window, bool isFullscreen )
		{
			_presentationParams = FNAPresentationParameters();
			_presentationParams.backBufferFormat = backbufferFormat;
			_presentationParams.backBufferWidth = (.)backbufferWidth;
			_presentationParams.backBufferHeight = (.)backbufferHeight;
			_presentationParams.depthStencilFormat = depthStencilFormat;
			_presentationParams.deviceWindowHandle = window.Handle;
			_presentationParams.displayOrientation = orientation;
			_presentationParams.isFullScreen = isFullscreen ? 1 : 0;
			_presentationParams.multiSampleCount = (.)multiSampleCount;
			_presentationParams.presentationInterval = presentInverval;
			_presentationParams.renderTargetUsage = renderTargetUsage;

			_isDirty = false;

#if DEBUG
			_deviceHandle = FNA3D_binding.CreateDevice( &_presentationParams, 1 );
#else
			_deviceHandle = FNA3D_binding.CreateDevice( &_presentationParams, 0 );
#endif

			// some default initial setup...
			SetViewport(.(0, 0, backbufferWidth, backbufferHeight));

			var dsState = DepthStencilState();
			dsState.depthBufferEnable = true;
			dsState.stencilEnable = true;

			SetDepthStencilState(dsState);

			_targetStack.Add(RenderTarget());

			LoadBuiltins();
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			DisposeResource!(_blit);
			DisposeResource!(_blitQuadVertexBuffer);
			DisposeResource!(_blitQuadIndexBuffer);

			if(_deviceHandle != null)
			{
				FNA3D_binding.DestroyDevice(_deviceHandle);
				_deviceHandle = null;
			}
		}

		private mixin DisposeResource(var resource)
		{
			if(resource != null)
			{
				delete resource;
				resource = null;
			}
		}

		private void LoadBuiltins()
		{
			// built-in effects
			let blitBytes = ResourceUtility.ReadAllBytes("./Content/Shaders/blit.fxo");
			_blit = new Effect( this, blitBytes );
			delete blitBytes;

			// blit quad geometry
			_blitQuadVertexBuffer = new VertexBuffer(this);
			_blitQuadIndexBuffer = new IndexBuffer(this);
			{
				let blitQuadVertices = scope BlitVertex[](
					BlitVertex(Vec2(-1f, 1f), Vec2(0f, 0f)),
					BlitVertex(Vec2(1f, 1f), Vec2(1f, 0f)),
					BlitVertex(Vec2(1f, -1f), Vec2(1f, 1f)),
					BlitVertex(Vec2(-1f, -1f), Vec2(0f, 1f)),
					);
				_blitQuadVertexBuffer.Set(blitQuadVertices);

				let blitQuadIndices = scope uint16[](
					0, 1, 3,
					1, 2, 3
					);
				_blitQuadIndexBuffer.Set(blitQuadIndices);
			}
		}

		public void FlushChanges()
		{
			if( _isDirty )
			{
				_isDirty = false;
				FNA3D_binding.ResetBackbuffer( _deviceHandle, &_presentationParams );
			}
		}

		public void BeginFrame()
		{
			FlushChanges();
			FNA3D_binding.BeginFrame(_deviceHandle);
		}

		public void Clear(ClearOptions options, Color color, float depth = 0f, int stencil = 0)
		{
			Vec4 clearCol = (.)color;
			FNA3D_binding.Clear(_deviceHandle, options, &clearCol, depth, (.)stencil);
		}

		public void Blit(Texture2D source, ColorRenderBuffer dest)
		{
			_blit.SetTexture("Tex", source, .(.Linear, .Clamp, 0));
			_blit.ApplyEffect(0);

			SetRenderTarget(dest);
			DrawIndexedPrimitives(.TriangleList, _blitQuadVertexBuffer, 2, _blitQuadIndexBuffer);
		}

		public void Present()
		{
			FNA3D_binding.SwapBuffers(_deviceHandle, null, null, _presentationParams.deviceWindowHandle);
		}

		public void Present(Rect source, Rect dest)
		{
			var src = source;
			var dst = dest;
			FNA3D_binding.SwapBuffers(_deviceHandle, &src, &dst, _presentationParams.deviceWindowHandle);
		}

		public void DrawIndexedPrimitives(PrimitiveType type, VertexBuffer buffer, int primitiveCount, IndexBuffer indexBuffer)
		{
			let numVertices = buffer.[Friend]_count;

			FNA3D_binding.ApplyVertexBufferBindings(_deviceHandle, &(buffer.[Friend]_binding), 1, 1, (.)0);
			FNA3D_binding.DrawIndexedPrimitives(_deviceHandle, type, (.)0, 0, (.)numVertices, (.)0, (.)primitiveCount, indexBuffer.[Friend]_buffer, indexBuffer.[Friend]_elementType);
		}

		public void DrawIndexedPrimitives(PrimitiveType type, VertexBufferSpan buffer, int primitiveCount, IndexBuffer indexBuffer)
		{
			FNA3D_binding.ApplyVertexBufferBindings(_deviceHandle, &(buffer.Buffer.[Friend]_binding), 1, 1, (.)buffer.StartIndex);
			FNA3D_binding.DrawIndexedPrimitives(_deviceHandle, type, (.)buffer.StartIndex, 0, (.)buffer.Length, (.)0, (.)primitiveCount, indexBuffer.[Friend]_buffer, indexBuffer.[Friend]_elementType);
		}

		public void DrawIndexedPrimitives(PrimitiveType type, VertexBuffer buffer, int baseVertex, int numVertices, int startIndex, int primitiveCount, IndexBuffer indexBuffer)
		{
			FNA3D_binding.ApplyVertexBufferBindings(_deviceHandle, &(buffer.[Friend]_binding), 1, 1, (.)baseVertex);
			FNA3D_binding.DrawIndexedPrimitives(_deviceHandle, type, (.)baseVertex, 0, (.)numVertices, (.)startIndex, (.)primitiveCount, indexBuffer.[Friend]_buffer, indexBuffer.[Friend]_elementType);
		}

		public void DrawIndexedPrimitives(PrimitiveType type, int baseVertex, int numVertices, int startIndex, int primitiveCount, IndexBuffer indexBuffer)
		{
			FNA3D_binding.DrawIndexedPrimitives(_deviceHandle, type, (.)baseVertex, 0, (.)numVertices, (.)startIndex, (.)primitiveCount, indexBuffer.[Friend]_buffer, indexBuffer.[Friend]_elementType);
		}

		public void DrawInstancedPrimitives(PrimitiveType type, int baseVertex, int numVertices, int startIndex, int primitiveCount, int instanceCount, IndexBuffer indexBuffer)
		{
			FNA3D_binding.DrawInstancedPrimitives(_deviceHandle, type, (.)baseVertex, 0, (.)numVertices, (.)startIndex, (.)primitiveCount, (.)instanceCount, indexBuffer.[Friend]_buffer, indexBuffer.[Friend]_elementType);
		}

		public void DrawPrimitives(PrimitiveType type, int vertexStart, int primitiveCount)
		{
			FNA3D_binding.DrawPrimitives(_deviceHandle, type, (.)vertexStart, (.)primitiveCount);
		}

		public void SetViewport(Viewport viewport)
		{
			_viewport = viewport;
			FNA3D_binding.SetViewport(_deviceHandle, &_viewport);
		}

		public Viewport GetViewport()
		{
			return _viewport;
		}

		public void SetScissorRect(Rect scissorRect)
		{
			var rect = scissorRect;
			FNA3D_binding.SetScissorRect(_deviceHandle, &rect);
		}

		public BlendState GetBlendState()
		{
			return _blendState;
		}

		public void SetBlendState(BlendState blendState)
		{
			_blendState = blendState;
			FNA3D_binding.SetBlendState(_deviceHandle, &_blendState);
		}

		public DepthStencilState GetDepthStencilState()
		{
			return _dsState;
		}

		public void SetDepthStencilState(DepthStencilState depthStencilState)
		{
			_dsState = depthStencilState;
			FNADepthStencilState state = (.)depthStencilState;
			FNA3D_binding.SetDepthStencilState(_deviceHandle, &state);
		}

		public void ApplyRasterizerState(RasterizerState rasterizerState)
		{
			FNARasterizerState state = (.)rasterizerState;
			FNA3D_binding.ApplyRasterizerState(_deviceHandle, &state);
		}

		public void VerifySampler(int index, Texture texture, SamplerState samplerState)
		{
			var state = samplerState;
			FNA3D_binding.VerifySampler(_deviceHandle, (.)index, texture.[Friend]_handle, &state);
		}

		public void VerifyVertexSampler(int index, Texture texture, SamplerState samplerState)
		{
			var state = samplerState;
			FNA3D_binding.VerifyVertexSampler(_deviceHandle, (.)index, texture.[Friend]_handle, &state);
		}

		public void ApplyVertexBufferBinding(VertexBuffer buffer, bool bindingsUpdated = true, int baseVertex = 0)
		{
			FNA3D_binding.ApplyVertexBufferBindings(_deviceHandle, &(buffer.[Friend]_binding), 1, bindingsUpdated ? 1 : 0, (.)baseVertex);
		}

		public void ApplyVertexBufferBindings(VertexBuffer[] buffers, bool bindingsUpdated = true, int baseVertex = 0)
		{
			FNAVertexBufferBinding[] bindings = scope FNAVertexBufferBinding[buffers.Count];

			for(int i = 0; i < bindings.Count; i++)
			{
				bindings[i] = buffers[i].[Friend]_binding;
			}

			FNA3D_binding.ApplyVertexBufferBindings(_deviceHandle, bindings.CArray(), (.)bindings.Count, bindingsUpdated ? 1 : 0, (.)baseVertex);
		}

		public void SetRenderTarget( ColorRenderBuffer renderTarget )
		{
			let renderTargetBinding = renderTarget == null ? null : &renderTarget.[Friend]_targetBinding;
			FNA3D_binding.SetRenderTargets(_deviceHandle, renderTargetBinding, renderTarget == null ? 0 : 1, null, .None);

			_targetStack[_targetStack.Count - 1] = .(renderTargetBinding, renderTarget == null ? 0 : 1, null, .None);
		}

		public void SetRenderTarget( ColorRenderBuffer renderTarget, DepthStencilRenderBuffer depthStencilTarget )
		{
			let renderTargetBinding = renderTarget == null ? null : &renderTarget.[Friend]_targetBinding;

			DepthFormat depthFormat = depthStencilTarget?.Format ?? .None;
			FNA3D_binding.SetRenderTargets(_deviceHandle, renderTargetBinding, renderTarget == null ? 0 : 1, depthStencilTarget?.[Friend]_handle ?? null, depthFormat);

			_targetStack[_targetStack.Count - 1] = .(renderTargetBinding, renderTarget == null ? 0 : 1, depthStencilTarget?.[Friend]_handle ?? null, depthFormat);
		}

		public void SetRenderTargets( ColorRenderBuffer[] renderTargets, DepthStencilRenderBuffer depthStencilTarget )
		{
			int renderTargetsCount = renderTargets?.Count ?? 0;
			DepthFormat depthFormat = depthStencilTarget?.Format ?? .None;

			let renderTargetBindings = renderTargets == null ? null : scope RenderTargetBinding[ renderTargets.Count ];
			for(int i = 0; i < renderTargetsCount; i++)
			{
				let buffer = renderTargets[i];

				renderTargetBindings[i] = buffer.[Friend]_targetBinding;
			}

			FNA3D_binding.SetRenderTargets(_deviceHandle, renderTargetBindings.CArray(), (.)renderTargetsCount, depthStencilTarget?.[Friend]_handle ?? null, depthFormat);

			_targetStack[_targetStack.Count - 1] = .(renderTargetBindings.CArray(), (.)renderTargetsCount, depthStencilTarget?.[Friend]_handle ?? null, depthFormat);
		}

		public void PushCurrentRenderTarget()
		{
			_targetStack.Add(_targetStack[_targetStack.Count - 1]);
		}

		public void PopCurrentRenderTarget()
		{
			_targetStack.RemoveAtFast(_targetStack.Count - 1);
			let target = _targetStack[_targetStack.Count - 1];

			FNA3D_binding.SetRenderTargets(_deviceHandle, target.bindings, (.)target.numBindings, target.depthStencilBuffer, target.depthFormat);
		}

		public void ResolveTarget( ColorRenderBuffer renderTarget )
		{
			FNA3D_binding.ResolveTarget(_deviceHandle, &renderTarget.[Friend]_targetBinding);
		}

		public void ResetBackbuffer( int backbufferWidth, int backbufferHeight, SurfaceFormat backbufferFormat, int multiSampleCount, DepthFormat depthStencilFormat, RenderTargetUsage renderTargetUsage,
			PresentInterval presentInverval, DisplayOrientation orientation, GameWindow window, bool isFullscreen )
		{
			_presentationParams = FNAPresentationParameters();
			_presentationParams.backBufferFormat = backbufferFormat;
			_presentationParams.backBufferWidth = (.)backbufferWidth;
			_presentationParams.backBufferHeight = (.)backbufferHeight;
			_presentationParams.depthStencilFormat = depthStencilFormat;
			_presentationParams.deviceWindowHandle = window.Handle;
			_presentationParams.displayOrientation = orientation;
			_presentationParams.isFullScreen = isFullscreen ? 1 : 0;
			_presentationParams.multiSampleCount = (.)multiSampleCount;
			_presentationParams.presentationInterval = presentInverval;
			_presentationParams.renderTargetUsage = renderTargetUsage;

			_isDirty = false;

			FNA3D_binding.ResetBackbuffer(_deviceHandle, &_presentationParams);
		}

		public void ReadBackbuffer(uint8[] dest)
		{
			FNA3D_binding.ReadBackbuffer(_deviceHandle, 0, 0, (.)BackbufferWidth, (.)BackbufferHeight, dest.CArray(), (.)dest.Count);
		}

		public void ReadBackbuffer(uint8[] dest, int x, int y, int w, int h)
		{
			FNA3D_binding.ReadBackbuffer(_deviceHandle, (.)x, (.)y, (.)w, (.)h, dest.CArray(), (.)dest.Count);
		}
	}
}
