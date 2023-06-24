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

wire [44:0] out;

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

latch_ro ro21(
   .en(en),
   .out(out[20]),
);

latch_ro ro22(
   .en(en),
   .out(out[21]),
);

latch_ro ro23(
   .en(en),
   .out(out[22]),
);

latch_ro ro24(
   .en(en),
   .out(out[23]),
);

latch_ro ro25(
   .en(en),
   .out(out[24]),
);

latch_ro ro26(
   .en(en),
   .out(out[25]),
);

latch_ro ro27(
   .en(en),
   .out(out[26]),
);

latch_ro ro28(
   .en(en),
   .out(out[27]),
);

latch_ro ro29(
   .en(en),
   .out(out[28]),
);

latch_ro ro30(
   .en(en),
   .out(out[29]),
);

latch_ro ro31(
   .en(en),
   .out(out[30]),
);

latch_ro ro32(
   .en(en),
   .out(out[31]),
);

latch_ro ro33(
   .en(en),
   .out(out[32]),
);

latch_ro ro34(
   .en(en),
   .out(out[33]),
);

latch_ro ro35(
   .en(en),
   .out(out[34]),
);

latch_ro ro36(
   .en(en),
   .out(out[35]),
);

latch_ro ro37(
   .en(en),
   .out(out[36]),
);

latch_ro ro38(
   .en(en),
   .out(out[37]),
);

latch_ro ro39(
   .en(en),
   .out(out[38]),
);

latch_ro ro40(
   .en(en),
   .out(out[39]),
);

latch_ro ro41(
   .en(en),
   .out(out[40]),
);

latch_ro ro42(
   .en(en),
   .out(out[41]),
);

latch_ro ro43(
   .en(en),
   .out(out[42]),
);

latch_ro ro44(
   .en(en),
   .out(out[43]),
);

latch_ro ro45(
   .en(en),
   .out(out[44]),
);

assign io_pad[13] = |out;
endmodule
