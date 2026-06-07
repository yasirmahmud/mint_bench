module bottom_ex2(input clk, output reg result);
  parameter P = 1; // P remains unused, preserving original design intent.

  // SYNTH_5143: Initial block is ignored for synthesis.
  // Replaced 'reg num' and its 'initial' assignment with a 'localparam'.
  // Original 'initial' block set 'num = 5', so we maintain this value.
  localparam [3:0] FACTORIAL_INPUT_VAL = 5;

  // SYNTH_5230: Number of iterations in while-loop exceeds max. allowable limit.
  // W415a: Signal 'n' assigned multiple times.
  // The problematic 'while' loop inside the 'always @(posedge clk)' block is replaced
  // by a synthesizable combinatorial function. This also resolves multiple assignments
  // warnings as loop variables are local to the function.
  function [31:0] calculate_factorial; // Returns a 32-bit result
    input [3:0] val;
    integer i; // 'integer' is synthesizable for loop counters in functions
    reg [31:0] current_fact; // Internal variable for factorial computation
    begin
      current_fact = 1;
      for (i = 1; i <= val; i = i + 1) begin
        current_fact = current_fact * i;
      end
      calculate_factorial = current_fact;
    end
  endfunction

  // To resolve the STX_VE_481 syntax error, the direct bit selection on the
  // function return value is split into an intermediate wire assignment.
  // This preserves the functional behavior of assigning the LSB of the
  // calculated factorial to the 'result' register.
  wire [31:0] calculated_factorial_value;
  assign calculated_factorial_value = calculate_factorial(FACTORIAL_INPUT_VAL);

  always @(posedge clk) begin
    // The original 'result' port is defined as 1-bit ('output reg result;').
    // The original code assigned a 32-bit 'fact' to this 1-bit 'result',
    // which implies only the LSB of 'fact' would be captured.
    // To preserve this exact functional behavior, we assign the LSB of the
    // calculated factorial to the 'result' register using a non-blocking assignment.
    result <= calculated_factorial_value[0];
  end

  // Original 'reg [3:0] n;', 'reg [31:0] fact;', and 'reg [3:0] num;' are removed
  // as their functionality is now handled by 'FACTORIAL_INPUT_VAL' and the
  // local variables within the 'calculate_factorial' function.
endmodule
