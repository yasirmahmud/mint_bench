module curve_w66_20260111_004713_attempt2 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] in_count1,
  input wire [3:0] in_count2,
  input wire [3:0] in_count3,
  input wire [3:0] in_count4,
  output reg [7:0] out_data
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 8'h00;
    end else begin
      // W66 Violation 1: Repeat expression 'in_count1' is not constant.
      repeat (in_count1) begin
        out_data <= out_data + 1;
      end

      // W66 Violation 2: Repeat expression 'in_count2' is not constant.
      repeat (in_count2) begin
        out_data <= out_data + 1;
      end

      // W66 Violation 3: Repeat expression 'in_count3' is not constant.
      repeat (in_count3) begin
        out_data <= out_data + 1;
      end

      // W66 Violation 4: Repeat expression 'in_count4' is not constant.
      repeat (in_count4) begin
        out_data <= out_data + 1;
      end
    end
  end

endmodule
