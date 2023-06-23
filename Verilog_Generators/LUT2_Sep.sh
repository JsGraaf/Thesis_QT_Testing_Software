#!/bin/bash

### LUT2 generator for verilog code for QT plus ###

# Usage: ./<Filename> <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="LUT2"
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

module lut_2_ro(
   input en,
   output out,
);

(*keep*)wire connect;
wire test;

assign out = connect;

mux2x0 enable (
   .S(en),
   .A(1'b0),
   .B(connect),
   .Q(test),
);

LUT2 #(
   .INIT(4'b0001)
) ro (
   .I0(test),
   .I1(1'b0),
   .O(connect)
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
// Initialize 48MHz clock
wire                                    CLK        ;
wire                                    CLK_RST    ;

qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
    // FB Clocks
    .Sys_Clk0                  ( CLK                       ), // output
    .Sys_Clk0_Rst              ( CLK_RST                   ), // output
);

reg  [31:0] counter;

reg en;

always @(posedge CLK) begin
   if (counter > 100000000) begin
      en <= 1;
   end
   counter = counter + 1;
end""" >> $FILE_NAME

### INSTANCE GENERATION (individual Circuit) ###
if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """
lut_2_ro ro$i(
   .en(en),
   .out(out[$(( i-1 ))]),
);""" >> $FILE_NAME
   done
else # In case the design is empty (circuits = 0), add 1 inverter
echo """inv invBase (
   .A(io_pad[2]),
   .Q(io_pad[25])
);""" >> $FILE_NAME
fi

### END OF MODULE ###
echo 'assign io_pad[13] = |out;' >> $FILE_NAME
echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH