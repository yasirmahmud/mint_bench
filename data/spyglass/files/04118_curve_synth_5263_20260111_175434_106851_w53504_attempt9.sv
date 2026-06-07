module curve_synth_5263_20260111_175434_106851_w53504_attempt9 (
    input wire clk,
    input wire reset,
    input wire select_branch,
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
        if (select_branch) begin
            // First instance of SYNTH_5263: Fork and Join constructs are not synthesizable
            fork
                out_reg_a <= data_in_a;
            join
        end else begin
            // Second instance of SYNTH_5263: Fork and Join constructs are not synthesizable
            fork
                out_reg_b <= data_in_b;
            join
        end
    end
end

endmodule
