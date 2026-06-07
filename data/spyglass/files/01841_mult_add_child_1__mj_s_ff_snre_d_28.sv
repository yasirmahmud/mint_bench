// Dummy mj_s_ff_snre_d_28 for linting
module mj_s_ff_snre_d_28 (output reg [27:0] out,
                          input [27:0] din,
                          input lenable, reset_l, clk);
  always @(posedge clk or negedge reset_l) begin
    if (!reset_l)
      out <= 28'b0;
    else if (!lenable) // active low enable
      out <= din;
  end
endmodule
