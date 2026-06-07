module short_circuit_ex2;
 reg clk;
 reg [7:0] data_in_a, data_in_b;
 reg [7:0] data_out_a, data_out_b;
 reg result_q;
 function automatic [0:0] my_func (input [7:0] i_data, output [7:0] o_data);
 o_data = i_data + 1;
 return (i_data == 8'h00) ? 1'b0 : 1'b1;
 endfunction

 always @(posedge clk) begin
  if (my_func(data_in_a, data_out_a) && my_func(data_in_b, data_out_b)) begin
   result_q <= 1'b1;
  end else begin
   result_q <= 1'b0;
  end
 end
endmodule
