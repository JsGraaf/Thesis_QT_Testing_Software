#!/bin/bash

FILE_NAME='OSCILLATOR_top.txt'

echo """
module OSCILLATOR_top(
   // LEDs from constraint file
   usr_btn,
   green_led,
   output_1
);

input       wire           usr_btn              ;
output      wire           green_led            ;
output      wire           output_1             ;

qlal4s3b_cell_macro u_qlal4s3b_cell_macro (
   .Sys_Clk0 (clk),
);

reg [31:0] counter;
wire LED_status;
""" > $FILE_NAME

echo """
(* keep = \"true\" *) wire lut_0_connect;
(* keep = \"true\" *) LUT2 #(
   .INIT(4'h0011)
) lut0 (
   .I0(usr_btn),
   .I1(LED_status),
   .O(lut_0_connect)
);""" >> $FILE_NAME

for i in {1..1}
do
   prev=$((i-1));
   echo """
(* keep = \"true\" *) wire lut_${i}_connect;
(* keep = \"true\" *) LUT2 #(
   .INIT(4'h0011)
) lut$i (
   .I0(usr_btn),
   .I1(lut_${prev}_connect),
   .O(lut_${i}_connect)
);""" >> $FILE_NAME
done

echo """
(* keep = \"true\" *) wire loop;
(* keep = \"true\" *) LUT2 #(
   .INIT(4'h0011)
) lut$((i+1)) (
   .I0(usr_btn),
   .I1(lut_${i}_connect),
   .O(LED_status)
);""" >> $FILE_NAME

echo """

assign green_led = LED_status;
""" >> $FILE_NAME



echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME 'fpga/rtl/OSCILLATOR_top.v'