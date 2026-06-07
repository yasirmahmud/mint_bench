module curve_w415a_20260111_200334_128724_w7792_attempt9 (
  input wire [7:0] in_vec,
  output reg [2:0] out_val
);

  integer k;
  reg [2:0] target_reg; // Target signal for W415a violation

  always @(*) begin
    target_reg = 3'b000; // Initialize before loop to prevent latch generation

    // W415a violation occurs here: 'target_reg' is assigned multiple times
    // within this for-loop if more than one bit in 'in_vec' is low.
    // For example, if in_vec = 8'b1111_1100, target_reg will be assigned
    // for k=0 (~0 = 3'b111) and then for k=1 (~1 = 3'b110).
    for (k = 0; k < 8; k = k + 1) begin
      if (in_vec[k] == 1'b0) begin
        target_reg = ~k; // Multiple assignments to target_reg within the loop
      end
    end
    out_val = target_reg;
  end

endmodule
