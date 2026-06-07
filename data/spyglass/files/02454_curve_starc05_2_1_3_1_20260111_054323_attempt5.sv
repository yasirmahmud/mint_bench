module curve_starc05_2_1_3_1_20260111_054323_attempt5 (
    input [39:0] data_in,
    output [319:0] data_out
);

    // Function that expects a 32-bit input and returns a 32-bit value.
    function [31:0] process_data;
        input [31:0] wide_input; // Function input is 32 bits
        begin
            process_data = wide_input + 10;
        end
    endfunction

    // Call the function 10 times, passing 4-bit slices from 'data_in' to the 32-bit function input.
    // Each call will trigger a STARC05-2.1.3.1 violation.
    // The argument (4 bits) has a bit-width mismatch with the function input 'wide_input' (32 bits).
    assign data_out[31:0]     = process_data(data_in[3:0]);     // Violation 1: 4-bit arg to 32-bit input
    assign data_out[63:32]    = process_data(data_in[7:4]);     // Violation 2
    assign data_out[95:64]    = process_data(data_in[11:8]);    // Violation 3
    assign data_out[127:96]   = process_data(data_in[15:12]);   // Violation 4
    assign data_out[159:128]  = process_data(data_in[19:16]);   // Violation 5
    assign data_out[191:160]  = process_data(data_in[23:20]);   // Violation 6
    assign data_out[223:192]  = process_data(data_in[27:24]);   // Violation 7
    assign data_out[255:224]  = process_data(data_in[31:28]);   // Violation 8
    assign data_out[287:256]  = process_data(data_in[35:32]);   // Violation 9
    assign data_out[319:288]  = process_data(data_in[39:36]);   // Violation 10

endmodule
