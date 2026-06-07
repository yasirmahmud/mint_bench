module curve_stx_ve_775_20260110_200225_attempt10 (
  input clk,
  input rst_n,
  output reg [7:0] data_out
);

  task my_dummy_task;
    // STX_VE_775: Initial statement not allowed in this scope
    // According to Verilog-2001 (IEEE Std 1364-2001), initial blocks
    // are procedural blocks and must be specified within module, UDP, or interface declarations.
    // They are not allowed within the scope of a task or function, which contain procedural statements.
    initial begin
      data_out = 8'h00; // This initial block is in an illegal scope
    end
  endtask

  // Dummy logic to ensure data_out is used and the module is otherwise valid RTL
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'h00;
    end else begin
      data_out <= data_out + 1;
    end
  end

endmodule
