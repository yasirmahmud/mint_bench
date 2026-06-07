module onebit_onehot0_violation_2 (
  input logic clk,
  input logic rst_n,
  input logic enable_bit,
  output logic status
);

  always_comb begin
    status = $onehot0(enable_bit);
  end

endmodule
