#!/bin/bash

### LUT4_I0 RO generator for verilog code for QT plus ###
# Generates LUT4_I0 RO generator with 

# Usage: ./baseGenerator <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="LUT4 seperate"
# Check if arguments where given
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

# Get amount from arguments
AMOUNT=$1
OUTPUT_FILE_PATH=$2

echo "Generating ${1} $CIRCUIT_NAME"

### TOP OF MODULE ###
# Add IOs between ()
echo """
module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;
""" > $FILE_NAME

if [ "$AMOUNT" -lt "2" ]; then
echo "wire [2:0] out;" >> $FILE_NAME
else
echo "wire [${AMOUNT}:0] out;" >> $FILE_NAME
fi

if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """
LUT4 #(
   .INIT(16'b0000000000000001)
) lut$i (
   .I0(io_pad[6]),
   .I1(out[$i]),
   .I2(1'b0),
   .I3(1'b0),
   .O(out[$i])
);""" >> $FILE_NAME
   done
fi

echo 'assign io_pad[4] = |out;' >> $FILE_NAME

echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH