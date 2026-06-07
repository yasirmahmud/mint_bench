module curve_w66_20260111_004713_attempt4 (
  input wire clk,
  input wire rst_n,
  input wire [3:0] in_count1,
  input wire [3:0] in_count2,
  input wire [3:0] in_count3,
  input wire [3:0] in_count4,
  output reg [7:0] out_data
);

  // Registers to hold the dynamic repeat counts
  // These values are updated from inputs, making them non-constant from a synthesis perspective.
  reg [3:0] current_count1;
  reg [3:0] current_count2;
  reg [3:0] current_count3;
  reg [3:0] current_count4;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_data <= 8'h00;
      current_count1 <= 4'h0;
      current_count2 <= 4'h0;
      current_count3 <= 4'h0;
      current_count4 <= 4'h0;
    end else begin
      // Update the repeat counts from inputs. This makes the repeat expressions non-constant.
      current_count1 <= in_count1;
      current_count2 <= in_count2;
      current_count3 <= in_count3;
      current_count4 <= in_count4;

      // Reset out_data for a new cycle to prevent unintended accumulation
      out_data <= 8'h00;

      // W66 Violation 1: Repeat expression 'current_count1' is not constant.
      repeat (current_count1) begin
        out_data <= out_data + 1;
      end

      // W66 Violation 2: Repeat expression 'current_count2' is not constant.
      repeat (current_count2) begin
        out_data <= out_data + 2;
      end

      // W66 Violation 3: Repeat expression 'current_count3' is not constant.
      repeat (current_count3) begin
        out_data <= out_data + 3;
      end

      // W66 Violation 4: Repeat expression 'current_count4' is not constant.
      repeat (current_count4) begin
        out_data <= out_data + 4;
      end
    end
  end

endmodule
