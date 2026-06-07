module fixedPriorityArbiter  #(parameter N = 4)(request, grant);

input [N-1:0] request;
output [N-1:0] grant;
  // Port[0] has highest priority
  assign grant[0] = request[0];

  genvar i;
  for (i=1; i<N; i=i+1) begin
    assign grant[i] = request[i] & ~(|grant[i-1:0]);
  end

endmodule
