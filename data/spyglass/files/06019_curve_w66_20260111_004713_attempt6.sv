module curve_w66_20260111_004713_attempt6 (
  input wire clk,
  input wire rst_n,
  input wire [15:0] in_data,
  output reg [7:0] out_val1,
  output reg [7:0] out_val2,
  output reg [7:0] out_val3,
  output reg [7:0] out_val4
);

  // Registers to hold dynamic repeat counts, derived from input
  // These registers are updated sequentially, making their values non-constant for repeat expressions.
  reg [3:0] repeat_count1_reg;
  reg [3:0] repeat_count2_reg;
  reg [3:0] repeat_count3_reg;
  reg [3:0] repeat_count4_reg;

  // Intermediate registers used for blocking assignments within the 'repeat' loops.
  // Declared at module level to avoid Verilog-2001 syntax errors.
  reg [7:0] temp_sum1;
  reg [7:0] temp_sum2;
  reg [7:0] temp_sum3;
  reg [7:0] temp_sum4;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      repeat_count1_reg <= 4'h0;
      repeat_count2_reg <= 4'h0;
      repeat_count3_reg <= 4'h0;
      repeat_count4_reg <= 4'h0;
      out_val1 <= 8'h00;
      out_val2 <= 8'h00;
      out_val3 <= 8'h00;
      out_val4 <= 8'h00;
      // Reset temporary sums
      temp_sum1 = 8'h00;
      temp_sum2 = 8'h00;
      temp_sum3 = 8'h00;
      temp_sum4 = 8'h00;
    end else begin
      // Update repeat counts from input data. Max value for each count is 15 (4'hF).
      repeat_count1_reg <= in_data[3:0];
      repeat_count2_reg <= in_data[7:4];
      repeat_count3_reg <= in_data[11:8];
      repeat_count4_reg <= in_data[15:12];

      // Calculation for out_val1
      temp_sum1 = 8'h00;
      // W66 Violation 1: 'repeat_count1_reg' is not a constant expression.
      repeat (repeat_count1_reg) begin
        temp_sum1 = temp_sum1 + 1;
      end
      out_val1 <= temp_sum1;

      // Calculation for out_val2
      temp_sum2 = 8'h00;
      // W66 Violation 2: 'repeat_count2_reg' is not a constant expression.
      repeat (repeat_count2_reg) begin
        temp_sum2 = temp_sum2 + 1;
      end
      out_val2 <= temp_sum2;

      // Calculation for out_val3
      temp_sum3 = 8'h00;
      // W66 Violation 3: 'repeat_count3_reg' is not a constant expression.
      repeat (repeat_count3_reg) begin
        temp_sum3 = temp_sum3 + 1;
      end
      out_val3 <= temp_sum3;

      // Calculation for out_val4
      temp_sum4 = 8'h00;
      // W66 Violation 4: 'repeat_count4_reg' is not a constant expression.
      repeat (repeat_count4_reg) begin
        temp_sum4 = temp_sum4 + 1;
      end
      out_val4 <= temp_sum4;
    end
  end

endmodule
