namespace BNA.Audio
{
	public struct Song
	{
		public readonly SoundEffect Intro;
		public readonly SoundEffect Loop;

		public this(SoundEffect loop)
		{
			Intro = null;
			Loop = loop;
		}

		public this(SoundEffect intro, SoundEffect loop)
		{
			Intro = intro;
			Loop = loop;
		}
	}
}
