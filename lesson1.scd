//L'Equipe du Son - Lesson 1
//Cover by Murtaza Javaid, April 2021

(
var bassline, key1s, key2s, key3s, key4s, keys_chords, kit, phased, kit_4, sparkles, keys_melody, saw_breakdown, p_uwu, whoosh, riser, french_lesson, p_so, p_love_words, p_tu_es_jolie, p_tu_es_gentil, p_je_taime, p_je_taime_bien, p_tu_es_formidable, d_kick, d_hh, d_sn;
var bar = 2.162;
var b4 = bar/4;
var b8 = bar/8;
var b16 = bar/16;

var uwu = Buffer.read(s, "samples/uwu.wav".resolveRelative);
//ATTRIBUTION:
//ooh sample from https://samplefocus.com/samples/female-vocals-ooh-g
//            and https://samplefocus.com/samples/female-vocals-ooh-d


var french = Buffer.read(s, "samples/jetaime.wav".resolveRelative);
var so = Buffer.read(s, "samples/so.wav".resolveRelative);
var tu_es_jolie = Buffer.read(s, "samples/tu_es_jolie.wav".resolveRelative);
var tu_es_gentil = Buffer.read(s, "samples/tu_es_gentil.wav".resolveRelative);
var je_taime = Buffer.read(s, "samples/je_taime.wav".resolveRelative);
var je_taime_bien = Buffer.read(s, "samples/je_taime_bien.wav".resolveRelative);
var tu_es_formidable = Buffer.read(s, "samples/tu_es_formidable.wav".resolveRelative);
//ATTRIBUTION:
//vocals recorded by my good friend G :) thanks



// b = Buffer.read(s, "uwu.wav".resolveRelative);
SynthDef(\sample, {| out = 0, bufnum = 0, amp = 1, dur=60|
	var snd = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf);
	var ampenv = Env.new([0, 1, 1, 0.01, 0], [0.1, dur-0.25, 0.14, 0.01], curve:['lin', 'lin', 'exp', 'lin']);
	ampenv = EnvGen.kr(ampenv, doneAction:2);
    Out.ar(out, snd * amp * ampenv);
}).add;

SynthDef(\sample1ch, {| out = 0, bufnum = 0, amp = 1, pan = 0, dur = 60|
	var snd = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf);
	var ampenv = Env.new([0, 1, 1, 0.01, 0], [0.1, dur-0.25, 0.14, 0.01], curve:['lin', 'lin', 'exp', 'lin']);
	ampenv = EnvGen.kr(ampenv, doneAction:2);
	Out.ar(out, Pan2.ar(snd * amp * ampenv, pan));
}).add;

// Synth(\sample, [\bufnum, b]);



// var bar = 2.162;
SynthDef(\fwwww, {|out = 0, amp = 1, dur = 1|
	var snd = WhiteNoise.ar();
	var line = XLine.kr(200, 15000, dur);
	var ampenv = Env.new([0, 1, 1, 0.01, 0], [0.1, dur+0.05, 0.15, 0.01], curve:['lin', 'lin', 'exp', 'lin']);
	ampenv = EnvGen.kr(ampenv, doneAction:2);
	// var lfo = SinOsc.kr(line, mul: 0.5, add: 1.0);
	snd = RLPF.ar(snd, line, 0.4);
	snd = HPF.ar(snd, 400);
	Out.ar(out, amp * ampenv * Pan2.ar(snd, 0, 0.1));
}).add;
// Synth(\fwwww);




// var bar = 2.162;
SynthDef(\vwvwvw, {|out = 0, amp = 1, dur = 1|
	var snd = WhiteNoise.ar();
	var line = Line.kr(12, 0.1, dur);
	var lfo = SinOsc.kr(line, mul: 0.5, add: 1.0);
	var ampenv = Env.new([0, 1, 1, 0.01, 0], [0.1, dur+0.05, 0.15, 0.01], curve:['lin', 'lin', 'exp', 'lin']);
	ampenv = EnvGen.kr(ampenv, doneAction:2);
	snd = RLPF.ar(snd, line.linexp(0.1, 12, 200, 15000) * lfo, 0.4);
	snd = HPF.ar(snd, 400);
	Out.ar(out, amp * Pan2.ar(snd, 0, 0.1));
}).add;
// Synth(\vwvwvw);



// var bar = 2.162;
SynthDef(\saw2,
	{
		|freq = 440, amp = 1, out = 0, dur=1, pan=0|
		var snd, panned;
		var algoNum = 7;
		// var freq = pitch.midicps;
		var freq2 = freq * 1.5;
		var ctls = [
			// freq, phase, amp
			[freq, pi, 0],
			[freq, 0, 0],
			[freq, 0, 1],
			[freq, 0, 2],
			[freq*2, 0, 1.2],
			// [freq*0.25, 0, 3],
			[freq*3, 0, 0]
		];
		var feedback = 0.45;
		var fm = FM7.arAlgo(algoNum, ctls, feedback);
		var ampenv = Env.new([0, 1, 1, 1, 0.01, 0], [0.01, 0.01, dur+0.05, 0.15, 0.01], curve:['lin', 'exp', 'lin', 'exp', 'lin']);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo
		snd = SinOsc.ar(0);
		panned = [SinOsc.ar(0), SinOsc.ar(0)];
		4.do({
			arg i;
			snd = Saw.ar((freq.cpsmidi - (0.06 * i)).midicps, 0.125);
			panned = panned + Pan2.ar(snd, (2/3) * i - 1, ampenv * amp);
		});
		panned = RLPF.ar(panned, 15000, 0.3);

		//stereo detuning! (thanks humz)

		// Out.ar(out, (Mix.ar(fm * 0.2) * ampenv * amp) ! 2);
		Out.ar(out, panned);
	}
).add;
// Synth(\sawish, [pitch:48]);

/*y = Pbind(
	\instrument, \saw2,
	\midinote, Pseq([
		48, 60, 84, 72, 48, 60, 84, 72,
		48, 60, 84, 75, 48, 60, 72, 84,
		48, 60, 84, 72, 48, 60, 84, 72,
		48, 60, 84, 75, 48, 60, 82, 79,
	]-12, 1),
	\dur, bar/16,
	\amp, 0.5
).play;*/



// {Saw.ar(72.midicps)}.play;


// var bar = 2.162;
SynthDef(\keys2,
	{
		|freq = 220, amp = 0.5, out = 0, dur = 10, panningfreq = 0|
		var algoNum, freq2, ctls, feedback, fm, ampenv, snd, pan, delay1, delay2;
		algoNum = 7;
		freq = freq * LFNoise2.kr(5, 0.005, 1);
		freq2 = freq * 1.5;
		ctls = [
			// freq, phase, amp
			[freq*1.0, pi, 0],
			[freq*1, 0, 0],
			[freq, 0, 1],
			[freq*1, 0, 0.4],
			[freq*2, 0, 2.7],
			// [freq*0.25, 0, 3],
			[freq*2, 0, 0.4]
		];
		feedback = 0.3;
		fm = FM7.arAlgo(algoNum, ctls, feedback);
		ampenv = Env.new([0, 1, 0.5, 0.3, 0.01, 0], [0.03, 0.05, dur-0.45, 0.1, 1], curve:['lin', 'lin', 'lin', 'exp', 'lin']);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo
		snd = (Mix.ar(fm) * ampenv * amp);
		// snd = BPeakEQ.ar(snd, freq, 0.4, -6, 1, 0);
		pan = SinOsc.kr(panningfreq, mul:0.4);
		snd = RLPF.ar(snd, freq*12, 2.0);
		// delay1 = DelayC.ar(snd, bar/16, bar/16, 0.4);
		// delay2 = DelayC.ar(snd, 2*bar/16, 2*bar/16, 0.2);
		// snd = snd*0.5 + delay1 + delay2;
		snd = SwitchDelay.ar(snd, 1, 0.8, bar/16, 0.7, 5);
		Out.ar(out, Pan2.ar(snd, pan));
	}
).add;
/*y = Pbind(
	\instrument, \keys2,
	\midinote, Pseq([46, 48, Rest(), 46, 48, 51, 58, 60]+12, 20),
	\dur, bar/8,
	\amp, 0.5
).play;*/
// Synth(\keys, [freq:56.midicps]);
// Synth(\keys, [freq:59.midicps]);
// Synth(\keys, [freq:63.midicps]);




SynthDef(\keys,
	{
		|freq = 220, amp = 0.5, out = 0, dur = 10, panningfreq = 0|
		var algoNum, freq2, ctls, feedback, fm, ampenv, snd, pan;
		algoNum = 7;
		freq = freq * LFNoise2.kr(5, 0.005, 1);
		freq2 = freq * 1.5;
		ctls = [
			// freq, phase, amp
			[freq*1.0, pi, 0.5],
			[freq*1, 0, 0],
			[freq, 0, 1],
			[freq*1, 0, 0.5],
			[freq*2, 0, 0.2],
			// [freq*0.25, 0, 3],
			[freq*2, 0, 0]
		];
		feedback = 0.7;
		fm = FM7.arAlgo(algoNum, ctls, feedback);
		ampenv = Env.new([0, 1, 0.5, 0.3, 0.01, 0], [0.03, 0.25, dur-0.45, 0.3, 0.01], curve:['lin', 'lin', 'lin', 'exp', 'lin']);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo
		snd = (Mix.ar(fm * 0.5) * ampenv * amp);
		// snd = BPeakEQ.ar(snd, freq, 0.4, -6, 1, 0);
		pan = SinOsc.kr(panningfreq, mul:0.4);
		Out.ar(out, Pan2.ar(snd, pan));
	}
).add;
/*y = Pbind(
	\instrument, \sawish,
	\midinote, Pseq([44, 53, 44, 53, 44, 53, 44, 53]-12, 2),
	\dur, bar/16,
	\amp, 0.5
).play;*/
// Synth(\keys, [freq:56.midicps]);
// Synth(\keys, [freq:59.midicps]);
// Synth(\keys, [freq:63.midicps]);




//ATTRIBUTION:
//starting point for hihat and snare was examples by Bruno Rivaro at https://sccode.org/1-54H


SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.03, rel = 0.3, ffreq = 5500, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = RHPF.ar(in: snd, freq: ffreq, rq: 0.6, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

// Synth(\hihat);



SynthDef("snare", {arg out = 0, amp = 0.3, sinfreq = 100, att = 0.01, rel = 0.15, ffreq = 2000, pan = 0;
	var env, snd1, snd2, sum;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd1 = HPF.ar(
		in: WhiteNoise.ar,
		freq: ffreq,
		mul: env
	);
	snd2 = SinOsc.ar(freq: sinfreq, mul: env*0.3);
	sum = snd1 + snd2;
	Out.ar(out, Pan2.ar(sum, pan));
}).add;
// Synth(\snare);


//kick!!!!!

SynthDef(\kick,
	{
		|freq = 200, amp = 1, out = 0, pan = 0|
		var snd;
		var algoNum = 7;
		// var freq2 = freq * 1.5;
		var ctls = [
			// freq, phase, amp
			[freq, 0, 0],
			[freq, 0, 0],
			[freq, 0, 1],
			[freq*0.1, 0, 1],
			[freq*0.05, 0, 4],
			// [freq*0.25, 0, 3],
			[freq*0.05, 0, 1]
		];
		var feedback = 0.5;
		var fm = FM7.arAlgo(algoNum, ctls, feedback);
		var ampenv = Env.new([1, 0.5, 0], [0.1, 0.15], curve:['lin', 'lin', 'lin']);
		freq = freq * Env.new([1, 1.01, 1], [0.1, 0.15]).kr + LFNoise1.kr(30, mul: 3);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo
		snd = RLPF.ar(Mix.ar(fm*0.95), 800);
		// snd = snd + RLPF.ar(PinkNoise.ar(mul:0.05), 300);
		Out.ar(out, Pan2.ar(snd, pan) * ampenv * amp);
	}
).add;
// Synth(\kick, [freq:34.midicps]);



// lost in the chrome forest saw thing


// var bar=2.162;
SynthDef(\sawish,
	{
		|freq = 440, amp = 1, out = 0|
		var algoNum = 7;
		// var freq = pitch.midicps;
		var freq2 = freq * 1.5;
		var ctls = [
			// freq, phase, amp
			[freq, pi, 0],
			[freq, 0, 0],
			[freq, 0, 1],
			[freq, 0, 2],
			[freq*2, 0, 1.2],
			// [freq*0.25, 0, 3],
			[freq*3, 0, 0]
		];
		var feedback = 0.45;
		var fm = FM7.arAlgo(algoNum, ctls, feedback);
		var ampenv = Env.new([0, 1, 0.7, 0.7, 0.01, 0], [0.01, 0.01, 0, 0.07, 0.01], curve:['lin', 'exp', 'lin', 'exp', 'lin']);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo

		Out.ar(out, (Mix.ar(fm * 0.2) * ampenv * amp) ! 2);
	}
).add;

// Synth(\sawish, [pitch:48]);

// y = Pbind(
// 	\instrument, \sawish,
// 	\midinote, Pseq([44, 53, 44, 53, 44, 53, 44, 53]-12, 2),
// 	\dur, bar/16,
// 	\amp, 0.5
// ).play;
//
// )
// Synth(\sawish, [pitch:53]);
// Synth(\sawish, [pitch:55]);



//bass guitar!

SynthDef(\bass,
	{
		|freq = 220, amp = 1, out = 0, pan = 0|
		var snd;
		var algoNum = 7;
		// var freq = pitch.midicps.postln;
		var freq2 = freq * 1.5;
		var ctls = [
			// freq, phase, amp
			[freq*1.0, 0, 1],
			[freq*1, 0, 0],
			[freq, 0, 1],
			[freq*3+LFNoise1.kr(24, mul:1), 0, 0.6],
			[freq, 0, 0.7],
			// [freq*0.25, 0, 3],
			[freq*2, 0, 0.6]
		];
		var feedback = 0.5;
		var fm = FM7.arAlgo(algoNum, ctls, feedback);
		var ampenv = Env.new([0, 1, 0.7, 0.7, 0.01, 0], [0.008, 0.06, 0, 0.4, 0.01], curve:['lin', 'exp', 'lin', 'exp', 'lin']);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together and make stereo
		snd = Mix.ar(fm * 0.5) * ampenv * amp;
		Out.ar(out, Pan2.ar(snd, pan));
	}
).add;
// Synth(\bass, [freq:36.midicps]);



//kinda majestic orchestral vibrating thing (30-70)

/*var bar = 2.162;
var b4 = bar/4;
var b8 = bar/8;
var b16 = bar/16;*/
SynthDef(\majestic,
	{
		|freq = 440, amp = 1, out = 0, mixratio = 1, eqcenterfreqfactor = 1, pan = 0|
		var algoNum = 7;
		// var freq = pitch.midicps.postln;
		var freq2 = freq * 1.5;
		var ctls = [
			// freq, phase, amp
			[freq, pi, 1],
			[freq*2, 0, 0],
			[freq, 0, 1],
			[freq*2, 0, 1],
			[freq*1.015, 0, 0.8],
			// [freq*0.25, 0, 3],
			[freq*2, 0, 1]
		];
		var feedback = 0.9;
		var fm = FM7.arAlgo(algoNum, ctls, feedback);
		var ampenv = Env.new([0, 1, 0.6, 0.6, 0.01, 0], [0.05, 0.05, 0.1, 0.3, 0.01], curve:['lin', 'lin', 'lin', 'exp', 'lin']);
		var snd;
		var effect;
		// var mixratio = SinOsc.kr(0.5, mul:0.5, add:0.5);
		ampenv = EnvGen.kr(ampenv, doneAction:2);
		//mix the output channels together
		snd = (Mix.ar(fm) * ampenv * amp);

		// effect = DelayN.ar(snd,0.02,MouseX.kr(0, 0.02));
		// snd = mixratio*snd + (1-mixratio)*AllpassL.ar(snd, delaytime:0);
		// snd = (1-mixratio)*snd + (mixratio)*effect;

		// eqcenterfreqfactor = MouseX.kr(0.8, 20);
		effect = BPeakEQ.ar(
			snd,
			eqcenterfreqfactor * freq, //ffreq
			2.0, //rq
			12, //boost
			1 //mul
		);
		snd = snd*0 + (effect*0.3);
		snd = RHPF.ar(snd, freq*4, 3);
		Out.ar(out, Pan2.ar(snd, pan));
    }
).add;
// Synth(\majestic, [pitch:58]);
// x = Pbind(
// 	\instrument, \majestic,
// 	\midinote, Pseq([Rest(), 58, 60, Rest(), 58, 60, Rest(), 58, 60, Rest()], 2),
// 	\dur, Pseq([b8, b16, b16, b8, b16, b16, b8, b16, b16, b4], 2),
// 	\eqcenterfreqfactor, Env.new([1, 24, 1], [bar, bar]),
// 	// \mixratio, 1,
// 	// \pan, Env(#[-1, 1, -1], #[2.5, 2.5], \sin),
// 	\amp, 0.25,
// 	\pan, 0.2,
// ).play;





d_kick = Pbind(
	\instrument, \kick,
	\midinote, Pseq([36], 4),
	\dur, bar/4,
	\amp, 0.6
);
d_hh = Pbind(
	\instrument, \hihat,
	\midinote, Pseq([Rest(), 0, Rest(), 0, Rest(), 0, Rest(), 0], 1),
	\rel, Pseq([0, 0.3, 0, 0.1, 0, 0.3, 0, 0.1]),
	\dur, bar/8,
	\amp, 0.05
);
d_sn = Pbind(
	\instrument, \snare,
	\midinote, Pseq([Rest(), 0, Rest(), 0], 1),
	\dur, bar/4,
	\amp, 0.1
);

kit = Ppar([d_kick, d_hh, d_sn]);
kit_4 = Pseq([kit], 4);

b = Pbind(
	\instrument, \bass,
	\midinote, Pseq([44, 44, 44, 44, 44, 44, 44, 46]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
c = Pbind(
	\instrument, \bass,
	\midinote, Pseq([48, 48, 48, 48, 48, 48, 48, 51]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
d = Pbind(
	\instrument, \bass,
	\midinote, Pseq([53, 53, 53, 53, 53, 53, 53, 48]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
e = Pbind(
	\instrument, \bass,
	\midinote, Pseq([53, 53, 53, 53, 53, 53, 53, 55]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);


f = Pbind(
	\instrument, \bass,
	\midinote, Pseq([44, 44, 44, 44, 44, 44, 44, 44]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
g = Pbind(
	\instrument, \bass,
	\midinote, Pseq([43, 43, 43, 43, 43, 43, 43, 46]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
h = Pbind(
	\instrument, \bass,
	\midinote, Pseq([41, 41, 41, 41, 41, 41, 41, 39]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);
i = Pbind(
	\instrument, \bass,
	\midinote, Pseq([41, 41, 41, 41, 41, 41, 41, 43]-12, 1),
	\dur, Pseq([b8, b8+b8, b16, b8, b16, b8, b8, b8], 1),
	\amp, 0.5
);

bassline = Pseq([b, c, d, e, f, g, h, i]);


phased = Pbind(
	\instrument, \majestic,
	\midinote, Pseq([Rest(), 58, 60, Rest(), 58, 60, Rest(), 58, 60, Rest()], 2),
	\dur, Pseq([b8, b16, b16, b8, b16, b16, b8, b16, b16, b4], 2),
	\eqcenterfreqfactor, Env.new([1, 24, 1], [bar, bar]),
	// \mixratio, 1,
	// \pan, Env(#[-1, 1, -1], #[2.5, 2.5], \sin),
	\amp, 0.25,
	\pan, 0.2,
);

// Pseq([Ptpar([0, a, 0, b, 0, x, bar, a, bar, c]), Ptpar([0, a, 0, d, 0, x, bar, a, bar, e])], 2).play;
// )

/*var chord1 = Environment.make({
	~k1 = 56
	~k2 = 63
});

var chord2 = Environment.make({
	~k1 = 48
	~k2 = 67
});

var chord3 = Environment.make({
	~k1 = 53
	~k2 = 72
});*/


key1s = Pbind(
	\instrument, \keys,
	\midinote, Pseq([44, 43, 41]+12, 1),
	\dur, Pseq([bar, bar, 2*bar], 2),
	\amp, 0.3,
	\panningfreq, 2.5
);

key2s = Pbind(
	\instrument, \keys,
	\midinote, Pseq([46, 46, 44]+12, 1),
	\dur, Pseq([bar, bar, 2*bar], 2),
	\amp, 0.3,
	\panningfreq, 2.5
);

key3s = Pbind(
	\instrument, \keys,
	\midinote, Pseq([48, 48, 48]+12, 1),
	\dur, Pseq([bar, bar, 2*bar], 2),
	\amp, 0.3,
	\panningfreq, 2.5
);

key4s = Pbind(
	\instrument, \keys,
	\midinote, Pseq([51, 51, 51]+12, 1),
	\dur, Pseq([bar, bar, 2*bar], 2),
	\amp, 0.3,
	\panningfreq, 2.5
);


keys_chords = Ppar([key1s, key2s, key3s, key4s]);


sparkles = Pbind(
	\instrument, \sawish,
	\midinote, Pseq([44, 53, 44, 53, 44, 53, 44, 53]-5, 2*4),
	\dur, bar/16,
	\amp, Env.new([0, 0, 0.4], [bar/4, 3*bar/4])
);

keys_melody = Pbind(
	\instrument, \keys2,
	\midinote, Pseq([46, 48, Rest(), 46, 48, 51, 58, 60]+12, 4),
	\dur, bar/8,
	\amp, 0.15,
	\pan, -0.3,
);

saw_breakdown = Pbind(
	\instrument, \saw2,
	\midinote, Pseq([
		48, 60, 84, 72, 48, 60, 84, 72,
		48, 60, 84, 75, 48, 60, 72, 84,
		48, 60, 84, 72, 48, 60, 84, 72,
		48, 60, 84, 75, 48, 60, 82, 79,
	]-12, 2),
	\dur, bar/16,
	\amp, 0.5
);

// Synth(\sample, [\bufnum, uwu]);

p_uwu = Pbind(
	\instrument, \sample,
	\bufnum, uwu,
	\dur, Pseq([bar], 4),
	\amp, 0.3
);

whoosh = Pbind(
	\instrument, \vwvwvw,
	\amp, 0.15,
	\dur, 4*bar,
	\midinote, Pseq([0], 1)
);

riser = Pbind(
	\instrument, \fwwww,
	\amp, 0.15,
	\dur, bar,
	\midinote, Pseq([0], 1)
);

french_lesson = Pbind(
	\instrument, \sample1ch,
	\bufnum, french,
	\dur, Pseq([28*bar], 1),
	\amp, 0.5
);

p_so = Pbind(
	\instrument, \sample1ch,
	\bufnum, so,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);
p_tu_es_jolie = Pbind(
	\instrument, \sample1ch,
	\bufnum, tu_es_jolie,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);
p_tu_es_gentil = Pbind(
	\instrument, \sample1ch,
	\bufnum, tu_es_gentil,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);
p_je_taime = Pbind(
	\instrument, \sample1ch,
	\bufnum, je_taime,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);
p_je_taime_bien = Pbind(
	\instrument, \sample1ch,
	\bufnum, je_taime_bien,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);
p_tu_es_formidable = Pbind(
	\instrument, \sample1ch,
	\bufnum, tu_es_formidable,
	\dur, Pseq([bar/2], 1),
	\amp, 0.5
);

p_love_words = Ptpar([
	2.5*b4, p_tu_es_jolie,
	5.5*b4, p_tu_es_gentil,
	8*b4, p_je_taime,
	10.5*b4, p_je_taime_bien,
	13.5*b4, p_tu_es_formidable,
]);

Ptpar([
	//music
	bar/2,
	Pseq([
		Pseq([keys_chords], 3), //12 bars
		Ptpar([0, bassline, 0, keys_chords, 4*bar, keys_chords], 1), //8 bars
		Ptpar([0, bassline, 0, keys_chords, 3*bar, riser, 4*bar, keys_chords,  4*bar, whoosh], 1), //8 bars
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased,
			6*bar, phased
		], 1), //8 bars
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles,
			6*bar, phased
		], 1), //8 bars
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, keys_melody,
			6*bar, phased
		], 2), //16 bars

		//uwu
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody, 0, p_uwu,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles, 4*bar, keys_melody, 4*bar, p_uwu,
			6*bar, phased
		], 1), //8 bars

		//voice returns
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody, 0, p_uwu, 0, p_love_words,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles, 4*bar, keys_melody, 4*bar, p_uwu,
			4*bar, p_love_words,
			6*bar, phased
		], 1), //8 bars

		Ptpar([
			0, keys_melody, 0, saw_breakdown, 0, keys_chords
		], 1), //8 bars breakdown

		Ptpar([
			0, Pn(keys_chords, 2), //8 bars of just keys
			7*bar, Pbind(
				\instrument, \vwvwvw,
				\amp, 0.15,
				\dur, bar,
				\midinote, Pseq([0], 1)
			);
		]),

		//chorus again (with words)
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased,
			6*bar, phased
		], 1), //8 bars
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles,
			6*bar, phased
		], 1), //8 bars

		//melody (no vocals)
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, keys_melody,
			6*bar, phased
		], 1), //8 bars

		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody, 0, p_uwu,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles, 4*bar, keys_melody, 4*bar, p_uwu,
			6*bar, phased
		], 1), //8 bars

		//voice returns
		Ptpar([
			0, bassline, 0, keys_chords, 0, kit_4, 0, phased, 0, keys_melody, 0, p_uwu, 0, p_love_words,
			2*bar, phased,
			4*bar, keys_chords, 4*bar, kit_4, 4*bar, phased, 4*bar, sparkles, 4*bar, keys_melody, 4*bar, p_uwu,
			4*bar, p_love_words,
			6*bar, phased
		], 2), //16 bars


		Ppar([keys_chords, p_love_words], 2)
	]),

	0,
	// voice 1
	Pseq([
		french_lesson
	], 1),

	(12+8+8 + 8+8+16 + 8+8+8+8) * bar,
	// 8.5*bar,
	Pbind(
		\instrument, \sample1ch,
		\bufnum, french,
		\dur, Pseq([16.25*bar], 1),
		\amp, 0.5
	);


]).play;

)