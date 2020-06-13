using System;
using System.Diagnostics;

namespace BNA.Math
{
	[CRepr]
	public struct Matrix4x4
	{
		public static readonly Matrix4x4 Identity = Matrix4x4(.(
			1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1
			));

		public float* m { get mut { return &M11; } }

		public float M11;
		public float M12;
		public float M13;
		public float M14;

		public float M21;
		public float M22;
		public float M23;
		public float M24;

		public float M31;
		public float M32;
		public float M33;
		public float M34;

		public float M41;
		public float M42;
		public float M43;
		public float M44;

		public this()
		{
			M11 = 0f;
			M12 = 0f;
			M13 = 0f;
			M14 = 0f;

			M21 = 0f;
			M22 = 0f;
			M23 = 0f;
			M24 = 0f;

			M31 = 0f;
			M32 = 0f;
			M33 = 0f;
			M34 = 0f;

			M41 = 0f;
			M42 = 0f;
			M43 = 0f;
			M44 = 0f;
		}

		public this(float[16] values)
		{
			M11 = values[0];
			M12 = values[1];
			M13 = values[2];
			M14 = values[3];

			M21 = values[4];
			M22 = values[5];
			M23 = values[6];
			M24 = values[7];

			M31 = values[8];
			M32 = values[9];
			M33 = values[10];
			M34 = values[11];

			M41 = values[12];
			M42 = values[13];
			M43 = values[14];
			M44 = values[15];
		}

		public float this[int x, int y]
		{
			get mut
			{
				Debug.Assert(x >= 0 && x < 4 && y >= 0 && y < 4, "Index out of range");
				return m[x + (y << 2)];
			}
			set mut
			{
				Debug.Assert(x >= 0 && x < 4 && y >= 0 && y < 4, "Index out of range");
				m[x + (y << 2)] = value;
			}
		}

		public static Matrix4x4 Transpose(Matrix4x4 mat)
		{
			return .(.(
				mat.M11, mat.M21, mat.M31, mat.M41,
				mat.M12, mat.M22, mat.M32, mat.M42,
				mat.M13, mat.M23, mat.M33, mat.M43,
				mat.M14, mat.M24, mat.M34, mat.M44
				));
		}

		public static Matrix4x4 Scale(Vec3 scale)
		{
			return .(.(
				scale.x, 0f, 0f, 0f,
				0f, scale.y, 0f, 0f,
				0f, 0f, scale.z, 0f,
				0f, 0f, 0f, 1f,
				));
		}

		public static Matrix4x4 Translate(Vec3 translate)
		{
			return .(.(
				1f, 0f, 0f, 0f,
				0f, 1f, 0f, 0f,
				0f, 0f, 1f, 0f,
				translate.x, translate.y, translate.z, 1f,
				));
		}

		public static Matrix4x4 Rotation(Quaternion rotation)
		{
			Matrix4x4 result;

			float num9 = rotation.x * rotation.x;
			float num8 = rotation.y * rotation.y;
			float num7 = rotation.z * rotation.z;
			float num6 = rotation.x * rotation.y;
			float num5 = rotation.z * rotation.w;
			float num4 = rotation.z * rotation.x;
			float num3 = rotation.y * rotation.w;
			float num2 = rotation.y * rotation.z;
			float num = rotation.x * rotation.w;

			result.M11 = 1f - (2f * (num8 + num7));
			result.M12 = 2f * (num6 + num5);
			result.M13 = 2f * (num4 - num3);
			result.M14 = 0f;
			result.M21 = 2f * (num6 - num5);
			result.M22 = 1f - (2f * (num7 + num9));
			result.M23 = 2f * (num2 + num);
			result.M24 = 0f;
			result.M31 = 2f * (num4 + num3);
			result.M32 = 2f * (num2 - num);
			result.M33 = 1f - (2f * (num8 + num9));
			result.M34 = 0f;
			result.M41 = 0f;
			result.M42 = 0f;
			result.M43 = 0f;
			result.M44 = 1f;

			return result;
		}

		public static Matrix4x4 CreateOrthographic(float width, float height, float zNear, float zFar)
		{
			Matrix4x4 result;

			result.M11 = 2f / width;
			result.M12 = result.M13 = result.M14 = 0f;
			result.M22 = 2f / height;
			result.M21 = result.M23 = result.M24 = 0f;
			result.M33 = 1f / (zNear - zFar);
			result.M31 = result.M32 = result.M34 = 0f;
			result.M41 = result.M42 = 0f;
			result.M43 = zNear / (zNear - zFar);
			result.M44 = 1f;

			return result;
		}

		public static Matrix4x4 CreatePerspective(float fieldOfView, float aspectRatio, float near, float far)
		{
			let fov = fieldOfView * MathUtils.DEG2RAD;

			Debug.Assert(fov > 0f && fov < Math.PI_f, "FOV must be >0 and <180");
			Debug.Assert(near > 0f, "Near plane must be >0");
			Debug.Assert(far > near, "Far plane must be greater than near plane");

			Matrix4x4 result;

			float num = 1f / Math.Tan(fieldOfView * 0.5f);
			float num9 = num / aspectRatio;
			result.M11 = num9;
			result.M12 = result.M13 = result.M14 = 0;
			result.M22 = num;
			result.M21 = result.M23 = result.M24 = 0;
			result.M31 = result.M32 = 0f;
			result.M33 = far / (near - far);
			result.M34 = -1;
			result.M41 = result.M42 = result.M44 = 0;
			result.M43 = (near * far) / (near - far);

			return result;
		}

		public static Matrix4x4 operator*(Matrix4x4 matrix1, Matrix4x4 matrix2)
		{
			Matrix4x4 result = .();

			result.M11 = matrix1.M11 * matrix2.M11 + matrix1.M12 * matrix2.M21 + matrix1.M13 * matrix2.M31 + matrix1.M14 * matrix2.M41;
			result.M12 = matrix1.M11 * matrix2.M12 + matrix1.M12 * matrix2.M22 + matrix1.M13 * matrix2.M32 + matrix1.M14 * matrix2.M42;
			result.M13 = matrix1.M11 * matrix2.M13 + matrix1.M12 * matrix2.M23 + matrix1.M13 * matrix2.M33 + matrix1.M14 * matrix2.M43;
			result.M14 = matrix1.M11 * matrix2.M14 + matrix1.M12 * matrix2.M24 + matrix1.M13 * matrix2.M34 + matrix1.M14 * matrix2.M44;
			            
			result.M21 = matrix1.M21 * matrix2.M11 + matrix1.M22 * matrix2.M21 + matrix1.M23 * matrix2.M31 + matrix1.M24 * matrix2.M41;
			result.M22 = matrix1.M21 * matrix2.M12 + matrix1.M22 * matrix2.M22 + matrix1.M23 * matrix2.M32 + matrix1.M24 * matrix2.M42;
			result.M23 = matrix1.M21 * matrix2.M13 + matrix1.M22 * matrix2.M23 + matrix1.M23 * matrix2.M33 + matrix1.M24 * matrix2.M43;
			result.M24 = matrix1.M21 * matrix2.M14 + matrix1.M22 * matrix2.M24 + matrix1.M23 * matrix2.M34 + matrix1.M24 * matrix2.M44;

			result.M31 = matrix1.M31 * matrix2.M11 + matrix1.M32 * matrix2.M21 + matrix1.M33 * matrix2.M31 + matrix1.M34 * matrix2.M41;
			result.M32 = matrix1.M31 * matrix2.M12 + matrix1.M32 * matrix2.M22 + matrix1.M33 * matrix2.M32 + matrix1.M34 * matrix2.M42;
			result.M33 = matrix1.M31 * matrix2.M13 + matrix1.M32 * matrix2.M23 + matrix1.M33 * matrix2.M33 + matrix1.M34 * matrix2.M43;
			result.M34 = matrix1.M31 * matrix2.M14 + matrix1.M32 * matrix2.M24 + matrix1.M33 * matrix2.M34 + matrix1.M34 * matrix2.M44;

			result.M41 = matrix1.M41 * matrix2.M11 + matrix1.M42 * matrix2.M21 + matrix1.M43 * matrix2.M31 + matrix1.M44 * matrix2.M41;
			result.M42 = matrix1.M41 * matrix2.M12 + matrix1.M42 * matrix2.M22 + matrix1.M43 * matrix2.M32 + matrix1.M44 * matrix2.M42;
			result.M43 = matrix1.M41 * matrix2.M13 + matrix1.M42 * matrix2.M23 + matrix1.M43 * matrix2.M33 + matrix1.M44 * matrix2.M43;
			result.M44 = matrix1.M41 * matrix2.M14 + matrix1.M42 * matrix2.M24 + matrix1.M43 * matrix2.M34 + matrix1.M44 * matrix2.M44; 

			return result;
		}

		public static Vec4 operator*(Matrix4x4 matrix, Vec2 vec)
		{
			return Vec4((vec.x * matrix.M11) + (vec.y * matrix.M21) + (matrix.M31) + (matrix.M41),
				(vec.x * matrix.M12) + (vec.y * matrix.M22) + (matrix.M32) + (matrix.M42),
				(vec.x * matrix.M13) + (vec.y * matrix.M23) + (matrix.M33) + (matrix.M43),
				(vec.x * matrix.M14) + (vec.y * matrix.M24) + (matrix.M34) + (matrix.M44));
		}

		public static Vec4 operator*(Matrix4x4 matrix, Vec3 vec)
		{
			return Vec4((vec.x * matrix.M11) + (vec.y * matrix.M21) + (vec.z * matrix.M31) + (matrix.M41),
				(vec.x * matrix.M12) + (vec.y * matrix.M22) + (vec.z * matrix.M32) + (matrix.M42),
				(vec.x * matrix.M13) + (vec.y * matrix.M23) + (vec.z * matrix.M33) + (matrix.M43),
				(vec.x * matrix.M14) + (vec.y * matrix.M24) + (vec.z * matrix.M34) + (matrix.M44));
		}

		public static Vec4 operator*(Matrix4x4 matrix, Vec4 vec)
		{
			return Vec4((vec.x * matrix.M11) + (vec.y * matrix.M21) + (vec.z * matrix.M31) + (vec.w * matrix.M41),
				(vec.x * matrix.M12) + (vec.y * matrix.M22) + (vec.z * matrix.M32) + (vec.w * matrix.M42),
				(vec.x * matrix.M13) + (vec.y * matrix.M23) + (vec.z * matrix.M33) + (vec.w * matrix.M43),
				(vec.x * matrix.M14) + (vec.y * matrix.M24) + (vec.z * matrix.M34) + (vec.w * matrix.M44));
		}
	}
}
