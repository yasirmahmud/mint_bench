module CheckAsyncHold_ML_ex1 (input cond, output reg q);
  always @(cond) begin
    if (cond == 1'b0) begin // When cond is low, q is reset
      q <= 1'b0;
    end
    // else if (cond == 1'b1), q retains its value (implied latch behavior)
  end
endmodule
