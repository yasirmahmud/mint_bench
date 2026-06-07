module test_ex2(clk, rst, d, out);
  input clk, rst, d;
  output out;
  reg tmp, b_sig, c_sig;
  IOBUF_ex2 io_inst (.A(clk), .B(b_sig), .X(c_sig));
  always @(posedge c_sig or posedge rst) begin
    if (rst) tmp <= 1'b0;
    else tmp <= d;
  end
  assign out = tmp;
endmodule
