module curve_w216_20260110_230746_attempt1 ();

  reg [7:0] counter;
  reg [7:0] lower_byte;

  initial begin
    counter = 8'd10;
    lower_byte = counter[7:0]; // Triggers W216: Inappropriate range select
  end

endmodule
