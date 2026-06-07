module curve_stx_ve_467_20260110_194250_attempt7 (
    input wire [7:0] data_in,
    output wire [7:0] result_out
);

// Function 1 definition: returns a packed 8-bit value
function automatic [7:0] my_function_1;
    input [7:0] input_data_1;
    // Declare an unpacked array *local* to the function
    reg [7:0] temp_unpacked_array_1 [0:1]; // Unpacked array of two 8-bit elements

    begin
        // Populate the unpacked array
        temp_unpacked_array_1[0] = input_data_1;
        temp_unpacked_array_1[1] = input_data_1 + 1;

        // STX_VE_467 violation 1: Non-equivalent data types in assignment operation.
        // The function return value 'my_function_1' is a packed [7:0] reg.
        // 'temp_unpacked_array_1' is an unpacked array. These are fundamentally
        // different types that cannot be directly assigned.
        my_function_1 = temp_unpacked_array_1;
    end
endfunction

// Function 2 definition: also returns a packed 8-bit value
function automatic [7:0] my_function_2;
    input [7:0] input_data_2;
    // Declare another unpacked array *local* to this function
    reg [7:0] another_unpacked_array [0:3]; // Unpacked array of four 8-bit elements

    integer i;
    begin
        // Populate the unpacked array
        for (i=0; i<4; i=i+1) begin
            another_unpacked_array[i] = input_data_2 + i*2;
        end

        // STX_VE_467 violation 2: Non-equivalent data types in assignment operation.
        // Similar to above, assigning an unpacked array to a packed function return type.
        my_function_2 = another_unpacked_array;
    end
endfunction

// Use both functions to prevent unused signal warnings for data_in and the functions themselves.
// This also provides a meaningful use for the outputs of the functions.
assign result_out = my_function_1(data_in) + my_function_2(data_in);

endmodule
