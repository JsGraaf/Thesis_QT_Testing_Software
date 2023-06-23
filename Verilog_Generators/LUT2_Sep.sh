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

assign connect = en ? connect : 0;
assign out = en ? connect : 0;

LUT2 #(
   .INIT(4'b0001)
) ro (
   .I0(connect),
   .I1(1'b0),
   .O(out)
);
endmodule
""" > $FILE_NAME

### TOP OF MODULE ###
echo """ 
module eightbitadd ( 
      input wire [31:0] a,
      input wire [31:0] b,
      input c_in,
      output reg c_out,
      output reg[31:0] sum,
      input clk,);

   always @ (posedge clk) begin
      {c_out, sum} = a + b + c_in;
   end
endmodule

module doubleeightbitadd (
   input wire [31:0] a1,
   input wire [31:0] a2,
   input wire [31:0] b1,
   input wire [31:0] b2,
   output wire [31:0] sum,
   input clk,);

wire [31:0] sum1;
wire [31:0] sum2;

 eightbitadd add1(
   .a(a1),
   .b(a2),
   .c_in(1'b0),
   .sum(sum1),
   .clk(clk),
);

 eightbitadd add2(
   .a(b1),
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
   input wire [31:0] a1,
   input wire [31:0] a2,
   input wire [31:0] a3,
   input wire [31:0] a4,
   input wire [31:0] b1,
   input wire [31:0] b2,
   input wire [31:0] b3,
   input wire [31:0] b4,
   output wire[31:0] sum,
   input clk,
);

reg [31:0] sum1;
reg [31:0] sum2;

doubleeightbitadd add1(
   .a1(a1),
   .a2(a2),
   .b1(a3),
   .b2(a4),
   .clk(clk),
   .sum(sum1),
);

doubleeightbitadd add2(
   .a1(b1),
   .a2(b2),
   .b1(b3),
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
   input wire[31:0] a1,
   input wire[31:0] a2,
   input wire[31:0] a3,
   input wire[31:0] a4,
   input wire[31:0] a5,
   input wire[31:0] a6,
   input wire[31:0] a7,
   input wire[31:0] a8,
   input wire[31:0] b1,
   input wire[31:0] b2,
   input wire[31:0] b3,
   input wire[31:0] b4,
   input wire[31:0] b5,
   input wire[31:0] b6,
   input wire[31:0] b7,
   input wire[31:0] b8,
   output wire[31:0] sum,
   input clk,
);

reg [31:0] sum1;
reg [31:0] sum2;

 quadeightbitadd add1(
   .a1(a1),
   .a2(a2),
   .a3(a3),
   .a4(a4),
   .b1(a5),
   .b2(a6),
   .b3(a7),
   .b4(a8),
   .clk(clk),
   .sum(sum1),
);

 quadeightbitadd add2(
   .a1(b1),
   .a2(b2),
   .a3(b3),
   .a4(b4),
   .b1(b5),
   .b2(b6),
   .b3(b7),
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

module hexaeightbitadd (
   input wire [31:0] a1,
   input wire [31:0] a2,
   input wire [31:0] a3,
   input wire [31:0] a4,
   input wire [31:0] a5,
   input wire [31:0] a6,
   input wire [31:0] a7,
   input wire [31:0] a8,
   input wire [31:0] a9,
   input wire [31:0] a10,
   input wire [31:0] a11,
   input wire [31:0] a12,
   input wire [31:0] a13,
   input wire [31:0] a14,
   input wire [31:0] a15,
   input wire [31:0] a16,
   input wire [31:0] b1,
   input wire [31:0] b2,
   input wire [31:0] b3,
   input wire [31:0] b4,
   input wire [31:0] b5,
   input wire [31:0] b6,
   input wire [31:0] b7,
   input wire [31:0] b8,
   input wire [31:0] b9,
   input wire [31:0] b10,
   input wire [31:0] b11,
   input wire [31:0] b12,
   input wire [31:0] b13,
   input wire [31:0] b14,
   input wire [31:0] b15,
   input wire [31:0] b16,
   output wire[31:0] sum,
   input clk,
);

reg [31:0] sum1;
reg [31:0] sum2;

 octaeightbitadd add1(
   .a1(a1),
   .a2(a2),
   .a3(a3),
   .a4(a4),
   .a5(a5),
   .a6(a6),
   .a7(a7),
   .a8(a8),
   .b1(a9),
   .b2(a10),
   .b3(a11),
   .b4(a12),
   .b5(a13),
   .b6(a14),
   .b7(a15),
   .b8(a16),
   .clk(clk),
   .sum(sum1),
);

 octaeightbitadd add2(
   .a1(b1),
   .a2(b2),
   .a3(b3),
   .a4(b4),
   .a5(b5),
   .a6(b6),
   .a7(b7),
   .a8(b8),
   .b1(b9),
   .b2(b10),
   .b3(b11),
   .b4(b12),
   .b5(b13),
   .b6(b14),
   .b7(b15),
   .b8(b16),
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
   input inw,
   output outw,
);

// Initialize 48MHz clock
wire                                    CLK        ;
wire                                    CLK_RST    ;
reg         [31:0]                      counter    ;
reg         [31:0]                      sum        ;

reg outw;

qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
    // FB Clocks
    .Sys_Clk0                  ( CLK                       ), // output
    .Sys_Clk0_Rst              ( CLK_RST                   ), // output
);

// Initialize "Normal" program
reg [31:0] v1;
reg [31:0] v2;
reg [31:0] v3;
reg [31:0] v4;
reg [31:0] v5;
reg [31:0] v6;
reg [31:0] v7;
reg [31:0] v8;
reg [31:0] v9;
reg [31:0] v10;
reg [31:0] v11;
reg [31:0] v12;
reg [31:0] v13;
reg [31:0] v14;
reg [31:0] v15;
reg [31:0] v16;
reg [31:0] v17;
reg [31:0] v18;
reg [31:0] v19;
reg [31:0] v20;
reg [31:0] v21;
reg [31:0] v22;
reg [31:0] v23;
reg [31:0] v24;
reg [31:0] v25;
reg [31:0] v26;
reg [31:0] v27;
reg [31:0] v28;
reg [31:0] v29;
reg [31:0] v30;
reg [31:0] v31;
reg [31:0] v32;

initial begin
   // Initialize values
   v1 <= 1;
   v2 <= 2;
   v3 <= 3;
   v4 <= 4;
   v5 <= 5;
   v6 <= 6;
   v7 <= 7;
   v8 <= 8;
   v9 <= 9;
   v10 <= 10;
   v11 <= 11;
   v12 <= 12;
   v13 <= 13;
   v14 <= 14;
   v15 <= 15;
   v16 <= 16;
   v17 <= 17;
   v18 <= 18;
   v19 <= 19;
   v20 <= 20;
   v21 <= 21;
   v22 <= 22;
   v23 <= 23;
   v24 <= 24;
   v25 <= 25;
   v26 <= 26;
   v27 <= 27;
   v28 <= 28;
   v29 <= 29;
   v30 <= 30;
   v31 <= 31;
   v32 <= 32;
   // Initialize counter
   counter <= 0;
end

hexaeightbitadd add1 (
   .a1(v1),
   .a2(v2),
   .a3(v3),
   .a4(v4),
   .a5(v5),
   .a6(v6),
   .a7(v7),
   .a8(v8),
   .a9(v9),
   .a10(v10),
   .a11(v11),
   .a12(v12),
   .a13(v13),
   .a14(v14),
   .a15(v15),
   .a16(v16),
   .b1(v17),
   .b2(v18),
   .b3(v19),
   .b4(v20),
   .b5(v21),
   .b6(v22),
   .b7(v23),
   .b8(v24),
   .b9(v25),
   .b10(v26),
   .b11(v27),
   .b12(v28),
   .b13(v29),
   .b14(v30),
   .b15(v31),
   .b16(v32),
   .sum(sum),
   .clk(CLK)
);

always @(posedge CLK) begin
   if (counter < 10000000) begin // Approx 1x every second
      counter <= counter + 1;
   end
   else begin
      if (inw) begin 
         v1 <= 1;
      end
      else begin
         v1 <= 30;
      end
      counter <= 0;
      if (sum == 528) begin // Check if correct value is computed
         outw <= 1;
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