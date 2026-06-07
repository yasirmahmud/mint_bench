`timescale 1ns / 1ps

module curve_w66_20260111_222147_600998_w38092_attempt12 ();

  reg [3:0] repeat_count_reg_1;
  reg [3:0] repeat_count_reg_2;
  reg [3:0] repeat_count_reg_3;
  reg [3:0] repeat_count_reg_4;

  reg [7:0] accumulator_val_1;
  reg [7:0] accumulator_val_2;
  reg [7:0] accumulator_val_3;
  reg [7:0] accumulator_val_4;

  // All repeat loops are combined into a single initial block.
  // This ensures the repeat expression is based on a 'reg' variable,
  // which is not considered a constant expression for synthesis, triggering W66.
  initial begin
    // Initialize accumulator registers (avoids SYNTH_89 warning for initial assignment at declaration)
    accumulator_val_1 = 8'd0;
    accumulator_val_2 = 8'd0;
    accumulator_val_3 = 8'd0;
    accumulator_val_4 = 8'd0;

    // W66 violation 1: 'repeat_count_reg_1' is a reg, not a constant expression.
    repeat_count_reg_1 = 4'd2;
    repeat (repeat_count_reg_1) begin
      accumulator_val_1 = accumulator_val_1 + 1;
    end

    // W66 violation 2: 'repeat_count_reg_2' is a reg, not a constant expression.
    repeat_count_reg_2 = 4'd3;
    repeat (repeat_count_reg_2) begin
      accumulator_val_2 = accumulator_val_2 + 2;
    end

    // W66 violation 3: 'repeat_count_reg_3' is a reg, not a constant expression.
    repeat_count_reg_3 = 4'd4;
    repeat (repeat_count_reg_3) begin
      accumulator_val_3 = accumulator_val_3 + 3;
    end

    // W66 violation 4: 'repeat_count_reg_4' is a reg, not a constant expression.
    repeat_count_reg_4 = 4'd5;
    repeat (repeat_count_reg_4) begin
      accumulator_val_4 = accumulator_val_4 + 4;
    end

  end

endmodule
