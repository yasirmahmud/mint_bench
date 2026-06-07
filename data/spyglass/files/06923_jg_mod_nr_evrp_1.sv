module disable_example (
  input clk,
  input rst_n,
  input enable_in,
  output reg out_reg
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      if (enable_in) begin
        begin : my_sequential_block
          out_reg <= 1'b1;
        end
      end else begin
        disable my_sequential_block; // Non-synthesizable 'disable' construct
      end
    end
  end

endmodule
