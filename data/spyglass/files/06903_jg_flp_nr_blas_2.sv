module blocking_ff_2 (
  input clk,
  input rst,
  input d,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      q = 1'b0; // Blocking assignment for reset of a flip-flop
    end else begin
      q = d;    // Blocking assignment for data of a flip-flop
    end
  end

endmodule
