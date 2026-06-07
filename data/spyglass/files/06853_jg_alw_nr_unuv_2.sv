module example2_unuv (
  input wire a,
  input wire b,
  input wire c,
  output reg out_val
);

  always @(a or b or c) begin // c is in sensitivity list
    if (a) begin
      out_val = b;
    end else begin
      out_val = 1'b0;
    end
  end

endmodule
