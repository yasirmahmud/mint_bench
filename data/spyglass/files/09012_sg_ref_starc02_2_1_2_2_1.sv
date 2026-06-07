module starc02_ex1 (input a, output reg b);
 function automatic [7:0] my_func (input [7:0] in_val);
 reg [7:0] temp_reg;
 begin temp_reg <= in_val + 1;
 return temp_reg;
 end endfunction;
 always @(*) begin b = my_func(a);
 end endmodule
