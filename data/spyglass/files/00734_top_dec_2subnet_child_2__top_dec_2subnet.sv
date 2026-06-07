module top_dec_2subnet  (
    input clk,
    input reset,
    input [`WIDTH_PORT-1:0] dinW1,
    input [`WIDTH_PORT-1:0] dinE1,
    input [`WIDTH_PORT-1:0] dinS1,
    input [`WIDTH_PORT-1:0] dinN1,
    input [`WIDTH_PORT-1:0] dinLocal1,
    input [`WIDTH_PV-1:0] PVLocal1,
    output [`WIDTH_PORT-1:0] doutW1,
    output [`WIDTH_PORT-1:0] doutE1,
    output [`WIDTH_PORT-1:0] doutS1,
    output [`WIDTH_PORT-1:0] doutN1,
    output [`WIDTH_PORT-1:0] doutLocal1,
    input [`WIDTH_PORT-1:0] dinW2,
    input [`WIDTH_PORT-1:0] dinE2,
    input [`WIDTH_PORT-1:0] dinS2,
    input [`WIDTH_PORT-1:0] dinN2,
    input [`WIDTH_PORT-1:0] dinLocal2,
    input [`WIDTH_PV-1:0] PVLocal2,
    output [`WIDTH_PORT-1:0] doutW2,
    output [`WIDTH_PORT-1:0] doutE2,
    output [`WIDTH_PORT-1:0] doutS2,
    output [`WIDTH_PORT-1:0] doutN2,
    output [`WIDTH_PORT-1:0] doutLocal2
);


wire [`WIDTH_PORT-1:0] bypass [1:0];
wire [`WIDTH_PV-1:0] PVBypass [1:0];

top_dec dec_subrouter_1 (
    .clk(clk),
    .reset(reset),
    .dinW(dinW1),
    .dinE(dinE1),
    .dinS(dinS1),
    .dinN(dinN1),
    .dinLocal(dinLocal1),
    .dinBypass(bypass[1]),
    .PVBypass(PVBypass[1]),
    .PVLocal(PVLocal1),
    .doutW(doutW1),
    .doutE(doutE1),
    .doutS(doutS1),
    .doutN(doutN1),
    .doutLocal(doutLocal1),
    .doutBypass(bypass[0]),
    .PVOutBypass(PVBypass[0])
);

top_dec dec_subrouter_2 (
    .clk(clk),
    .reset(reset),
    .dinW(dinW2),
    .dinE(dinE2),
    .dinS(dinS2),
    .dinN(dinN2),
    .dinLocal(dinLocal2),
    .dinBypass(bypass[0]),
    .PVBypass(PVBypass[0]),
    .PVLocal(PVLocal2),
    .doutW(doutW2),
    .doutE(doutE2),
    .doutS(doutS2),
    .doutN(doutN2),
    .doutLocal(doutLocal2),
    .doutBypass(bypass[1]),
    .PVOutBypass(PVBypass[1])
);

endmodule
