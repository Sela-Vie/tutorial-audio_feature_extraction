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