#### PIPELINE

how to extract, from any Speech signal
- Magnitude Spectra
- Mel-Frequency Cepstral Coefficients
- Perceptual Linear Prediction Coefficients
- Linear Predictive Coding Coeffieicnts

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

#### ***FRAMING/SEGMENTATION***
- framing the audio samples
- 16khz over 0.025 seconds is 400 samples
    - 16_000 samples per second
    - 0.025 is 1/40th of a second
    - 16_000/40 = 400 samples
- standard values
    - 20-40ms sized windows
    - 25ms sized window for the standard
    - 10ms steps


if the last frame doesnt make a full frame
padding the frame is better than dropping the frame

you can also reflect the frame
Libraries like librosa do this by default with center=True, which pads both ends by half a frame (reflect padding).

#### ***WINDOWING***
- reference: https://web.archive.org/web/20260628190812/https://speechprocessingbook.aalto.fi/Representations/Short-time_analysis.html
- multiplies each frame by a window function to reduce spectral leakage
- Common window functions include:
    - Hann window (smooth cosine taper and puts emphasis on the middle of the frame)
    - Hamming window (smooth cosine taper but wider than the hann window)
    - Rectangular window (equivalent having no window)
- we will be using the hamming window


#### FFT (outputs: bin, spectrum, magnitude power, power)

why theres only 200 samples in magnitude and power spectrum

context:
- 400 samples
- 16_000 hz sampling rate

##### FFT: bins and theoretically representable frequencies

- highest theoretically representable frequency is defined by the ***Nyquist theorem***

16_000 can reasonably measure at maximum 8_000 hz including negative frequencies (cuz that how measuring works)
16_000 can reasonably measure at minimum 40 hz including negative frequencies (cuz 400 samples at 16_000 40hz is the biggest wave we can see)
-8_000 to -40 AND +40 to +8_000
negative and postitive frequencies are the see as the same in this context so we only care about
+40hz to +8_000hz with accuracy of 40hz
 
this explains why we have a bin of 20
8_0000hz to 40hz with minimum accuracy of 40hz
gives us bin 0-40hz, 41-80hz, 81-120hz,...
8_0000/40 = 20

***spectrum*** is a complex number because it also holds the timings of the frequencies
complex number us just 2 numbers stored as one
the first number is the ***magnitude***
the second number is when it starts (does the wave begin at its peak, at zero, somewhere in between?)
***power*** is derived from *magnitude*^2/number_of_samples_in_frame
- supposedly its an sum of the magnitudes of a frequency over many mins and then divided by the number of bins but my code doesnt do that so idk what it actually is

#### MFCC

|***CONFIG***|***DEFINITION***|
|-|-|
|`ROLLOFF_PERCENT`| breakpoint for the rolloff column feature |
|`N_FFT`| specified to transfer specifications from last processing; to determine the n-bins of the fft |
|`N_MELS`| is 26 because its a common speech-processing convention, not a required standard<br>(GONNA NEED A SOURCE TO USE THIS) |
|`N_MFCC`| is 13 because its a common speech-processing convention, not a required standard; this also has not relation to N_MELS as long as N_MFCC is <= N_MELS (idk y but ok)<br>(GONNA NEED A SOURCE TO USE THIS) |
|`F_MIN`| is specified to remove noise|
|`F_MAX`| is specified to remove noise; defined by ***Nyquist theorem*** |
|***FEATURE***||
| `zcr_mean` | Average Zero Crossing Rate. Measures how frequently the audio signal changes sign. |
| `centroid_mean` | Average Spectral Centroid. Represents the brightness of the sound. |
| `rolloff_mean` | Average Spectral Rolloff. Represents the frequency below which a specified percentage (usually 85%) of spectral energy is contained. |
| `rms_mean` | Average Root Mean Square energy. Measures the overall signal energy or loudness level. |
