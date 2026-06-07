module curve_w218_20260111_224458_210521_w38092_attempt11 (
    input [2:0] data_bus,
    input rst_n,
    output reg out_reg
);

    // W218 violation: Edge specification (posedge) should not be used
    // for a multibit expression ('data_bus' is 3 bits wide).
    // This triggers exactly one W218 violation.
    always @(posedge data_bus or negedge rst_n) begin
        if (!rst_n) begin
            out_reg <= 1'b0;
        end else begin
            // Simple assignment to ensure the 'always' block has a synthesizable action
            // and 'data_bus' and 'out_reg' are used.
            out_reg <= data_bus[0];
        end
    end

endmodule
