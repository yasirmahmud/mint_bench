module curve_starc05_1_3_1_3_20260111_132956_attempt4 (
  input CLK,
  input RST, // Active-high asynchronous reset
  input D_in, // Data input for Q1
  output reg Q1,
  output reg Q2
);

  // Flop Q1: RST is used as an asynchronous, active-high reset
  always @(posedge CLK or posedge RST) begin
    if (RST) begin // Asynchronous reset condition
      Q1 <= 1'b0;
    end else begin
      Q1 <= D_in;
    end
  end

  // Flop Q2: RST is used as a data input, which is a non-reset usage.
  // This triggers STARC05-1.3.1.3 because RST is identified as an
  // asynchronous reset for flop Q1.
  always @(posedge CLK) begin
    // No reset for Q2 in this block
    Q2 <= RST; // RST is used as data for Q2
  end

endmodule
