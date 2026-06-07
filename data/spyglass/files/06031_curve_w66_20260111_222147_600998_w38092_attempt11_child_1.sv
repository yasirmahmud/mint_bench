`timescale 1ns / 1ps

module curve_w66_20260111_222147_600998_w38092_attempt11();

  localparam [3:0] repeat_val_a = 4'd2;
  localparam [3:0] repeat_val_b = 4'd3;
  localparam [3:0] repeat_val_c = 4'd4;
  localparam [3:0] repeat_val_d = 4'd5;

  reg [7:0] data_reg = 8'h00;

  initial begin
    // The W66 violations are resolved by using 'localparam' for the repeat counts.
    // 'initial' blocks themselves are generally ignored by synthesis tools,
    // which may still lead to SYNTH_5143 warnings (now consolidated).
    // The initial assignment to 'data_reg' will still trigger SYNTH_89.

    repeat (repeat_val_a) begin
      data_reg = data_reg + 1;
      $display("Iteration A: data_reg = %0d", data_reg);
    end

    repeat (repeat_val_b) begin
      data_reg = data_reg + 2;
      $display("Iteration B: data_reg = %0d", data_reg);
    end

    repeat (repeat_val_c) begin
      data_reg = data_reg + 3;
      $display("Iteration C: data_reg = %0d", data_reg);
    end

    repeat (repeat_val_d) begin
      data_reg = data_reg + 4;
      $display("Iteration D: data_reg = %0d", data_reg);
    end
  end

endmodule
