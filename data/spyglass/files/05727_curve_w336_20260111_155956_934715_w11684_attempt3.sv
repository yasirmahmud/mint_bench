module curve_w336_20260111_155956_934715_w11684_attempt3 (
    input wire clk,
    input wire rst_n,
    output reg [3:0] counter_val
);

  // This always block infers a flip-flop due to posedge clk
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_val <= 4'd0; // Non-blocking assignment for reset
    end else begin
      // W336: Blocking assignment used inside a FlipFlop inferred sequential block
      counter_val = counter_val + 4'd1; // This blocking assignment triggers W336
    end
  end

endmodule
