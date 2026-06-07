module curve_synth_5263_20260111_175434_106851_w53504_attempt8 (
    input wire clk,
    input wire reset,
    input wire data_in_a,
    input wire data_in_b,
    output reg out_reg_a,
    output reg out_reg_b
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_reg_a <= 1'b0;
        out_reg_b <= 1'b0;
    end else begin
        // First instance of SYNTH_5263: Fork and Join constructs are not synthesizable
        fork
            out_reg_a <= data_in_a;
        join

        // Second instance of SYNTH_5263: Fork and Join constructs are not synthesizable
        fork
            out_reg_b <= data_in_b;
        join
    end
end

endmodule
