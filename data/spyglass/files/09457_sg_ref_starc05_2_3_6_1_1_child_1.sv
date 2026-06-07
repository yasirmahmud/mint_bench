module my_module_ex1 (input clk, input rst_n, input in1, input in2, output reg out1, output reg out2);
  // Register out1 has an asynchronous reset.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out1 <= 1'b0;
    end else begin
      out1 <= in1;
    end
  end

  // Register out2 is updated synchronously, enabled by rst_n.
  // This resolves the STARC05-1.3.1.3 violation by separating the usage
  // of rst_n for out1's asynchronous reset and out2's synchronous enable.
  always @(posedge clk) begin
    if (rst_n) begin // rst_n acts as a synchronous enable for out2
      out2 <= in2;
    end
    // When rst_n is low, out2 retains its current value, matching original behavior.
  end
endmodule
