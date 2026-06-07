module curve_stx_ve_1201_20260112_002318_802554_w25608_attempt15 (
    input clk,
    input reset_n,
    input [7:0] data_in,
    output reg [7:0] data_out
);

    // STX_VE_1201 violation: The 'begin' label 'function_computation_block' does not match the 'end' label 'function_output_block_mismatch'.
    function [7:0] process_data_func;
        input [7:0] input_val;
        reg [7:0] processed_val;
        begin : function_computation_block // Start label for the function block
            processed_val = input_val ^ 8'hAA; // Simple bitwise operation
            process_data_func = processed_val; // Assign return value
        end : function_output_block_mismatch // Mismatched end label, causing STX_VE_1201
    endfunction

    // This always block uses the function and all module ports to prevent unused signal warnings.
    // Its own begin/end labels match, so it does not trigger a violation.
    always @(posedge clk or negedge reset_n) begin : main_processing_block
        if (!reset_n) begin
            data_out <= 8'h00;
        end else begin
            data_out <= process_data_func(data_in); // Call the function
        end
    end : main_processing_block

endmodule
