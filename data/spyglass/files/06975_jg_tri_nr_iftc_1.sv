module tri_if_condition (
  input wire enable_tri, 
  input wire data_in, 
  output reg out_val
);

  wire tri_state_output;

  // Simulate a tri-state buffer output
  assign tri_state_output = enable_tri ? data_in : 1'bz;

  // Using the tri-state output in an if condition
  always_comb begin
    if (tri_state_output) begin // TRI_NR_IFTC violation
      out_val = 1'b1;
    end else begin
      out_val = 1'b0;
    end
  end

endmodule
