module curve_starc05_2_10_1_4a_20260111_195933_071951_w36056_attempt9 (
  input wire [1:0] data_in_vec
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This initial block ensures the comparison is not treated as synthesis logic,
  // thus aiming to avoid SYNTH_5058 and W339a warnings related to '==='.
  // The comparison of a signal bit with 1'bz directly targets STARC05-2.10.1.4a.
  initial begin
    if (data_in_vec[0] === 1'bz) begin
      // This branch is intentionally left empty or can contain a non-functional statement
      // to mark the violation point. $display is often ignored by synthesis but for linting it is fine.
      $display("Violation: data_in_vec[0] is high-impedance (z).");
    end
  end

endmodule
