module curve_synth_78_20260111_070734_attempt1 (
  input wire enable_i,
  input wire condition_i,
  output reg data_o
);

  // SYNTH_78: 'wait' construct is not synthesizable. Ignoring for synthesis
  always @(*) begin
    if (enable_i) begin
      wait (condition_i); // This 'wait' construct will trigger SYNTH_78
      data_o = 1'b1;
    end else begin
      data_o = 1'b0;
    end
  end

endmodule
