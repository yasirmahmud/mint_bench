module curve_w215_20260111_002217_attempt2 (
    input clk,
    input rst,
    output reg [3:0] data_out // Output to avoid W528 (unused signal)
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      data_out <= 4'b0;
    end else begin
      // The integer loop variable 'i' is bit-selected four times.
      // Each instance of 'i[0]' on an integer variable triggers W215.
      for (integer i = 0; i < 4; i = i + 1) begin
        data_out[i] <= i[0]; // Triggers W215 for each 'i'
      end
    end
  end

endmodule
