module st_2_1_7_3_ex2 (input in_bit, output reg [3:0] out_vec);
 always @* begin out_vec <= (2 => in_bit, others => '0');
 end endmodule
