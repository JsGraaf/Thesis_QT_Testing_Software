module latch_ro(
   input en,
   output out,
);

(*keep*)wire connect;

assign connect = en ? connect : 0;
assign out = en ? connect : 0;

dffp ro (
   .D(1'b0),
   .CLK(connect),
   .PRE(!connect),
   .Q(connect),
);
endmodule

 
module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;

wire [4:0] out;

reg en;
initial begin
   en <= 1;
end

latch_ro ro1(
   .en(en),
   .out(out[4:0]),
);

latch_ro ro2(
   .en(en),
   .out(out[4:0]),
);

latch_ro ro3(
   .en(en),
   .out(out[4:0]),
);

latch_ro ro4(
   .en(en),
   .out(out[4:0]),
);

latch_ro ro5(
   .en(en),
   .out(out[4:0]),
);

assign io_pad[13] = |out;
endmodule
