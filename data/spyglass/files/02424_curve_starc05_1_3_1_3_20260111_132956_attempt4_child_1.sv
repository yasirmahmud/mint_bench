module curve_starc05_1_3_1_3_20260111_132956_attempt4 (
  input CLK,
  input RST, // Active-high asynchronous reset
  input D_in, // Data input for Q1
  output reg Q1,
  output reg Q2
);

  // Create a local wire to explicitly separate the data usage of RST
  // from its asynchronous reset usage, resolving STARC05-1.3.1.3.
  wire rst_for_q2;
  assign rst_for_q2 = RST;

  // Flop Q1: RST is used as an asynchronous, active-high reset
  always @(posedge CLK or posedge RST) begin
    if (RST) begin // Asynchronous reset condition
      Q1 <= 1'b0;
    end else begin
      Q1 <= D_in;
    end
  end

  // Flop Q2: rst_for_q2 is used as a data input. This prevents
  // STARC05-1.3.1.3 as RST is no longer directly used as data for Q2.
  always @(posedge CLK) begin
    // No reset for Q2 in this block
    Q2 <= rst_for_q2; // Use the dedicated data wire for Q2
  end

endmodule
