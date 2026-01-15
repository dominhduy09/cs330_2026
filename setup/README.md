# Environment Setup Guide

This guide will help you set up your development environment for CS330.

## Prerequisites

- Python 3.8 or higher
- pip package manager
- Git
- 8GB+ RAM recommended
- GPU recommended (but not required)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/dominhduy09/cs330_2026.git
cd cs330_2026
```

### 2. Create a Virtual Environment

We recommend using a virtual environment to manage dependencies:

```bash
# Using venv
python3 -m venv cs330_env
source cs330_env/bin/activate  # On Windows: cs330_env\Scripts\activate
```

Alternatively, you can use conda:

```bash
conda create -n cs330 python=3.9
conda activate cs330
```

### 3. Install Required Packages

```bash
pip install --upgrade pip
pip install torch torchvision torchaudio
pip install numpy scipy matplotlib
pip install jupyter notebook
pip install tqdm
pip install tensorboard
```

For GPU support (optional but recommended):

```bash
# For CUDA 11.x
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

### 4. Install from requirements.txt

Install all required packages at once:

```bash
pip install -r requirements.txt
```

### 5. Verify Installation

Run our environment verification script:

```bash
python setup/verify_environment.py
```

This will check:
- Python version
- All required packages
- PyTorch installation
- CUDA availability (if applicable)

Alternatively, you can manually verify with this Python script:

```python
import torch
import numpy as np

print(f"Python: OK")
print(f"NumPy version: {np.__version__}")
print(f"PyTorch version: {torch.__version__}")
print(f"CUDA available: {torch.cuda.is_available()}")
if torch.cuda.is_available():
    print(f"CUDA device: {torch.cuda.get_device_name(0)}")
```

### 6. Jupyter Notebook Setup

To use Jupyter notebooks for assignments:

```bash
pip install ipykernel
python -m ipykernel install --user --name=cs330
```

Then start Jupyter:

```bash
jupyter notebook
```

## Troubleshooting

### Common Issues

**Issue**: CUDA out of memory error
- **Solution**: Reduce batch size in your code or use CPU instead

**Issue**: Import errors for packages
- **Solution**: Make sure your virtual environment is activated and all packages are installed

**Issue**: Slow training on CPU
- **Solution**: Consider using Google Colab or cloud computing resources with GPU support

## Using Google Colab (Alternative)

If you don't have access to a GPU locally, you can use Google Colab:

1. Go to [Google Colab](https://colab.research.google.com/)
2. Upload your notebook or create a new one
3. Enable GPU: Runtime → Change runtime type → GPU
4. Clone the repository and install dependencies in the first cell

## Additional Resources

- [PyTorch Documentation](https://pytorch.org/docs/stable/index.html)
- [NumPy Documentation](https://numpy.org/doc/)
- [Python Virtual Environments Guide](https://docs.python.org/3/tutorial/venv.html)

## Getting Help

If you encounter issues with setup:
1. Check the troubleshooting section above
2. Search for similar issues online
3. Post on the course forum
4. Contact the TAs during office hours
