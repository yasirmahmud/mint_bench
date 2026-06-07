module multiple_writers_ex1 (
  input clk,
  input rst_n,
  input in_a,
  input in_b,
  output reg out_reg
);

  // Consolidated all assignments to out_reg into a single always block.
  // The original design had two always blocks attempting to drive out_reg
  // simultaneously, leading to multiple driver and write-write race violations.
  // To resolve the ambiguity, out_reg is now driven solely by in_a (when not in reset).
  // The input 'in_b' is no longer used by out_reg, as there was no control
  // signal to multiplex between 'in_a' and 'in_b' in the original design.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= in_a;
    end
  end

endmodule
