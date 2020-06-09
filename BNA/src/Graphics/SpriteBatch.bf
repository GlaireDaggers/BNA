using System;
using System.Diagnostics;
using System.Collections;

using BNA.Math;

namespace BNA.Graphics
{
	public enum SpriteBlendMode
	{
		Additive,
		AlphaBlend,
		None
	}

	public enum SpriteSortMode
	{
		Immediate,
		BackToFront,
		FrontToBack,
		Texture
	}

	public enum SpriteFlags
	{
		None = 0,
		FlipHorizontal = 1,
		FlipVertical = 2
	}

	public sealed class SpriteBatch : IDisposable
	{
		[Packed, Reflect]
		private struct SpriteVertex
		{
			[VertexUsage(.Position)]
			public Vec4 Position;
			[VertexUsage(.TextureCoordinate)]
			public Vec4 UV;
			[VertexUsage(.Color)]
			public Vec4 Color;

			public this(Vec2 pos, Vec2 uv, Color color)
			{
				Position = Vec4(pos.x, pos.y, 0.5f, 1f);
				UV = Vec4(uv.x, uv.y, 0f, 0f);
				Color = color;
			}
		}

		private struct Batch
		{
			public BlendState blendState;
			public DepthStencilState dsState;
			public bool restoreState;
			public SpriteSortMode sortMode;
		}

		private struct SpriteCall
		{
			public Texture2D texture;
			public float depth;
			public int index;
			public SpriteVertex[4] vertices;

			public void Set(float x, float y, float dx, float dy, float w, float h, float sin, float cos, Color color, Vec2 texCoordTL, Vec2 texCoordBR) mut
			{
				vertices[0] = .(
					Vec2(x+dx*cos-dy*sin, y+dx*sin+dy*cos),
					texCoordTL,
					color
					);

				vertices[1] = .(
					Vec2(x+(dx+w)*cos-dy*sin, y+(dx+w)*sin+dy*cos),
					Vec2(texCoordBR.x, texCoordTL.y),
					color
					);

				vertices[2] = .(
					Vec2(x+dx*cos-(dy+h)*sin, y+dx*sin+(dy+h)*cos),
					Vec2(texCoordTL.x, texCoordBR.y),
					color
					);

				vertices[3] = .(
					Vec2(x+(dx+w)*cos-(dy+h)*sin, y+(dx+w)*sin+(dy+h)*cos),
					texCoordBR,
					color
					);
			}
		}

		private struct DrawCall
		{
			public Texture2D texture;
			public int indexStart;
			public int indexLength;
		}

		public GraphicsDevice GraphicsDevice { get; private set; }

		private Effect _spriteShader;
		private Batch? _activeBatch;

		private List<SpriteVertex> _vtemp = new List<SpriteVertex>() ~ delete _;
		private List<uint16> _itemp = new List<uint16>() ~ delete _;

		private List<SpriteCall> _spriteCalls = new List<SpriteCall>() ~ delete _;
		private List<DrawCall> _drawCalls = new List<DrawCall>() ~ delete _;

		public this(GraphicsDevice context)
		{
			GraphicsDevice = context;
			_spriteShader = Effect.Load(context, "./Content/Shaders/sprite.fxo");
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			if(_spriteShader != null)
			{
				delete _spriteShader;
				_spriteShader = null;
			}	
		}

		public void Begin()
		{
			Begin(.AlphaBlend, .BackToFront, false, Matrix4x4.Identity);
		}

		public void Begin(SpriteBlendMode blendMode)
		{
			Begin(blendMode, .BackToFront, false, Matrix4x4.Identity);
		}

		public void Begin(SpriteBlendMode blendMode, SpriteSortMode sortMode, bool saveState)
		{
			Begin(blendMode, sortMode, saveState, Matrix4x4.Identity);
		}

		public void Begin(SpriteBlendMode blendMode, SpriteSortMode sortMode, bool saveState, Matrix4x4 transform)
		{
			Debug.Assert(_activeBatch == null, "Cannot call Begin when there's already an active sprite batch");

			var trs = transform;
			trs *= Matrix4x4.Scale(Vec3(2f / GraphicsDevice.TargetWidth, 2f / GraphicsDevice.TargetHeight, 1f));
			trs *= Matrix4x4.Translate(Vec3(-1f, -1f, 0f));

			_spriteShader.SetMatrix4x4("MATRIX_M", trs);

			var batch = Batch();
			batch.blendState = GraphicsDevice.GetBlendState();
			batch.dsState = GraphicsDevice.GetDepthStencilState();
			batch.sortMode = sortMode;
			batch.restoreState = saveState;

			_activeBatch = batch;

			BlendState blendState;

			switch(blendMode)
			{
			case .Additive:
				blendState = BlendState(.SrcAlpha, .One);
				break;
			case .AlphaBlend:
				blendState = BlendState(.SrcAlpha, .InverseSrcAlpha);
				break;
			case .None:
				blendState = BlendState(.One, .Zero);
				break;
			}

			GraphicsDevice.SetBlendState(blendState);

			DepthStencilState dsState = .();
			dsState.depthBufferEnable = false;
			dsState.stencilEnable = false;

			GraphicsDevice.SetDepthStencilState(dsState);

			_vtemp.Clear();
			_itemp.Clear();

			_spriteCalls.Clear();
		}

		private mixin draw(Texture2D texture,
			Vec2 position,
			Rect? sourceRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			Vec2 scale,
			SpriteFlags flags,
			float depth)
		{
			Debug.Assert(texture != null);

			var item = SpriteCall();

			item.depth = depth;
			item.texture = texture;
			item.index = _spriteCalls.Count;

			Rect rect;
			if(sourceRectangle.HasValue) rect = sourceRectangle.Value;
			else rect = Rect(0, 0, texture.Width, texture.Height);

			Vec2 texCoordTL = Vec2(rect.x, rect.y) / Vec2(texture.Width, texture.Height);
			Vec2 texCoordBR = Vec2(rect.x + rect.w, rect.y + rect.h) / Vec2(texture.Width, texture.Height);

			if(flags.HasFlag(.FlipVertical))
			{
				let tmp = texCoordBR.y;
				texCoordBR.y = texCoordTL.y;
				texCoordTL.y = tmp;
			}

			if(flags.HasFlag(.FlipHorizontal))
			{
				let tmp = texCoordBR.x;
				texCoordBR.x = texCoordTL.x;
				texCoordTL.x = tmp;
			}

			item.Set(
				position.x,
				position.y,
				-origin.x * scale.x,
				-origin.y * scale.y,
				rect.w * scale.x,
				rect.y * scale.y,
				Math.Sin(rotation),
				Math.Cos(rotation),
				color,
				texCoordTL,
				texCoordBR
				);

			_spriteCalls.Add(item);
		}

		private mixin draw(Texture2D texture,
			Rect destRectangle,
			Rect? sourceRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			SpriteFlags flags,
			float depth)
		{
			Debug.Assert(texture != null);

			var item = SpriteCall();

			item.depth = depth;
			item.texture = texture;
			item.index = _spriteCalls.Count;

			Rect rect;
			if(sourceRectangle.HasValue) rect = sourceRectangle.Value;
			else rect = Rect(0, 0, texture.Width, texture.Height);

			Vec2 texCoordTL = Vec2(rect.x, rect.y) / Vec2(texture.Width, texture.Height);
			Vec2 texCoordBR = Vec2(rect.x + rect.w, rect.y + rect.h) / Vec2(texture.Width, texture.Height);

			if(flags.HasFlag(.FlipVertical))
			{
				let tmp = texCoordBR.y;
				texCoordBR.y = texCoordTL.y;
				texCoordTL.y = tmp;
			}

			if(flags.HasFlag(.FlipHorizontal))
			{
				let tmp = texCoordBR.x;
				texCoordBR.x = texCoordTL.x;
				texCoordTL.x = tmp;
			}

			item.Set(
				destRectangle.x,
				destRectangle.y,
				-origin.x,
				-origin.y,
				destRectangle.w,
				destRectangle.h,
				Math.Sin(rotation),
				Math.Cos(rotation),
				color,
				texCoordTL,
				texCoordBR
				);

			_spriteCalls.Add(item);
		}

		public void Draw(
			Texture2D texture,
			Vec2 position,
			Rect? srcRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			float scale,
			SpriteFlags flags,
			float depth )
		{
			draw!(texture, position, srcRectangle, color, rotation, origin, Vec2( scale, scale ), flags, depth);
		}

		public void Draw(
			Texture2D texture,
			Rect destRectangle,
			Rect? srcRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			SpriteFlags flags )
		{
			draw!(texture, destRectangle, srcRectangle, color, rotation, origin, flags, 0f);
		}

		public void Draw(
			Texture2D texture,
			Rect destRectangle,
			Rect? srcRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			SpriteFlags flags,
			float depth )
		{
			draw!(texture, destRectangle, srcRectangle, color, rotation, origin, flags, depth);
		}

		public void Draw( Texture2D texture, Vec2 position, Rect? sourceRect, Color color )
		{
			draw!(texture, position, sourceRect, color, 0f, Vec2.Zero, Vec2.One, SpriteFlags.None, 0f);
		}

		public void Draw( Texture2D texture, Rect rect, Rect? sourceRect, Color color )
		{
			draw!(texture, rect, sourceRect, color, 0f, Vec2.Zero, SpriteFlags.None, 0f);
		}

		public void Draw( Texture2D texture, Vec2 position, Color color )
		{
			draw!(texture, position, null, color, 0f, Vec2.Zero, Vec2.One, SpriteFlags.None, 0f);
		}

		public void Draw( Texture2D texture, Rect rect, Color color )
		{
			draw!(texture, rect, null, color, 0f, Vec2.Zero, SpriteFlags.None, 0f);
		}

		public void Draw(
			Texture2D texture,
			Vec2 position,
			Rect? sourceRectangle,
			Color color,
			float rotation,
			Vec2 origin,
			Vec2 scale,
			SpriteFlags flags,
			float depth)
		{
			draw!(texture, position, sourceRectangle, color, rotation, origin, scale, flags, depth);
		}

		public void End()
		{
			Debug.Assert(_activeBatch != null, "Cannot call End when there's no active sprite batch");

			let batch = _activeBatch.Value;

			if(_spriteCalls.Count > 0)
			{
				// depending on our draw mode, we'll sort our sprite list either by texture or by depth
				switch(batch.sortMode)
				{
				case .BackToFront:
					_spriteCalls.Sort(scope => SortBackToFront);
					break;
				case .FrontToBack:
					_spriteCalls.Sort(scope => SortFrontToBack);
					break;
				case .Texture:
					_spriteCalls.Sort(scope => SortTexture);
					break;
				default:
					break;
				}

				// now that our sprites are in order, we can start building geometry buffers & draw calls
				DrawCall dt = .();

				for(let sprite in _spriteCalls)
				{
					if(sprite.texture != dt.texture)
					{
						// make a new draw call
						if(dt.indexLength > 0)
							_drawCalls.Add(dt);

						dt.texture = sprite.texture;
						dt.indexStart += dt.indexLength;
						dt.indexLength = 0;
					}

					let vertexStart = (uint16)_vtemp.Count;

					// append geometry
					_vtemp.Add( sprite.vertices[0] );
					_vtemp.Add( sprite.vertices[1] );
					_vtemp.Add( sprite.vertices[2] );
					_vtemp.Add( sprite.vertices[3] );

					_itemp.Add(vertexStart + 2);
					_itemp.Add(vertexStart + 1);
					_itemp.Add(vertexStart);

					_itemp.Add(vertexStart + 1);
					_itemp.Add(vertexStart + 2);
					_itemp.Add(vertexStart + 3);

					dt.indexLength += 6;
				}

				if(dt.indexLength > 0)
					_drawCalls.Add(dt);

				// now we have actual draw calls, and vertex+index arrays.
				// time to build some buffers and submit some draw calls!

				let varray = scope SpriteVertex[_vtemp.Count];
				_vtemp.CopyTo(varray);

				let iarray = scope uint16[_itemp.Count];
				_itemp.CopyTo(iarray);

				let vbuffer = new VertexBuffer(GraphicsDevice);
				vbuffer.Set(varray);

				let ibuffer = new IndexBuffer(GraphicsDevice);
				ibuffer.Set(iarray);

				// we only need to bind the vertex buffer once, since all calls share the same buffer
				GraphicsDevice.ApplyVertexBufferBinding(vbuffer);

				for(let dc in _drawCalls)
				{
					_spriteShader.SetTexture("Tex", dc.texture, .(.Linear, .Clamp));
					_spriteShader.ApplyEffect(0);

					GraphicsDevice.DrawIndexedPrimitives(.TriangleList, 0, _vtemp.Count, dc.indexStart, dc.indexLength / 3, ibuffer);
				}

				delete vbuffer;
				delete ibuffer;
			}

			if(batch.restoreState)
			{
				GraphicsDevice.SetBlendState(batch.blendState);
				GraphicsDevice.SetDepthStencilState(batch.dsState);
			}

			_activeBatch = null;

			_vtemp.Clear();
			_itemp.Clear();
			_drawCalls.Clear();
			_spriteCalls.Clear();
		}

		private int SortFrontToBack(SpriteCall lhs, SpriteCall rhs)
		{
			return rhs.depth.CompareTo(lhs.depth);
		}

		private int SortBackToFront(SpriteCall lhs, SpriteCall rhs)
		{
			return lhs.depth.CompareTo(rhs.depth);
		}

		private int SortTexture(SpriteCall lhs, SpriteCall rhs)
		{
			// kinda stupid, but if we take the raw texture pointers and turn them into integers, we can somewhat crudely sort on texture
			let t1 = (int)(void*)(lhs.texture.[Friend]_handle);
			let t2 = (int)(void*)(rhs.texture.[Friend]_handle);

			return t1 <=> t2;
		}
	}
}
