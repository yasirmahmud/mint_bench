module curve_starc05_2_1_6_5_20260111_173608_928277_w7792_attempt10;

  reg [1:0] idx_val = 2'bx; // Index register initialized with 'x'
  reg [7:0] my_ram [0:3];   // Declare a memory array

  initial begin
    // Using an 'x' value in the array index, triggering STARC05-2.1.6.5
    my_ram[idx_val] = 8'hAA;
  end

endmodule
