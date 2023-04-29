#!/bin/bash

FILE_NAME='OSCILLATOR_top.txt'
AMOUNT=$1

echo "Generating ${1} ROs consisting of 3 inverters"

echo """
module OSCILLATOR_top(
   // LEDs from constraint file
   usr_btn,
   green_led
);

input       wire            usr_btn              ;
output      wire            green_led            ;

wire connectWire0;
assign usr_btn = connectWire0; """ > $FILE_NAME

for i in $( eval echo {1..$AMOUNT} )
do
prev=$((i-1));
echo """
wire connectWire${i};
inv invert${i} (
   .A(connectWire${prev}),
   .Q(connectWire${i})
);""" >> $FILE_NAME
done

echo "assign green_led = connectWire${i};" >> $FILE_NAME

echo 'endmodule' >> $FILE_NAME

mv $FILE_NAME 'fpga/rtl/OSCILLATOR_top.v'