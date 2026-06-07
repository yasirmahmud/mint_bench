module mj_s_ff_s_d_32 (
    output reg [31:0] out,
    input      [31:0] din,
    input             clk
);
    always @(posedge clk) out <= din;
endmodule
