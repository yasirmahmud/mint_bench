module curve_w442c_20260111_183124_687888_w37940_attempt10 (
  input clk,
  input rst,
  input d,
  output reg q
);

  // Function to evaluate reset condition
  function is_reset_active;
    input rst_signal;
    begin
      is_reset_active = rst_signal;
    end
  endfunction

  always @(posedge clk or posedge rst) begin
    if (is_reset_active(rst)) begin // W442c violation: Reset condition is a function call
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end

endmodule
