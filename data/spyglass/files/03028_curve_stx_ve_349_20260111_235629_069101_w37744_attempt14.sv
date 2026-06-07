module curve_stx_ve_349_20260111_235629_069101_w37744_attempt14 (
  input wire clk,
  input wire rst_n,
  input wire enable_exit,
  output reg dummy_output
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      dummy_output <= 1'b0;
    end else begin
      if (enable_exit) begin
        // STX_VE_349 violation: Task or function name ( exit ) not defined
        // Calling the undefined 'exit' task within a fork...join block
        // ensures a distinct context for this violation example.
        fork
          exit; 
        join
      end
      dummy_output <= 1'b1;
    end
  end

endmodule
