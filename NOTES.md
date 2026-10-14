## MISC
#### QUANTIZATION VS SAMPLING
- sampling is 
    - sampling is detail over time
    - detail in the x axis
- quantization is resolution/bit depth
    - quantization is detail over pitch
    - detail in the y axis
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


#### FFT vs. Short-Time FT