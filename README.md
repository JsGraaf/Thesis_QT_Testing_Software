# Thesis QT Testing Software
Software used for automatically compiling, flashing and testing the Sparkfun Quicklogic Thing+.

# Installation
Ensure that Python 3 and pip are installed. 

The following fork of the QORC SDK should also be installed and operational: https://github.com/JsGraaf/QuickThingPlus_SDK/tree/master.

The test setup should also be copied and the SAMD21 SEEEDUINO XIAO needs to be configured with the following code: https://github.com/JsGraaf/SAMD21_INA219_Power_Meter. This repo also contains the test setup.

Before install the requirements, be sure to enable the qorc sdk environment. This will install the requirements in that conda environment.
Install the requirements:
``` pip install -r requirements.txt ```

# Running the program
To show the help menu, run ```python3 AutoTester.py -h```
