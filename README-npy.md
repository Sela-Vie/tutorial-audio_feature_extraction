# Preprocessing NumPy files

This file describes the NumPy outputs used by the audio preprocessing notebooks.

## Framed audio: `preprocessing-01-framing.npz`

Produced by: `preprocessing-01-framing.ipynb`

The notebook loads supported audio files from `Artists`, converts each file to mono at 16 kHz, then divides it into overlapping frames. Each frame has 400 samples (25 ms), and consecutive frames start 160 samples (10 ms) apart.

The `.npz` archive contains four aligned arrays. Row `i` in each array refers to the same audio frame:

| Member | Shape | Dtype | Description |
|---|---|---|---|
| `FRAME` | `(number_of_frames, 400)` | `float32` | Audio samples for each frame. |
| `FRAME_Y` | `(number_of_frames,)` | `bool` | `True` for a recording in the `Rapper` folder; `False` otherwise. |
| `frame_number` | `(number_of_frames,)` | `int32` | One-based frame number within its source recording. |
| `frame_path_encoding` | `(number_of_frames,)` | `uint8` | Encoded source path for each frame. |

The fitted scikit-learn `LabelEncoder` is saved separately as `preprocessing-01-path-encoder.joblib`. Use its `inverse_transform` method to map path codes to the relative source paths used by the encoder. The codes refer to paths relative to `Artists`.

Load the archive with `np.load(path, allow_pickle=False)`. The member names and dtypes are numeric, so the archive does not need pickle.

## Downstream preprocessing notebooks

`preprocessing-02-windowing.ipynb` and `preprocessing-03-fft.ipynb` currently describe or load the earlier `preprocessing-01-framing.npy` object-array format. They are not yet compatible with the `.npz` schema above. Update those notebooks to load the four aligned arrays and carry the label, frame number, and path encoding alongside the transformed frame data before using them as the next stages of this pipeline.

The legacy `.npy` layouts described below apply only to outputs produced by older versions of the notebooks.

## Legacy windowing output: `preprocessing-02-windowing.npy`

Older versions stored each row as `source_file`, `frame_number`, and 400 Hamming-windowed samples in a `dtype=object` array. Object arrays require pickle when loaded.

## Legacy FFT output: `preprocessing-03-fft.npy`

Older versions stored each row as `source_file`, `frame_number`, 201 complex FFT bins (`complex64`), magnitude values (`float32`), and power values (`float32`). The outer array used `dtype=object` and required pickle when loaded.
