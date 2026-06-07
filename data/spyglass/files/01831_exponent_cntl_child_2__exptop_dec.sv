// Stub module definitions to resolve ErrorAnalyzeBBox violations
module exptop_dec(
    output [1:0] mux1ad, mux2ad, mux2bd,
    output addtcin, addlcin,
    input [3:0] ef, ef_rom0, ef_rom1,
    input [1:0] romsel,
    input clk, reset_l, fpuhold_l,
    input [2:0] saf,
    input sm, sin,
    output so
);
    // Assign default values to outputs to satisfy linting rules for unconnected outputs
    assign mux1ad = 2'b0;
    assign mux2ad = 2'b0;
    assign mux2bd = 2'b0;
    assign addtcin = 1'b0;
    assign addlcin = 1'b0;
    assign so = 1'b0;

    // Dummy assignment to consume unused inputs and resolve W240 violations
    wire _dummy_exptop_unused;
    assign _dummy_exptop_unused = |ef | |ef_rom0 | |ef_rom1 | |romsel | clk | reset_l | fpuhold_l | |saf | sm | sin;
endmodule
