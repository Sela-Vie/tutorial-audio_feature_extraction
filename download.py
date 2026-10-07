# Author				: Sela-Vie #BeSomeoneWhoCanStandByShinomiya
# Date					: ur my date uwu
# Description			: Code that will impress u ;)
# Actual Description	: 
#       To download the test dataset im going to use
#       to explore and learn some ML, specifically random forest concepts
#       https://www.kaggle.com/datasets/siddharthmandgi/singer-vs-rapper/data
# ========================================================================
# HEADERS
# ========================================================================

import os
import shutil
import kagglehub

# Download latest version
path = kagglehub.dataset_download("siddharthmandgi/singer-vs-rapper")
print("Path to dataset files:", path)

print("Copying to the folder this file is executed in")
target = os.getcwd()
shutil.copytree(path, target, dirs_exist_ok=True)
print("Path to dataset files:", target)