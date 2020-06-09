using System;

namespace BNA.Graphics
{
	[CRepr]
	public enum SurfaceFormat : int32
	{
		Color,
		BGR565,
		BGRA5551,
		BGRA4444,
		DXT1,
		DXT3,
		DXT5,
		NORMALIZEDBYTE2,
		NORMALIZEDBYTE4,
		RGBA1010102,
		RG32,
		RGBA64,
		ALPHA8,
		SINGLE,
		VECTOR2,
		VECTOR4,
		HALFSINGLE,
		HALFVECTOR2,
		HALFVECTOR4,
		HDRBLENDABLE,
		COLORBGRA_EXT
	}

	[CRepr]
	public enum DepthFormat : int32
	{
		None,
		D16,
		D24,
		D24S8
	}

	[CRepr]
	public enum PresentInterval : int32
	{
		Default,
		One,
		Two,
		Immediate
	}

	[CRepr]
	public enum DisplayOrientation : int32
	{
		Default,
		LandscapeLeft,
		LandscapeRight,
		Portrait
	}

	[CRepr]
	public enum RenderTargetUsage : int32
	{
		DiscardContents,
		PreserveContents,
		PlatformContents
	}

	[CRepr]
	public enum ClearOptions : int32
	{
		Target = 1,
		DepthBuffer = 2,
		Stencil = 4
	}

	[CRepr]
	public enum PrimitiveType : int32
	{
		TriangleList,
		TriangleStrip,
		LineList,
		LineStrip,
		PointList_Ext
	}

	[CRepr]
	public enum IndexElementSize : int32
	{
		u16,
		u32
	}

	[CRepr]
	public enum CubemapFace : int32
	{
		PositiveX,
		NegativeX,
		PositiveY,
		NegativeY,
		PositiveZ,
		NegativeZ
	}

	[CRepr]
	public enum BufferUsage : int32
	{
		None,
		WriteOnly
	}

	[CRepr]
	public enum SetDataOptions : int32
	{
		None,
		Discard,
		NoOverwrite
	}

	[CRepr]
	public enum Blend : int32
	{
		One,
		Zero,
		SrcColor,
		InverseSrcColor,
		SrcAlpha,
		InverseSrcAlpha,
		DstColor,
		InverseDstColor,
		DstAlpha,
		InverseDstAlpha,
		BlendFactor,
		InverseBlendFactor,
		SrcAlphaSaturation
	}

	[CRepr]
	public enum BlendFunction : int32
	{
		Add,
		Subtract,
		ReverseSubtract,
		Max,
		Min
	}

	[CRepr]
	public enum ColorWriteChannels : int32
	{
		None = 0,
		Red = 1,
		Green = 2,
		Blue = 4,
		Alpha = 8,
		All = 15
	}

	[CRepr]
	public enum StencilOperation : int32
	{
		Keep,
		Zero,
		Replace,
		Increment,
		Decrement,
		IncrementSaturation,
		DecrementSaturation,
		Invert
	}

	[CRepr]
	public enum CompareFunction : int32
	{
		Always,
		Never,
		Less,
		LessEqual,
		Equal,
		GreaterEqual,
		Greater,
		NotEqual
	}

	[CRepr]
	public enum CullMode : int32
	{
		None,
		CullClockwiseFace,
		CullCounterClockwiseFace
	}

	[CRepr]
	public enum FillMode : int32
	{
		Solid,
		Wireframe
	}

	[CRepr]
	public enum TextureAddressMode : int32
	{
		Wrap,
		Clamp,
		Mirror
	}

	[CRepr]
	public enum TextureFilter : int32
	{
		Linear,
		Point,
		Anisotropic,
		Linear_MipPoint,
		Point_MipLinear,
		MinLinear_MagPoint_MipLinear,
		MinLinear_MagPoint_MipPoint,
		MinPoint_MagLinear_MipLinear,
		MinPoint_MagLinear_MipPoint
	}

	[CRepr]
	public enum VertexElementFormat : int32
	{
		Single,
		Vector2,
		Vector3,
		Vector4,
		Color,
		Byte4,
		Short2,
		Short4,
		NormalizedShort2,
		NormalizedShort4,
		HalfVector2,
		HalfVector4
	}

	[CRepr]
	public enum VertexElementUsage : int32
	{
		Position,
		Color,
		TextureCoordinate,
		Normal,
		Binormal,
		Tangent,
		BlendIndices,
		BlendWeight,
		Depth,
		Fog,
		PointSize,
		Sample,
		TesselateFactor
	}

	public enum ShaderParameterClass
	{
		Scalar=0,
		Vector,
		Matrix_rows,
		Matrix_columns,
		Object,
		Struct
	}

	public enum ShaderParameterType
	{
		void=0,
		bool,
		int,
		float,
		string,
		texture,
		texture1D,
		texture2D,
		texture3D,
		textureCube,
		sampler,
		sampler1D,
		sampler2D,
		sampler3D,
		samplerCube,
		pixelShader,
		vertexShader,
		pixelFragment,
		vertexFragment,
		unsupported
	}
}
