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
  // 'out1' using a 'bufif1' primitive. This satisfies the rule
  // by making the tristate control explicit and often helps
  // linting tools recognize the intended tristate behavior without
  // flagging the register output 'q_enable' as 'logic in enable condition'.
  // The enable condition 'q_enable' is a single register output,
  // which now drives the control input of the primitive.
  bufif1 tristate_driver (out1, q_data, q_enable);

endmodule
