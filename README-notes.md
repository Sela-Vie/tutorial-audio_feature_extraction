## MISC
#### QUANTIZATION VS SAMPLING
- sampling is 
    - sampling is detail over time
    - detail in the x axis
- quantization is resolution/bit depth
    - quantization is detail over pitch
    - detail in the y axis


#### STEPS BREAKDOWN

```
      Speech signal
            |
            v
 Pre-emphasis (optional)
            |
            v
         Framing
            |
            v
        Windowing
            |
            +--------------------------------------------------------------+
            |                                                              |
            v                                                              |
           FFT                                                             |
            |                                                              |
            +--------------------+--------------------+                    |
            |                    |                    |                    |
            v                    v                    v                    v
   [ Magnitude |X|  ]   [ Power spectrum ]   [ Power spectrum ]   [ Autocorrelation]
            |                    |                    |                    |
            v                    v                    v                    v
   [ Log (optional) ]   [ Mel filterbank ]   [ Bark filterbank]   [ Levinson-Durbin]
            |                    |                    |                    |
            |                    v                    v                    v
            |           [ Log            ]   [ Equal-loudness ]   [ LPC-to-cepstrum]
            |                    |                    |                    |
            |                    v                    v                    |
            |           [ DCT            ]   [ Cube-root      ]            |
            |                    |                    |                    |
            |                    v                    v                    |
            |           [ Keep 12-13 coef]   [ Inverse DFT    ]            |
            |                    |                    |                    |
            |                    |                    v                    |
            |                    |           [ Levinson-Durbin]            |
            |                    |                    |                    |
            |                    |                    v                    |
            |                    |           [ Cepstrum (opt.)]            |
            |                    |                    |                    |
            v                    v                    v                    v
    MAGNITUDE SPECTRA          MFCC                 PLP                  LPCC
```
idk if were going to go autocorrelation for the PLP and LPCC

#### CEPSTRUM
- source: https://www.youtube.com/watch?v=SJo7vPgRlBQ&t=223s
$$
C_p = \left| \mathcal{F}\left\{ \log\left( \left| \mathcal{F}\{f(t)\} \right|^2 \right) \right\} \right|^2
$$
1. f(t) being the signal
2. |F{f(t)}| fourier transform of the signal
3. |F{f(t)}| ^ 2 gives us the power spectrum (idk how)
4. log(|F{f(t)}| ^ 2) getting the natural log compresses the distribution
5. you can either fourier transform this or do an inverse fourier transform, the output has the same distribution so it doesnt matter in in machine learning

- note: the fourier transform using braces instead of parenthesis is notational and is still understandable with the usage of F(f(t))
- note: `cepstrum` is an anagram of `spectrum`
- note: MFCC is just a cepstrum converted to the mel scale

#### FFT OUTPUTS (spectrum, magnitude power)

why theres only 200 samples in magnitude and power spectrum

context:
- 400 samples
- 16_000 hz sampling rate

16_000 can reasonably measure at maximum 8_000 hz including negative frequencies (cuz that how measuring works)
16_000 can reasonably measure at minimum 40 hz including negative frequencies (cuz 400 samples at 16_000 40hz is the biggest wave we can see)
-8_000 to -40 AND +40 to +8_000
negative and postitive frequencies are the see as the same in this context so we only care about
+40hz to +8_000hz with accuracy of 40hz
0-40hz, 41-80hz, 81-120hz,... 

spectrum is a complex number because it also holds the timings of the frequencies
complex number us just 2 numbers stored as one
the first number is the magnitude
the second number is when it starts (does the wave begin at its peak, at zero, somewhere in between?)

#### FFT vs. Short-Time FT

## FRAMING 

if the last frame doesnt make a full frame
padding the frame is better than dropping the frame

you can also reflect the frame
Libraries like librosa do this by default with center=True, which pads both ends by half a frame (reflect padding).

## DATASET SPLITTING BEFORE FRAMING

Do not randomly split the frames after framing. Adjacent frames from one recording are very similar. If they appear in both the training and test sets, this causes data leakage and unrealistically high accuracy.

If `Artists/` contains the original audio and `Samples/` contains shorter clips, split the data at the highest independent level:

- For pathological speech, split by speaker or patient when possible.
- If speaker identity is unavailable, split by the original recording.
- Do not split only by frame.

### SOURCES

Stark et al. compare random utterance partitions with speaker-separated cross-validation for pathological speech. They explain that utterances from one speaker are dependent samples. A classifier can otherwise learn speaker traits instead of the pathological condition.

- Stark, A. P., Bayestehtashk, A., Asgari, M., & Shafran, I. (2012). *Interspeech Pathology Challenge: Investigations into Speaker and Sentence Specific Effects*. Interspeech 2012, 538-541. https://doi.org/10.21437/Interspeech.2012-104

Section 4.2.2 Train/test data separation
A 2026 scoping review examined 80 studies about multi-class voice-disorder classification. It reports that overlapping speakers can inflate performance metrics. The review recommends clear training and test separation without speaker overlap.

WE NEED TO ADD THIS TO THE STUDY
IT GIVES MUCH CREDENCE TO WHAT WERE DOING
4.2.1 Evaluation metrics
Most research uses different evaluation metrics, making comparison between studies arduous. For multi-class classification, we recommend the use of balanced accuracy (equivalent to average recall), as it reflects performance across all classes while accounting for class imbalance.

- Gupta, R., Jin, C. T., Gunjawate, D. R., Nguyen, D. D., Stasak, B., Chacon, A. M., & Madill, C. (2026). *Voice disorders classification using machine learning: A scoping review*. Frontiers in Digital Health, 8, 1800132. https://doi.org/10.3389/fdgth.2026.1800132

Apicella et al. discuss temporal leakage from overlapping frames. On printed page 5, they explain that consecutive frames are not independent and can contain identical signal parts. Figure 5 on printed page 15 defines overlap leakage. Printed page 50 recommends that training and test sets do not share information through overlapping data instances.

- Apicella, A., Isgrò, F., & Prevete, R. (2025). *Don’t push the button! Exploring data leakage risks in machine learning and transfer learning*. Artificial Intelligence Review, 58, 339. https://doi.org/10.1007/s10462-025-11326-3
