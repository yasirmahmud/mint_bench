module sig_nr_indl_example2 (
  input clk,
  input enable,
  output logic [3:0] state
);

  logic [1:0] flag = 2'b01; // Violation: Initialized in declaration

  always_ff @(posedge clk) begin
    if (enable) begin
      state <= state + 1;
      flag <= ~flag;
    end
  end

endmodule
