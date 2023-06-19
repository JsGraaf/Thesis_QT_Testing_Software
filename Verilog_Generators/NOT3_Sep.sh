#!/bin/bash

### NOT3 RO generator for verilog code for QT plus ###
# Generates NOT3 RO generator with 

# Usage: ./baseGenerator <Amount of circuits> <output file path>
FILE_NAME='MODULE_top.txt'
CIRCUIT_NAME="NOT3"
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
echo """module not_3_ro(
   input en,
   output out,
);

assign connect[0] = en ? connect[3] : 0;
assign out = en ? connect[3] : 0;

wire [3:0] connect;

inv inv1 (
   .A(connect[0]),
   .Q(connect[1])
);

inv inv2 (
   .A(connect[1]),
   .Q(connect[2]),
);

inv inv3 (
   .A(connect[2]),
   .Q(connect[3])
);
endmodule

module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;
""" > $FILE_NAME

if [ "$AMOUNT" -lt "2" ]; then
echo "wire [2:0] out;" >> $FILE_NAME
else
echo "wire [$(( AMOUNT-1 )):0] out;" >> $FILE_NAME
fi
echo """
reg en;
initial begin
   en <= 1;
end
""" >> $FILE_NAME


if [ "$AMOUNT" -gt "0" ]; then
   for i in $( eval echo {1..$AMOUNT} )
   do
      echo """(*keep=1*) not_3_ro ro$((i - 1)) (
   .en(en),
   .out(out[$((i-1))]),
);
""" >> $FILE_NAME
   done
else # In case the design is empty (circuits = 0)
echo """inv invBase (
   .A(io_pad[2]),
   .Q(io_pad[4])
);
""" >> $FILE_NAME
fi

echo 'assign io_pad[2] = |out;' >> $FILE_NAME
echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME $OUTPUT_FILE_PATH