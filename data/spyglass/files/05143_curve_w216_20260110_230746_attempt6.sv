module curve_w216_20260110_230746_attempt6 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] result_a,
  output reg [7:0] result_b,
  output reg [7:0] result_c
);

  integer my_int_counter_a;
  integer my_int_counter_b;
  integer my_int_counter_c;

  reg [7:0] lower_part_a;
  reg [7:0] lower_part_b;
  reg [7:0] lower_part_c;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_int_counter_a <= 0;
      my_int_counter_b <= 0;
      my_int_counter_c <= 0;
      lower_part_a <= 8'h00;
      lower_part_b <= 8'h00;
      lower_part_c <= 8'h00;
      result_a <= 8'h00;
      result_b <= 8'h00;
      result_c <= 8'h00;
    end else begin
      my_int_counter_a <= my_int_counter_a + 1;
      my_int_counter_b <= my_int_counter_b + 2;
      my_int_counter_c <= my_int_counter_c + 3;

      // W216 is expected for each of these lines:
      // "Inappropriate range select for int_part_sel variable: "my_int_counter_a[7:0] "
      // SpyGlass typically flags range selection on integer variables when it's selecting
      // the lower bits, considering it redundant as direct assignment to a smaller width
      // register would achieve implicit truncation.
      lower_part_a <= my_int_counter_a[7:0];
      lower_part_b <= my_int_counter_b[7:0];
      lower_part_c <= my_int_counter_c[7:0];

      result_a <= lower_part_a;
      result_b <= lower_part_b;
      result_c <= lower_part_c;
    end
  end

endmodule
