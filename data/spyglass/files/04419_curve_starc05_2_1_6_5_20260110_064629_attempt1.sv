module curve_starc05_2_1_6_5_20260110_064629_attempt1;
  reg [7:0] my_array [0:3];

  initial begin
    my_array[2'bx] = 8'hAA; // Triggers STARC05-2.1.6.5
  end

endmodule
