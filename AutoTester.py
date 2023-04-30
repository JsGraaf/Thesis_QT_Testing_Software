### A program to automatically generate verilog code for the Quicklogic Thing ###
### Plus, flash it and run power tests when connected to a uC with an INA219  ###
### and the companion controller                                              ###

import argparse
import subprocess
import os
import serial
import xlsxwriter
import datetime

VERILOG_GENERATION_FILES_PATH = r"Verilog_Generators/"
QORC_SDK_PATH = r"/home/joris/Uni/Scriptie/qorc_sdk/"
QT_APP_DIR = r"QT_App"
QT_APP_PATH = r"QT_App/fpga/rtl/"
FPGA_FILE_PATH = os.path.join(QT_APP_PATH, "MODULE_top.v")
OUTPUT_DIR = r"Output"
OUTPUT_FILE = r"Power_Test_Output.xlsx"

HEADERS = ["Voltage(V)", "Amperage(A)", "Wattage(mW)"]

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
   argParser.add_argument("-l", "--testLength", required=False,
                          help="Specify the length of the power tests")
   argParser.add_argument("-d", "--delay", required=True, 
                          help="Specify delay between measurements")
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


# Output measurements string to csv file
# Sample seperated by ';', values by ':'
def outputToCsv(sheetName: str, measurements: list):
   # Check if output dir exists
   if not os.path.isdir(OUTPUT_DIR):
      os.mkdir(OUTPUT_DIR)
   # Check if file is already present
   if not os.path.isfile(os.path.join(OUTPUT_DIR, OUTPUT_FILE)):
         workbook = xlsxwriter.Workbook(OUTPUT_FILE)
   # Create new worksheet
   while sheetName in workbook.sheetnames:
      # Prevent overwriting
      sheetName = "new_" + sheetName
   worksheet = workbook.add_worksheet(sheetName)
   # Add headers
   for i in range(len(HEADERS)):
      worksheet.write(0, i, HEADERS[i])
   # Add date as final header
   worksheet.write(0, 3, datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S"))
   # Add data
   rowCounter = 1 # Start at one due to header row
   # Split measurments string
   measurements = measurements.split(';')
   for row in measurements:
      sample = row.split(':')
      for column in range(len(sample)):
         worksheet.write(rowCounter, column, sample[column])
   
   workbook.close()
   return True
# Run power tests by sending serial command to uC connected to INA219 to 
# perform power tests for the desired amount of time
# comPort: Port to which the uC with the INA219 is connected
def runPowerTests(ser, testLength: int, betweenTime: int, outName: str):
   # Send command to uC to confirm link
   ser.write("T")
   if (ser.read() != 'C'): return False
   # Send command to uC to start testing for power with length and sample delay
   ser.write("{} {}".format(testLength, betweenTime))
   # Receive all the data and chop up into individual measurements
   measurements = ser.read_until('\n')
   # Output to CSV file
   outputToCsv(outName, measurements)
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