module LatchBlockingAssign1 (
  input wire enable,
  input wire data_in,
  output reg data_out
);

  always @* begin
    if (enable) begin
      data_out = data_in; // Latch inferred, blocking assignment
    end
  end

endmodule
