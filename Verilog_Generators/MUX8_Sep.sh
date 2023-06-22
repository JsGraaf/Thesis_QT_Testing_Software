#!/bin/bash

### MUX8 Seperate generator for verilog code for QT plus ###

# Usage: ./<Filename> <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="MUX8 Seperate"
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
echo """module mux8_ro(
   input en,
   output out,
);

(*keep*)wire connect;

assign connect = en ? connect : 0;
assign out = en ? connect : 0;

mux8x0 ro (
   .S0(connect),
   .S1(connect),
   .S2(connect),
   .A(1'b1),
   .B(1'b0),
   .C(1'b0),
   .D(1'b0),
   .E(1'b0),
   .F(1'b0),
   .G(1'b0),
   .H(1'b0),
   .Q(connect)
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
   if [ "$AMOUNT" -eq "1" ]; then
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
      echo """mux8_ro ro$i(
   .en(en),
   .out(out[$(( i-1 ))]),
);
""" >> $FILE_NAME
   done
else # In case the design is empty (circuits = 0), add 1 inverter
echo """inv invBase (
   .A(io_pad[2]),
   .Q(io_pad[25])
);
""" >> $FILE_NAME
fi

### END OF MODULE ###
echo 'assign io_pad[13] = |out;' >> $FILE_NAME
echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH