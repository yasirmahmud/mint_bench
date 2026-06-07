module lop_nr_arnc_ex1 (
    input wire [7:0] data_in,
    output reg [7:0] sum_out
);

  integer i;
  reg [7:0] temp_sum;

  always @(*) begin
    temp_sum = 0;
    for (i = 0; i < 8; i = i + 1) begin
      temp_sum = temp_sum + (i + data_in); // LOP_NR_ARNC: i (loop var) + data_in (non-constant) inside loop
    end
    sum_out = temp_sum;
  end

endmodule
