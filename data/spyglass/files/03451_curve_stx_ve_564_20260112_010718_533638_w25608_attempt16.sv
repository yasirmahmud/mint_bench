module curve_stx_ve_564_20260112_010718_533638_w25608_attempt16 (
    input wire clk,
    input wire reset_n,
    input wire [3:0] data_in,
    output reg parity_out
);

    // This function is intentionally missing its 'endfunction' keyword to trigger STX_VE_564.
    function [0:0] compute_parity;
        input [3:0] value_to_check;
        integer i;
        reg p_val;
        begin
            p_val = 1'b0; // Initialize for XOR reduction
            for (i=0; i<4; i=i+1) begin
                p_val = p_val ^ value_to_check[i];
            end
            compute_parity = p_val;
        end
    // The 'endfunction' keyword is explicitly omitted here, triggering STX_VE_564.

    // This 'always' block is placed immediately after the incomplete function definition.
    // SpyGlass is expected to flag the beginning of this 'always' block with STX_VE_564,
    // as 'endfunction' was expected at this location.
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            parity_out <= 1'b0;
        end else begin
            // Call the malformed function to ensure 'data_in' is used and avoid other warnings.
            // The actual result of this call is not critical for demonstrating STX_VE_564.
            parity_out <= compute_parity(data_in);
        end
    end

endmodule
