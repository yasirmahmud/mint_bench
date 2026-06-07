module day14(
  input wire clk,
  input wire reset,
  input wire serial_in,
  output wire seq_det_o
);
  
  reg [7:0] shift_reg;
 wire [7:0] shift_next;
  
  always@(posedge clk or negedge reset)
    begin
      if(reset)
        shift_reg <= 8'h0;
      else
        shift_reg <= shift_next;
 	 end
  assign shift_next = {shift_reg[6:0],serial_in};
  
  assign seq_det_o = (shift_reg[7:0] == 8'b1010_0011);
  
endmodule
