# frida-python-ios

This repository provides instructions for setting up and using Frida on a jailbroken iOS device. 
Traditionally, Frida is controlled from a computer using commands like `frida`, `frida-trace`, or `frida-ps`. 
The standard Frida package available on Cydia only installs `frida-server` and `frida-agent.dylib` and does not include tools required to run Frida commands directly on the iOS device. 
With this setup, you can run these commands directly on the iOS device by cross-compiling frida-python for iOS on a Mac.

## Prerequisites

- A jailbroken iOS device.
- Python installed on the target iOS device.
- A Mac for cross-compilation.

## Setup Instructions

### Step 1: Install Python and pip on the iOS Device

1. Install Python on your iOS device using your preferred package manager (e.g., `apt` from Cydia or Sileo).
2. Install `pip` by running the following command on your iOS device:
   ```bash
   python -m ensurepip
   ```
3. Determine the target platform for your device by running:
   ```bash
   python -c 'import sysconfig; print(sysconfig.get_platform())'
   ```
   Note the output, as it will be used in the Makefile later.

### Step 2: Clone the Repository and Configure the Makefile

1. Clone this repository to your Mac:
   ```bash
   git clone https://github.com/vnc0/frida-python-ios
   cd frida-python-ios
   ```
2. Edit the `Makefile` and set the `PYTHON_TARGET_PLATFORM` variable to the value obtained from Step 1. For example:
   ```make
   PYTHON_TARGET_PLATFORM=macosx_11_0_iphone13,1
   ```

### Step 3: Cross-Compile frida-python

1. Run the following command on your Mac:
   ```bash
   make
   ```
   This will generate a `.whl` file in the `out` directory.

### Step 4: Install the Compiled Package on the iOS Device

1. Transfer the `.whl` file from the `out` folder to your iOS device using a method such as `scp` or `AirDrop`.
2. Install the package on your iOS device using `pip`:
   ```bash
   pip install ./frida-16.6.4-cp37-abi3-macosx_11_0_iphone13,1.whl
   ```

### Step 5: Install Frida Tools

1. Once frida-python is installed, you can install Frida Tools on the iOS device:
   ```bash
   pip install frida-tools
   ```

## Usage

After completing the setup, you can now run Frida commands directly on your iOS device. For example:
```bash
frida -n terminusd
```