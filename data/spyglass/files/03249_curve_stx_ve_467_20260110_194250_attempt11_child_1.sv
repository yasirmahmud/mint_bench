module curve_stx_ve_467_20260110_194250_attempt11 (
    input wire clk,
    input wire reset_n,
    input wire [7:0] data_in_a,
    input wire [7:0] data_in_b,
    output reg [7:0] output_a,
    output reg [7:0] output_b
);

// Violation 1: Function declared to return a packed vector, but assigned a real data type.
// This is a fundamental type mismatch between an integer/vector type and a real type.
function automatic [7:0] func_real_to_packed_reg;
    input [7:0] input_val;
    real local_real_val;
begin
    // Valid: Implicit conversion from integer (input_val) to real is allowed.
    local_real_val = input_val;
    // FATAL: STX_VE_467 - Non-equivalent data types in assignment operation.
    // Attempting to assign a 'real' type to a packed 'reg [7:0]' return value.
    // FIX: Convert the real value back to an integer type using $rtoi.
    func_real_to_packed_reg = $rtoi(local_real_val);
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_a <= 8'h0;
    end else begin
        // The function itself returns reg [7:0], so this usage is type-compatible.
        output_a <= func_real_to_packed_reg(data_in_a);
    end
end

// Violation 2: Function declared to return a packed vector, but assigned an event data type.
// This is a fundamental type mismatch between an integer/vector type and an event handle.
function automatic [7:0] func_event_to_packed_reg;
    input [7:0] input_val;
    // Declare an event variable. Functions can declare local variables of any type.
    event local_event_handle;
begin
    // Using the input to ensure it's not unused, even if it's just an arbitrary operation.
    // This line doesn't affect the type mismatch; it just avoids an unused signal warning for input_val.
    if (input_val == 8'hFF) begin
        // do nothing, just use input_val
    end
    // FATAL: STX_VE_467 - Non-equivalent data types in assignment operation.
    // Attempting to assign an 'event' type to a packed 'reg [7:0]' return value.
    // FIX: An event handle cannot be converted to a packed vector. Assign a compatible [7:0] value.
    // The most functionally consistent value to assign is the input_val itself.
    func_event_to_packed_reg = input_val;
end
endfunction

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        output_b <= 8'h0;
    end else begin
        // The function itself returns reg [7:0], so this usage is type-compatible.
        output_b <= func_event_to_packed_reg(data_in_b);
    end
end

endmodule
