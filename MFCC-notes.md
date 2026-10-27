## ***STEPS***
source: https://www.youtube.com/watch?v=SJo7vPgRlBQ&t=223s
#### **FRAMING/SEGMENTATION**
- framing the audio samples
- 16khz over 0.025 seconds is 400 samples
- a sample can be a range, usually a power of 2 for machine efficiency, ex:
    - frame 1 being sample 1 to 128 
    - frame 2 being sample 64 to 192
    - frame 3 being a sample 128 to 256
    - frame 4 being a sample 192 to 320
    - ...
- standard values
    - 20-40ms sized windows
    - 25ms sized window for the standard
    - 10ms steps
#### **WINDOWING**
- reference: https://web.archive.org/web/20260628190812/https://speechprocessingbook.aalto.fi/Representations/Short-time_analysis.html
- multiplies each frame by a window function to reduce spectral leakage
- Common window functions include:
    - Hann window (smooth cosine taper and puts emphasis on the middle of the frame)
    - Hamming window (smooth cosine taper but wider than the hann window)
    - Rectangular window (equivalent having no window)

#### **FOURIER TRANSFORM/ GETTING THE SPECTROGRAM**
- usually the fast fourier transform for the windowed audio
- we know what this is, check your usc notes
- u dont need to know the process, just the input and the output
    - input     : signal
    - output    : a signal what tells us what frequency the input signal is made of
#### **TRANSFORM TO THE MEL-FREQUENCY SPECTROGRAM**
- usually easier to interpret compared to the raw spectrogram

#### **EXTRACTING THE CEPSTRAL COEFFICIENT**
- Use the Fourier Transform (usually the Discrete Cosine Transform) to get the cepstral coefficients 