module LatchReset_ex2 (input d, input en, input rst, output reg q_async, output reg q_sync);
 always @(d or en or rst) begin if (rst) q_async = 1'b0;
 else if (en) q_async = d;
 end always @(d or en or rst) begin if (en) begin if (rst) q_sync = 1'b0;
 else q_sync = d;
 end end endmodule
