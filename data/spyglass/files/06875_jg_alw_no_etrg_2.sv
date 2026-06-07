module MissingTrigger2 (
  input wire clk,
  input wire rst,
  output reg out_reg
);

  always begin
    if (rst) begin
      out_reg = 1'b0;
    end else begin
      out_reg = clk;
    end
  end

endmodule
