module curve_stx_ve_467_20260110_194250_attempt10 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output reg [7:0] output_a,
    output reg [7:0] output_b
);

// Violation 1: Function declared to return a multi-bit packed vector, but assigned an unpacked array.
// This is a direct type mismatch between a single packed object and a collection of objects.
function automatic [7:0] func_assign_unpacked_array;
    input [7:0] input_val;
    // Declare a local unpacked array of 2 elements, each 8 bits wide.
    reg [7:0] local_unpacked_array [1:0];
begin
    local_unpacked_array[0] = input_val + 1;
    local_unpacked_array[1] = input_val + 2;
    // FATAL: STX_VE_467 expected here.
    // Assignment of an unpacked array (reg [7:0] [1:0]) to a packed vector return value (reg [7:0]).
    // FIX: Assign one element of the unpacked array to match the packed vector return type.
    func_assign_unpacked_array = local_unpacked_array[0];
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_a <= 8'h0;
    end else begin
        // The STX_VE_467 error occurs inside the function definition, not at its usage.
        output_a <= func_assign_unpacked_array(data_in_a);
    end
}

// Violation 2: Function declared to return a multi-bit packed vector, but assigned a single-bit scalar.
// This is a fundamental type mismatch between a 1-bit scalar and an 8-bit packed vector.
function automatic [7:0] func_assign_single_bit_scalar;
    input [7:0] input_val;
    // Declare a local single-bit scalar register.
    reg local_scalar_bit;
begin
    local_scalar_bit = input_val[0]; // Assign LSB to the 1-bit scalar
    // FATAL: STX_VE_467 expected here.
    // Assignment of a 1-bit scalar (reg) to an 8-bit packed vector return value (reg [7:0]).
    func_assign_single_bit_scalar = local_scalar_bit;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_b <= 8'h0;
    end else begin
        // The STX_VE_467 error occurs inside the function definition.
        output_b <= func_assign_single_bit_scalar(data_in_b);
    end
end

endmodule
