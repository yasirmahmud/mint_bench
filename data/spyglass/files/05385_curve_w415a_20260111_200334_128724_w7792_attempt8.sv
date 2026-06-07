module curve_w415a_20260111_200334_128724_w7792_attempt8 (
  input wire [3:0] in_data,
  output reg [1:0] out_result
);

  integer i;
  reg [1:0] temp_result; // Target signal for W415a violation

  always @(*) begin
    temp_result = 2'b00; // Initialize before loop to prevent latch

    // 'temp_result' is assigned multiple times within this for-loop
    // if more than one bit in 'in_data' is high.
    for (i = 0; i < 4; i = i + 1) begin
      if (in_data[i] == 1'b1) begin
        temp_result = i; // W415a violation: Assignment within a conditional inside a for-loop
      end
    end
    out_result = temp_result;
  end

endmodule
