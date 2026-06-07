module curve_w336_20260111_155956_934715_w11684_attempt5 (
    input wire clk,
    input wire rst_n,
    output reg [7:0] data_out
);

  reg [7:0] counter_reg;

  // This always block infers a flip-flop due to posedge clk
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Use non-blocking assignment for reset to avoid W336 violation here
      counter_reg <= 8'd0;
      data_out    <= 8'd0;
    end else begin
      // W336: Blocking assignment 'counter_reg = (counter_reg + 8'd1);' used
      // inside a 'FlipFlop' inferred sequential block.
      // This is the intended violation point.
      counter_reg = counter_reg + 8'd1;
      
      // Propagate the value using non-blocking assignment to avoid additional W336
      data_out <= counter_reg;
    end
  end

endmodule
