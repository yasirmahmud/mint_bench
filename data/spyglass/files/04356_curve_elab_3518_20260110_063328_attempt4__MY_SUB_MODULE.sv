module MY_SUB_MODULE (
    input clk_in,
    output reg data_out
);
    parameter SAMPLE_PERIOD = 10; // An integer parameter

    // Minimal logic to use ports and avoid unused signal warnings
    always @(posedge clk_in) begin
        data_out <= 1'b0; // Simple assignment to use clk_in and data_out
    end

    initial begin
        data_out = 1'b0; // Initialize to avoid X-propagation warnings
    end

endmodule
