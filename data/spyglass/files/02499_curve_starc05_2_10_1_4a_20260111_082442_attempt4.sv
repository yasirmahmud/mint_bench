module curve_starc05_2_10_1_4a_20260111_082442_attempt4 (
  input wire my_signal
);

  // STARC05-2.10.1.4a: Signal compared with 'z'
  // This initial block context is typically used for testbench or formal verification,
  // which might reduce the likelihood of synthesis-specific warnings,
  // compared to an always block.
  initial begin
    if (my_signal === 1'bz) begin
      // This empty block ensures the comparison is present but no further logic is added.
      // This line is expected to trigger STARC05-2.10.1.4a.
    end
  end

endmodule
