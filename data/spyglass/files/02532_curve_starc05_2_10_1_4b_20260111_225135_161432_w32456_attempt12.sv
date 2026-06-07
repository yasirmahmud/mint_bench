module curve_starc05_2_10_1_4b_20260111_225135_161432_w32456_attempt12 (
  input wire [1:0] data_in
);

  // STARC05-2.10.1.4b violation: Signal compared with value containing x
  initial begin
    if (data_in === 2'b1x) begin
      $display("Comparison with X matched.");
    end else begin
      $display("Comparison with X did not match.");
    end
  end

endmodule
