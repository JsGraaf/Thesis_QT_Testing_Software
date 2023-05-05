
module MODULE_top(
   io_pad
);

// GPIO
inout       wire    [31:0]      io_pad          ;

wire connectWire0;
assign io_pad[6] = connectWire0; 

wire connectWire1;
inv invert1 (
   .A(connectWire0),
   .Q(connectWire1)
);

wire connectWire0;
inv invert0 (
   .A(connectWire-1),
   .Q(connectWire0)
);

assign io_pad[21] = connectWire0;
endmodule
