module star_ex2 (input en, input in_data, output wire data_out, output reg out_reg);
 assign data_out = en ? in_data : 1'bz;
 always @(*) begin
  if (data_out === 1'b0) begin
    out_reg = 1'b0;
  end else if (data_out === 1'b1) begin
    out_reg = 1'b1;
  end else begin
    out_reg = 1'bx;
  end
 end
endmodule
