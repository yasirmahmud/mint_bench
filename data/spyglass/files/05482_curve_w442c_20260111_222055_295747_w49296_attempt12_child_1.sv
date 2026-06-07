module curve_w442c_20260111_222055_295747_w49296_attempt12 (
  input clk,
  input rst,
  input en,
  output reg q1,
  output reg q2,
  output reg q3,
  output reg q4
);

  // Define a local function for the reset condition.
  // A function call in the reset condition expression violates W442c.
  function is_reset_active;
    input reset_sig;
    is_reset_active = reset_sig;
  endfunction

  // A different function for active-low reset logic.
  function is_reset_deactive;
    input reset_sig;
    is_reset_deactive = !reset_sig;
  endfunction

  // Violation 1: Using a function call for the asynchronous reset condition.
  // This is not a simple identifier (rst) or its negation (!rst).
  always @(posedge clk or posedge rst) begin
    if (rst) begin // W442c violation fixed: replaced is_reset_active(rst) with rst
      q1 <= 1'b0;
    end else begin
      q1 <= en;
    end
  end

  // Violation 2: Using a function call for an active-low asynchronous reset condition.
  // The `rst` signal itself is active high, but the function `is_reset_deactive` checks for its low state.
  // The sensitivity list uses negedge `rst` to align with a potentially active-low reset signal.
  always @(posedge clk or negedge rst) begin
    if (!rst) begin // W442c violation fixed: replaced is_reset_deactive(rst) with !rst
      q2 <= 1'b0;
    end else begin
      q2 <= en;
    end
  end

  // Violation 3: Another distinct function call for the asynchronous reset condition.
  function check_reset;
    input r_val;
    check_reset = r_val;
  endfunction

  always @(posedge clk or posedge rst) begin
    if (rst) begin // W442c violation fixed: replaced check_reset(rst) with rst
      q3 <= 1'b0;
    end else begin
      q3 <= en;
    end
  end

  // Violation 4: Function call where the input argument is an expression (!rst).
  // Even if the input expression is a simple negation, the overall condition is a function call.
  function get_reset_status;
    input r_in;
    get_reset_status = r_in;
  endfunction

  always @(posedge clk or posedge rst) begin
    if (!rst) begin // W442c violation fixed: replaced get_reset_status(!rst) with !rst
      q4 <= 1'b0;
    end else begin
      q4 <= en;
    end
  end

endmodule
