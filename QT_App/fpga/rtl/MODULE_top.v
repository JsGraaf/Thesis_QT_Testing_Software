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

wire [19:0] out;

reg en;
initial begin
   en <= 1;
end

latch_ro ro1(
   .en(en),
   .out(out[0]),
);

latch_ro ro2(
   .en(en),
   .out(out[1]),
);

latch_ro ro3(
   .en(en),
   .out(out[2]),
);

latch_ro ro4(
   .en(en),
   .out(out[3]),
);

latch_ro ro5(
   .en(en),
   .out(out[4]),
);

latch_ro ro6(
   .en(en),
   .out(out[5]),
);

latch_ro ro7(
   .en(en),
   .out(out[6]),
);

latch_ro ro8(
   .en(en),
   .out(out[7]),
);

latch_ro ro9(
   .en(en),
   .out(out[8]),
);

latch_ro ro10(
   .en(en),
   .out(out[9]),
);

latch_ro ro11(
   .en(en),
   .out(out[10]),
);

latch_ro ro12(
   .en(en),
   .out(out[11]),
);

latch_ro ro13(
   .en(en),
   .out(out[12]),
);

latch_ro ro14(
   .en(en),
   .out(out[13]),
);

latch_ro ro15(
   .en(en),
   .out(out[14]),
);

latch_ro ro16(
   .en(en),
   .out(out[15]),
);

latch_ro ro17(
   .en(en),
   .out(out[16]),
);

latch_ro ro18(
   .en(en),
   .out(out[17]),
);

latch_ro ro19(
   .en(en),
   .out(out[18]),
);

latch_ro ro20(
   .en(en),
   .out(out[19]),
);

assign io_pad[13] = |out;
endmodule
