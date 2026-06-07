module reserved_word_as_wire (
  input clk,
  output reg out
);
  wire always; // 'always' is a Verilog reserved word
  assign always = clk;

  always @(posedge always) begin
    out <= ~out;
  end
endmodule
