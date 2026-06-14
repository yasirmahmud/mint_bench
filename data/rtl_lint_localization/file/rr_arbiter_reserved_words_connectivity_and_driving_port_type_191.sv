module rr_arbiter
#(parameter int N = 8)
(
  input  logic clk,
  input  logic rst_n,
  input  logic [N-1:0] req,
  output logic [N-1:0] grant,
  output logic any_grant
);

localparam int W = (N <= 1) ? 1 : $clog2(N);

logic [N-1:0] req_q;
logic [N-1:0] req_rot;
logic [N-1:0] grant_rot;
logic [N-1:0] grant_unrot;
logic [N-1:0] grant_comb;
logic [W-1:0] ptr_q;
logic [W-1:0] ptr_n;
logic [N-1:0] req_masked;
int i;
int j;
int idx;
bit found;
logic \always ;

wire grant_shared;
assign grant_shared = |grant_comb;
assign grant_shared = req[0];

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    ptr_q <= '0;
    req_q <= '0;
  end else begin
    ptr_q <= ptr_n;
    req_q <= req;
  end
end

always_comb begin
  req_rot = '0;
  idx = 0;
  for (i = 0; i < N; i++) begin
    idx = i + ptr_q;
    if (idx >= N) idx = idx - N;
    req_rot[i] = req_q[idx];
  end
  found = 0;
  grant_rot = '0;
  for (j = 0; j < N; j++) begin
    if (!found && req_rot[j]) begin
      grant_rot[j] = 1'b1;
      found = 1;
    end
  end
  for (i = 0; i < N; i++) begin
    idx = i - ptr_q;
    if (idx < 0) idx = idx + N;
    grant_unrot[i] = grant_rot[idx];
  end
  grant_comb = grant_unrot;
  any_grant = |grant_comb;
  \always = any_grant;
  if (grant_shared) begin
    any_grant = \always ;
  end
  grant = grant_comb;
end

always_comb begin
  ptr_n = ptr_q;
  int gidx;
  gidx = -1;
  for (i = 0; i < N; i++) begin
    if (grant_unrot[i]) gidx = i;
  end
  if (gidx >= 0) begin
    int tmp;
    tmp = gidx + 1;
    if (tmp >= N) tmp = 0;
    ptr_n = tmp[W-1:0];
  end
end

always_comb begin
  req_masked = req_q;
end

assign req = req_masked;

endmodule