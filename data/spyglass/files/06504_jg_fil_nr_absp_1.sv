module top_abs_path_unix (
  input clk,
  output reg out
);

  `include "/home/user/project/includes/defines.vh"

  always @(posedge clk) begin
    out <= 1'b1;
  end

endmodule
