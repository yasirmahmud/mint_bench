module curve_w66_20260111_182526_395512_w7792_attempt10 (
  input wire dummy_in,
  output reg dummy_out
);

  reg [3:0] loop_counter_1;
  reg [3:0] loop_counter_2;
  reg [3:0] loop_counter_3;
  reg [3:0] loop_counter_4;

  // A simple synthesizable block to provide module context and avoid unused port warnings
  always @(*) begin
    dummy_out = dummy_in;
  end

  // First occurrence of W66: Repeat expression is a reg, not a constant.
  initial begin
    loop_counter_1 = 4'd2; // Value is known at simulation time, but 'loop_counter_1' is not a constant expression type.
    repeat (loop_counter_1) begin
      $display("W66_example_1: Loop iteration for count %0d", loop_counter_1);
    end
  end

  // Second occurrence of W66: Repeat expression is a reg, not a constant.
  initial begin
    loop_counter_2 = 4'd3;
    repeat (loop_counter_2) begin
      $display("W66_example_2: Loop iteration for count %0d", loop_counter_2);
    end
  end

  // Third occurrence of W66: Repeat expression is a reg, not a constant.
  initial begin
    loop_counter_3 = 4'd4;
    repeat (loop_counter_3) begin
      $display("W66_example_3: Loop iteration for count %0d", loop_counter_3);
    end
  end

  // Fourth occurrence of W66: Repeat expression is a reg, not a constant.
  initial begin
    loop_counter_4 = 4'd5;
    repeat (loop_counter_4) begin
      $display("W66_example_4: Loop iteration for count %0d", loop_counter_4);
    end
  end

endmodule
