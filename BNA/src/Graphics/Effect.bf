using System;
using System.Diagnostics;
using System.Collections;
using BNA.bindings;
using BNA.Utils;
using BNA.Math;

namespace BNA.Graphics
{
	public struct SamplerSlot
	{
		public StringView Name;
		public EffectParameter Parameter;
		public int Slot;

		public this(StringView name, EffectParameter param, int slot)
		{
			Name = StringView(name);
			Parameter = param;
			Slot = slot;
		}
	}

	public sealed class EffectPass
	{
		public readonly String Name ~ delete _;

		private MOJOSHADER_effectPass* _pass;

		private SamplerSlot[] vertex_samplers ~ delete _;
		private SamplerSlot[] pixel_samplers ~ delete _;

		private this(MOJOSHADER_effectPass* pass)
		{
			_pass = pass;
			Name = pass.name == null ? new String() : new String(pass.name);
		}
	}

	public sealed class EffectTechnique
	{
		public readonly String Name ~ delete _;
		public readonly EffectPass[] Passes ~ DeleteContainerAndItems!(Passes);

		private MOJOSHADER_effectTechnique* _technique;

		private this(MOJOSHADER_effectTechnique* technique)
		{
			_technique = technique;

			Name = technique.name == null ? new String() : new String(technique.name);
			Passes = new EffectPass[technique.pass_count];

			for(int i = 0; i < (.)technique.pass_count; i++)
			{
				Passes[i] = new [Friend]EffectPass(&technique.passes[i]);
			}
		}
	}

	public sealed class EffectParameter
	{
		public readonly String Name ~ delete _;

		public ShaderParameterClass Class => (.)_param.value.type.parameter_class;
		public ShaderParameterType Type => (.)_param.value.type.parameter_type;
		public int Rows => (.)_param.value.type.rows;
		public int Columns => (.)_param.value.type.columns;
		public int Elements => (.)_param.value.type.elements;
		public int MemberCount => (.)_param.value.type.member_count;

		private MOJOSHADER_param* _param;

		private this(MOJOSHADER_param* param)
		{
			_param = param;
			Name = param.value.name == null ? new String() : new String(param.value.name);
		}
	}

	public sealed class Effect : IDisposable
	{
		private struct BoundSampler
		{
			public Texture Texture;
			public SamplerState Sampler;

			public this(Texture tex, SamplerState sampler)
			{
				Texture = tex;
				Sampler = sampler;
			}
		}

		public readonly EffectTechnique[] Techniques ~ DeleteContainerAndItems!(Techniques);
		public readonly EffectParameter[] Parameters ~ DeleteContainerAndItems!(Parameters);

		private int _currentTechnique;

		private FNA3D_DeviceHandle* _deviceHandle;
		private FNA3D_Effect* _effectHandle;
		private MOJOSHADER_effect* _mojoEffect;
		private MOJOSHADER_effectStateChanges _stateChanges;

		private MOJOSHADER_effectObject*[] obj ~ delete _;

		private Dictionary<String, BoundSampler> samplers = new Dictionary<String, BoundSampler>() ~ DeleteDictionaryAndKeys!(samplers);

		public static Result<Effect> Load(GraphicsDevice graphicsDevice, StringView path)
		{
			let effectCode = ResourceUtility.ReadAllBytes(path);
			if(effectCode == null)
				return .Err;

			let fx = new Effect(graphicsDevice, effectCode);
			delete effectCode;

			return fx;
		}

		public this(GraphicsDevice graphicsDevice, uint8[] effectCode)
		{
			_currentTechnique = 0;

			_deviceHandle = graphicsDevice.[Friend]_deviceHandle;
			FNA3D_binding.CreateEffect(_deviceHandle, effectCode.CArray(), (.)effectCode.Count, &_effectHandle, &_mojoEffect);

			Debug.Assert(_mojoEffect.error_count == 0, "Encountered errors while loading effect file!");

			Parameters = new EffectParameter[_mojoEffect.param_count];
			for(int i = 0; i < _mojoEffect.param_count; i++)
			{
				Parameters[i] = new [Friend]EffectParameter(&_mojoEffect.param[i]);
			}

			Techniques = new EffectTechnique[_mojoEffect.technique_count];
			for(int i = 0; i < _mojoEffect.technique_count; i++)
			{
				Techniques[i] = new [Friend]EffectTechnique(&_mojoEffect.techniques[i]);
			}

			obj = new MOJOSHADER_effectObject*[_mojoEffect.object_count];
			for(int i = 0; i < obj.Count; i++)
			{
				obj[i] = &_mojoEffect.objects[i];

				// store array of pixel shader samplers to each pass
				if(obj[i].type == .MOJOSHADER_SYMTYPE_PIXELSHADER)
				{
					let techniqueIdx = obj[i].shader.technique;
					let passIdx = obj[i].shader.pass;

					let pass = Techniques[(int)techniqueIdx].Passes[(int)passIdx];

					let samplers = new SamplerSlot[obj[i].shader.sampler_count];
					for(int j = 0; j < samplers.Count; j++)
					{
						let sampler = &obj[i].shader.samplers[j];
						let param = GetParameter(StringView(sampler.sampler_name));
						samplers[j] = SamplerSlot(StringView(sampler.sampler_name), param, (int)sampler.sampler_register);
					}

					pass.[Friend]pixel_samplers = samplers;
				}
				// store array of vertex shader samplers to each pass
				else if(obj[i].type == .MOJOSHADER_SYMTYPE_VERTEXSHADER)
				{
					let techniqueIdx = obj[i].shader.technique;
					let passIdx = obj[i].shader.pass;

					let pass = Techniques[(int)techniqueIdx].Passes[(int)passIdx];

					let samplers = new SamplerSlot[obj[i].shader.sampler_count];
					for(int j = 0; j < samplers.Count; j++)
					{
						let sampler = &obj[i].shader.samplers[j];
						let param = GetParameter(StringView(sampler.sampler_name));
						samplers[j] = SamplerSlot(StringView(sampler.sampler_name), param, (int)sampler.sampler_register);
					}

					pass.[Friend]vertex_samplers = samplers;
				}
			}
		}

		public this(Effect clone)
		{
			_deviceHandle = clone._deviceHandle;
			FNA3D_binding.CloneEffect(_deviceHandle, clone._effectHandle, &_effectHandle, &_mojoEffect);

			Parameters = new EffectParameter[_mojoEffect.param_count];
			for(int i = 0; i < _mojoEffect.param_count; i++)
			{
				Parameters[i] = new [Friend]EffectParameter(&_mojoEffect.param[i]);
			}

			Techniques = new EffectTechnique[_mojoEffect.technique_count];
			for(int i = 0; i < _mojoEffect.technique_count; i++)
			{
				Techniques[i] = new [Friend]EffectTechnique(&_mojoEffect.techniques[i]);
			}

			obj = new MOJOSHADER_effectObject*[_mojoEffect.object_count];
			for(int i = 0; i < obj.Count; i++)
			{
				obj[i] = &_mojoEffect.objects[i];

				// store array of pixel shader samplers to each pass
				if(obj[i].type == .MOJOSHADER_SYMTYPE_PIXELSHADER)
				{
					let techniqueIdx = obj[i].shader.technique;
					let passIdx = obj[i].shader.pass;

					let pass = Techniques[(int)techniqueIdx].Passes[(int)passIdx];

					let samplers = new SamplerSlot[obj[i].shader.sampler_count];
					for(int j = 0; j < samplers.Count; j++)
					{
						let sampler = &obj[i].shader.samplers[j];
						let param = GetParameter(StringView(sampler.sampler_name));
						samplers[j] = SamplerSlot(StringView(sampler.sampler_name), param, (int)sampler.sampler_register);
					}

					pass.[Friend]pixel_samplers = samplers;
				}
				// store array of vertex shader samplers to each pass
				else if(obj[i].type == .MOJOSHADER_SYMTYPE_VERTEXSHADER)
				{
					let techniqueIdx = obj[i].shader.technique;
					let passIdx = obj[i].shader.pass;

					let pass = Techniques[(int)techniqueIdx].Passes[(int)passIdx];

					let samplers = new SamplerSlot[obj[i].shader.sampler_count];
					for(int j = 0; j < samplers.Count; j++)
					{
						let sampler = &obj[i].shader.samplers[j];
						let param = GetParameter(StringView(sampler.sampler_name));
						samplers[j] = SamplerSlot(StringView(sampler.sampler_name), param, (int)sampler.sampler_register);
					}

					pass.[Friend]vertex_samplers = samplers;
				}
			}
		}

		public ~this()
		{
			Dispose();
		}

		public void Dispose()
		{
			Debug.Assert(_deviceHandle != null);

			if(_effectHandle != null)
			{
				// NOTE: FNA internally disposes the MOJOSHADER_effect too (I checked)
				FNA3D_binding.AddDisposeEffect(_deviceHandle, _effectHandle);
			}

			_deviceHandle = null;
			_effectHandle = null;
			_mojoEffect = null;
		}

		public void SetTechnique(int index)
		{
			Debug.Assert(index >= 0 && index < Techniques.Count);
			_currentTechnique = index;
			FNA3D_binding.SetEffectTechnique(_deviceHandle, _effectHandle, Techniques[index].[Friend]_technique);
		}

		public void ApplyEffect(int pass)
		{
			Debug.Assert(pass >= 0 && pass < (.)_mojoEffect.current_technique.pass_count);

			let technique = Techniques[_currentTechnique];
			let passObj = technique.Passes[pass];

			// when we call SetTexture we actually just store the texture/sampler in a Dictionary
			// when we go to apply a pass, iterate through the samplers it wants and try to pull them out of that Dictionary
			// if they exist, bind them to the correct slot
			for(let sampler in passObj.[Friend]pixel_samplers)
			{
				let s = scope String(sampler.Name);
				if(!samplers.ContainsKey(s))
				{
					continue;
				}

				var data = samplers[s];
				FNA3D_binding.VerifySampler(_deviceHandle, (.)sampler.Slot, data.Texture.[Friend]_handle, &data.Sampler);
			}

			for(let sampler in passObj.[Friend]vertex_samplers)
			{
				let s = scope String(sampler.Name);
				if(!samplers.ContainsKey(s))
				{
					continue;
				}

				var data = samplers[s];
				FNA3D_binding.VerifyVertexSampler(_deviceHandle, (.)sampler.Slot, data.Texture.[Friend]_handle, &data.Sampler);
			}

			// and finally apply the effect
			FNA3D_binding.ApplyEffect(_deviceHandle, _effectHandle, (.)pass, &_stateChanges);
		}

		public Result<void> SetTexture(StringView paramName, Texture2D texture, SamplerState samplerState)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Object, ShaderParameterType.sampler2D);

			let s = scope String(paramName);

			if(!samplers.ContainsKey(s))
				samplers.Add(new String(paramName), BoundSampler(texture, samplerState));
			else
				samplers[s] = BoundSampler(texture, samplerState);

			return .Ok;
		}

		public Result<void> SetTexture(StringView paramName, Texture3D texture, SamplerState samplerState)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Object, ShaderParameterType.sampler3D);

			let s = scope String(paramName);

			if(!samplers.ContainsKey(s))
				samplers.Add(new String(paramName), BoundSampler(texture, samplerState));
			else
				samplers[s] = BoundSampler(texture, samplerState);

			return .Ok;
		}

		public Result<void> SetTexture(StringView paramName, TextureCube texture, SamplerState samplerState)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Object, ShaderParameterType.samplerCube);

			let s = scope String(paramName);

			if(!samplers.ContainsKey(s))
				samplers.Add(new String(paramName), BoundSampler(texture, samplerState));
			else
				samplers[s] = BoundSampler(texture, samplerState);

			return .Ok;
		}

		public Result<void> SetFloat(StringView paramName, float value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Scalar, ShaderParameterType.float);

			param.[Friend]_param.value.values.valuesF[0] = value;

			return .Ok;
		}

		public Result<void> SetInt(StringView paramName, int value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Scalar, ShaderParameterType.int);

			param.[Friend]_param.value.values.valuesI[0] = (.)value;

			return .Ok;
		}

		public Result<void> SetBool(StringView paramName, bool value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Scalar, ShaderParameterType.bool);

			param.[Friend]_param.value.values.valuesI[0] = value ? 1 : 0;

			return .Ok;
		}

		public Result<void> SetVec2(StringView paramName, Vec2 value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Vector, ShaderParameterType.float);

			if(param.Columns != 2) return .Err;

			let ptr = (Vec2*)(param.[Friend]_param.value.values.values);
			*ptr = value;

			return .Ok;
		}

		public Result<void> SetVec3(StringView paramName, Vec3 value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Vector, ShaderParameterType.float);

			if(param.Columns != 3) return .Err;

			let ptr = (Vec3*)(param.[Friend]_param.value.values.values);
			*ptr = value;

			return .Ok;
		}

		public Result<void> SetVec4(StringView paramName, Vec4 value)
		{
			let param = GetParameter(paramName);
			CheckParam!(param, ShaderParameterClass.Vector, ShaderParameterType.float);

			if(param.Columns != 4) return .Err;

			let ptr = (Vec4*)(param.[Friend]_param.value.values.values);
			*ptr = value;

			return .Ok;
		}

		public Result<void> SetMatrix4x4(StringView paramName, Matrix4x4 value)
		{
			let param = GetParameter(paramName);
			if(param == null || ( param.Class != .Matrix_rows && param.Class != .Matrix_columns ) || param.Type != .float)
				return Result<void>.Err;

			if(param.Rows != 4 || param.Columns != 4) return .Err;

			let ptr = (Matrix4x4*)(param.[Friend]_param.value.values.values);

			// unless compiled with /Zpc, shaders will expect column-major matrices
			// so we'll transpose our row-major matrices to match
			*ptr = Matrix4x4.Transpose(value);

			return .Ok;
		}

		private mixin CheckParam(EffectParameter param, ShaderParameterClass c, ShaderParameterType t)
		{
			if(param == null || param.Class != c || param.Type != t)
				return Result<void>.Err;
		}

		private EffectParameter GetParameter(StringView paramName)
		{
			// TODO: this kinda sucks

			for(let param in Parameters)
			{
				if(param.Name == paramName)
				{
					return param;
				}
			}

			return null;
		}
	}
}