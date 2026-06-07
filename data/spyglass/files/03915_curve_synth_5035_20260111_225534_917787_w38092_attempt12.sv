module curve_synth_5035_20260111_225534_917787_w38092_attempt12 (
  input [3:0] sel,
  output reg out
);

  always @* begin
    out = 1'b0; // Default assignment to avoid latches
    case (sel) 
      4'b0000: out = 1'b0;
      4'b0001: out = 1'b1;
      4'b0010: out = 1'b0;
      // SYNTH_5035: 4'b0101 is duplicated in the same case item list
      4'b0101, 4'b1010, 4'b0101: out = 1'b1; 
      4'b1100: out = 1'b0;
      4'b1101: out = 1'b1;
      default: out = 1'b0; // Covers all other states including X/Z on 'sel'
    endcase
  end

endmodule
