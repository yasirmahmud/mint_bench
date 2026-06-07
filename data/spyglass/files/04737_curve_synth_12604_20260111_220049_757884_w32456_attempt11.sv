module curve_synth_12604_20260111_220049_757884_w32456_attempt11 (
  input [2:0] sel,
  output reg [1:0] out
);

  always @* begin
    case (sel)
      3'b000: out = 2'h0;
      3'b001: out = 2'h1;
      3'b010: out = 2'h2;
      3'b011: out = 2'h3;
      3'b100: out = 2'h0;
      3'b001: out = 2'h2; // Duplicate of 3'b001
      3'b101: out = 2'h1;
      3'b011: out = 2'h0; // Duplicate of 3'b011
      3'b110: out = 2'h3;
      3'b111: out = 2'h1;
    endcase
  end

endmodule
