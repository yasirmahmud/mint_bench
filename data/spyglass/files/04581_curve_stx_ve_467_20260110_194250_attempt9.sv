module curve_stx_ve_467_20260110_194250_attempt9 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output reg [7:0] output_a,
    output reg [7:0] output_b
);

// Violation 1: Function declared to return a scalar, but assigned a packed array.
// This function is declared to return a single 8-bit value (scalar).
function automatic [7:0] func_scalar_return_mismatch;
    input [7:0] input_val;
    // Declare a local packed array of 2 elements, each 8 bits.
    reg [7:0] local_array [1:0]; 
begin
    local_array[0] = input_val + 1;
    local_array[1] = input_val + 2;
    // FATAL: STX_VE_467 expected here.
    // Assignment of a packed array (reg [7:0] [1:0]) to a scalar return value (reg [7:0]).
    func_scalar_return_mismatch = local_array;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_a <= 8'h0;
    end else begin
        output_a <= func_scalar_return_mismatch(data_in_a);
    end
end

// Violation 2: Function declared to return a packed array, but assigned a scalar.
// This function is declared to return a packed array of 2 elements, each 8 bits.
function automatic [1:0][7:0] func_array_return_mismatch;
    input [7:0] input_val;
    // Declare a local scalar reg.
    reg [7:0] local_scalar;
begin
    local_scalar = input_val + 3;
    // FATAL: STX_VE_467 expected here.
    // Assignment of a scalar (reg [7:0]) to a packed array return value (reg [1:0][7:0]).
    func_array_return_mismatch = local_scalar;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_b <= 8'h0;
    end else begin
        // The STX_VE_467 error occurs inside the function, not at its usage.
        output_b <= func_array_return_mismatch(data_in_b)[0];
    end
end

endmodule
