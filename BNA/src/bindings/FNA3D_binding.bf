using System;
using BNA;
using BNA.Graphics;
using BNA.Math;

namespace BNA.bindings
{
	static class FNA3D_binding
	{
		[LinkName("FNA3D_HookLogFunctions")]
		public static extern void HookLogFunctions( FNA3D_LogFunc info, FNA3D_LogFunc warn, FNA3D_LogFunc error );

		[LinkName("FNA3D_PrepareWindowAttributes")]
		public static extern uint32 PrepareWindowAttributes();

		[LinkName("FNA3D_GetDrawableSize")]
		public static extern void GetDrawableSize( void* window, int32* x, int32* y );

		[LinkName("FNA3D_CreateDevice")]
		public static extern FNA3D_DeviceHandle* CreateDevice( FNAPresentationParameters* presentationParameters, uint8 debugMode );

		[LinkName("FNA3D_DestroyDevice")]
		public static extern void DestroyDevice( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_BeginFrame")]
		public static extern void BeginFrame( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SwapBuffers")]
		public static extern void SwapBuffers( FNA3D_DeviceHandle* device, Rect* sourceRectangle, Rect* destinationRectangle, void* overrideWindowHandle );

		[LinkName("FNA3D_SetPresentationInterval")]
		public static extern void SetPresentationInterval( FNA3D_DeviceHandle* device, PresentInterval presentInterval );

		[LinkName("FNA3D_Clear")]
		public static extern void Clear( FNA3D_DeviceHandle* device, ClearOptions options, Vec4* color, float depth, int32 stencil );

		[LinkName("FNA3D_DrawIndexedPrimitives")]
		public static extern void DrawIndexedPrimitives( FNA3D_DeviceHandle* device, PrimitiveType primitiveType, int32 baseVertex, int32 minVertexIndex, int32 numVertices, int32 startIndex, int32 primitiveCount, FNA3D_Buffer* indices, IndexElementSize indexElementSize );

		[LinkName("FNA3D_DrawInstancedPrimitives")]
		public static extern void DrawInstancedPrimitives( FNA3D_DeviceHandle* device, PrimitiveType primitiveType, int32 baseVertex, int32 minVertexIndex, int32 numVertices, int32 startIndex, int32 primitiveCount, int32 instanceCount, FNA3D_Buffer* indices, IndexElementSize indexElementSize );

		[LinkName("FNA3D_DrawPrimitives")]
		public static extern void DrawPrimitives( FNA3D_DeviceHandle* device, PrimitiveType primitiveType, int32 vertexStart, int32 primitiveCount );

		[LinkName("FNA3D_DrawUserIndexedPrimitives")]
		public static extern void DrawUserIndexedPrimitives( FNA3D_DeviceHandle* device, PrimitiveType primitiveType, void* vertexData, int32 vertexOffset, int32 numVertices, void* indexData, int32 indexOffset, IndexElementSize indexElementSize, int32 primitiveCount );

		[LinkName("FNA3D_DrawUserPrimitives")]
		public static extern void DrawUserPrimitives( FNA3D_DeviceHandle* device, PrimitiveType primitiveType, void* vertexData, int32 vertexOffset, int32 primitiveCount );

		[LinkName("FNA3D_SetViewport")]
		public static extern void SetViewport( FNA3D_DeviceHandle* device, Viewport* viewport );

		[LinkName("FNA3D_SetScissorRect")]
		public static extern void SetScissorRect( FNA3D_DeviceHandle* device, Rect* scissorRect );

		[LinkName("FNA3D_GetBlendFactor")]
		public static extern void GetBlendFactor( FNA3D_DeviceHandle* device, Color* blendFactor );

		[LinkName("FNA3D_SetBlendFactor")]
		public static extern void SetBlendFactor( FNA3D_DeviceHandle* device, Color* blendFactor );

		[LinkName("FNA3D_GetMultiSampleMask")]
		public static extern int32 GetMultiSampleMask( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SetMultiSampleMask")]
		public static extern void SetMultiSampleMask( FNA3D_DeviceHandle* device, int32 mask );

		[LinkName("FNA3D_GetReferenceStencil")]
		public static extern int32 GetReferenceStencil( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SetReferenceStencil")]
		public static extern void SetReferenceStencil( FNA3D_DeviceHandle* device, int32 refStencil );

		[LinkName("FNA3D_SetBlendState")]
		public static extern void SetBlendState( FNA3D_DeviceHandle* device, BlendState* blendState );

		[LinkName("FNA3D_SetDepthStencilState")]
		public static extern void SetDepthStencilState( FNA3D_DeviceHandle* device, FNADepthStencilState* depthStencilState );

		[LinkName("FNA3D_ApplyRasterizerState")]
		public static extern void ApplyRasterizerState( FNA3D_DeviceHandle* device, FNARasterizerState* rasterizerState );

		[LinkName("FNA3D_VerifySampler")]
		public static extern void VerifySampler( FNA3D_DeviceHandle* device, int32 index, FNA3D_Texture* texture, SamplerState* samplerState );

		[LinkName("FNA3D_VerifyVertexSampler")]
		public static extern void VerifyVertexSampler( FNA3D_DeviceHandle* device, int32 index, FNA3D_Texture* texture, SamplerState* samplerState );

		[LinkName("FNA3D_ApplyVertexBufferBindings")]
		public static extern void ApplyVertexBufferBindings( FNA3D_DeviceHandle* device, FNAVertexBufferBinding* bindings, int32 numBindings, uint8 bindingsUpdated, int32 baseVertex );

		[LinkName("FNA3D_ApplyVertexDeclaration")]
		public static extern void ApplyVertexDeclaration( FNA3D_DeviceHandle* device, VertexDeclaration* vertexDeclaration, void* vertexData, int32 vertexOffset );

		[LinkName("FNA3D_SetRenderTargets")]
		public static extern void SetRenderTargets( FNA3D_DeviceHandle* device, RenderTargetBinding* renderTargets, int32 numRenderTargets, FNA3D_Renderbuffer* depthStencilBuffer, DepthFormat depthFormat );

		[LinkName("FNA3D_ResolveTarget")]
		public static extern void ResolveTarget( FNA3D_DeviceHandle* device, RenderTargetBinding* target );

		[LinkName("FNA3D_ResetBackbuffer")]
		public static extern void ResetBackbuffer( FNA3D_DeviceHandle* device, FNAPresentationParameters* presentationParameters );

		[LinkName("FNA3D_ReadBackbuffer")]
		public static extern void ReadBackbuffer( FNA3D_DeviceHandle* device, int32 x, int32 y, int32 w, int32 h, void* data, int32 dataLength );

		[LinkName("FNA3D_GetBackbufferSize")]
		public static extern void GetBackbufferSize( FNA3D_DeviceHandle* device, int32* w, int32* h );

		[LinkName("FNA3D_GetBackbufferSurfaceFormat")]
		public static extern SurfaceFormat GetBackbufferSurfaceFormat( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_GetBackbufferDepthFormat")]
		public static extern DepthFormat GetBackbufferDepthFormat( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_GetBackbufferMultiSampleCount")]
		public static extern int32 GetBackbufferMultiSampleCount( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_CreateTexture2D")]
		public static extern FNA3D_Texture* CreateTexture2D( FNA3D_DeviceHandle* device, SurfaceFormat format, int32 width, int32 height, int32 levelCount, uint8 isRenderTarget );

		[LinkName("FNA3D_CreateTexture3D")]
		public static extern FNA3D_Texture* CreateTexture3D( FNA3D_DeviceHandle* device, SurfaceFormat format, int32 width, int32 height, int32 depth, int32 levelCount );

		[LinkName("FNA3D_CreateTextureCube")]
		public static extern FNA3D_Texture* CreateTextureCube( FNA3D_DeviceHandle* device, SurfaceFormat format, int32 size, int32 levelCount, uint8 isRenderTarget );

		[LinkName("FNA3D_AddDisposeTexture")]
		public static extern void AddDisposeTexture( FNA3D_DeviceHandle* device, FNA3D_Texture* texture );

		[LinkName("FNA3D_SetTextureData2D")]
		public static extern void SetTextureData2D( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 w, int32 h, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_SetTextureData3D")]
		public static extern void SetTextureData3D( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 z, int32 w, int32 h, int32 d, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_SetTextureDataCube")]
		public static extern void SetTextureDataCube( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 w, int32 h, CubemapFace face, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_SetTextureDataYUV")]
		public static extern void SetTextureDataYUV( FNA3D_DeviceHandle* device, FNA3D_Texture* y, FNA3D_Texture* u, FNA3D_Texture* v, int32 yWidth, int32 yHeight, int32 uvWidth, int32 uvHeight, void* data, int32 dataLength );

		[LinkName("FNA3D_GetTextureData2D")]
		public static extern void GetTextureData2D( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 w, int32 h, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_GetTextureData3D")]
		public static extern void GetTextureData3D( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 z, int32 w, int32 h, int32 d, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_GetTextureDataCube")]
		public static extern void GetTextureDataCube( FNA3D_DeviceHandle* device, FNA3D_Texture* texture, SurfaceFormat format, int32 x, int32 y, int32 w, int32 h, CubemapFace face, int32 level, void* data, int32 dataLength );

		[LinkName("FNA3D_GenColorRenderbuffer")]
		public static extern FNA3D_Renderbuffer* GenColorRenderbuffer( FNA3D_DeviceHandle* device, int32 width, int32 height, SurfaceFormat format, int32 multiSampleCount, FNA3D_Texture* texture );

		[LinkName("FNA3D_GenDepthStencilRenderbuffer")]
		public static extern FNA3D_Renderbuffer* GenDepthStencilRenderbuffer( FNA3D_DeviceHandle* device, int32 width, int32 height, DepthFormat format, int32 multiSampleCount );

		[LinkName("FNA3D_AddDisposeRenderbuffer")]
		public static extern void AddDisposeRenderbuffer( FNA3D_DeviceHandle* device, FNA3D_Renderbuffer* renderbuffer );

		[LinkName("FNA3D_GenVertexBuffer")]
		public static extern FNA3D_Buffer* GenVertexBuffer( FNA3D_DeviceHandle* device, uint8 dynamic, BufferUsage usage, int32 vertexCount, int32 vertexStride );

		[LinkName("FNA3D_AddDisposeVertexBuffer")]
		public static extern void AddDisposeVertexBuffer( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer );

		[LinkName("FNA3D_SetVertexBufferData")]
		public static extern void SetVertexBufferData( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer, int32 offsetInBytes, void* data, int32 elementCount, int32 elementSizeInBytes, int32 vertexStride, SetDataOptions options );

		[LinkName("FNA3D_GetVertexBufferData")]
		public static extern void GetVertexBufferData( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer, int32 offsetInBytes, void* data, int32 elementCount, int32 elementSizeInBytes, int32 vertexStride );

		[LinkName("FNA3D_GenIndexBuffer")]
		public static extern FNA3D_Buffer* GenIndexBuffer( FNA3D_DeviceHandle* device, uint8 dynamic, BufferUsage usage, int32 indexCount, IndexElementSize indexElementSize );

		[LinkName("FNA3D_AddDisposeIndexBuffer")]
		public static extern void AddDisposeIndexBuffer( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer );

		[LinkName("FNA3D_SetIndexBufferData")]
		public static extern void SetIndexBufferData( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer, int32 offsetInBytes, void* data, int32 dataLength, SetDataOptions options );

		[LinkName("FNA3D_GetIndexBufferData")]
		public static extern void GetIndexBufferData( FNA3D_DeviceHandle* device, FNA3D_Buffer* buffer, int32 offsetInBytes, void* data, int32 dataLength );

		[LinkName("FNA3D_CreateEffect")]
		public static extern void CreateEffect( FNA3D_DeviceHandle* device, uint8* effectCode, uint32 effectCodeLength, FNA3D_Effect** effect, MOJOSHADER_effect** effectData );

		[LinkName("FNA3D_CloneEffect")]
		public static extern void CloneEffect( FNA3D_DeviceHandle* device, FNA3D_Effect* cloneSource, FNA3D_Effect** effect, MOJOSHADER_effect** effectData );

		[LinkName("FNA3D_AddDisposeEffect")]
		public static extern void AddDisposeEffect( FNA3D_DeviceHandle* device, FNA3D_Effect* effect );

		[LinkName("FNA3D_SetEffectTechnique")]
		public static extern void SetEffectTechnique( FNA3D_DeviceHandle* device, FNA3D_Effect* effect, MOJOSHADER_effectTechnique* technique );

		[LinkName("FNA3D_ApplyEffect")]
		public static extern void ApplyEffect( FNA3D_DeviceHandle* device, FNA3D_Effect* effect, uint32 pass, MOJOSHADER_effectStateChanges* stateChanges );

		[LinkName("FNA3D_BeginPassRestore")]
		public static extern void BeginPassRestore( FNA3D_DeviceHandle* device, FNA3D_Effect* effect, MOJOSHADER_effectStateChanges* stateChanges );

		[LinkName("FNA3D_EndPassRestore")]
		public static extern void EndPassRestore( FNA3D_DeviceHandle* device, FNA3D_Effect* effect );

		[LinkName("FNA3D_CreateQuery")]
		public static extern FNA3D_Query* CreateQuery( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_AddDisposeQuery")]
		public static extern void AddDisposeQuery( FNA3D_DeviceHandle* device, FNA3D_Query* query );

		[LinkName("FNA3D_QueryBegin")]
		public static extern void QueryBegin( FNA3D_DeviceHandle* device, FNA3D_Query* query );

		[LinkName("FNA3D_QueryComplete")]
		public static extern uint8 QueryComplete( FNA3D_DeviceHandle* handle, FNA3D_Query* query );

		[LinkName("FNA3D_QueryPixelCount")]
		public static extern int32 QueryPixelCount( FNA3D_DeviceHandle* device, FNA3D_Query* query );

		[LinkName("FNA3D_SupportsDXT1")]
		public static extern uint8 SupportsDXT1( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SupportsS3TC")]
		public static extern uint8 SupportsS3TC( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SupportsHardwareInstancing")]
		public static extern uint8 SupportsHardwareInstancing( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_SupportsNoOverwrite")]
		public static extern uint8 SupportsNoOverwrite( FNA3D_DeviceHandle* device );

		[LinkName("FNA3D_GetMaxTextureSlots")]
		public static extern void GetMaxTextureSlots( FNA3D_DeviceHandle* device, int32* textures, int32* vertexTextures );

		[LinkName("FNA3D_GetMaxMultiSampleCount")]
		public static extern int32 GetMaxMultiSampleCount( FNA3D_DeviceHandle* device, SurfaceFormat format, int32 multiSampleCount );

		[LinkName("FNA3D_SetStringMarker")]
		public static extern void SetStringMarker( FNA3D_DeviceHandle* device, char8* text );

		[LinkName("FNA3D_Image_Load")]
		public static extern uint8* Image_Load(FNA3D_Image_ReadFunc readFunc, FNA3D_Image_SkipFunc skipFunc, FNA3D_Image_EOFFunc eofFunc, void* context,
			int32* w, int32* h, int32* len, int32 forceW, int32 forceH, uint8 zoom);

		[LinkName("FNA3D_Image_Free")]
		public static extern void Image_Free(uint8* mem);

		[LinkName("FNA3D_Image_SavePNG")]
		public static extern void Image_SavePNG(FNA3D_Image_WriteFunc writeFunc, void* context, int32 srcW, int32 srcH, int32 dstW, int32 dstH, uint8* data);

		[LinkName("FNA3D_Image_SavePNG")]
		public static extern void Image_SaveJPG(FNA3D_Image_WriteFunc writeFunc, void* context, int32 srcW, int32 srcH, int32 dstW, int32 dstH, uint8* data, int32 quality);

		[LinkName("stbi_failure_reason")]
		public static extern char8* stbi_failure_reason();
	}
}
