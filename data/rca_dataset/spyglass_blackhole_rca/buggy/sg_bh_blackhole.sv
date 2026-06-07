module sg_bh_blackhole #(
    parameter int DATA_W = 32
) (
    input  logic [DATA_W-1:0] src0,
    input  logic [DATA_W-1:0] src1,
    input  logic [DATA_W-1:0] src2,
    input  logic [DATA_W-1:0] src3,
    input  logic [DATA_W-1:0] src4,
    input  logic [DATA_W-1:0] src5,
    input  logic [DATA_W-1:0] src6,
    input  logic [DATA_W-1:0] src7,
    input  logic [DATA_W-1:0] src8,
    input  logic [DATA_W-1:0] src9,
    output logic [DATA_W-1:0] sink0,
    output logic [DATA_W-1:0] sink1,
    output logic [DATA_W-1:0] sink2,
    output logic [DATA_W-1:0] sink3,
    output logic [DATA_W-1:0] sink4,
    output logic [DATA_W-1:0] sink5,
    output logic [DATA_W-1:0] sink6,
    output logic [DATA_W-1:0] sink7,
    output logic [DATA_W-1:0] sink8,
    output logic [DATA_W-1:0] sink9
);
    always_comb begin
        sink0 = src0 + 32'h1;
        sink1 = src1 ^ 32'hA5A5_A5A5;
        sink2 = {src2[DATA_W-2:0], src2[DATA_W-1]};
        sink3 = ~src3;
        sink4 = src4 + src5;
        sink5 = src5 - src6;
        sink6 = src6 ^ src7;
        sink7 = src7 | src8;
        sink8 = src8 & src9;
        sink9 = src9 + 32'h1234_5678;
    end
endmodule
