module curve_w442a (
    input clk,
    input rst_n,
    input enable,
    input [7:0] data_in,
    output reg [7:0] q_out
);

  always @(posedge clk or negedge rst_n) begin
    // W442a violation: The 'if (enable)' statement is at the top level,
    // not the 'if (!rst_n)' statement, for an asynchronously reset block.
    if (enable) begin 
      if (!rst_n) begin
        q_out <= 8'b0;
      end else begin
        q_out <= data_in;
      end
    end else begin
      // Hold value when not enabled to avoid unintended latches
      q_out <= q_out; 
    end
  end

endmodule
