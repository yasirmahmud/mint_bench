module ff_s_2 (
                out,
                din,
                clk
               );

  output [1:0] out;
  input  [1:0] din;
  input        clk;

  reg [1:0] out_reg;

  // A simple 2-bit D flip-flop, inferring the behavior from its instantiation
  // in the parent module 'b_recoder', which only connects din, out, and clk.
  always @(posedge clk) begin
    out_reg <= din;
  end

  assign out = out_reg;

endmodule
