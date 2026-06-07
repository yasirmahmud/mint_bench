module curve_w415a_20260111_200334_128724_w7792_attempt10 (
  input wire [7:0] data_in,
  output reg [3:0] count_out
);

  integer i;
  reg [3:0] count_reg; // Target signal for W415a violation

  always @(*) begin
    count_reg = 4'b0000; // Initialize before loop to prevent latch generation

    // W415a violation occurs here: 'count_reg' is assigned multiple times
    // within this for-loop if multiple bits in 'data_in' are '1'.
    // For example, if data_in = 8'b0000_0011, count_reg will be incremented
    // for i=0 and then for i=1, resulting in multiple assignments.
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i] == 1'b1) begin
        count_reg = count_reg + 1; // Multiple assignments within the same for-loop
      end
    end
    count_out = count_reg;
  end

endmodule
