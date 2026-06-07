module curve_stx_ve_564_20260111_182334_486824_w47100_attempt8 (
    input wire clk,
    input wire reset_n,
    input wire [3:0] data_in,
    output reg parity_out
);

    // Function definition missing 'endfunction'
    function [0:0] calculate_parity; // Output is 1-bit for parity
        input [3:0] value;
        begin
            calculate_parity = value[0] ^ value[1] ^ value[2] ^ value[3];
        end
    // The 'endfunction' keyword is intentionally omitted here to trigger STX_VE_564.

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            parity_out <= 1'b0;
        end else begin
            parity_out <= calculate_parity(data_in);
        end
    end

endmodule
