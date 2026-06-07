// Behavioral model for 32-bit standard flip-flop
// This model reflects the ports used in the instantiation.
module ff_s_32 (output [31:0] out,
                input [31:0] din,
                input clk);
    reg [31:0] q_reg;
    always @(posedge clk) begin
        q_reg <= din;
    end
    assign out = q_reg;
endmodule
