#!/usr/bin/env python3
"""
Environment verification script for CS330.

This script checks if your development environment is correctly set up
for the CS330 course.
"""

import sys


def check_python_version():
    """Check if Python version is 3.8 or higher."""
    print("Checking Python version...")
    version = sys.version_info
    if version.major == 3 and version.minor >= 8:
        print(f"✓ Python {version.major}.{version.minor}.{version.micro} - OK")
        return True
    else:
        print(f"✗ Python {version.major}.{version.minor}.{version.micro} - FAIL")
        print("  Please install Python 3.8 or higher")
        return False


def check_package(package_name, min_version=None):
    """Check if a package is installed and optionally verify version."""
    try:
        module = __import__(package_name)
        version = getattr(module, "__version__", "unknown")
        
        if min_version and version != "unknown":
            from packaging import version as pkg_version
            if pkg_version.parse(version) >= pkg_version.parse(min_version):
                print(f"✓ {package_name} {version} - OK")
                return True
            else:
                print(f"✗ {package_name} {version} - UPDATE REQUIRED (need {min_version}+)")
                return False
        else:
            print(f"✓ {package_name} {version} - OK")
            return True
    except ImportError:
        print(f"✗ {package_name} - NOT INSTALLED")
        return False


def check_torch_cuda():
    """Check PyTorch CUDA availability."""
    try:
        import torch
        print("\nChecking CUDA availability...")
        if torch.cuda.is_available():
            print(f"✓ CUDA available: {torch.cuda.get_device_name(0)}")
            print(f"  CUDA version: {torch.version.cuda}")
            return True
        else:
            print("⚠ CUDA not available - will use CPU")
            print("  GPU is recommended but not required")
            return True
    except ImportError:
        return False


def main():
    """Run all environment checks."""
    print("=" * 60)
    print("CS330 Environment Verification")
    print("=" * 60)
    print()
    
    all_checks = []
    
    # Check Python version
    all_checks.append(check_python_version())
    print()
    
    # Check core packages
    print("Checking required packages...")
    packages = [
        ("numpy", "1.20.0"),
        ("torch", "2.0.0"),
        ("torchvision", None),
        ("matplotlib", None),
        ("tqdm", None),
        ("jupyter", None),
    ]
    
    for package_info in packages:
        if len(package_info) == 2:
            all_checks.append(check_package(package_info[0], package_info[1]))
        else:
            all_checks.append(check_package(package_info[0]))
    
    print()
    
    # Check CUDA
    all_checks.append(check_torch_cuda())
    
    print()
    print("=" * 60)
    
    if all(all_checks):
        print("✓ All checks passed! Your environment is ready for CS330.")
    else:
        print("✗ Some checks failed. Please install missing packages.")
        print("\nTo install all requirements, run:")
        print("  pip install -r requirements.txt")
    
    print("=" * 60)
    
    return 0 if all(all_checks) else 1


if __name__ == "__main__":
    sys.exit(main())
