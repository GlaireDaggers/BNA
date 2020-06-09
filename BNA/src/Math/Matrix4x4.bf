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
	}
}
