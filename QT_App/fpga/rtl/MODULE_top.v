
module MODULE_top(
   io_pad
);

// GPIO
inout       wire    [31:0]      io_pad          ;

wire connectWire0;
assign io_pad[6] = connectWire0; 

assign io_pad[21] = connectWire{1..None};
endmodule
