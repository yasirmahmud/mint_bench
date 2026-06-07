module curve_stx_ve_1201_20260111_174643_397442_w7792_attempt10 (
    input [7:0] data_in,
    output [7:0] data_out
);

function [7:0] calculate_parity;
    input [7:0] value;
    reg [7:0] temp_val;
    // STX_VE_1201 violation: Begin block name 'func_body_begin_label' does not match with end label name 'func_body_end_label'
    begin : func_body_begin_label
        temp_val = value;
        // Perform a simple bitwise operation
        calculate_parity = temp_val ^ (temp_val >> 4) ^ (temp_val >> 2) ^ (temp_val >> 1);
    end : func_body_end_label
endfunction

assign data_out = calculate_parity(data_in);

endmodule
