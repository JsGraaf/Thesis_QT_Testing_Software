### A program to automatically generate verilog code for the Quicklogic Thing ###
### Plus, flash it and run power tests when connected to a uC with an INA219  ###
### and the companion controller                                              ###

import argparse
import subprocess
import os
import serial

VERILOG_GENERATION_FILES_PATH = r"Verilog_Generators/"
QORC_SDK_PATH = r"/home/joris/Uni/Scriptie/qorc_sdk/"
QT_APP_DIR = r"QT_App"
QT_APP_PATH = r"QT_App/fpga/rtl/"
FPGA_FILE_PATH = os.path.join(QT_APP_PATH, "MODULE_top.v")

def parseArguments():
   argParser = argparse.ArgumentParser()
   argParser.add_argument("-q", "--QORC_PORT", required=False,
                          help="Specify the serial port to which the QT+ is connected in programming mode")
   argParser.add_argument("-p", "--comPort", required=False,
                          help="Specify the serial port to which the controller uC with INA219 is connected")
   argParser.add_argument("-g", "--generator", required=False,
                          help="Specify the filename of the verilog generator, located in Verilog_Generators/")
   argParser.add_argument("-c", "--circuitCount", required=False,
                          help="Specify the amount of circuits to generate")
   argParser.add_argument("-o", "--outFile", required=False,
                          help="Path for the output file, must end in .csv")
   argParser.add_argument("-l", "--testLength", required=False,
                          help="Specify the length of the power tests")
   return argParser.parse_args()

def printError(errno: int):
   if (errno == 1):
      print("Error in generator execution!")
   elif (errno == 2):
      print("Error in executing make")
   elif (errno == 3):
      print("Error in flashing board!")

   exit(errno)

# Runs the specified generator, located in VERILOG_GENERATION_FILES_PATH
def runGenerator(filePath: os.path, circuitCount: int):
   # Prepend './'
   filePath = os.path.join("./", filePath)
   # Run the bash generator script
   val = subprocess.check_call("{} {} {}".format(filePath, circuitCount, 
                               FPGA_FILE_PATH), shell=True)
   
   if (val == 0): return True
   else: return False

# Resets the board by pulling down RESET 
# And then by pulling down USR_BTN (GPIO6)
def enableProgrammingMode():
   ### PLACEHOLDER ###
   # Reset board using uC connected to RST pin and GPIO6 (USR_BTN)
   # Pull down USR_BTN (GPIO6)
   return True

# Compiles the QT_APP using make -C
def compileProgram():
   val = subprocess.check_call("make -C {}".format(QT_APP_DIR), shell=True)
   if (val == 0): return True
   else: return False

# Start Serial connection
def startSerial(comPort: str):
   ser = serial.Serial(comPort)
   if (ser.name != comPort): return False
   # Test connection
   ser.write('T')
   if (ser.read() != 'C'): return False
   return ser

# Flasing board over USB
# comPort: port which is connected to the uC for controlling the QT+
# QORC_PORT: port to which the QT+ is connected for transferring data
def flashBoard(ser, QORC_PORT: str, ):
   if not enableProgrammingMode(ser): 
      printError(2)
   # Setting the QORC_PORT in the environment
   os.environ['QORC_PORT'] = QORC_PORT
   # Using make flash
   val = subprocess.check_call("make flash -C {}".format(QT_APP_DIR), shell=True)
   if (val == 0): return True
   else: return False

# Run power tests by sending serial command to uC connected to INA219 to 
# perform power tests for the desired amount of time
# comPort: Port to which the uC with the INA219 is connected
def runPowerTests(ser, testLength: int, betweenTime: int, outFile: os.path):
   # Send command to uC to confirm link
   ser.write("T")
   if (ser.read() != 'C'): return False
   # Send command to uC to start testing for power
   ser.write("{} {}".format(testLength, betweenTime))
   # Send command with total sampling time in ms
   # Send command with time in between samples in ms
   # Receive all the data and chop up into individual measurements
   # Output to CSV file
   return True

if __name__ == '__main__':
   args = parseArguments()
   if not runGenerator(os.path.join(VERILOG_GENERATION_FILES_PATH, args.generator), args.circuitCount):
      printError(1)
   if not compileProgram():
      printError(2)
   ser = startSerial(args.comPort)
   if (ser == False):
      printError(3)
   if not flashBoard(ser):
      printError(4)
   if not runPowerTests(ser, args.powerLength, args.outFile):
      printError(5)