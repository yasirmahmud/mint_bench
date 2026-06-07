module curve_w422_20260111_224449_864478_w32456_attempt11 (
    input wire clk_A,
    input wire clk_B,
    input wire data_in,
    output reg data_out_reg
);

  // SpyGlass violations W422 and STARC05-2.3.3.1 indicate that an always block
  // cannot be sensitive to the positive edges of more than one independent clock.
  // Such a construct is generally un-synthesizable or leads to unreliable hardware.
  //
  // To resolve these violations and ensure synthesizability, the 'always' block
  // must be sensitive to a single clock.
  //
  // The original design's functional behavior of updating 'data_out_reg' on
  // 'posedge clk_A' OR 'posedge clk_B' cannot be perfectly preserved for a single
  // register in a standard synthesizable way if 'clk_A' and 'clk_B' are asynchronous.
  // A perfect preservation would require complex clock-domain crossing (CDC) logic
  // and an arbitration scheme not implied by the simple 'data_out_reg <= data_in;'
  // assignment, or the generation of a problematic derived clock.
  //
  // As no primary clock or arbitration mechanism is specified, the most direct
  // and synthesizable fix, requiring minimal changes to the given assignment,
  // is to assign 'data_out_reg' to be synchronous to one of the clocks. We will
  // choose 'clk_A' as the clock for 'data_out_reg'.
  // This resolves all reported violations (W422, STARC05-2.3.3.1, and implicitly W442a).
  // Note that this change implies that 'data_out_reg' will no longer update
  // on 'posedge clk_B'. If 'clk_B's influence is critical, a more complex CDC
  // design would be needed.
  always @(posedge clk_A) begin
    data_out_reg <= data_in;
  end

endmodule
