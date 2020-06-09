using System;

namespace BNA.bindings
{
	[AllowDuplicates]
	public enum SoLoud_Enums : int32
	{
		SOLOUD_AUTO = 0,
		SOLOUD_SDL1 = 1,
		SOLOUD_SDL2 = 2,
		SOLOUD_PORTAUDIO = 3,
		SOLOUD_WINMM = 4,
		SOLOUD_XAUDIO2 = 5,
		SOLOUD_WASAPI = 6,
		SOLOUD_ALSA = 7,
		SOLOUD_JACK = 8,
		SOLOUD_OSS = 9,
		SOLOUD_OPENAL = 10,
		SOLOUD_COREAUDIO = 11,
		SOLOUD_OPENSLES = 12,
		SOLOUD_VITA_HOMEBREW = 13,
		SOLOUD_MINIAUDIO = 14,
		SOLOUD_NOSOUND = 15,
		SOLOUD_NULLDRIVER = 16,
		SOLOUD_BACKEND_MAX = 17,
		SOLOUD_CLIP_ROUNDOFF = 1,
		SOLOUD_ENABLE_VISUALIZATION = 2,
		SOLOUD_LEFT_HANDED_3D = 4,
		SOLOUD_NO_FPU_REGISTER_CHANGE = 8,
		BASSBOOSTFILTER_WET = 0,
		BASSBOOSTFILTER_BOOST = 1,
		BIQUADRESONANTFILTER_LOWPASS = 0,
		BIQUADRESONANTFILTER_HIGHPASS = 1,
		BIQUADRESONANTFILTER_BANDPASS = 2,
		BIQUADRESONANTFILTER_WET = 0,
		BIQUADRESONANTFILTER_TYPE = 1,
		BIQUADRESONANTFILTER_FREQUENCY = 2,
		BIQUADRESONANTFILTER_RESONANCE = 3,
		ECHOFILTER_WET = 0,
		ECHOFILTER_DELAY = 1,
		ECHOFILTER_DECAY = 2,
		ECHOFILTER_FILTER = 3,
		FLANGERFILTER_WET = 0,
		FLANGERFILTER_DELAY = 1,
		FLANGERFILTER_FREQ = 2,
		FREEVERBFILTER_WET = 0,
		FREEVERBFILTER_FREEZE = 1,
		FREEVERBFILTER_ROOMSIZE = 2,
		FREEVERBFILTER_DAMP = 3,
		FREEVERBFILTER_WIDTH = 4,
		LOFIFILTER_WET = 0,
		LOFIFILTER_SAMPLERATE = 1,
		LOFIFILTER_BITDEPTH = 2,
		NOISE_WHITE = 0,
		NOISE_PINK = 1,
		NOISE_BROWNISH = 2,
		NOISE_BLUEISH = 3,
		ROBOTIZEFILTER_WET = 0,
		ROBOTIZEFILTER_FREQ = 1,
		ROBOTIZEFILTER_WAVE = 2,
		SFXR_COIN = 0,
		SFXR_LASER = 1,
		SFXR_EXPLOSION = 2,
		SFXR_POWERUP = 3,
		SFXR_HURT = 4,
		SFXR_JUMP = 5,
		SFXR_BLIP = 6,
		SPEECH_KW_SAW = 0,
		SPEECH_KW_TRIANGLE = 1,
		SPEECH_KW_SIN = 2,
		SPEECH_KW_SQUARE = 3,
		SPEECH_KW_PULSE = 4,
		SPEECH_KW_NOISE = 5,
		SPEECH_KW_WARBLE = 6,
		VIC_PAL = 0,
		VIC_NTSC = 1,
		VIC_BASS = 0,
		VIC_ALTO = 1,
		VIC_SOPRANO = 2,
		VIC_NOISE = 3,
		VIC_MAX_REGS = 4,
		WAVESHAPERFILTER_WET = 0,
		WAVESHAPERFILTER_AMOUNT = 1
	}

	[AllowDuplicates]
	public enum Soloud_Result : int32
	{
		OK = 0,

		InvalidParameter = 1,
		FileNotFound = 2,
		FileLoadFailed = 3,
		DLLNotFound = 4,
		OutOfMemory = 5,
		NotImplemented = 6,
		UnknownError = 7
	}

	public typealias AlignedFloatBuffer = void*;
	public typealias TinyAlignedFloatBuffer = void*;
	public typealias Soloud = void*;
	public typealias AudioCollider = void*;
	public typealias AudioAttenuator = void*;
	public typealias AudioSource = void*;
	public typealias BassboostFilter = void*;
	public typealias BiquadResonantFilter = void*;
	public typealias Bus = void*;
	public typealias DCRemovalFilter = void*;
	public typealias EchoFilter = void*;
	public typealias Fader = void*;
	public typealias FFTFilter = void*;
	public typealias Filter = void*;
	public typealias FlangerFilter = void*;
	public typealias FreeverbFilter = void*;
	public typealias LofiFilter = void*;
	public typealias Monotone = void*;
	public typealias Noise = void*;
	public typealias Openmpt = void*;
	public typealias Queue = void*;
	public typealias RobotizeFilter = void*;
	public typealias Sfxr = void*;
	public typealias Speech = void*;
	public typealias TedSid = void*;
	public typealias Vic = void*;
	public typealias Vizsn = void*;
	public typealias Wav = void*;
	public typealias WaveShaperFilter = void*;
	public typealias WavStream = void*;
	public typealias File = void*;

	public static class SoLoud_binding
	{
#region Soloud
		[CLink]
		public static extern Soloud Soloud_create();

		[CLink]
		public static extern void Soloud_destroy(Soloud aSoloud);

		[CLink]
		public static extern Soloud_Result Soloud_init(Soloud aSoloud);

		[CLink]
		public static extern void Soloud_deinit(Soloud aSoloud);

		[CLink]
		public static extern uint32 Soloud_getBackendSamplerate(Soloud aSoloud);

		[CLink]
		public static extern void Soloud_update3dAudio(Soloud aSoloud);

		[CLink]
		public static extern float Soloud_get3dSoundSpeed(Soloud aSoloud);

		[CLink]
		public static extern void Soloud_set3dSoundSpeed(Soloud aSoloud, float speedOfSound);

		[CLink]
		public static extern void Soloud_set3dListenerPosition(Soloud aSoloud, float x, float y, float z);

		[CLink]
		public static extern void Soloud_set3dListenerAt(Soloud aSoloud, float x, float y, float z);

		[CLink]
		public static extern void Soloud_set3dListenerUp(Soloud aSoloud, float x, float y, float z);

		[CLink]
		public static extern void Soloud_set3dListenerVelocity(Soloud aSoloud, float x, float y, float z);

		[CLink]
		public static extern int32 Soloud_createVoiceGroup(Soloud aSoloud);

		[CLink]
		public static extern Soloud_Result Soloud_destroyVoiceGroup(Soloud aSoloud, uint32 vgHandle);

		[CLink]
		public static extern Soloud_Result Soloud_addVoiceToGroup(Soloud aSoloud, uint32 vgHandle, uint32 voiceHandle);

		[CLink]
		public static extern int32 Soloud_isVoiceGroupEmpty(Soloud aSoloud, uint32 vgHandle);

		[CLink]
		public static extern int32 Soloud_play(Soloud aSoloud, void* voicePtr);

		[CLink]
		public static extern int32 Soloud_playEx(Soloud aSoloud, void* voicePtr, float volume, float pan, int32 paused, uint bus);

		[CLink]
		public static extern int32 Soloud_play3d(Soloud aSoloud, void* voicePtr, float posX, float posY, float posZ);

		[CLink]
		public static extern int32 Soloud_play3dEx(Soloud aSoloud, void* voicePtr, float posX, float posY, float posZ, float velX, float velY, float velZ, float volume, int32 paused, uint32 bus);

		[CLink]
		public static extern void Soloud_stop(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern float Soloud_getSamplerate(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setDelaySamples(Soloud aSoloud, int32 voiceHandle, uint32 delaySamples);

		[CLink]
		public static extern void Soloud_scheduleStop(Soloud aSoloud, int32 voiceHandle, double time);

		[CLink]
		public static extern int32 Soloud_getPause(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setPause(Soloud aSoloud, int32 voiceHandle, int32 pause);

		[CLink]
		public static extern int32 Soloud_getLooping(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setLooping(Soloud aSoloud, int32 voiceHandle, int32 looping);

		[CLink]
		public static extern double Soloud_getLoopPoint(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setLoopPoint(Soloud aSoloud, int32 voiceHandle, double loopPoint);

		[CLink]
		public static extern float Soloud_getVolume(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setVolume(Soloud aSoloud, int32 voiceHandle, float volume);

		[CLink]
		public static extern float Soloud_getPan(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setPan(Soloud aSoloud, int32 voiceHandle, float pan);

		[CLink]
		public static extern float Soloud_getRelativePlaySpeed(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setRelativePlaySpeed(Soloud aSoloud, int32 voiceHandle, float speed);

		[CLink]
		public static extern int32 Soloud_getProtectVoice(Soloud aSoloud, int32 voiceHandle);

		[CLink]
		public static extern void Soloud_setProtectVoice(Soloud aSoloud, int32 voiceHandle, int32 protect);

		[CLink]
		public static extern void Soloud_setInaudibleBehavior(Soloud aSoloud, int32 voiceHandle, int32 mustTick, int32 kill);

		[CLink]
		public static extern void Soloud_set3dSourcePosition(Soloud aSoloud, int32 voiceHandle, float posX, float posY, float posZ);

		[CLink]
		public static extern void Soloud_set3dSourceVelocity(Soloud aSoloud, int32 voiceHandle, float velX, float velY, float velZ);

		[CLink]
		public static extern void Soloud_set3dSourceMinMaxDistance(Soloud aSoloud, int32 voiceHandle, float minDistance, float maxDistance);

		[CLink]
		public static extern void Soloud_set3dSourceAttenuation(Soloud aSoloud, int32 voiceHandle, uint32 attenuationModel, float rolloffFactor);

		[CLink]
		public static extern void Soloud_set3dSourceDopplerFactor(Soloud aSoloud, int32 voiceHandle, float dopplerFactor);

		[CLink]
		public static extern void Soloud_setFilterParameter(Soloud aSoloud, uint32 voiceHandle, uint32 filterId, uint32 attributeId, float value);
#endregion

#region Wav
		[CLink]
		public static extern Wav Wav_create();

		[CLink]
		public static extern void Wav_destroy(Wav ptr);

		[CLink]
		public static extern Soloud_Result Wav_loadMemEx(Wav ptr, uint8* mem, uint32 length, int32 copy, int32 takeOwnership);

		[CLink]
		public static extern double Wav_getLength(Wav ptr);
#endregion

#region WavStream
		[CLink]
		public static extern WavStream WavStream_create();

		[CLink]
		public static extern WavStream WavStream_destroy(WavStream handle);

		[CLink]
		public static extern Soloud_Result WavStream_load(WavStream handle, char8* filename);

		[CLink]
		public static extern double WavStream_getLength(WavStream ptr);
#endregion

#region Bus
		[CLink]
		public static extern Bus Bus_create();

		[CLink]
		public static extern void Bus_destroy(Bus bus);

		[CLink]
		public static extern uint32 Bus_play(Bus bus, AudioSource audioSrc);

		[CLink]
		public static extern uint32 Bus_playEx(Bus bus, AudioSource audioSrc, float volume, float pan, int32 paused);

		[CLink]
		public static extern uint32 Bus_play3d(Bus bus, AudioSource audioSrc, float posX, float posY, float posZ);

		[CLink]
		public static extern uint32 Bus_play3dEx(Bus bus, AudioSource audioSrc, float posX, float posY, float posZ, float velX, float velY, float velZ, float volume, int32 paused);

		[CLink]
		public static extern void Bus_setVolume(Bus bus, float volume);

		[CLink]
		public static extern void Bus_annexSound(Bus bus, int32 handle);

		[CLink]
		public static extern void Bus_setFilter(Bus bus, uint32 slot, Filter filter);
#endregion

#region Freeverb
		[CLink]
		public static extern FreeverbFilter FreeverbFilter_create();

		[CLink]
		public static extern void FreeverbFilter_destroy(FreeverbFilter filter);
#endregion

#region Echo
		[CLink]
		public static extern EchoFilter EchoFilter_create();

		[CLink]
		public static extern void EchoFilter_destroy(EchoFilter filter);
#endregion

#region Flanger
		[CLink]
		public static extern FlangerFilter FlangerFilter_create();

		[CLink]
		public static extern void FlangerFilter_destroy(FlangerFilter filter);
#endregion

#region Lofi
		[CLink]
		public static extern LofiFilter LofiFilter_create();

		[CLink]
		public static extern void LofiFilter_destroy(LofiFilter filter);
#endregion

#region WaveShaper
		[CLink]
		public static extern WaveShaperFilter WaveShaperFilter_create();

		[CLink]
		public static extern void WaveShaperFilter_destroy(WaveShaperFilter filter);
#endregion

#region BiquadResonantFilter
		[CLink]
		public static extern BiquadResonantFilter BiquadResonantFilter_create();

		[CLink]
		public static extern void BiquadResonantFilter_destroy(BiquadResonantFilter filter);
#endregion

#region RobotizeFilter
		[CLink]
		public static extern RobotizeFilter RobotizeFilter_create();

		[CLink]
		public static extern void RobotizeFilter_destroy(RobotizeFilter filter);
#endregion

#region BassboostFilter
		[CLink]
		public static extern BassboostFilter BassboostFilter_create();

		[CLink]
		public static extern void BassboostFilter_destroy(BassboostFilter filter);
#endregion
	}
}
