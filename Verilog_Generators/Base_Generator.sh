#!/bin/bash

### <CIRCUIT NAME HERE> generator for verilog code for QT plus ###

# Usage: ./<Filename> <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="<CIRCUIT NAME HERE>"
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

### INITIALISATION OF SUBMODULES ###
# This can be deleted if there are no submodules
echo """
<ADD SUBMODULE DEFINITIONS HERE>
""" > $FILE_NAME

### TOP OF MODULE ###
echo """ 
module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;
""" >> $FILE_NAME

echo """
<ADD TOP MODULE DEFINITION HERE>
<BEWARE OF \$AMOUNT == 0>
""" >> $FILE_NAME

### INSTANCE GENERATION (individual Circuit) ###
if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """<ADD INSTANCE DEFINITION HERE>
""" >> $FILE_NAME
   done
else # In case the design is empty (circuits = 0), add 1 inverter
echo """inv invBase (
   .A(io_pad[2]),
   .Q(io_pad[4])
);
""" >> $FILE_NAME
fi

### END OF MODULE ###
echo '<ADD MODULE END HERE' >> $FILE_NAME
echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH