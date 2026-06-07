module curve_stx_ve_776_20260111_054830_attempt9 (
    input wire clk,
    input wire reset,
    input wire in_data,
    output reg out_data
);

    reg internal_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            internal_reg <= 1'b0;
        end else begin
            internal_reg <= in_data;

            // STX_VE_776: Always statement not allowed in this scope
            // An 'always' block cannot be nested inside another 'always' block.
            always @(*) begin // This line should trigger STX_VE_776
                out_data = internal_reg;
            end
        end
    end

endmodule
