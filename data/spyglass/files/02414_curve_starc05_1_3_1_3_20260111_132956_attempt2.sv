module curve_starc05_1_3_1_3_20260111_132956_attempt2 (
  input CLK,
  input RST, // Active-low reset
  input D,
  output reg Q1,
  output reg Q2
);

  // Q1: RST is used as an asynchronous, active-low reset
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin // Asynchronous reset condition
      Q1 <= 1'b0;
    end else begin
      Q1 <= D;
    end
  end

  // Q2: RST is used as a synchronous enable/gate
  // This use of RST as a synchronous signal for Q2, while it's identified
  // as an asynchronous reset for Q1, triggers STARC05-1.3.1.3.
  always @(posedge CLK) begin
    if (RST) begin // If RST is high (not in reset state), enable data
      Q2 <= D;
    end else begin // Explicitly hold value when RST is low, avoiding a latch
      Q2 <= Q2;
    end
  end

endmodule
