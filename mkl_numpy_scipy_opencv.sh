#!/usr/bin/env bash



# Install MKL from AUR (can't build in ram -- too big)
BUILDDIR=~/.cache/ pacaur -S --needed --noconfirm --noedit intel-mkl 
rm -rf /.cache/intel-parallel-studio-xe
rm -rf /tmp/intel-parallel-studio-xe

# Give mkl a knowable location
sudo ln -sf /opt/intel/*/linux/mkl /opt/intel/mkl

# Work around known numpy issue (will not link to mkl w/o this)
sudo ln -sf ~/.numpy-site.cfg /root/.numpy-site.cfg

# Compile + install numpy / scipy from source so MKL is added
sudo pip install git+https://github.com/numpy/numpy.git
sudo pip install git+https://github.com/scipy/scipy.git


# Install SIMD-enabled Pillow as well
sudo pip install --upgrade git+https://github.com/uploadcare/pillow-simd.git

# Install Theano and Keras from source
sudo pip install git+https://github.com/Theano/Theano.git
sudo pip install git+https://github.com/fchollet/keras.git

# For CUDA compatible building of OpenCV
export GCC_HOST_COMPILER_PATH=/usr/bin/gcc-5

# Install MKL-enabled OpenCV
pacaur -S --needed --noconfirm --noedit opencv-git
rm -rf /tmp/opencv-git

# Test if numpy / scipy are properly linked with mkl
(( numpy_mkl = `python -c 'import numpy; numpy.show_config()' | grep "mkl_rt" | wc -l` ))

if [ "$numpy_mkl" == "4" ];then
   echo "SUCCESS: MKL properly linked to numpy"
else
   echo "ERROR: MKL NOT LINKED TO NUMPY"
fi

(( scipy_mkl = `python -c 'import scipy; scipy.show_config()' | grep "mkl_rt" | wc -l` ))

if [ "$scipy_mkl" == "4" ];then
   echo "SUCCESS: MKL properly linked to scipy"
else
   echo "ERROR: MKL NOT LINKED TO SCIPY"
fi

# Redundant way to check same info for scikit-learn
# python -c "from numpy.distutils.system_info import get_info;print(get_info('blas_opt'));print(get_info('lapack_opt'))"
