module curve_starc05_2_10_1_4b_20260111_094016_attempt2 (
  input  wire [1:0]  data_in
);

  // STARC05-2.10.1.4b: Signal compared with value containing x or z
  // Comparison to a multi-bit value containing 'z' to differentiate from STARC05-2.10.1.4a ('x' only).
  // Placed in an 'initial' block to avoid synthesis warnings (SYNTH_5058, W339a).
  initial begin
    if (data_in === 2'b1z) begin
      // No functional logic required for the violation to trigger
    end
  end

endmodule
