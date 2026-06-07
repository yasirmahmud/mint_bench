module w259_ex1 (input clk, input rst, input in1, input in2, output reg out_sig);
  always @(posedge clk) begin
    if (rst) begin
      out_sig <= 1'b0;
    end else begin
      // Original design had a write-write race for out_sig between in1 and in2 when !rst.
      // To resolve this, in2 is chosen to be the driver in the !rst case,
      // effectively giving it precedence over in1 to remove the ambiguity.
      out_sig <= in2;
    end
  end
endmodule
