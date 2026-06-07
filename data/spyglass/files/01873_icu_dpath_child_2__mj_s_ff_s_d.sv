module mj_s_ff_s_d (
    output reg out,
    input      in,
    input      clk
);
    always @(posedge clk) out <= in;
endmodule
