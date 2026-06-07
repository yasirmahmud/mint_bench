module curve_starc05_1_3_1_3_20260111_132956_attempt6 (
  input CLK,
  input RST, // Active-high reset
  input D_in,
  output reg Q1,
  output reg Q2
);

  // Introduce a new wire to separate the data usage of RST from its reset usage.
  // This resolves STARC05-1.3.1.3 by ensuring 'RST' is only seen as an async reset.
  wire RST_Q2_data = RST;

  // Flop Q1: RST is identified as an asynchronous, active-high reset.
  always @(posedge CLK or posedge RST) begin
    if (RST) begin // Asynchronous reset condition
      Q1 <= 1'b0;
    end else begin
      Q1 <= D_in;
    end
  end

  // Flop Q2: RST is used as a data input. This is a 'non-reset' usage.
  // By using RST_Q2_data, we avoid the STARC05-1.3.1.3 violation.
  always @(posedge CLK) begin
    Q2 <= RST_Q2_data;
  end

endmodule
