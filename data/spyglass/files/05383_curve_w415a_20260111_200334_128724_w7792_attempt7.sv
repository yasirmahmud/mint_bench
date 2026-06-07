module curve_w415a_20260111_200334_128724_w7792_attempt7 (
  input wire [3:0] in_data,
  output reg [1:0] out_last_one_idx
);

  integer i;
  reg [1:0] last_one_idx; // Target signal for W415a violation

  always @(*) begin
    last_one_idx = 2'b00; // Initialize before loop to prevent latch if no condition is met

    // 'last_one_idx' is assigned multiple times within this for-loop
    // if more than one bit in 'in_data' is high.
    for (i = 0; i < 4; i = i + 1) begin
      if (in_data[i] == 1'b1) begin
        last_one_idx = i[1:0]; // W415a violation: Assignment within a conditional inside a for-loop
      end
    end
    out_last_one_idx = last_one_idx;
  end

endmodule
