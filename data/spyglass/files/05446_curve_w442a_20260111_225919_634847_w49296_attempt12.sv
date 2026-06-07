module curve_w442a_20260111_225919_634847_w49296_attempt12 (
    input clk,
    input rst_n,
    input [7:0] data_in,
    output reg [7:0] q_out
);

  always @(posedge clk or negedge rst_n) begin
    // W442a violation: An assignment is the top-level statement,
    // not the asynchronous reset 'if' statement, for this always block.
    q_out <= data_in; 

    // The asynchronous reset check appears after an initial assignment.
    if (!rst_n) begin
      q_out <= 8'b0;
    end
  end

endmodule
