
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

wire connectWire2;
inv invert2 (
   .A(connectWire1),
   .Q(connectWire2)
);

wire connectWire3;
inv invert3 (
   .A(connectWire2),
   .Q(connectWire3)
);

wire connectWire4;
inv invert4 (
   .A(connectWire3),
   .Q(connectWire4)
);

wire connectWire5;
inv invert5 (
   .A(connectWire4),
   .Q(connectWire5)
);

wire connectWire6;
inv invert6 (
   .A(connectWire5),
   .Q(connectWire6)
);

wire connectWire7;
inv invert7 (
   .A(connectWire6),
   .Q(connectWire7)
);

wire connectWire8;
inv invert8 (
   .A(connectWire7),
   .Q(connectWire8)
);

wire connectWire9;
inv invert9 (
   .A(connectWire8),
   .Q(connectWire9)
);

wire connectWire10;
inv invert10 (
   .A(connectWire9),
   .Q(connectWire10)
);

wire connectWire11;
inv invert11 (
   .A(connectWire10),
   .Q(connectWire11)
);

wire connectWire12;
inv invert12 (
   .A(connectWire11),
   .Q(connectWire12)
);

wire connectWire13;
inv invert13 (
   .A(connectWire12),
   .Q(connectWire13)
);

wire connectWire14;
inv invert14 (
   .A(connectWire13),
   .Q(connectWire14)
);

wire connectWire15;
inv invert15 (
   .A(connectWire14),
   .Q(connectWire15)
);

assign io_pad[21] = connectWire15;
endmodule
