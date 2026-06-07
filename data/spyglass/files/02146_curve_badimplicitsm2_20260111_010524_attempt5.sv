module curve_badimplicitsm2_20260111_010524_attempt5 (
  input wire [1:0] data_in_i,
  input wire clk_i,
  input wire reset_n_i,
  output reg [1:0] state_reg_pos_q,
  output reg [1:0] state_reg_neg_q
);

  // This always block contains multiple event controls, one for posedge clk_i
  // and another for negedge clk_i, attempting to update different registers.
  // According to the badimplicitSM2 rule, states can only be updated on the same clock phase.
  // By updating state_reg_pos_q on the positive edge and state_reg_neg_q on the negative edge
  // within a single 'always' block, it implicitly forms unsynthesizable sequential logic.
  // This example is distinct from previous attempts by using 2-bit signals, including
  // a synchronous reset for one register, and different arithmetic logic for the other.
  always begin
    @(posedge clk_i) begin
      if (!reset_n_i) begin
        state_reg_pos_q <= 2'b00;
      end else begin
        state_reg_pos_q <= data_in_i;
      end
    end
    @(negedge clk_i) begin
      state_reg_neg_q <= data_in_i + 2'b01;
    end
  end

endmodule
