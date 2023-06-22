#!/bin/bash

### LUT4_I0 RO generator for verilog code for QT plus ###
# Generates LUT4_I0 RO generator with 

# Usage: ./baseGenerator <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="Chained LUT4"
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

assign io_pad[22] = io_pad[2];
""" > $FILE_NAME


if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """
(* keep = \"true\" *) wire lut_${i}_connect;
(* keep = \"true\" *) LUT4 #(
   .INIT(16'b0000000000000010)
) lut$i (
   .I0(io_pad[2]),
   .I1(lut_${i}_connect),
   .I2(1'b0),
   .I3(1'b0),
   .O(lut_$(( $i + 1 ))_connect)
);""" >> $FILE_NAME
   done
fi

echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH