using System;

using BNA.bindings;
using BNA.Math;

namespace BNA.Graphics
{
	[CRepr]
	public struct Color
	{
		public static readonly Color White = .(1f, 1f, 1f);
		public static readonly Color Black = .(0f, 0f, 0f);

		public uint8 r;
		public uint8 g;
		public uint8 b;
		public uint8 a;

		public this(uint8 r, uint8 g, uint8 b, uint8 a = 255)
		{
			this.r = r;
			this.g = g;
			this.b = b;
			this.a = a;
		}

		public this(float r, float g, float b, float a = 1f)
		{
			this.r = (.)( r * 255f );
			this.g = (.)( g * 255f );
			this.b = (.)( b * 255f );
			this.a = (.)( a * 255f );
		}

		public static operator Vec4(Color color)
		{
			return Vec4(color.r / 255f, color.g / 255f, color.b / 255f, color.a / 255f);
		}
	}

	[CRepr]
	public struct Rect
	{
		public int32 x;
		public int32 y;
		public int32 w;
		public int32 h;

		public this(int x, int y, int w, int h)
		{
			this.x = (.)x;
			this.y = (.)y;
			this.w = (.)w;
			this.h = (.)h;
		}
	}

	[CRepr]
	public struct Viewport
	{
		public int32 x;
		public int32 y;
		public int32 w;
		public int32 h;
		public float minDepth;
		public float maxDepth;

		public this(int x, int y, int w, int h, float minDepth = 0f, float maxDepth = 1f)
		{
			this.x = (.)x;
			this.y = (.)y;
			this.w = (.)w;
			this.h = (.)h;
			this.minDepth = minDepth;
			this.maxDepth = maxDepth;
		}
	}

	[CRepr]
	public struct BlendState
	{
		public Blend colorSourceBlend;
		public Blend colorDestBlend;
		public BlendFunction colorBlendFunction;

		public Blend alphaSourceBlend;
		public Blend alphaDestBlend;
		public BlendFunction alphaBlendFunction;

		public ColorWriteChannels colorWriteEnable;
		public ColorWriteChannels colorWriteEnable1;
		public ColorWriteChannels colorWriteEnable2;
		public ColorWriteChannels colorWriteEnable3;

		public Color blendFactor;

		public int32 multiSampleMask;

		public this(Blend src, Blend dst)
		{
			colorSourceBlend = src;
			alphaSourceBlend = src;
			colorDestBlend = dst;
			alphaDestBlend = dst;

			colorBlendFunction = .Add;
			alphaBlendFunction = .Add;

			colorWriteEnable = .All;
			colorWriteEnable1 = .All;
			colorWriteEnable2 = .All;
			colorWriteEnable3 = .All;

			blendFactor = Color(255, 255, 255, 255);

			multiSampleMask = (int32)0xffffffff;
		}

		public this(Blend src, Blend dst, BlendFunction func)
		{
			colorSourceBlend = src;
			alphaSourceBlend = src;
			colorDestBlend = dst;
			alphaDestBlend = dst;

			colorBlendFunction = func;
			alphaBlendFunction = func;

			colorWriteEnable = .All;
			colorWriteEnable1 = .All;
			colorWriteEnable2 = .All;
			colorWriteEnable3 = .All;

			blendFactor = Color(255, 255, 255, 255);

			multiSampleMask = (int32)0xffffffff;
		}

		public this(Blend srcColor, Blend srcAlpha, Blend dstColor, Blend dstAlpha)
		{
			colorSourceBlend = srcColor;
			alphaSourceBlend = srcAlpha;
			colorDestBlend = dstColor;
			alphaDestBlend = dstAlpha;

			colorBlendFunction = .Add;
			alphaBlendFunction = .Add;

			colorWriteEnable = .All;
			colorWriteEnable1 = .All;
			colorWriteEnable2 = .All;
			colorWriteEnable3 = .All;

			blendFactor = Color(255, 255, 255, 255);

			multiSampleMask = (int32)0xffffffff;
		}

		public this(Blend srcColor, Blend srcAlpha, Blend dstColor, Blend dstAlpha, BlendFunction colorFunc, BlendFunction alphaFunc)
		{
			colorSourceBlend = srcColor;
			alphaSourceBlend = srcAlpha;
			colorDestBlend = dstColor;
			alphaDestBlend = dstAlpha;

			colorBlendFunction = colorFunc;
			alphaBlendFunction = alphaFunc;

			colorWriteEnable = .All;
			colorWriteEnable1 = .All;
			colorWriteEnable2 = .All;
			colorWriteEnable3 = .All;

			blendFactor = Color(255, 255, 255, 255);

			multiSampleMask = (int32)0xffffffff;
		}
	}

	public struct DepthStencilState
	{
		public bool depthBufferEnable;
		public bool depthBufferWriteEnable;
		public CompareFunction depthBufferFunction;
		public bool stencilEnable;
		public int32 stencilMask;
		public int32 stencilWriteMask;
		public bool twoSidedStencilMode;
		public StencilOperation stencilFail;
		public StencilOperation stencilDepthBufferFail;
		public StencilOperation stencilPass;
		public CompareFunction stencilFunction;
		public StencilOperation ccwStencilFail;
		public StencilOperation ccwStencilDepthBufferFail;
		public StencilOperation ccwStencilPass;
		public CompareFunction ccwStencilFunction;
		public int32 referenceStencil;

		public static operator FNADepthStencilState(DepthStencilState obj)
		{
			var state = FNADepthStencilState();
			state.depthBufferEnable = obj.depthBufferEnable ? 1 : 0;
			state.depthBufferWriteEnable = obj.depthBufferWriteEnable ? 1 : 0;
			state.depthBufferFunction = obj.depthBufferFunction;
			state.stencilEnable = obj.stencilEnable ? 1 : 0;
			state.stencilMask = obj.stencilMask;
			state.stencilWriteMask = obj.stencilWriteMask;
			state.twoSidedStencilMode = obj.twoSidedStencilMode ? 1 : 0;
			state.stencilFail = obj.stencilFail;
			state.stencilDepthBufferFail = obj.stencilDepthBufferFail;
			state.stencilPass = obj.stencilPass;
			state.stencilFunction = obj.stencilFunction;
			state.ccwStencilFail = obj.ccwStencilFail;
			state.ccwStencilDepthBufferFail = obj.ccwStencilDepthBufferFail;
			state.ccwStencilPass = obj.ccwStencilPass;
			state.ccwStencilFunction = obj.ccwStencilFunction;
			state.referenceStencil = obj.referenceStencil;

			return state;
		}
	}

	public struct RasterizerState
	{
		public FillMode fillMode;
		public CullMode cullMode;
		public float depthBias;
		public float slopeScaleDepthBias;
		public bool scissorTestEnable;
		public bool multiSampleAntiAlias;

		public static operator FNARasterizerState(RasterizerState obj)
		{
			var state = FNARasterizerState();
			state.fillMode = obj.fillMode;
			state.cullMode = obj.cullMode;
			state.depthBias = obj.depthBias;
			state.slopeScaleDepthBias = obj.slopeScaleDepthBias;
			state.scissorTestEnable = obj.scissorTestEnable ? 1 : 0;
			state.multiSampleAntiAlias = obj.multiSampleAntiAlias ? 1 : 0;

			return state;
		}
	}

	[CRepr]
	public struct SamplerState
	{
		public TextureFilter filter;
		public TextureAddressMode addressU;
		public TextureAddressMode addressV;
		public TextureAddressMode addressW;
		public float mipMapLevelOfDetailBias;
		public int32 maxAnisotropy;
		public int32 maxMipLevel;

		public this(TextureFilter filter, TextureAddressMode addressMode, int maxMip = 0, float mipMapBias = 0f, int maxAniso = 0)
		{
			this.filter = filter;
			this.addressU = addressMode;
			this.addressV = addressMode;
			this.addressW = addressMode;
			this.mipMapLevelOfDetailBias = mipMapBias;
			this.maxAnisotropy = (.)maxAniso;
			this.maxMipLevel = (.)maxMip;
		}
	}
}
