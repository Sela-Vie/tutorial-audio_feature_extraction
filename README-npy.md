# Preprocessing `.npy` files

This file describes the NumPy arrays produced by the audio preprocessing notebooks.

## Pipeline order

```text
audio files
    -> preprocessing-01-framing.npy
    -> preprocessing-02-windowing.npy
    -> preprocessing-03-fft.npy
```

## `preprocessing-01-framing.npy`

Produced by: `preprocessing-01-framing.ipynb`

Contains the audio after it is resampled to 16 kHz, converted to mono, and divided into overlapping frames. Each frame has 400 samples, which is 25 ms at 16 kHz. Consecutive frames start 160 samples, or 10 ms, apart.

Each row has three columns:

| Column | Label | Description |
|---:|---|---|
| 0 | `source_file` | Absolute path of the source audio file. |
| 1 | `frame_number` | One-based frame number within that source file. |
| 2 | `samples` | The 400 time-domain audio samples for the frame, stored as `float32`. |

The outer array has shape `(number_of_frames, 3)` and uses `dtype=object` because a row contains both metadata and a numeric array.

## `preprocessing-02-windowing.npy`

Produced by: `preprocessing-02-windowing.ipynb`

Input: `preprocessing-01-framing.npy`

Contains the same frames after a Hamming window is applied. Windowing reduces spectral leakage before the FFT. The source paths and frame numbers remain unchanged.

Each row has three columns:

| Column | Label | Description |
|---:|---|---|
| 0 | `source_file` | Absolute path of the source audio file. |
| 1 | `frame_number` | One-based frame number within that source file. |
| 2 | `samples` | The 400 Hamming-windowed time-domain samples, stored as `float32`. |

The outer array has shape `(number_of_frames, 3)` and uses `dtype=object`.

## `preprocessing-03-fft.npy`

Produced by: `preprocessing-03-fft.ipynb`

Input: `preprocessing-02-windowing.npy`

Contains the real FFT and derived frequency-domain values for every windowed frame. A 400-sample real FFT produces 201 nonnegative-frequency bins.

Each row has five columns:

| Column | Label | Description |
|---:|---|---|
| 0 | `source_file` | Absolute path of the source audio file. |
| 1 | `frame_number` | One-based frame number within that source file. |
| 2 | `complex_spectrum` | The 201 complex FFT bins, stored as `complex64`. |
| 3 | `magnitude` | Absolute value of each FFT bin, stored as `float32`. |
| 4 | `power` | Power per bin, calculated as `magnitude ** 2 / 400` and stored as `float32`. |

The outer array has shape `(number_of_frames, 5)` and uses `dtype=object`.
