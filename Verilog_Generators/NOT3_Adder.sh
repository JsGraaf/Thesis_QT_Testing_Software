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

module eightbitadd ( 
      input [31:0] a,
      input [31:0] b,
      input c_in,
      output reg c_out,
      output reg[31:0] sum,
      input clk,);

   always @ (posedge clk) begin
      {c_out, sum} = a + b + c_in;
   end
endmodule

module doubleeightbitadd (
   input [31:0] a1,
   input [31:0] a2,
   input [31:0] b1,
   input [31:0] b2,
   output reg[31:0] sum,
   input clk,);

wire [31:0] sum1;
wire [31:0] sum2;

 eightbitadd add1(
   .a(a1),
   .b(b1),
   .c_in(1'b0),
   .sum(sum1),
   .clk(clk),
);

 eightbitadd add2(
   .a(a2),
   .b(b2),
   .c_in(1'b0),
   .sum(sum2),
   .clk(clk),
);

 eightbitadd addTot(
   .a(sum1),
   .b(sum2),
   .c_in(1'b0),
   .sum(sum),
   .clk(clk),
);
endmodule

module quadeightbitadd (
   input [31:0] a1,
   input [31:0] a2,
   input [31:0] a3,
   input [31:0] a4,
   input [31:0] b1,
   input [31:0] b2,
   input [31:0] b3,
   input [31:0] b4,
   output reg[31:0] sum,
   input clk,
);

reg [31:0] sum1;
reg [31:0] sum2;

doubleeightbitadd add1(
   .a1(a1),
   .b1(b1),
   .a2(a2),
   .b2(b2),
   .clk(clk),
   .sum(sum1),
);

doubleeightbitadd add2(
   .a1(a3),
   .b1(b3),
   .a2(a4),
   .b2(b4),
   .clk(clk),
   .sum(sum2),
);

eightbitadd addTot(
   .a(sum1),
   .b(sum2),
   .c_in(1'b0),
   .clk(clk),
   .sum(sum),
);
endmodule

module octaeightbitadd (
   input [31:0] a1,
   input [31:0] a2,
   input [31:0] a3,
   input [31:0] a4,
   input [31:0] a5,
   input [31:0] a6,
   input [31:0] a7,
   input [31:0] a8,
   input [31:0] b1,
   input [31:0] b2,
   input [31:0] b3,
   input [31:0] b4,
   input [31:0] b5,
   input [31:0] b6,
   input [31:0] b7,
   input [31:0] b8,
   output reg[31:0] sum,
   input clk,
);

reg [31:0] sum1;
reg [31:0] sum2;

 quadeightbitadd add1(
   .a1(a1),
   .b1(b1),
   .a2(a2),
   .b2(b2),
   .a3(a3),
   .b3(b3),
   .a4(a4),
   .b4(b4),
   .clk(clk),
   .sum(sum1),
);

 quadeightbitadd add2(
   .a1(a5),
   .b1(b5),
   .a2(a6),
   .b2(b6),
   .a3(a7),
   .b3(b7),
   .a4(a8),
   .b4(b8),
   .clk(clk),
   .sum(sum2),
);

 eightbitadd addTot(
   .a(sum1),
   .b(sum2),
   .c_in(1'b0),
   .clk(clk),
   .sum(sum),
);
endmodule

module activeTest(
   input wire inw,
   output wire outw,
);

// Initialize 48MHz clock
wire                                    CLK        ;
wire                                    CLK_RST    ;

qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
    // FB Clocks
    .Sys_Clk0                  ( CLK                       ), // output
    .Sys_Clk0_Rst              ( CLK_RST                   ), // output
);

// Initialize "Normal" program
reg [31:0] a1;
reg [31:0] a2;
reg [31:0] a3;
reg [31:0] a4;
reg [31:0] a5;
reg [31:0] a6;
reg [31:0] a7;
reg [31:0] a8;
reg [31:0] b1;
reg [31:0] b2;
reg [31:0] b3;
reg [31:0] b4;
reg [31:0] b5;
reg [31:0] b6;
reg [31:0] b7;
reg [31:0] b8;
wire [31:0] sum;

octaeightbitadd add1 (
   .a1(a1),
   .a2(a2),
   .a3(a3),
   .a4(a4),
   .a5(a5),
   .a6(a6),
   .a7(a7),
   .a8(a8),
   .b1(b1),
   .b2(b2),
   .b3(b3),
   .b4(b4),
   .b5(b5),
   .b6(b6),
   .b7(b7),
   .b8(b8),
   .sum(sum),
   .clk(CLK)
);

reg [31:0] counter;

initial begin 
   counter <= 0;
   a1 <= 1;
   a2 <= 2;
   a3 <= 3;
   a4 <= 4;
   a5 <= 5;
   a6 <= 6;
   a7 <= 7;
   a8 <= 8;
   b1 <= 9;
   b2 <= 10;
   b3 <= 11;
   b4 <= 12;
   b5 <= 13;
   b6 <= 14;
   b7 <= 15;
   b8 <= 0;
end

always @(posedge CLK) begin
   if (counter < 10000000) begin // Approx 1x every second
      counter <= counter + 1;
   end
   else begin
      if (!inw) begin 
         a1 <= 30;
      end
      else begin
         a1 <= 1;
      end
      counter <= 0;
      if (sum == 120) begin // Check if corrent value is computed
         outw <= !outw;
      end
      else begin
         outw <= 0;
      end
   end
end
endmodule

module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;

(*keep=1*)activeTest test (
   .inw(io_pad[6]),
   .outw(io_pad[21])
);
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
      echo """not_3_ro ro$((i - 1)) (
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