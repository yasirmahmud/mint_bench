module curve_synth_12611_20260111_065659_attempt5 (
  input sys_clk,
  input data_in,
  input reset_n,
  output reg data_out
);

  // Synthesizable logic to ensure all inputs and outputs are used,
  // and no latches are inferred, preventing 'unused signal' (e.g., W240)
  // or 'latch' related warnings.
  always @(posedge sys_clk) begin
    if (!reset_n) begin // Synchronous active-low reset
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

  // This property uses '@(sys_clk)' as the clocking event for a scalar signal.
  // In Verilog-2001, for a scalar signal like 'sys_clk', '@(sys_clk)' is
  // implicitly interpreted as '@(edge sys_clk)', which means it's sensitive
  // to both positive and negative edges. This creates a "double-edge clock property".
  // Synthesis tools typically ignore such properties, leading to the SYNTH_12611 violation.
  property p_double_edge_data_check;
    @(sys_clk) (reset_n == 1'b1 && data_in == 1'b1) |-> ##1 (data_out == 1'b1);
  endproperty

  // The property is declared but not asserted using 'assert property'.
  // This ensures SYNTH_12611 is triggered by the property's definition itself,
  // while preventing rules related to the synthesizability of assertions, such as
  // SYNTH_5064 (ASSERT statements are not synthesizable), which was seen in
  // some context examples or earlier attempts.

endmodule
