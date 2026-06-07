// Dummy mj_s_ff_snre_d_6 for linting
module mj_s_ff_snre_d_6 (output reg [5:0] out,
                         input [5:0] din,
                         input lenable, reset_l, clk);
  always @(posedge clk or negedge reset_l) begin
    if (!reset_l)
      out <= 6'b0;
    else if (!lenable) // active low enable
      out <= din;
  end
endmodule
