KERNEL="https://github.com/onettboots/bool-x_xiaomi_raphael"
VENDOR="https://github.com/InVictusXV/vendor_xiaomi_raphael"

CLANG="https://gitlab.com/onettboots/boolx-clang -b Clang-17.0_x86"
QCOM_VENDOR="https://gitlab.com/yaosp/vendor_qcom_common"
QCOM_DEVICE="https://github.com/yaap/device_qcom_common"
DEVICESETTINGS="https://github.com/LineageOS/android_packages_resources_devicesettings"
HARDWARE="https://github.com/InVictusXV/android_hardware_xiaomi"
DISPLAY="https://github.com/Peam269/hardware_qcom_display"

GCAM="https://gitlab.com/Peam269/vendor_GcamBSG"
V4AFX="https://github.com/DanipunK1/vendor_v4afx"
OTOMUSIC="https://github.com/onettboots/packages_apps_OtoMusicPlayer"


# Check if this is the initial setup or not
FILE=initialsetup > /dev/null 2>&1
if test -f "$FILE"; then :
else
    rm -rf kernel/xiaomi/raphael > /dev/null 2>&1
    rm -rf vendor/xiaomi/raphael > /dev/null 2>&1
    rm -rf vendor/qcom/common > /dev/null 2>&1
    rm -rf device/qcom/common > /dev/null 2>&1
    rm -rf packages/resources/devicesettings > /dev/null 2>&1
    rm -rf hardware/xiaomi > /dev/null 2>&1
    rm -rf hardware/qcom-caf/sm8150/display > /dev/null 2>&1
    rm -rf vendor/v4afx > /dev/null 2>&1
    rm -rf packages/apps/OtoMusicPlayer > /dev/null 2>&1
    rm -rf vendor/GcamMGC > /dev/null 2>&1
    echo "Downloading dependencies (initial setup)..."
fi

# Pull changes / download non-existing dependencies

# Raphael-Vendor
if [ -d "vendor/xiaomi/raphael" ]
then
    echo "Pulling changes from GitHub"
    git -C vendor/xiaomi/raphael pull 2>&1 | grep "fatal"
else
    git clone $VENDOR vendor/xiaomi/raphael --depth=1 2>&1 | grep "fatal"
    echo "Vendor downloaded"
fi

# Raphael-Kernel
if [ -d "kernel/xiaomi/raphael" ]
then
    git -C kernel/xiaomi/raphael pull 2>&1 | grep "fatal"
else
    git clone $KERNEL kernel/xiaomi/raphael --depth=1 2>&1 | grep "fatal"
    echo "Kernel downloaded"
fi

# Clang
if [ -d "prebuilts/clang/host/linux-x86/boolx-clang" ]
then
    git -C prebuilts/clang/host/linux-x86/boolx-clang pull 2>&1 | grep "fatal"
else
    git clone $CLANG prebuilts/clang/host/linux-x86/boolx-clang --depth=1 2>&1 | grep "fatal"
    echo "Clang downloaded"
fi

# QCOM common vendor
if [ -d "vendor/qcom/common" ]
then
    git -C vendor/qcom/common pull 2>&1 | grep "fatal"
else
    git clone $QCOM_VENDOR vendor/qcom/common --depth=1 2>&1 | grep "fatal"
    echo "vendor_qcom_common downloaded"
fi

# QCOM common device
if [ -d "device/qcom/common" ]
then
    git -C device/qcom/common pull 2>&1 | grep "fatal"
else
    git clone $QCOM_DEVICE device/qcom/common --depth=1 2>&1 | grep "fatal"
    echo "device_qcom_common downloaded"
fi

# Lineage Devicesettings (XiaomiParts)
if [ -d "packages/resources/devicesettings" ]
then
    git -C packages/resources/devicesettings pull 2>&1 | grep "fatal"
else
    git clone $DEVICESETTINGS packages/resources/devicesettings 2>&1 | grep "fatal"
    echo "XiaomiParts downloaded"
fi

# Xiaomi Hardware
if [ -d "hardware/xiaomi" ]
then
    git -C hardware/xiaomi pull 2>&1 | grep "fatal"
else
    git clone $HARDWARE hardware/xiaomi 2>&1 | grep "fatal"
    echo "Xiaomi Hardware downloaded"
fi

# SM8150 Display
if [ -d "hardware/qcom-caf/sm8150/display" ]
then
    git -C hardware/qcom-caf/sm8150/display pull 2>&1 | grep "fatal"
else
    git clone $DISPLAY hardware/qcom-caf/sm8150/display 2>&1 | grep "fatal"
    echo "SM8150 Display downloaded"
fi

# Google Camera
if [ -d "vendor/GcamMGC" ]
then
    git -C vendor/GcamMGC pull 2>&1 | grep "fatal"
else
    git clone $GCAM vendor/GcamMGC 2>&1 | grep "fatal"
    echo "Google Camera downloaded"
fi

# ViPER4Android (sound mod)
if [ -d "vendor/v4afx" ]
then
    git -C vendor/v4afx pull 2>&1 | grep "fatal"
else
    git clone $V4AFX vendor/v4afx 2>&1 | grep "fatal"
    echo "ViPER4Android downloaded"
fi

# Oto Music Player
if [ -d "packages/apps/OtoMusicPlayer" ]
then
    git -C packages/apps/OtoMusicPlayer pull 2>&1 | grep "fatal"
else
    git clone $OTOMUSIC packages/apps/OtoMusicPlayer 2>&1 | grep "fatal"
    echo "Oto Music Player downloaded"
fi

# Pull DeviceTree Changes
    git -C device/xiaomi/raphael pull 2>&1 | grep "fatal"

# Enable OTA for unofficial Bliss builds
sed -i 's+https://downloads.blissroms.org/api/v1/updater/los/{device}/{variant}/+https://raw.githubusercontent.com/Peam269/ota/master/bliss/{variant}/{device}.json+g' packages/apps/BlissUpdater/res/values/strings.xml


# Create file after initial setup
touch initialsetup > /dev/null 2>&1
