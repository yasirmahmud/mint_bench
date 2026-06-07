module curve_stx_ve_564_20260112_010718_533638_w25608_attempt14 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    // This function is intentionally missing its 'endfunction' keyword to trigger STX_VE_564.
    function [7:0] simple_increment;
        input [7:0] value;
        begin
            simple_increment = value + 8'd1;
        end
    endfunction // The 'endfunction' keyword is added here to resolve STX_VE_564.

    // This 'always' block is placed immediately after the incomplete function.
    // The parser is expected to find 'always' where 'endfunction' is required,
    // leading to the STX_VE_564 violation at this line.
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            data_out <= 8'h00;
        %BLANKLINE%
        end else begin
            data_out <= data_in; // Simple data path to avoid other rule violations.
        end
    end

endmodule
