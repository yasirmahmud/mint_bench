module SEQUENCE_GENERATOR_child_2(
  input clk,
  input reset,
  output reg [3:0] q
);
  
  reg [3:0] count;
  wire [3:0] count_next;
  
  // Combinational logic to determine the next state of the counter
  always_comb begin
    if (reset) begin
      count_next = 4'b0000;
    
    end else if (count == 4'b1111) begin // Reset to zero when count reaches 15
      count_next = 4'h0;
    end else begin
      count_next = count + 1; // Increment counter
    end
  end
  
  // Sequential logic to update the counter and output register on clock edge
  always_ff @(posedge clk) begin
    count <= count_next; // Update the main counter register
    q <= count_next;     // Output the current count (reflecting the updated value)
  end
  
endmodule
