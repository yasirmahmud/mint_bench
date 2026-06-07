module curve_stx_ve_467_20260110_194250_attempt13 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    output reg [7:0] output_a,
    output reg [31:0] output_b
);

// Violation 1: Function declared to return a packed vector (reg [7:0]),
// but assigned an entire unpacked array (reg [7:0] [0:1]).
// This is a fundamental type mismatch between a single packed vector and a collection of such vectors.
function automatic [7:0] func_packed_ret_unpacked_assign;
    input [7:0] input_val; // Used to avoid unused input warning
    reg [7:0] my_unpacked_array [0:1]; // Declare an unpacked array
begin
    my_unpacked_array[0] = input_val;
    my_unpacked_array[1] = input_val + 1;
    // FATAL STX_VE_467: Non-equivalent data types in assignment operation.
    // Assigning unpacked array 'my_unpacked_array' to packed vector 'func_packed_ret_unpacked_assign'.
    func_packed_ret_unpacked_assign = my_unpacked_array;
end
endfunction

// Violation 2: Function declared to return an integer,
// but assigned an entire unpacked array (reg [7:0] [0:1]).
// An 'integer' is a single 32-bit scalar value, distinct from a collection of elements.
function automatic integer func_integer_ret_unpacked_assign;
    input [7:0] input_val; // Used to avoid unused input warning
    reg [7:0] another_unpacked_array [0:1]; // Declare another unpacked array
begin
    another_unpacked_array[0] = input_val + 2;
    another_unpacked_array[1] = input_val + 3;
    // FATAL STX_VE_467: Non-equivalent data types in assignment operation.
    // Assigning unpacked array 'another_unpacked_array' to integer 'func_integer_ret_unpacked_assign'.
    func_integer_ret_unpacked_assign = another_unpacked_array;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_a <= 8'h0;
        output_b <= 32'h0;
    end else begin
        output_a <= func_packed_ret_unpacked_assign(data_in_a);
        output_b <= func_integer_ret_unpacked_assign(data_in_a);
    end
end

endmodule
