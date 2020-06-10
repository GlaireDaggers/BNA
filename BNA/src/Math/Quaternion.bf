using System;

namespace BNA.Math
{
	[CRepr]
	public struct Quaternion
	{
		public static readonly Quaternion Identity = .(0, 0, 0, 1);

		public float x;
		public float y;
		public float z;
		public float w;

		public this(float x, float y, float z, float w)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("({0}, {1}, {2}, {3})", x, y, z, w);
		}

		public Quaternion Conjugate()
		{
			return .(-x, -y, -z, w);
		}

		public Quaternion Inverse()
		{
			Quaternion quaternion2;
			float num2 = (((this.x * this.x) + (this.y * this.y)) + (this.z * this.z)) + (this.w * this.w);
			float num = 1f / num2;
			quaternion2.x = -this.x * num;
			quaternion2.y = -this.y * num;
			quaternion2.z = -this.z * num;
			quaternion2.w = this.w * num;

			return quaternion2;
		}

		public Quaternion Normalized()
		{
			float num = 1f / ((float) Math.Sqrt((x * x) + (y * y) + (z * z) + (w * w)));
			Quaternion q = this;
			q.x *= num;
			q.y *= num;
			q.z *= num;
			q.w *= num;

			return q;
		}

		public static Quaternion CreateFromAxisAngle(Vec3 axis, float angle)
		{
			float half = angle * 0.5f * MathUtils.DEG2RAD;
			float sin = Math.Sin(half);
			float cos = Math.Cos(half);
			return .(axis.x * sin, axis.y * sin, axis.z * sin, cos);
		}

		public static Quaternion CreateFromEulerAngles(Vec3 angles)
		{
			Vec3 half = angles * 0.5f * MathUtils.DEG2RAD;

			Vec3 sin = .( Math.Sin(half.x), Math.Sin(half.y), Math.Sin(half.z) );
			Vec3 cos = .( Math.Cos(half.x), Math.Cos(half.y), Math.Cos(half.z) );

			return .(
				(cos.y * sin.x * cos.z) + (sin.y * cos.x * sin.z),
				(sin.y * cos.x * cos.z) - (cos.y * sin.x * sin.z),
				(cos.y * cos.x * sin.z) - (sin.y * sin.x * cos.z),
				(cos.y * cos.x * cos.z) + (sin.y * sin.x * sin.z)
				);
		}

		public static Quaternion operator*(Quaternion lhs, Quaternion rhs)
		{
			Quaternion quaternion;

			float x1 = lhs.x;
			float y1 = lhs.y;
			float z1 = lhs.z;
			float w1 = lhs.w;

			float x2 = rhs.x;
			float y2 = rhs.y;
			float z2 = rhs.z;
			float w2 = rhs.w;

			quaternion.x = ((x2 * w1) + (x1 * w2)) + ((y2 * z1) - (z2 * y1));
			quaternion.y = ((y2 * w1) + (y1 * w2)) + ((z2 * x1) - (x2 * z1));
			quaternion.z = ((z2 * w1) + (z1 * w2)) + ((x2 * y1) - (y2 * x1));
			quaternion.w = (w2 * w1) - (((x2 * x1) + (y2 * y1)) + (z2 * z1));

			return quaternion;
		}
	}
}
