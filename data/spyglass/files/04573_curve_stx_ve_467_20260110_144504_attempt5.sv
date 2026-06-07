module curve_stx_ve_467_20260110_144504_attempt5 (
  input wire clk,
  input wire rst_n,
  input wire trigger_event_a,
  input wire trigger_event_b,
  output reg [7:0] output_val_a,
  output reg [7:0] output_val_b
);

  // Declare event variables
  event my_event_a;
  event my_event_b;

  // Declare register variables that will receive the disallowed assignment
  reg [7:0] target_reg_a;
  reg [7:0] target_reg_b;

  // Stimulate events. This is for demonstrating usage of events and ensures they are 'active'.
  // The actual state of the event (triggered or not) does not change the type mismatch rule.
  always @(posedge clk) begin
    if (trigger_event_a) begin
      -> my_event_a;
    end
    if (trigger_event_b) begin
      -> my_event_b;
    end
  end

  // STX_VE_467 violation 1: Non-equivalent data types in assignment operation.
  // The Verilog-2001 LRM (IEEE 1364-2001, section 5.2.4) explicitly states:
  // "Event variables shall not be used in arithmetic expressions or assigned to variables other than other event variables."
  // Assigning an 'event' type (my_event_a) to a 'reg' type (target_reg_a) is a violation of this rule.
  always @* begin
    target_reg_a = my_event_a; // FATAL: Non-equivalent data types
  end

  // STX_VE_467 violation 2: Second instance of the same non-equivalent data type assignment.
  always @* begin
    target_reg_b = my_event_b; // FATAL: Non-equivalent data types
  end

  // Drive outputs to ensure 'target_reg_a' and 'target_reg_b' are used
  // and to avoid 'unused signal' warnings from SpyGlass.
  assign output_val_a = target_reg_a;
  assign output_val_b = target_reg_b;

endmodule
