module tristate_port_ex2 (input clk, input rst, input in1, output out1);

  // Internal register to hold the data part (in1) synchronously.
  reg q_data;

  // Internal register to hold the enable part (rst) synchronously.
  reg q_enable;

  always @(posedge clk) begin
    // W336 fix: Use non-blocking assignments for sequential logic.
    q_data <= in1;
    q_enable <= rst;
  end

  // STARC05-2.5.1.2 fix: Explicitly model the tristate output
  // 'out1' as a wire, driven by a continuous assignment.
  // The enable condition 'q_enable' is now a single register output,
  // which is typically acceptable for tristate control.
  assign out1 = q_enable ? q_data : 1'bz;

endmodule
