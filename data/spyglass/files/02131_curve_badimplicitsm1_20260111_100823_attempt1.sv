module curve_badimplicitsm1_20260111_100823_attempt1 (
  input clk,
  input rst, // Asynchronous reset
  input enable,
  input data_in,
  output reg q
);

  always @(posedge clk or posedge rst) begin
    if (enable) begin // 'enable' is checked first
      q <= data_in;
    end else if (rst) begin // Asynchronous 'rst' should be checked first, but is not.
      q <= 1'b0;
    end else begin
      q <= q;
    end
  end

endmodule
