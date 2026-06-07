module st_2_1_7_3_ex2 (input in_bit, output reg [3:0] out_vec);
  always @* begin
    out_vec = 4'b0;       // Initialize all bits to 0
    out_vec[2] = in_bit;  // Assign in_bit to the 2nd bit
  end
endmodule
