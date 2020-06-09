using System;

using BNA;
using BNA.Graphics;
using BNA.Math;

namespace BNA.bindings
{
	typealias FNA3D_LogFunc = function void(char8* msg);

	typealias FNA3D_Image_ReadFunc = function int32(void* context, uint8* data, int32 size);
	typealias FNA3D_Image_SkipFunc = function void(void* context, int32 n);
	typealias FNA3D_Image_EOFFunc = function int32(void* context);
	typealias FNA3D_Image_WriteFunc = function void(void* context, uint8* data, int32 size);

	[CRepr] public struct FNA3D_DeviceHandle {}
	[CRepr] public struct FNA3D_Texture {}
	[CRepr] public struct FNA3D_Buffer {}
	[CRepr] public struct FNA3D_Renderbuffer {}
	[CRepr] public struct FNA3D_Effect {}
	[CRepr] public struct FNA3D_Query {}

	[CRepr]
	public struct FNAPresentationParameters
	{
		public int32 backBufferWidth;
		public int32 backBufferHeight;
		public SurfaceFormat backBufferFormat;
		public int32 multiSampleCount;
		public void* deviceWindowHandle;
		public uint8 isFullScreen;
		public DepthFormat depthStencilFormat;
		public PresentInterval presentationInterval;
		public DisplayOrientation displayOrientation;
		public RenderTargetUsage renderTargetUsage;
	}

	[CRepr]
	public struct FNADepthStencilState
	{
		public uint8 depthBufferEnable;
		public uint8 depthBufferWriteEnable;
		public CompareFunction depthBufferFunction;
		public uint8 stencilEnable;
		public int32 stencilMask;
		public int32 stencilWriteMask;
		public uint8 twoSidedStencilMode;
		public StencilOperation stencilFail;
		public StencilOperation stencilDepthBufferFail;
		public StencilOperation stencilPass;
		public CompareFunction stencilFunction;
		public StencilOperation ccwStencilFail;
		public StencilOperation ccwStencilDepthBufferFail;
		public StencilOperation ccwStencilPass;
		public CompareFunction ccwStencilFunction;
		public int32 referenceStencil;
	}

	[CRepr]
	public struct FNARasterizerState
	{
		public FillMode fillMode;
		public CullMode cullMode;
		public float depthBias;
		public float slopeScaleDepthBias;
		public uint8 scissorTestEnable;
		public uint8 multiSampleAntiAlias;
	}

	[CRepr]
	public struct VertexElement
	{
		public int32 offset;
		public VertexElementFormat elementFormat;
		public VertexElementUsage elementUsage;
		public int32 usageIndex;
	}

	[CRepr]
	public struct VertexDeclaration
	{
		public int32 vertexStride;
		public int32 elementCount;
		public VertexElement* elements;
	}

	[CRepr]
	public struct FNAVertexBufferBinding
	{
		public FNA3D_Buffer* vertexBuffer;
		public VertexDeclaration vertexDeclaration;
		public int32 vertexOffset;
		public int32 instanceFrequency;
	}

	[CRepr]
	public struct RenderTargetBinding
	{
		public const uint8 TYPE_2D = 0;
		public const uint8 TYPE_CUBE = 1;

		[CRepr]
		public struct Dimensions2D
		{
			public int32 width;
			public int32 height;
		}

		[CRepr]
		public struct DimensionsCube
		{
			public int32 size;
			public CubemapFace face;
		}

		[CRepr, Union]
		public struct Dimensions
		{
			public Dimensions2D twod;
			public DimensionsCube cube;
		}

		public uint8 type;
		public Dimensions dimensions;
		public int32 levelCount;
		public int32 multiSampleCount;
		public FNA3D_Texture* texture;
		public FNA3D_Renderbuffer* colorBuffer;
	}
}
