module complex_for_ex2;
 reg [7:0] data;
 reg [7:0] temp_val;
 integer i;
 always @* begin temp_val = 8'h00;
 for (i = 0; i < 7; i = i + 1) begin temp_val = data[i];
 data[i+1] = temp_val;
 end end endmodule
