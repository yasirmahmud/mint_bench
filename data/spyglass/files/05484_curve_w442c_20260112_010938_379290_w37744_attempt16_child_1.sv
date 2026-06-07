module curve_w442c_20260112_010938_379290_w37744_attempt16 (
  input wire clk,
  input wire rst,
  input wire d_in,
  output reg q1,
  output reg q2,
  output reg q3,
  output reg q4
);

  // Function to encapsulate the reset check, intended to cause a W442c violation
  // The return type should be `reg` for Verilog-2001.
  function automatic reg is_reset_condition_met;
    input reset_val;
    begin
      is_reset_condition_met = reset_val;
    end
  endfunction

  // Violation 1: Asynchronous reset condition is a function call. RESOLVED by direct `rst` check.
  always @(posedge clk or posedge rst) begin
    if (rst) begin // W442c violation fixed
      q1 <= 1'b0;
    end else begin
      q1 <= d_in;
    end
  end

  // Violation 2: Another function call for the reset condition. RESOLVED by direct `rst` check.
  function automatic reg check_async_reset;
    input reset_sig;
    begin
      check_async_reset = reset_sig;
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin // W442c violation fixed
      q2 <= 1'b0;
    end else begin
      q2 <= d_in;
    end
  end

  // Violation 3: Function call with inverted logic inside, still violates the rule. RESOLVED by direct `!rst` check.
  function automatic reg get_reset_status;
    input reset_line;
    begin
      get_reset_status = !reset_line;
    end
  endfunction

  // Using negedge rst for variety, but the function call still triggers W442c.
  always @(posedge clk or negedge rst) begin
    if (!rst) begin // W442c violation fixed
      q3 <= 1'b0;
    end else begin
      q3 <= d_in;
    end
  end

  // Violation 4: A fourth function call, ensuring 4 total occurrences. RESOLVED by direct `rst` check.
  function automatic reg reset_activated;
    input reset_bit;
    begin
      reset_activated = reset_bit;
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin // W442c violation fixed
      q4 <= 1'b0;
    end else begin
      q4 <= d_in;
    end
  end

endmodule
