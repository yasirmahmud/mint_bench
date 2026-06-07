module curve_w216_20260110_230746_attempt5 (
  input wire clk,
  input wire rst_n,
  output reg [7:0] result
);

  integer my_int_counter;
  reg [7:0] lower_part;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_int_counter <= 0;
      lower_part <= 8'h00;
      result <= 8'h00;
    end else begin
      my_int_counter <= my_int_counter + 1;
      // W216 is expected here: "Inappropriate range select for int_part_sel variable: "my_int_counter[7:0] "
      // This line explicitly selects the lower 8 bits of an integer variable.
      // It is hypothesized that SpyGlass considers this "inappropriate" or redundant
      // because assigning the integer directly to an 8-bit register would implicitly
      // truncate it to the lower 8 bits, achieving the same result.
      lower_part <= my_int_counter[7:0];
      result <= lower_part;
    end
  end

endmodule
