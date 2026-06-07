module curve_stx_ve_467_20260110_194250_attempt8 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in,
    output reg [7:0] result_out_a,
    output reg [7:0] result_out_b
);

// Declare a real variable. Real types are distinct from integer/reg types.
real r_value_1;

// Declare an internal register that is an integer type.
reg [7:0] integer_target_1;

// Function that returns a real value.
function automatic real get_real_value_func;
    input [7:0] dummy_input; // Used to prevent unused signal warning for data_in and to make function distinct.
    begin
        // The result is a real number, influenced by dummy_input.
        // $ITOR converts an integer to a real type.
        get_real_value_func = 2.71828 + ($ITOR(dummy_input) / 256.0);
    end
endfunction

// Initialize the real variable.
initial begin
    r_value_1 = 1.618;
end

// Violation 1: Assignment of a 'real' type to an 'integer' (reg) type.
// The left-hand side 'integer_target_1' is a 'reg [7:0]', which is an integer data type.
// The right-hand side 'r_value_1' is a 'real' data type.
// These are non-equivalent data types for direct assignment, expected to trigger STX_VE_467.
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        integer_target_1 <= 8'd0;
    end else begin
        integer_target_1 <= r_value_1; // FATAL: STX_VE_467 expected here
    end
end

// Violation 2: Assignment of a function returning 'real' to an 'integer' (reg) type.
// The left-hand side 'result_out_b' is a 'reg [7:0]', an integer data type.
// The right-hand side 'get_real_value_func(data_in)' returns a 'real' data type.
// This is another instance of non-equivalent data types in assignment, expected to trigger STX_VE_467.
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        result_out_b <= 8'd0;
    end else begin
        result_out_b <= get_real_value_func(data_in); // FATAL: STX_VE_467 expected here
    end
end

// Use 'integer_target_1' and 'data_in' to prevent any 'unused signal' warnings.
assign result_out_a = integer_target_1 + data_in;

endmodule
