#!/usr/bin/env bash


# Install CUDA if card present
if [ `mhwd | grep nvidia | wc -l` != "0" ];then
    sudo pacman -S --needed --noconfirm cuda
    pacaur -S --needed --noconfirm --noedit cudnn
fi

# Install OpenCL if ATI card present
# Block OpenCL / SYCL for Tensorflow until it's actually working
if [ `false` ];then
#if [ `mhwd | grep catalyst | wc -l` != "0" ];then
    sudo pacman -Rdd --noconfirm ocl-icd 2> /dev/null # fixes a blocking dep
    sudo pacman -S --needed --noconfirm qt4 2> /dev/null # for amdcccle
    sudo pacman -S --needed --noconfirm opencl-catalyst

    # Enable Tear Free Desktop
    sudo sed -i 's/EnableTearFreeDesktop=V0/EnableTearFreeDesktop=V1/;' /etc/ati/amdpcsdb


    # Install ComputeCpp llvm <--> SYCL lib (if in Downloads)
    if [ -f ~/Downloads/ComputeCpp-CE-0.1.3-Ubuntu.14.04-64bit.tar.gz ]; then
        cd /tmp && tar xf ~/Downloads/ComputeCpp-CE-0.1.3-Ubuntu.14.04-64bit.tar.gz && sudo rm -rf /usr/local/computecpp && sudo cp -R ComputeCpp-CE-0.1.3-Linux /usr/local/computecpp && echo '/usr/local/computecpp/lib' | sudo tee /etc/ld.so.conf.d/computecpp.conf > /dev/null && sudo ldconfig && echo "SUCCESS: ComputeCpp Installed."
    else

        echo ""
        echo "Get: https://www.codeplay.com/products/computesuite/computecpp/download"
        echo "Download to: ~/Downloads/ComputeCpp-CE-0.1.3-Ubuntu.14.04-64bit.tar.gz"
        echo ""
    fi

fi




# Enable OpenCL if llvm lib is installed

# Block OpenCL / SYCL for Tensorflow until it's actually working
#if [ -f /usr/local/computecpp/bin/computecpp_info ]; then
if [ `false` ]; then

    # dump some basic driver info
    clinfo
    /usr/local/computecpp/bin/computecpp_info

    echo "Enabling OpenCL"
    export SYCL_BUILD="--config=sycl"
    export TF_NEED_OPENCL=1
    export HOST_CXX_COMPILER=/usr/bin/g++
    export HOST_C_COMPILER=/usr/bin/gcc
    #export HOST_CXX_COMPILER=/usr/bin/clang++
    #export HOST_C_COMPILER=/usr/bin/clang
    export COMPUTECPP_TOOLKIT_PATH=/usr/local/computecpp
    export COMPUTE=:0
else
    export TF_NEED_OPENCL=0
    export SYCL_BUILD=""
fi

# Enable CUDA if cuDDN is installed
if [ -f /opt/cuda/include/cudnn.h ]; then
    echo "Enabling CUDA"
    export CUDA_BUILD="--config=cuda"
    export TF_NEED_CUDA=1
    
    #sudo pacman -S --needed --noconfirm gcc49

    export GCC_HOST_COMPILER_PATH=/usr/bin/gcc
    export CUDA_TOOLKIT_PATH=/opt/cuda
    export CUDNN_INSTALL_PATH=/opt/cuda
    export TF_CUDA_COMPUTE_CAPABILITIES=5.2
    export TF_CUDA_VERSION=$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')
    export TF_CUDNN_VERSION=$(sed -n 's/^#define CUDNN_MAJOR\s*\(.*\).*/\1/p' $CUDNN_INSTALL_PATH/include/cudnn.h)
else
    export TF_NEED_CUDA=0
    export CUDA_BUILD=""
fi

#export TF_NEED_MKL=1
export PYTHON_BIN_PATH=$(which python || which python3  || true)
export TF_NEED_GCP=0
export TF_NEED_HDFS=0
export TF_ENABLE_XLA=1
export TF_NEED_JEMALLOC=0
export CC_OPT_FLAGS="-march=native"
export USE_DEFAULT_PYTHON_LIB_PATH=1
#export TF_UNOFFICIAL_SETTING=1
#export TF_CPP_MIN_LOG_LEVEL=1


cd /tmp

git clone https://github.com/tensorflow/tensorflow

cd tensorflow

# Enable MKL
sed -i 's/if false/if true/;' /tmp/tensorflow/configure

echo "Finished Patching"

./configure

bazel build --config=opt $SYCL_BUILD $CUDA_BUILD --verbose_failures --ignore_unsupported_sandboxing //tensorflow/tools/pip_package:build_pip_package

bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

sudo pip install --ignore-installed --upgrade /tmp/tensorflow_pkg/t*

if [ "$INSTALL_OPENCL" == "1" ]; then
    (( sycl = python -c 'from tensorflow.python.client import device_lib;print([x.name for x in device_lib.list_local_devices()])' | grep "sycl" | wc -l ))
    if [ "$sycl" == "1" ];then
       echo "TENSORFLOW OPENCL / SYCL SUPPORT ENABLED!"
    else
       echo "ERROR: TENSORFLOW MISSING OPENCL / SYCL SUPPORT"
    fi
fi
