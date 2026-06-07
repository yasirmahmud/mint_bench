module curve_starc05_1_3_1_3_20260111_132956_attempt3 (
  input CLK,
  input RST, // Active-high reset
  input D,
  output reg Q1,
  output reg Q2
);

  // Q1: RST is used as an asynchronous, active-high reset
  always @(posedge CLK or posedge RST) begin
    if (RST) begin // Asynchronous reset condition
      Q1 <= 1'b0;
    end else begin
      Q1 <= D;
    end
  end

  // Q2: RST is used as a synchronous reset
  // This use of RST as a synchronous reset for Q2, while it's identified
  // as an asynchronous reset for Q1, triggers STARC05-1.3.1.3.
  always @(posedge CLK) begin
    if (RST) begin // Synchronous reset condition
      Q2 <= 1'b0;
    end else begin
      Q2 <= D;
    end
  end

endmodule
