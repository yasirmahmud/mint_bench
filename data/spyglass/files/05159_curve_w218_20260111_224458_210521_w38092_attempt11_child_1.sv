module curve_w218_20260111_224458_210521_w38092_attempt11 (
    input [2:0] data_bus,
    input rst_n,
    output reg out_reg
);

    // Fix for W218 violation: Replaced 'posedge data_bus' with 'posedge data_bus[0]'
    // to use a single-bit expression for the clock, resolving SYNTH_5405 and W218.
    always @(posedge data_bus[0] or negedge rst_n) begin
        if (!rst_n) begin
            out_reg <= 1'b0;
        end else begin
            // Simple assignment to ensure the 'always' block has a synthesizable action
            // and 'data_bus' and 'out_reg' are used.
            out_reg <= data_bus[0];
        end
    end

endmodule
