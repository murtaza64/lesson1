# L’Equipe du Son - Lesson 1 (cover by Murtaza) - final blog post

# The final product

[lesson1.flac](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/lesson1.flac)

There was probably no need to export this as flac but oh well.

[This is a link to the SuperCollider source code as well as all the samples I used.](https://github.com/murtaza64/lesson1) Attributions, where appropriate, are included within the source file.

# Thanks

This project and the experience of creating it was significantly enhanced by the support of my high-school friends Humza, G and Ethan. Ethan gave me a great tip over dinner for how to achieve a certain effect; G recorded some beautiful French educational material for use in the song; Humza sat with me to help transcribe notes and gave me high level explanations of numerous effects and synthesis techniques he's picked up over the years as an EDM producer.

# Background for audio noobs

I wanted to make this post relatively accessible so that everybody who I've been nerding out about this project to can at least understand what I'm writing about here. As such, here's some background about audio and sound synthesis that I've picked up in this class and needed to make this cover. If you don't need it, skip to **My cover**.

Sound consists of waves in air. Air pressure oscillates between high and low at some *frequency*, and this frequency is perceived by our ears as pitch. Combining waves of various frequencies at various points in time (sometimes) produces music. Volume of a sound is essentially based on the *amplitude,* i.e. the maximum deviation from rest of air pressure.

Sound from physical instruments can be incredibly complex. Here's what a 'boring old' piano looks like:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled.png)

What you're seeing is the frequency spectrum of a piano note. The green bars show the frequencies that are present in the signal. As you can see, there are at least 6 frequencies even though I have played a single C3 note. C3 is said to have a *fundamental* frequency of 264Hz, though actually playing it produces *partial* frequencies above that fundamental. The particular frequencies that appear in a sound are an important factor in how it, well, sounds. Part of the difficulty of sound synthesis is figuring out what kind of frequency spectrum to aim for when trying to get a particular sound.

## Adding sine waves to make sound

The basic unit we use to synthesize sound is the sine wave (yes, the mathematical one). The equation we'll use to define a general sine wave is this:

$$x(t) = A\sin(2\pi \cdot f\cdot t + \phi)$$

$A$ is the amplitude, $f$ is the frequency, and $t$ is time. The output $x(t)$ is the displacement from rest, in the range of $(-A, A)$. In the context of sound, this can be thought of as the amount of air pressure difference from rest. $\phi$ refers to phase, which can be thought of as shifting the wave forwards and backwards in time by a certain amount.

If you don't know, this is what a basic sine wave looks like, with $A=f=1$:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%201.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%201.png)

I've created these diagrams with Desmos. [You can play with them interactively here if you're interested](https://www.desmos.com/calculator/tg8hkwrqbo) and slide around the parameters at will.

We can create another sine wave with a different frequency and amplitude, to get something like the blue wave below. If we add the two sine waves together, a more complex waveform emerges, and has both frequencies within it:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%202.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%202.png)

Here's a snippet of the waveform of my cover, by the way, just so you can see how complex these things get:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%203.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%203.png)

We can get rich sounds, maybe replicating the sound of a physical instrument if we wish, by manually generating several sine waves at different frequencies and amplitudes and adding them together. This is called *additive synthesis*. This is a technique I've used a decent amount throughout this project. If we added 6 sine waves with appropriate frequencies and amplitudes together, we might approximate the sound of a piano.

## Frequency modulation synthesis

While additive synthesis is simple enough to understand, and works, it can be quite cumbersome. One of the other synthesis techniques we use is *modulation synthesis*. Modulation synthesis uses a few sine waves to create rich sounds with partials by using the output of one sine wave to change the *frequency* of another. The latter sine wave is used as the audio output. This can create complex waveforms with many, many partial frequencies using only two sine oscillators. The equation for this would look something like:

$$x(t)=A\sin(f_1t + I\sin(f_2t + \phi_2) + \phi_1)$$

You are not of course limited to two sines—you can chain this process both recursively and in parallel, and in some combination of the two.

There are some great explanations online about frequency modulation, both from a synthesis perspective and a mathematical one, so I won't get too technical here. But most of the instruments in my cover are made using frequency modulation synthesis, particularly the FM7 plugin for SuperCollider (based on the Yamaha DX7). This provides 6 sine oscillators that can be arranged into various layouts for frequency modulation (FM) synthesis.  

## Amplitude envelopes

I said earlier that the particular partials present in a sound are one factor in its perceptual effect. Another important one is how the volume of the sound evolves over time. Take a look at this spectrograph of the same piano note from earlier:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%204.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%204.png)

This shows the same frequency data as earlier, but with the added dimension of time (amplitude is shown by color now). Notice how the volume is generally high at the beginning, but tends to decay over time, moreso in higher frequencies. How a sound evolves over time is almost as important as the frequencies present themselves. We can control parameters of our synthesized instruments (synths) over time using *envelopes*, which are nothing more than shapes:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%205.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%205.png)

This is the archetypal Attack Decay Sustain Release (ADSR) envelope layout, with straight lines connecting five different values. The time windows between each value and the values themselves can be changed to obtain a desired shape. The chief use for envelopes in my cover is to control the amplitude of a synth over time. Every single note played goes through the four spans of the envelope, but each synth will have a distinct envelope depending on the sound quality it needs to have. For example, a bass guitar would have a fast and loud attack, while a violin might have a slower attack and a longer sustain. 

# My cover

Alright, let's jump into it. How did I make the track?

I used FM7 for most of the heavy lifting. I stuck with algorithm 8 (`algoNum = 7` in SuperCollider) for everything because I found that it had a good mix of parallel and serial modulation:

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%206.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%206.png)

I used a few additive synthesis techniques as well to achieve some sounds that I will discuss below.

## Instruments

These are the names of the 11 synths straight from the code, with a brief description where needed. They are approximately in the chronological order that they appear in. I'll then provide a slightly longer exploration including a one-second spectrogram of each one.

`\keys` — basic synth keys that play three chords throughout the track

`\bass`

`\hihat` 

`\snare`

`\kick`

`\fwwww` — rising white noise 'whoosh' effect

`\vwvwvw` — descending oscillating white noise effect (the name should probably be 'fwfwfw')

`\majestic` — two note ascending pattern in chorus with heavy phaser-ish effect

`\sawish` — used for low 'sparkles' just before the second keys come in

`\keys2` — melody synth keys during chorus

`\saw2` — stereo detuned lead synth for the breakdown

### keys

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%207.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%207.png)

This one has a fast attack, a relatively quiet sustain and a fast exponential release. There's some slight noise added to the fundamental frequency to achieve some organic feel. In the track, it plays 4-tone chords the whole time and is panned left and right at `panningfreq=2.5`:

```c
pan = SinOsc.kr(panningfreq, mul:0.4);
```

The chords would have been impossible to transcribe without the musical genius of Humza.

### bass

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%208.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%208.png)

This one has a fixed duration, which I wish it didn't since not all the bass hits in the original track sound the same. I used the second carrier frequency to duplicate the fundamental frequency to give it a punchier low note. I think it could use some more high frequency energy, some effects to replicate the electronic sound of the original, and maybe a slightly longer sustain or slower decay. 

### drums

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%209.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%209.png)

k-h-(ks)-h

The snare and hi-hat are inspired by Bruno Rivaro's examples [here](https://sccode.org/1-54H). They use white noise with a high pass filter and a particular percussive envelope to achieve their feel. The snare has a lower cutoff frequency than the hihat, and is combined with a very quiet low sine tone to simulate the sound of the drum hit itself. 

The kick was synthesized in FM7 using a lot of partials by setting the frequencies of the modulators extremely low and setting the indices of modulation high. There is significant noise added to the kick's fundamental to make it fuller and less synthetic. Well, there would be, if I didn't just catch a bug in the code. The kick is tuned to Ab to match the song's key.

 

### fwww and vwvwvw

Just before `\majestic` comes in, there's a cool noisy ascending whoosh followed by what is hard to describe with words alone. The names of the synths were my best approximation at transcribing the sound.

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2010.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2010.png)

First we have this ascending thing, which was easy to get by just sliding a low pass filter upwards (exponentially) over (slightly high pass filtered) white noise:

```c
var snd = WhiteNoise.ar();
var line = XLine.kr(200, 15000, dur);
// var lfo = SinOsc.kr(line, mul: 0.5, add: 1.0);
snd = RLPF.ar(snd, line, 0.4);
snd = HPF.ar(snd, 400);
```

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2011.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2011.png)

This thing is almost just the opposite of the previous thing, but in addition to moving linearly down, the filter cutoff deviates sinusoidally from the line. We use an LFO to achieve this deviation. The frequency of this deviation also decreases as time goes on, so we use a `Line` to modulate the frequency and also map the line to the frequency range using `linexp`:

```c
var snd = WhiteNoise.ar();
var line = Line.kr(12, 0.1, dur);
var lfo = SinOsc.kr(line, mul: 0.5, add: 1.0);
snd = RLPF.ar(snd, line.linexp(0.1, 12, 200, 15000) * lfo, 0.4);
snd = HPF.ar(snd, 400);
```

### majestic

There's a synth in most of Lesson 1 playing 3 pairs of ascending notes per bar. Most of the quality of this sound come from the intense phaser effect applied to it. I couldn't really get the synth itself to sound like the original, but I did get an effect that sounds quite a bit like a phaser.

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2012.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2012.png)

It might be hard to see from the diagram, but in the first three pairs, the low frequency energy decreases over time, and in the second three, the low frequency energy increases. This sounds a bit like a speaker submerging and surfacing. I achieved this using a sliding `BPeakEQ` filter (thanks for the tip Ethan!). The center of the EQ is given as a control to the synth, and is modulated by an envelope in the pattern.

```c
//SynthDef
//...
effect = BPeakEQ.ar(
			snd,
			eqcenterfreqfactor * freq, //ffreq
			2.0, //rq
			12, //boost
			1 //mul
		);
//...

//pattern
phased = Pbind(
	\instrument, \majestic,
	\midinote, Pseq([Rest(), 58, 60, Rest(), 58, 60, Rest(), 58, 60, Rest()], 2),
	\dur, Pseq([b8, b16, b16, b8, b16, b16, b8, b16, b16, b4], 2), //bn are constants
																				 //obtained by dividing the bar length by n
	\eqcenterfreqfactor, Env.new([1, 24, 1], [bar, bar]), //bar is the length of each bar
	// \mixratio, 1,
	// \pan, Env(#[-1, 1, -1], #[2.5, 2.5], \sin),
	\amp, 0.25,
	\pan, 0.2,
).play;
```

This one took a lot of experimentation to get to sound any good. 

### sawish

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2013.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2013.png)

This is essentially a sawtooth wave, but is generated with FM7 by cranking up the modulator frequencies. It has a fixed short duration with a very fast attack and release. It's used for the quiet 'sparkles' in the buildup to the chorus just before the melody keys come in.

### keys2

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2014.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2014.png)

This one is not much different from the other key synth at its core, but it has a lot more high partials in it as well as a substantial delay effect. The high frequency energy gives it a richer sound required for it to stand out amongst the other instruments. There is a `SwitchDelay` of the original output signal added to the output to achieve the delay effect. Or at least there would be if I had caught this bug:

```c
snd = SwitchDelay.ar(snd, 1, 0.8, bar/16, 0.7, 5);
Out.ar(out, Pan2.ar(snd, pan)); //where's the original sound gone???
```

It didn't end up having any noticeable effect on the sound, but the attack has become a bit weaker as a result.

### saw2

***IF YOU'RE SKIMMING BY, THIS ONE IS COOL!***

This is a really cool synth in my opinion, used in the synth breakdown in the middle of the track.

![L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2015.png](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/Untitled%2015.png)

The spectrogram doesn't do it justice, so I've recorded the isolated part:

[saw2.flac](L%E2%80%99Equipe%20du%20Son%20-%20Lesson%201%20(cover%20by%20Murtaza)%20-%20fi%20ad06baad70ac4d2ab39aa751a0bfdf3b/saw2.flac)

Humza helped me figure out how to do this, using an additive synthesis technique called stereo detuning. We just take 4 perfect sawtooth waves and pan them equally from left to right. We detune each one by a few cents (3 to be precise). The result is honestly quite stunning for how simple it is.

```c
//stereo detuning! (thanks humz)
var ampenv = Env.new([0, 1, 1, 1, 0.01, 0], [0.01, 0.01, dur+0.05, 0.15, 0.01], curve:['lin', 'exp', 'lin', 'exp', 'lin']);
ampenv = EnvGen.kr(ampenv, doneAction:2);
panned = [SinOsc.ar(0), SinOsc.ar(0)]; //array of two empty Ugens
4.do({
	arg i;
	snd = Saw.ar((freq.cpsmidi - (0.06 * i)).midicps, 0.125);
	panned = panned + Pan2.ar(snd, (2/3) * i - 1, ampenv * amp);
});
panned = RLPF.ar(panned, 15000, 0.3);
Out.ar(out, panned);
```

## Samples

In addition to the instruments, I used a few samples that were needed for the song. The oohs in the chorus are from two free samples from [samplefocus.com](http://samplefocus.com) which I spliced together in Audacity and detuned to the right pitch. The result is janky, and I probably could have done better by recruiting a singer or working a bit longer on touching up the sample. Regardless, `uwu.wav` appears ubiquitously throughout the song.

For the introductory French lesson, my friend G offered to help me out and record the monologue in her beautiful anglicized French accent. We used an apple headphone mic because no one had access to better equipment. I sliced up the speech segments and arranged them into patterns to be played at certain points in the track. I would have done some filtering to get rid of random windy noises that are clearly audible at the beginning of the track if I had more time.

There is a bug that I only caught after exporting that makes her second French lesson come in four bars too late. This was an arithmetic error typical of me, but thankfully it doesn't sound entirely awful. 

# Conclusion

I am quite happy with the way this project turned out. I learned a lot about digital synthesis, including several new techniques and crucially more finesse working with FM7, Patterns and sclang. I am excited to work on my next track.