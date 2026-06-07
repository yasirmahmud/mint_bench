`timescale 1ns / 1ps

module curve_w66_20260111_222147_600998_w38092_attempt11();

  reg [3:0] repeat_val_a;
  reg [3:0] repeat_val_b;
  reg [3:0] repeat_val_c;
  reg [3:0] repeat_val_d;

  reg [7:0] data_reg = 8'h00;

  initial begin
    repeat_val_a = 4'd2;
    // W66 violation: 'repeat_val_a' is not a constant expression.
    repeat (repeat_val_a) begin
      data_reg = data_reg + 1;
      $display("Iteration A: data_reg = %0d", data_reg);
    end
  end

  initial begin
    repeat_val_b = 4'd3;
    // W66 violation: 'repeat_val_b' is not a constant expression.
    repeat (repeat_val_b) begin
      data_reg = data_reg + 2;
      $display("Iteration B: data_reg = %0d", data_reg);
    end
  end

  initial begin
    repeat_val_c = 4'd4;
    // W66 violation: 'repeat_val_c' is not a constant expression.
    repeat (repeat_val_c) begin
      data_reg = data_reg + 3;
      $display("Iteration C: data_reg = %0d", data_reg);
    end
  end

  initial begin
    repeat_val_d = 4'd5;
    // W66 violation: 'repeat_val_d' is not a constant expression.
    repeat (repeat_val_d) begin
      data_reg = data_reg + 4;
      $display("Iteration D: data_reg = %0d", data_reg);
    end
  end

endmodule
