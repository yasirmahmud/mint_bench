module curve_w415a_20260111_231708_927225_w49296_attempt12 (
  input wire [3:0] in_val, // Used to avoid W528 (unused input)
  output reg [3:0] out_data
);

  reg [3:0] target_reg; // Signal that will trigger W415a
  integer loop_idx;

  always @* begin
    target_reg = 4'h0; // Initialize target_reg outside the loop
    
    for (loop_idx = 0; loop_idx < 4; loop_idx = loop_idx + 1) begin
      // W415a violation: target_reg is assigned multiple times (once per iteration)
      // within the same for-loop in this always block.
      target_reg = loop_idx; // This single statement triggers the rule.
    end
    
    // Use in_val to prevent unused input warning (W528)
    out_data = target_reg ^ in_val;
  end

endmodule
