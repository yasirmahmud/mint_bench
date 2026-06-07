module ff_sre_32 (
    output reg [31:0] out,
    input      [31:0] din,
    input             clk,
    input             enable,
    input             reset_l
);
    always @(posedge clk or negedge reset_l) begin
        if (!reset_l) out <= 32'b0;
        else if (enable) out <= din;
    end
endmodule
