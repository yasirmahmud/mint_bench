module curve_w216_20260111_182232_071091_w47100_attempt10 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] out_data_a,
  output reg [7:0] out_data_b,
  output reg [7:0] out_data_c
);

  integer counter_int_a; // Integer variable 1
  integer counter_int_b; // Integer variable 2
  integer counter_int_c; // Integer variable 3

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter_int_a <= 0;
      counter_int_b <= 10;
      counter_int_c <= 20;
      out_data_a <= 0;
      out_data_b <= 0;
      out_data_c <= 0;
    end else begin
      counter_int_a <= counter_int_a + 1;
      counter_int_b <= counter_int_b + 2;
      counter_int_c <= counter_int_c + 3;

      // Violation 1: Inappropriate range select for int_part_sel variable 'counter_int_a[7:0]'
      out_data_a <= counter_int_a[7:0]; 

      // Violation 2: Inappropriate range select for int_part_sel variable 'counter_int_b[7:0]'
      out_data_b <= counter_int_b[7:0];

      // Violation 3: Inappropriate range select for int_part_sel variable 'counter_int_c[7:0]'
      out_data_c <= counter_int_c[7:0];
    end
  end

endmodule
