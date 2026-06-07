module star_c05_2_9_3_1_ex1 (
    output reg [7:0] data
);
  integer i;

  // synthesis translate_off
  initial begin : loop_scope
    for (i = 0; i < 10; i = i + 1) begin
      if (i == 5) disable loop_scope;
      data = i;
    end
  end
  // synthesis translate_on

endmodule
