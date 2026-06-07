module curve_stx_ve_776_20260111_054830_attempt2 (
    input wire clk,
    output wire [7:0] out_signal
);

    // Functions are procedural blocks, but they cannot contain always blocks.
    // An always block within a function is an illegal placement.
    function [7:0] my_function (input [7:0] in_data);
        reg [7:0] temp_reg; // Declared within the function scope

        // This always block is placed inside a function, which is not allowed.
        // This exact placement triggers the STX_VE_776 violation.
        always @(posedge clk) begin
            temp_reg = in_data + 1; // This logic attempts to use clk and in_data
        end

        my_function = temp_reg; // Assign the function's return value
    endfunction

    assign out_signal = my_function(8'hAB);

endmodule
