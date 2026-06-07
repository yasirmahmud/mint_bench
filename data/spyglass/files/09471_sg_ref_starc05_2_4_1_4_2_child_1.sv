module combinational_loop_latch_ex2 (input en, output reg q_out);
  // Original violation: The 'assign' statement creates a combinational loop
  // because 'q_out' is continuously assigned based on its own inverted value when 'en' is high.
  // This leads to an oscillation when 'en' is asserted.
  // To fix this, we need to model 'q_out' as a sequential element (a latch)
  // and break the direct combinational feedback.
  // The original behavior for 'en=0' implies holding the state, characteristic of a latch.
  // The behavior for 'en=1' implies toggling, which is sequential in nature.
  // We introduce an explicit data input 'd_latch_in' to the latch.
  
  reg d_latch_in;
  
  // Calculate the data input to the latch based on the current stable output 'q_out'
  // When 'en' is high, the latch's input should be the inverted current 'q_out'.
  // When 'en' is low, the latch should hold its current value. This means its effective
  // data input for the 'hold' state is its current output 'q_out'.
  always @(en or q_out) begin
    if (en) begin
      d_latch_in = ~q_out; // Data for toggling
    end else begin
      d_latch_in = q_out; // Data for holding (pass current state as input if not enabled)
    end
  end
  
  // Infer a D-latch for 'q_out' using the calculated 'd_latch_in'
  // This `always` block implements the latching behavior.
  // When 'en' is high, 'q_out' becomes 'd_latch_in'.
  // When 'en' is low, 'q_out' holds its previous value (implicit latching in Verilog).
  always @(en or d_latch_in) begin
    if (en) begin
      q_out = d_latch_in;
    end
    // else q_out implicitly holds its value (latch behavior)
  end

endmodule
