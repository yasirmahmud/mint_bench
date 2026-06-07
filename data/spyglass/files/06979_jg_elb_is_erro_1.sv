module deassign_violation (
  input wire clk,
  output reg out_reg
);

initial begin
  out_reg = 1'b0;
  #10 deassign out_reg; // 'deassign' is not supported for synthesis and causes elaboration failure
end

endmodule
