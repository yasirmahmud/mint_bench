// Behavioral model for 32-bit scan-enabled flip-flop
// This model reflects the ports used in the instantiation. Scan ports (sin, so, sm) are not part of the instance interface.
module ff_se_32 (output [31:0] out,
                 input [31:0] din,
                 input clk,
                 input enable);
    reg [31:0] q_reg;
    always @(posedge clk) begin
        if (enable) q_reg <= din;
    end
    assign out = q_reg;
endmodule
