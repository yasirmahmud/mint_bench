// Behavioral model for 30-bit scan-enabled flip-flop
// This model reflects the ports used in the instantiation. Scan ports (sin, so, sm) are not part of the instance interface.
module ff_se_30 (output [29:0] out,
                 input [29:0] din,
                 input enable,
                 input clk);
    reg [29:0] q_reg;
    always @(posedge clk) begin
        if (enable) q_reg <= din;
    end
    assign out = q_reg;
endmodule
