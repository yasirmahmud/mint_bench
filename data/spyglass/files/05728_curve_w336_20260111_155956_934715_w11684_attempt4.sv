module curve_w336_20260111_155956_934715_w11684_attempt4 (
    input wire clk,
    input wire rst_n,
    output reg [3:0] count_out
);

  // This always block infers a flip-flop due to posedge clk
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Blocking assignment for reset - consistent with the data path below
      count_out = 4'd0;
    end else begin
      // W336: Blocking assignment 'count_out = (count_out + 4'd1);' used
      // inside a 'FlipFlop' inferred sequential block.
      // All assignments to count_out are blocking within this block to
      // avoid SYNTH_77/W505 errors from mixed assignments.
      count_out = count_out + 4'd1;
    end
  end

endmodule
