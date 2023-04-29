#!/bin/bash

### Basic generator for verilog code for QT plus ###
# Generates a small fpga design which toggles the green LED

# Usage: ./baseGenerator <Amount of circuits>

FILE_NAME='MODULE_TOP.txt'

OUTPUT_FILE_PATH=$2

CIRCUIT_NAME='inverters'

# Check if arguments where given
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi

# Get amount from arguments
AMOUNT=$1

echo "Generating ${1} $CIRCUIT_NAME"

### TOP OF MODULE ###
# Add IOs between ()
echo """
module MODULE_top(
   io_pad
);

// GPIO
inout       wire    [31:0]      io_pad          ;

wire connectWire0;
assign io_pad[6] = connectWire0; """ > $FILE_NAME

### REPEATED CIRCUITS HERE ###
for i in $( eval echo {1..$AMOUNT} )
do
prev=$(( i-1 ));
echo """
wire connectWire${i};
inv invert${i} (
   .A(connectWire${prev}),
   .Q(connectWire${i})
);""" >> $FILE_NAME
done

### FINAL PART OF DESIGN ###
echo """
assign io_pad[21] = connectWire${i};
endmodule""" >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH