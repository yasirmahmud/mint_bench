module mj_s_ff_snre_d_2 (
    output reg [1:0] out,
    input [1:0] din,
    input reset_l,
    input clk,
    input lenable
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) begin
            out <= 2'h0;
        end else if (lenable) {
            out <= din;
        }
    end
endmodule
