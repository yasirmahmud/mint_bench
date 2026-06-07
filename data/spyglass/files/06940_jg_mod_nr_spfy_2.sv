module mod_nr_spfy_example2 (
  input clk,
  input rst,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      q <= 1'b0;
    end else begin
      q <= ~q;
    end
  end

  specify
    specparam T_setup = 10;
    (clk => q) = (5, 8); // Another non-synthesizable specify block
  endspecify

endmodule
