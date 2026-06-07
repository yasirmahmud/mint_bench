module curve_synth_5035_20260111_225534_917787_w38092_attempt11 (
  input [2:0] sel,
  output reg out
);

  always @* begin
    out = 1'b0; // Default assignment to avoid latches
    case (sel) 
      3'b001, 3'b010, 3'b001: out = 1'b1; // SYNTH_5035: 3'b001 is duplicated in the same case item list
      3'b100: out = 1'b0;
      3'b101: out = 1'b1;
      3'b110: out = 1'b0;
      3'b111: out = 1'b1;
      default: out = 1'b0; // Covers 3'b000 and any X/Z states on 'sel'
    endcase
  end

endmodule
