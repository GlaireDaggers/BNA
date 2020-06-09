using System;

namespace BNA.bindings
{
	[CRepr]
	public enum MOJOSHADER_renderStateType : int32
	{
		MOJOSHADER_RS_ZENABLE,
		MOJOSHADER_RS_FILLMODE,
		MOJOSHADER_RS_SHADEMODE,
		MOJOSHADER_RS_ZWRITEENABLE,
		MOJOSHADER_RS_ALPHATESTENABLE,
		MOJOSHADER_RS_LASTPIXEL,
		MOJOSHADER_RS_SRCBLEND,
		MOJOSHADER_RS_DESTBLEND,
		MOJOSHADER_RS_CULLMODE,
		MOJOSHADER_RS_ZFUNC,
		MOJOSHADER_RS_ALPHAREF,
		MOJOSHADER_RS_ALPHAFUNC,
		MOJOSHADER_RS_DITHERENABLE,
		MOJOSHADER_RS_ALPHABLENDENABLE,
		MOJOSHADER_RS_FOGENABLE,
		MOJOSHADER_RS_SPECULARENABLE,
		MOJOSHADER_RS_FOGCOLOR,
		MOJOSHADER_RS_FOGTABLEMODE,
		MOJOSHADER_RS_FOGSTART,
		MOJOSHADER_RS_FOGEND,
		MOJOSHADER_RS_FOGDENSITY,
		MOJOSHADER_RS_RANGEFOGENABLE,
		MOJOSHADER_RS_STENCILENABLE,
		MOJOSHADER_RS_STENCILFAIL,
		MOJOSHADER_RS_STENCILZFAIL,
		MOJOSHADER_RS_STENCILPASS,
		MOJOSHADER_RS_STENCILFUNC,
		MOJOSHADER_RS_STENCILREF,
		MOJOSHADER_RS_STENCILMASK,
		MOJOSHADER_RS_STENCILWRITEMASK,
		MOJOSHADER_RS_TEXTUREFACTOR,
		MOJOSHADER_RS_WRAP0,
		MOJOSHADER_RS_WRAP1,
		MOJOSHADER_RS_WRAP2,
		MOJOSHADER_RS_WRAP3,
		MOJOSHADER_RS_WRAP4,
		MOJOSHADER_RS_WRAP5,
		MOJOSHADER_RS_WRAP6,
		MOJOSHADER_RS_WRAP7,
		MOJOSHADER_RS_WRAP8,
		MOJOSHADER_RS_WRAP9,
		MOJOSHADER_RS_WRAP10,
		MOJOSHADER_RS_WRAP11,
		MOJOSHADER_RS_WRAP12,
		MOJOSHADER_RS_WRAP13,
		MOJOSHADER_RS_WRAP14,
		MOJOSHADER_RS_WRAP15,
		MOJOSHADER_RS_CLIPPING,
		MOJOSHADER_RS_LIGHTING,
		MOJOSHADER_RS_AMBIENT,
		MOJOSHADER_RS_FOGVERTEXMODE,
		MOJOSHADER_RS_COLORVERTEX,
		MOJOSHADER_RS_LOCALVIEWER,
		MOJOSHADER_RS_NORMALIZENORMALS,
		MOJOSHADER_RS_DIFFUSEMATERIALSOURCE,
		MOJOSHADER_RS_SPECULARMATERIALSOURCE,
		MOJOSHADER_RS_AMBIENTMATERIALSOURCE,
		MOJOSHADER_RS_EMISSIVEMATERIALSOURCE,
		MOJOSHADER_RS_VERTEXBLEND,
		MOJOSHADER_RS_CLIPPLANEENABLE,
		MOJOSHADER_RS_POINTSIZE,
		MOJOSHADER_RS_POINTSIZE_MIN,
		MOJOSHADER_RS_POINTSPRITEENABLE,
		MOJOSHADER_RS_POINTSCALEENABLE,
		MOJOSHADER_RS_POINTSCALE_A,
		MOJOSHADER_RS_POINTSCALE_B,
		MOJOSHADER_RS_POINTSCALE_C,
		MOJOSHADER_RS_MULTISAMPLEANTIALIAS,
		MOJOSHADER_RS_MULTISAMPLEMASK,
		MOJOSHADER_RS_PATCHEDGESTYLE,
		MOJOSHADER_RS_DEBUGMONITORTOKEN,
		MOJOSHADER_RS_POINTSIZE_MAX,
		MOJOSHADER_RS_INDEXEDVERTEXBLENDENABLE,
		MOJOSHADER_RS_COLORWRITEENABLE,
		MOJOSHADER_RS_TWEENFACTOR,
		MOJOSHADER_RS_BLENDOP,
		MOJOSHADER_RS_POSITIONDEGREE,
		MOJOSHADER_RS_NORMALDEGREE,
		MOJOSHADER_RS_SCISSORTESTENABLE,
		MOJOSHADER_RS_SLOPESCALEDEPTHBIAS,
		MOJOSHADER_RS_ANTIALIASEDLINEENABLE,
		MOJOSHADER_RS_MINTESSELLATIONLEVEL,
		MOJOSHADER_RS_MAXTESSELLATIONLEVEL,
		MOJOSHADER_RS_ADAPTIVETESS_X,
		MOJOSHADER_RS_ADAPTIVETESS_Y,
		MOJOSHADER_RS_ADAPTIVETESS_Z,
		MOJOSHADER_RS_ADAPTIVETESS_W,
		MOJOSHADER_RS_ENABLEADAPTIVETESSELLATION,
		MOJOSHADER_RS_TWOSIDEDSTENCILMODE,
		MOJOSHADER_RS_CCW_STENCILFAIL,
		MOJOSHADER_RS_CCW_STENCILZFAIL,
		MOJOSHADER_RS_CCW_STENCILPASS,
		MOJOSHADER_RS_CCW_STENCILFUNC,
		MOJOSHADER_RS_COLORWRITEENABLE1,
		MOJOSHADER_RS_COLORWRITEENABLE2,
		MOJOSHADER_RS_COLORWRITEENABLE3,
		MOJOSHADER_RS_BLENDFACTOR,
		MOJOSHADER_RS_SRGBWRITEENABLE,
		MOJOSHADER_RS_DEPTHBIAS,
		MOJOSHADER_RS_SEPARATEALPHABLENDENABLE,
		MOJOSHADER_RS_SRCBLENDALPHA,
		MOJOSHADER_RS_DESTBLENDALPHA,
		MOJOSHADER_RS_BLENDOPALPHA,

		MOJOSHADER_RS_VERTEXSHADER = 146,
		MOJOSHADER_RS_PIXELSHADER = 147
	}

	[CRepr]
	public enum MOJOSHADER_zBufferType : int32
	{
		MOJOSHADER_ZB_FALSE,
		MOJOSHADER_ZB_TRUE,
		MOJOSHADER_ZB_USEW
	}

	[CRepr]
	public enum MOJOSHADER_fillMode : int32
	{
		MOJOSHADER_FILL_POINT     = 1,
		MOJOSHADER_FILL_WIREFRAME = 2,
		MOJOSHADER_FILL_SOLID     = 3
	}

	[CRepr]
	public enum MOJOSHADER_shadeMode : int32
	{
		MOJOSHADER_SHADE_FLAT    = 1,
		MOJOSHADER_SHADE_GOURAUD = 2,
		MOJOSHADER_SHADE_PHONG   = 3
	}

	[CRepr]
	public enum MOJOSHADER_blendMode : int32
	{
		MOJOSHADER_BLEND_ZERO            = 1,
		MOJOSHADER_BLEND_ONE             = 2,
		MOJOSHADER_BLEND_SRCCOLOR        = 3,
		MOJOSHADER_BLEND_INVSRCCOLOR     = 4,
		MOJOSHADER_BLEND_SRCALPHA        = 5,
		MOJOSHADER_BLEND_INVSRCALPHA     = 6,
		MOJOSHADER_BLEND_DESTALPHA       = 7,
		MOJOSHADER_BLEND_INVDESTALPHA    = 8,
		MOJOSHADER_BLEND_DESTCOLOR       = 9,
		MOJOSHADER_BLEND_INVDESTCOLOR    = 10,
		MOJOSHADER_BLEND_SRCALPHASAT     = 11,
		MOJOSHADER_BLEND_BOTHSRCALPHA    = 12,
		MOJOSHADER_BLEND_BOTHINVSRCALPHA = 13,
		MOJOSHADER_BLEND_BLENDFACTOR     = 14,
		MOJOSHADER_BLEND_INVBLENDFACTOR  = 15,
		MOJOSHADER_BLEND_SRCCOLOR2       = 16,
		MOJOSHADER_BLEND_INVSRCCOLOR2    = 17
	}

	[CRepr]
	public enum MOJOSHADER_cullMode : int32
	{
		MOJOSHADER_CULL_NONE = 1,
		MOJOSHADER_CULL_CW   = 2,
		MOJOSHADER_CULL_CCW  = 3
	}

	[CRepr]
	public enum MOJOSHADER_compareFunc : int32
	{
		MOJOSHADER_CMP_NEVER        = 1,
		MOJOSHADER_CMP_LESS         = 2,
		MOJOSHADER_CMP_EQUAL        = 3,
		MOJOSHADER_CMP_LESSEQUAL    = 4,
		MOJOSHADER_CMP_GREATER      = 5,
		MOJOSHADER_CMP_NOTEQUAL     = 6,
		MOJOSHADER_CMP_GREATEREQUAL = 7,
		MOJOSHADER_CMP_ALWAYS       = 8
	}

	[CRepr]
	public enum MOJOSHADER_fogMode : int32
	{
		MOJOSHADER_FOG_NONE,
		MOJOSHADER_FOG_EXP,
		MOJOSHADER_FOG_EXP2,
		MOJOSHADER_FOG_LINEAR
	}

	[CRepr]
	public enum MOJOSHADER_stencilOp : int32
	{
		MOJOSHADER_STENCILOP_KEEP    = 1,
		MOJOSHADER_STENCILOP_ZERO    = 2,
		MOJOSHADER_STENCILOP_REPLACE = 3,
		MOJOSHADER_STENCILOP_INCRSAT = 4,
		MOJOSHADER_STENCILOP_DECRSAT = 5,
		MOJOSHADER_STENCILOP_INVERT  = 6,
		MOJOSHADER_STENCILOP_INCR    = 7,
		MOJOSHADER_STENCILOP_DECR    = 8
	}

	[CRepr]
	public enum MOJOSHADER_materialColorSource : int32
	{
		MOJOSHADER_MCS_MATERIAL,
		MOJOSHADER_MCS_COLOR1,
		MOJOSHADER_MCS_COLOR2
	}

	[CRepr]
	public enum MOJOSHADER_vertexBlendFlags : int32
	{
		MOJOSHADER_VBF_DISABLE  = 0,
		MOJOSHADER_VBF_1WEIGHTS = 1,
		MOJOSHADER_VBF_2WEIGHTS = 2,
		MOJOSHADER_VBF_3WEIGHTS = 3,
		MOJOSHADER_VBF_TWEENING = 255,
		MOJOSHADER_VBF_0WEIGHTS = 256
	}

	[CRepr]
	public enum MOJOSHADER_patchedEdgeStyle : int32
	{
		MOJOSHADER_PATCHEDGE_DISCRETE,
		MOJOSHADER_PATCHEDGE_CONTINUOUS
	}

	[CRepr]
	public enum MOJOSHADER_debugMonitorTokens : int32
	{
		MOJOSHADER_DMT_ENABLE,
		MOJOSHADER_DMT_DISABLE
	}

	[CRepr]
	public enum MOJOSHADER_blendOp : int32
	{
	    MOJOSHADER_BLENDOP_ADD         = 1,
	    MOJOSHADER_BLENDOP_SUBTRACT    = 2,
	    MOJOSHADER_BLENDOP_REVSUBTRACT = 3,
	    MOJOSHADER_BLENDOP_MIN         = 4,
	    MOJOSHADER_BLENDOP_MAX         = 5
	}

	[CRepr]
	public enum MOJOSHADER_degreeType : int32
	{
		MOJOSHADER_DEGREE_LINEAR    = 1,
		MOJOSHADER_DEGREE_QUADRATIC = 2,
		MOJOSHADER_DEGREE_CUBIC     = 3,
		MOJOSHADER_DEGREE_QUINTIC   = 5
	}

	[CRepr]
	public enum MOJOSHADER_samplerStateType : int32
	{
		MOJOSHADER_SAMP_UNKNOWN0      = 0,
		MOJOSHADER_SAMP_UNKNOWN1      = 1,
		MOJOSHADER_SAMP_UNKNOWN2      = 2,
		MOJOSHADER_SAMP_UNKNOWN3      = 3,
		MOJOSHADER_SAMP_TEXTURE       = 4,
		MOJOSHADER_SAMP_ADDRESSU      = 5,
		MOJOSHADER_SAMP_ADDRESSV      = 6,
		MOJOSHADER_SAMP_ADDRESSW      = 7,
		MOJOSHADER_SAMP_BORDERCOLOR   = 8,
		MOJOSHADER_SAMP_MAGFILTER     = 9,
		MOJOSHADER_SAMP_MINFILTER     = 10,
		MOJOSHADER_SAMP_MIPFILTER     = 11,
		MOJOSHADER_SAMP_MIPMAPLODBIAS = 12,
		MOJOSHADER_SAMP_MAXMIPLEVEL   = 13,
		MOJOSHADER_SAMP_MAXANISOTROPY = 14,
		MOJOSHADER_SAMP_SRGBTEXTURE   = 15,
		MOJOSHADER_SAMP_ELEMENTINDEX  = 16,
		MOJOSHADER_SAMP_DMAPOFFSET    = 17
	}

	[CRepr]
	public enum MOJOSHADER_textureAddress : int32
	{
		MOJOSHADER_TADDRESS_WRAP       = 1,
		MOJOSHADER_TADDRESS_MIRROR     = 2,
		MOJOSHADER_TADDRESS_CLAMP      = 3,
		MOJOSHADER_TADDRESS_BORDER     = 4,
		MOJOSHADER_TADDRESS_MIRRORONCE = 5
	}

	[CRepr]
	public enum MOJOSHADER_textureFilterType : int32
	{
		MOJOSHADER_TEXTUREFILTER_NONE,
		MOJOSHADER_TEXTUREFILTER_POINT,
		MOJOSHADER_TEXTUREFILTER_LINEAR,
		MOJOSHADER_TEXTUREFILTER_ANISOTROPIC,
		MOJOSHADER_TEXTUREFILTER_PYRAMIDALQUAD,
		MOJOSHADER_TEXTUREFILTER_GAUSSIANQUAD,
		MOJOSHADER_TEXTUREFILTER_CONVOLUTIONMONO
	}

	[CRepr]
	public enum MOJOSHADER_symbolClass : int32
	{
		MOJOSHADER_SYMCLASS_SCALAR=0,
		MOJOSHADER_SYMCLASS_VECTOR,
		MOJOSHADER_SYMCLASS_MATRIX_ROWS,
		MOJOSHADER_SYMCLASS_MATRIX_COLUMNS,
		MOJOSHADER_SYMCLASS_OBJECT,
		MOJOSHADER_SYMCLASS_STRUCT
	}

	[CRepr]
	public enum MOJOSHADER_symbolType : int32
	{
		MOJOSHADER_SYMTYPE_VOID=0,
		MOJOSHADER_SYMTYPE_BOOL,
		MOJOSHADER_SYMTYPE_INT,
		MOJOSHADER_SYMTYPE_FLOAT,
		MOJOSHADER_SYMTYPE_STRING,
		MOJOSHADER_SYMTYPE_TEXTURE,
		MOJOSHADER_SYMTYPE_TEXTURE1D,
		MOJOSHADER_SYMTYPE_TEXTURE2D,
		MOJOSHADER_SYMTYPE_TEXTURE3D,
		MOJOSHADER_SYMTYPE_TEXTURECUBE,
		MOJOSHADER_SYMTYPE_SAMPLER,
		MOJOSHADER_SYMTYPE_SAMPLER1D,
		MOJOSHADER_SYMTYPE_SAMPLER2D,
		MOJOSHADER_SYMTYPE_SAMPLER3D,
		MOJOSHADER_SYMTYPE_SAMPLERCUBE,
		MOJOSHADER_SYMTYPE_PIXELSHADER,
		MOJOSHADER_SYMTYPE_VERTEXSHADER,
		MOJOSHADER_SYMTYPE_PIXELFRAGMENT,
		MOJOSHADER_SYMTYPE_VERTEXFRAGMENT,
		MOJOSHADER_SYMTYPE_UNSUPPORTED
	}

	[CRepr]
	public enum MOJOSHADER_symbolRegisterSet : int32
	{
		MOJOSHADER_SYMREGSET_BOOL=0,
		MOJOSHADER_SYMREGSET_INT4,
		MOJOSHADER_SYMREGSET_FLOAT4,
		MOJOSHADER_SYMREGSET_SAMPLER
	}

	[CRepr]
	public struct MOJOSHADER_error
	{
		public char8* error;
		public char8* filename;
		public int32 error_position;
	}

	[CRepr]
	public struct MOJOSHADER_effectSamplerState
	{
		public MOJOSHADER_samplerStateType type;
		public MOJOSHADER_effectValue value;
	}

	[CRepr]
	public struct MOJOSHADER_symbolStructMember
	{
		public char8* name;
		public MOJOSHADER_symbolTypeInfo info;
	}

	[CRepr]
	public struct MOJOSHADER_symbolTypeInfo
	{
		public MOJOSHADER_symbolClass parameter_class;
		public MOJOSHADER_symbolType parameter_type;
		public uint32 rows;
		public uint32 columns;
		public uint32 elements;
		public uint32 member_count;
		public MOJOSHADER_symbolStructMember* members;
	}

	[CRepr]
	public struct MOJOSHADER_effectValue
	{
		[CRepr, Union]
		public struct Values
		{
			public void* values;
			public int32* valuesI;
			public float* valuesF;
			public MOJOSHADER_zBufferType* valuesZBT;
			public MOJOSHADER_fillMode* valuesFiM;
			public MOJOSHADER_shadeMode* valuesSM;
			public MOJOSHADER_blendMode* valuesBM;
			public MOJOSHADER_cullMode* valuesCM;
			public MOJOSHADER_compareFunc* valuesCF;
			public MOJOSHADER_fogMode* valuesFoM;
			public MOJOSHADER_stencilOp* valuesSO;
			public MOJOSHADER_materialColorSource* valuesMCS;
			public MOJOSHADER_vertexBlendFlags* valuesVBF;
			public MOJOSHADER_patchedEdgeStyle* valuesPES;
			public MOJOSHADER_debugMonitorTokens* valuesDMT;
			public MOJOSHADER_blendOp* valuesBO;
			public MOJOSHADER_degreeType* valuesDT;
			public MOJOSHADER_textureAddress* valuesTA;
			public MOJOSHADER_textureFilterType* valuesTFT;
			public MOJOSHADER_effectSamplerState* valuesSS;
		}

		public char8* name;
		public char8* semantic;
		public MOJOSHADER_symbolTypeInfo type;
		public uint32 value_count;
		public Values values;
	}

	typealias MOJOSHADER_effectAnnotation = MOJOSHADER_effectValue;

	[CRepr]
	public struct MOJOSHADER_effectState
	{
		public MOJOSHADER_renderStateType type;
		public MOJOSHADER_effectValue value;
	}

	[CRepr]
	public struct MOJOSHADER_effectPass
	{
		public char8* name;
		public uint32 state_count;
		public MOJOSHADER_effectState* states;
		public uint32 annotation_count;
		public MOJOSHADER_effectAnnotation* annotations;
	}

	[CRepr]
	public struct MOJOSHADER_effectTechnique
	{
		public char8* name;
		public uint32 pass_count;
		public MOJOSHADER_effectPass* passes;
		public uint32 annotation_count;
		public MOJOSHADER_effectAnnotation* annotations;
	}

	[CRepr]
	public struct MOJOSHADER_param
	{
		public MOJOSHADER_effectValue value;
		public uint32 annotation_count;
		public MOJOSHADER_effectAnnotation* annotations;
	}

	[CRepr]
	public struct MOJOSHADER_symbol
	{
		public char8* name;
		public MOJOSHADER_symbolRegisterSet register_set;
		public uint32 register_index;
		public uint32 register_count;
		public MOJOSHADER_symbolTypeInfo info;
	}

	[CRepr]
	public struct MOJOSHADER_samplerStateRegister
	{
		public char8* sampler_name;
		public uint32 sampler_register;
		public uint32 sampler_count;
		public readonly MOJOSHADER_effectSamplerState* sampler_states;
	}

	[CRepr]
	public struct MOJOSHADER_effectShader
	{
		public MOJOSHADER_symbolType type;
		public uint32 technique;
		public uint32 pass;
		public uint32 is_preshader;
		public uint32 preshader_param_count;
		public uint32* preshader_params;
		public uint32 param_count;
		public uint32* param;
		public uint32 sampler_count;
		public MOJOSHADER_samplerStateRegister* samplers;
		public void* shader;
	}

	[CRepr]
	public struct MOJOSHADER_effectSamplerMap
	{
		public MOJOSHADER_symbolType type;
		public char8* name;
	}

	[CRepr]
	public struct MOJOSHADER_effectString
	{
		public MOJOSHADER_symbolType type;
		public char8* name;
	}

	[CRepr]
	public struct MOJOSHADER_effectTexture
	{
		public MOJOSHADER_symbolType type;
	}

	[CRepr, Union]
	public struct MOJOSHADER_effectObject
	{
		public MOJOSHADER_symbolType type;
		
		public MOJOSHADER_effectShader shader;
		public MOJOSHADER_effectSamplerMap mapping;
		public MOJOSHADER_effectString string;
		public MOJOSHADER_effectTexture texture;
	}

	[CRepr]
	public struct MOJOSHADER_effectStateChanges
	{
		public uint32 render_state_change_count;
		public readonly MOJOSHADER_effectState* render_state_changes;
		public uint32 sampler_state_change_count;
		public readonly MOJOSHADER_samplerStateRegister* sampler_state_changes;
		public uint32 vertex_sampler_state_change_count;
		public readonly MOJOSHADER_samplerStateRegister* vertex_sampler_state_changes;
	}

	// TBH I really don't give a shit about this struct's contents, I just need it for interop.
	[CRepr]
	public struct MOJOSHADER_effectShaderContext
	{
		function void() compileShader;
		function void() shaderAddRef;
		function void() deleteShader;
		function void() getParseData;
		function void() bindShaders;
		function void() getBoundShaders;
		function void() mapUniformBufferMemory;
		function void() unmapUniformBufferMemory;

		function void() m;
		function void() f;
		void* malloc_data;
	}

	[CRepr]
	public struct MOJOSHADER_effect
	{
		public int32 error_count;
		public MOJOSHADER_error* errors;
		public int32 param_count;
		public MOJOSHADER_param* param;
		public int32 technique_count;
		public MOJOSHADER_effectTechnique* techniques;
		public int32 object_count;
		public MOJOSHADER_effectObject* objects;
		public MOJOSHADER_effectTechnique* current_technique;
		public int32 current_pass;
		public int32 restore_shader_state;
		public MOJOSHADER_effectStateChanges* state_changes;
		public MOJOSHADER_effectShader* current_vert_raw;
		public MOJOSHADER_effectShader* current_pixl_raw;
		public void* current_vert;
		public void* current_pixl;
		public void* prev_vertex_shader;
		public void* prev_pixel_shader;
		public MOJOSHADER_effectShaderContext ctx;
	}
}
