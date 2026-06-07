module inout_io_output_ex1(clk_in, rst_in, d_in, inout_b, q_out);
 input clk_in, rst_in, d_in;
 inout inout_b;
 output q_out;
 wire io_buf_x;
 reg flop_q;
 IOBUF u_iobuf (.A(clk_in), .B(inout_b), .X(io_buf_x));
 always @(posedge io_buf_x or posedge rst_in) begin if (rst_in) flop_q <= 1'b0;
 else flop_q <= d_in;
 end assign q_out = flop_q;
 endmodule
