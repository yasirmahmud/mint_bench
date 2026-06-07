module curve_stx_ve_776_20260111_054830_attempt3 (
    input wire clk,
    input wire [7:0] data_in,
    output wire [7:0] data_out
);

    // Verilog functions are strictly combinational and cannot contain 'always' blocks.
    // Placing an 'always' block here is an illegal construct that triggers STX_VE_776.
    function [7:0] my_function (input [7:0] func_data_in);
        reg [7:0] func_local_reg; // Local to the function

        // This 'always' block is the direct cause of STX_VE_776: "Always statement not allowed in this scope".
        always @(posedge clk) begin // Violation STX_VE_776 is expected on this line
            func_local_reg = func_data_in + 1;
        end

        my_function = func_local_reg;
    endfunction

    assign data_out = my_function(data_in);

endmodule
