
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

 
module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;

wire [2:0] out;

reg en;
initial begin
   en <= 1;
end


inv invBase (
   .A(io_pad[2]),
   .Q(io_pad[4])
);

assign io_pad[2] = |out;
endmodule
