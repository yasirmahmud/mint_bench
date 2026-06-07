module verified_counter_12 
(
  input rst_n,
  input clk,
  input valid_count,

  output reg [3:0] out
);

  // Intermediate wire to compute the next state combinatorially
  wire [3:0] out_next;

  // Sequential block for state update and asynchronous reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out <= 4'b0000; // Asynchronous reset
    end else begin
      out <= out_next; // Synchronous update with next state
    end
  end

  // Combinational block to determine the next state (out_next)
  always @(*) begin
    // Default to holding the current value if no other condition is met
    out_next = out; 

    if (valid_count) begin
      if (out == 4'd11) begin
        out_next = 4'b0000; // Wrap to zero
      end else begin
        out_next = out + 1; // Increment count
      end
    end
    // If valid_count is inactive, out_next remains 'out', preserving the hold behavior.
  end

endmodule
