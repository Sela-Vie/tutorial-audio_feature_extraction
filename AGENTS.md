# Repository Instructions

## Python environment

- Do not use the system `python3` 
- Use `venv/bin/python` for all Python scripts, checks, and test fixtures in this repository.
- If `venv/bin/python` does not exist, stop and report that the project environment is missing.

- make sure to save the floats as float32 intstead of float 64 to save on space

## Test and data-processing limits

- Never run large, full-dataset, end-to-end, stress, performance, or resource-intensive tests or data-processing jobs.
- Run only very small tests that use tiny synthetic inputs or a minimal sample of the real data.
- Before running a test or script, confirm that its input size and resource use are small and bounded.
- If adequate validation requires processing substantial data or using significant CPU, memory, storage, or time, do not run it. Report the limitation and provide the command for the user to run manually if requested.
