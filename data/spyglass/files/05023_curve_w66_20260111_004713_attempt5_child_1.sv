module curve_w66_20260111_004713_attempt5 (
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

  // Temporary registers moved to module scope from inside the always block
  // to resolve STX_VE_481 (Illegal use of Verilog keyword 'reg')
  // and STX_VE_606 (Identifier not declared in current scope) violations.
  // This also ensures they are visible throughout the always block.
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
      // Reset temporary sum registers as well for predictable behavior on reset.
      temp_sum1 <= 8'h00;
      temp_sum2 <= 8'h00;
      temp_sum3 <= 8'h00;
      temp_sum4 <= 8'h00;
    end else begin
      // Update repeat counts from input data. Max value for each count is 15 (4'hF).
      repeat_count1_reg <= in_data[3:0];
      repeat_count2_reg <= in_data[7:4];
      repeat_count3_reg <= in_data[11:8];
      repeat_count4_reg <= in_data[15:12];

      // The original `repeat` loops cause W66 violations ("not a constant expression")
      // and are not synthesizable. The functional intent of `repeat (N) begin sum = sum + 1; end`
      // starting with `sum = 0` is simply `sum = N`. This direct assignment
      // preserves the functional behavior and resolves the W66 violations.

      temp_sum1 = repeat_count1_reg; // Replaced repeat loop logic
      out_val1 <= temp_sum1;

      temp_sum2 = repeat_count2_reg; // Replaced repeat loop logic
      out_val2 <= temp_sum2;

      temp_sum3 = repeat_count3_reg; // Replaced repeat loop logic
      out_val3 <= temp_sum3;

      temp_sum4 = repeat_count4_reg; // Replaced repeat loop logic
      out_val4 <= temp_sum4;
    end
  end

endmodule
