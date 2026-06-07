module curve_synth_12604_20260110_152704_attempt2 (
  input [2:0] control_in,
  output reg data_out
);

  always @(*) begin
    unique case (control_in)
      3'b000: data_out = 1'b0;
      3'b001: data_out = 1'b1;
      3'b010: data_out = 1'b0; // First occurrence of this condition
      3'b011: data_out = 1'b1;
      3'b010: data_out = 1'b1; // This is a duplicate label, triggering SYNTH_12604
      default: data_out = 1'b0;
    endcase
  end

endmodule
