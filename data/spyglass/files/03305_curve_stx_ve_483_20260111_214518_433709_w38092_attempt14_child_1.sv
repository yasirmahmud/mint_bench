module curve_stx_ve_483_20260111_214518_433709_w38092_attempt14 (
    input wire clk,
    input wire rst_n,
    output reg operation_out
);

    // STX_VE_483: The enum pragma must include a size (bit-width) specification
    // This 'parameter' declaration uses a 'synopsys enum' pragma but lacks the required
    // bit-width specification within the comment, e.g., '[1]' or '[2]'.
    parameter /* synopsys enum operation_codes [1] */ OP_READ = 1'b0, OP_WRITE = 1'b1;

    // Use the parameters to avoid unused parameter warnings and provide minimal functionality.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            operation_out <= OP_READ; // Assign a default value on reset
        end else begin
            operation_out <= OP_WRITE; // Simple assignment to use the parameter
        end
    end

endmodule
