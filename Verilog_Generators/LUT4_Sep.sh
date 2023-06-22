#!/bin/bash

### LUT4 generator for verilog code for QT plus ###

# Usage: ./<Filename> <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="LUT4"
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
module lut_4_ro(
   input en,
   output out,
);

(*keep*)wire connect;

assign connect = en ? connect : 0;
assign out = en ? connect : 0;

LUT4 #(
   .INIT(16'b0000000000000001)
) ro (
   .I0(connect),
   .I1(1'b0),
   .I2(1'b0),
   .I3(1'b0),
   .O(out)
);
endmodule
""" > $FILE_NAME

### TOP OF MODULE ###
echo """ 
module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;
""" >> $FILE_NAME

if [ "$AMOUNT" -lt "2" ]; then
   if ["$AMOUNT" -eq "1"]; then
      echo "wire out;" >> $FILE_NAME
   else
      echo "wire [2:0] out;" >> $FILE_NAME
   fi
else
   echo "wire [$(( AMOUNT-1 )):0] out;" >> $FILE_NAME
fi

echo """
reg en;
initial begin
   en <= 1;
end

""" >> $FILE_NAME

### INSTANCE GENERATION (individual Circuit) ###
if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """
lut_4_ro ro$i(
   .en(en),
   .out(out),
);
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
echo 'assign io_pad[2] = |out;' >> $FILE_NAME
echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH