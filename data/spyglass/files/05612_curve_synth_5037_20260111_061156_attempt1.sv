module curve_synth_5037_20260111_061156_attempt1 (
  input wire sel,
  output reg data_out
);

always @(*) begin
  case (sel) 
    1'b0: data_out = 1'b0;
    1'b1: data_out = 1'b1;
    2'd2: data_out = 1'b0;
  endcase
end

endmodule
