module final_block_example_2(
  input clk,
  input rst_n,
  output reg [3:0] count
);

  initial begin
    count = 4'h0;
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count <= 4'h0;
    end else begin
      count <= count + 1;
    end
  end

  final begin
    $display("Simulation ended. Final count value: %0d", count);
  end

endmodule
