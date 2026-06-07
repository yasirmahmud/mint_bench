module child_module (
    input clk,
    output reg output_data
);
    parameter DELAY_PARAM = 1; // An integer parameter

    initial begin
        output_data = 1'b0; // Initialize output to avoid uninitialized register warnings
    end

    // Minimal logic to use ports and avoid unused signal warnings
    always @(posedge clk) begin
        output_data <= ~output_data; // Simple toggle logic
    end

endmodule
