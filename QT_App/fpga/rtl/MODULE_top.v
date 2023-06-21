module not_3_ro(
   input en,
   output out,
);

assign connect[0] = en ? connect[3] : 0;
assign out = en ? connect[3] : 0;

(*keep*)wire [3:0] connect;

inv inv1 (
   .A(connect[0]),
   .Q(connect[1])
);

inv inv2 (
   .A(connect[1]),
   .Q(connect[2]),
);

inv inv3 (
   .A(connect[2]),
   .Q(connect[3])
);
endmodule

module MODULE_top(
   io_pad
);

// GPIO
inout    wire     [31:0]      io_pad      ;

wire [99:0] out;

reg en;
initial begin
   en <= 1;
end

not_3_ro ro0 (
   .en(en),
   .out(out[0]),
);

not_3_ro ro1 (
   .en(en),
   .out(out[1]),
);

not_3_ro ro2 (
   .en(en),
   .out(out[2]),
);

not_3_ro ro3 (
   .en(en),
   .out(out[3]),
);

not_3_ro ro4 (
   .en(en),
   .out(out[4]),
);

not_3_ro ro5 (
   .en(en),
   .out(out[5]),
);

not_3_ro ro6 (
   .en(en),
   .out(out[6]),
);

not_3_ro ro7 (
   .en(en),
   .out(out[7]),
);

not_3_ro ro8 (
   .en(en),
   .out(out[8]),
);

not_3_ro ro9 (
   .en(en),
   .out(out[9]),
);

not_3_ro ro10 (
   .en(en),
   .out(out[10]),
);

not_3_ro ro11 (
   .en(en),
   .out(out[11]),
);

not_3_ro ro12 (
   .en(en),
   .out(out[12]),
);

not_3_ro ro13 (
   .en(en),
   .out(out[13]),
);

not_3_ro ro14 (
   .en(en),
   .out(out[14]),
);

not_3_ro ro15 (
   .en(en),
   .out(out[15]),
);

not_3_ro ro16 (
   .en(en),
   .out(out[16]),
);

not_3_ro ro17 (
   .en(en),
   .out(out[17]),
);

not_3_ro ro18 (
   .en(en),
   .out(out[18]),
);

not_3_ro ro19 (
   .en(en),
   .out(out[19]),
);

not_3_ro ro20 (
   .en(en),
   .out(out[20]),
);

not_3_ro ro21 (
   .en(en),
   .out(out[21]),
);

not_3_ro ro22 (
   .en(en),
   .out(out[22]),
);

not_3_ro ro23 (
   .en(en),
   .out(out[23]),
);

not_3_ro ro24 (
   .en(en),
   .out(out[24]),
);

not_3_ro ro25 (
   .en(en),
   .out(out[25]),
);

not_3_ro ro26 (
   .en(en),
   .out(out[26]),
);

not_3_ro ro27 (
   .en(en),
   .out(out[27]),
);

not_3_ro ro28 (
   .en(en),
   .out(out[28]),
);

not_3_ro ro29 (
   .en(en),
   .out(out[29]),
);

not_3_ro ro30 (
   .en(en),
   .out(out[30]),
);

not_3_ro ro31 (
   .en(en),
   .out(out[31]),
);

not_3_ro ro32 (
   .en(en),
   .out(out[32]),
);

not_3_ro ro33 (
   .en(en),
   .out(out[33]),
);

not_3_ro ro34 (
   .en(en),
   .out(out[34]),
);

not_3_ro ro35 (
   .en(en),
   .out(out[35]),
);

not_3_ro ro36 (
   .en(en),
   .out(out[36]),
);

not_3_ro ro37 (
   .en(en),
   .out(out[37]),
);

not_3_ro ro38 (
   .en(en),
   .out(out[38]),
);

not_3_ro ro39 (
   .en(en),
   .out(out[39]),
);

not_3_ro ro40 (
   .en(en),
   .out(out[40]),
);

not_3_ro ro41 (
   .en(en),
   .out(out[41]),
);

not_3_ro ro42 (
   .en(en),
   .out(out[42]),
);

not_3_ro ro43 (
   .en(en),
   .out(out[43]),
);

not_3_ro ro44 (
   .en(en),
   .out(out[44]),
);

not_3_ro ro45 (
   .en(en),
   .out(out[45]),
);

not_3_ro ro46 (
   .en(en),
   .out(out[46]),
);

not_3_ro ro47 (
   .en(en),
   .out(out[47]),
);

not_3_ro ro48 (
   .en(en),
   .out(out[48]),
);

not_3_ro ro49 (
   .en(en),
   .out(out[49]),
);

not_3_ro ro50 (
   .en(en),
   .out(out[50]),
);

not_3_ro ro51 (
   .en(en),
   .out(out[51]),
);

not_3_ro ro52 (
   .en(en),
   .out(out[52]),
);

not_3_ro ro53 (
   .en(en),
   .out(out[53]),
);

not_3_ro ro54 (
   .en(en),
   .out(out[54]),
);

not_3_ro ro55 (
   .en(en),
   .out(out[55]),
);

not_3_ro ro56 (
   .en(en),
   .out(out[56]),
);

not_3_ro ro57 (
   .en(en),
   .out(out[57]),
);

not_3_ro ro58 (
   .en(en),
   .out(out[58]),
);

not_3_ro ro59 (
   .en(en),
   .out(out[59]),
);

not_3_ro ro60 (
   .en(en),
   .out(out[60]),
);

not_3_ro ro61 (
   .en(en),
   .out(out[61]),
);

not_3_ro ro62 (
   .en(en),
   .out(out[62]),
);

not_3_ro ro63 (
   .en(en),
   .out(out[63]),
);

not_3_ro ro64 (
   .en(en),
   .out(out[64]),
);

not_3_ro ro65 (
   .en(en),
   .out(out[65]),
);

not_3_ro ro66 (
   .en(en),
   .out(out[66]),
);

not_3_ro ro67 (
   .en(en),
   .out(out[67]),
);

not_3_ro ro68 (
   .en(en),
   .out(out[68]),
);

not_3_ro ro69 (
   .en(en),
   .out(out[69]),
);

not_3_ro ro70 (
   .en(en),
   .out(out[70]),
);

not_3_ro ro71 (
   .en(en),
   .out(out[71]),
);

not_3_ro ro72 (
   .en(en),
   .out(out[72]),
);

not_3_ro ro73 (
   .en(en),
   .out(out[73]),
);

not_3_ro ro74 (
   .en(en),
   .out(out[74]),
);

not_3_ro ro75 (
   .en(en),
   .out(out[75]),
);

not_3_ro ro76 (
   .en(en),
   .out(out[76]),
);

not_3_ro ro77 (
   .en(en),
   .out(out[77]),
);

not_3_ro ro78 (
   .en(en),
   .out(out[78]),
);

not_3_ro ro79 (
   .en(en),
   .out(out[79]),
);

not_3_ro ro80 (
   .en(en),
   .out(out[80]),
);

not_3_ro ro81 (
   .en(en),
   .out(out[81]),
);

not_3_ro ro82 (
   .en(en),
   .out(out[82]),
);

not_3_ro ro83 (
   .en(en),
   .out(out[83]),
);

not_3_ro ro84 (
   .en(en),
   .out(out[84]),
);

not_3_ro ro85 (
   .en(en),
   .out(out[85]),
);

not_3_ro ro86 (
   .en(en),
   .out(out[86]),
);

not_3_ro ro87 (
   .en(en),
   .out(out[87]),
);

not_3_ro ro88 (
   .en(en),
   .out(out[88]),
);

not_3_ro ro89 (
   .en(en),
   .out(out[89]),
);

not_3_ro ro90 (
   .en(en),
   .out(out[90]),
);

not_3_ro ro91 (
   .en(en),
   .out(out[91]),
);

not_3_ro ro92 (
   .en(en),
   .out(out[92]),
);

not_3_ro ro93 (
   .en(en),
   .out(out[93]),
);

not_3_ro ro94 (
   .en(en),
   .out(out[94]),
);

not_3_ro ro95 (
   .en(en),
   .out(out[95]),
);

not_3_ro ro96 (
   .en(en),
   .out(out[96]),
);

not_3_ro ro97 (
   .en(en),
   .out(out[97]),
);

not_3_ro ro98 (
   .en(en),
   .out(out[98]),
);

not_3_ro ro99 (
   .en(en),
   .out(out[99]),
);

assign io_pad[2] = |out;
endmodule
