module curve_stx_ve_467_20260110_194250_attempt12 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output reg [7:0] output_a,
    output reg [7:0] output_b
);

// Violation 1: Function declared to return a packed vector (reg [7:0]), but assigned a 'time' data type.
// 'time' is a 64-bit unsigned integer type, fundamentally distinct from a bit-vector 'reg'.
function automatic [7:0] func_time_to_reg;
    input [7:0] input_val; // Used to avoid unused input warning
    time local_time_val;
begin
    // Use input_val to prevent unused signal warning and ensure operation
    local_time_val = $time + input_val; // Operation to use input_val and generate a time value
    // FATAL: STX_VE_467 - Non-equivalent data types in assignment operation.
    // Attempting to assign a 'time' type (64-bit unsigned) to a packed 'reg [7:0]' return value.
    func_time_to_reg = local_time_val;
end
endfunction

// Violation 2: Function declared to return an 'integer', but assigned a 'real' data type.
// 'integer' is a signed 32-bit type, and 'real' is a floating-point type.
// Direct assignment of 'real' to 'integer' without explicit casting is a non-equivalent type operation.
function automatic integer func_real_to_integer;
    input [7:0] input_val; // Used to avoid unused input warning
    real local_real_val;
begin
    // Use input_val to prevent unused signal warning and ensure operation
    local_real_val = 3.14159 * input_val; // Operation to use input_val and generate a real value
    // FATAL: STX_VE_467 - Non-equivalent data types in assignment operation.
    // Attempting to assign a 'real' type to an 'integer' return value.
    func_real_to_integer = local_real_val;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_a <= 8'h0;
        output_b <= 8'h0;
    end else begin
        // The function func_time_to_reg returns reg [7:0]. The internal violation is contained.
        // This assignment to output_a is type-compatible externally.
        output_a <= func_time_to_reg(data_in_a);

        // The function func_real_to_integer returns integer.
        // This assignment to output_b is type-compatible externally (integer to reg [7:0] involves width truncation/extension).
        output_b <= func_real_to_integer(data_in_b);
    end
end

endmodule
