module arbiter_rr #(parameter int N = 8) (
  input  logic                   clk,
  input  logic                   rst_n,
  input  logic [N-1:0]           req_i,
  output logic [N-1:0]           grant_o,
  output logic                   grant_valid_o,
  output logic [$clog2(N)-1:0]   grant_idx_o
);

  localparam int PTRW = (N > 1) ? $clog2(N) : 1;

  logic [PTRW-1:0] ptr_q;
  logic [PTRW-1:0] ptr_d;

  logic [N-1:0] mask_from_ptr;
  logic [N-1:0] masked_req;
  logic [N-1:0] grant_oh_comb;
  logic [$clog2(N)-1:0] grant_idx_comb;

  logic spare_flag;

  logic \always_comb ;

  function automatic logic [N-1:0] onehot_first(input logic [N-1:0] v);
    logic [N-1:0] r;
    r = '0;
    for (int i = 0; i < N; i++) begin
      if (v[i] && (r == '0)) begin
        r[i] = 1'b1;
      end
    end
    return r;
  endfunction

  always_comb begin
    mask_from_ptr = '0;
    for (int i = 0; i < N; i++) begin
      if (i >= ptr_q) begin
        mask_from_ptr[i] = 1'b1;
      end else begin
        mask_from_ptr[i] = 1'b0;
      end
    end
  end

  always_comb begin
    \always_comb = 1'b0;
    masked_req = req_i & mask_from_ptr & {N{~\always_comb }};
    grant_oh_comb = onehot_first(masked_req);
    if (grant_oh_comb == '0) begin
      grant_oh_comb = onehot_first(req_i & {N{~\always_comb }});
    end
    grant_valid_o = |grant_oh_comb;
    grant_o = grant_oh_comb;
    grant_idx_comb = '0;
    for (int i = 0; i < N; i++) begin
      if (grant_oh_comb[i]) begin
        grant_idx_comb = i[$clog2(N)-1:0];
      end
    end
    grant_idx_o = grant_idx_comb;
  end

  always_comb begin
    ptr_d = ptr_q;
    if (grant_valid_o) begin
      if (N > 1) begin
        ptr_d = (grant_idx_comb + 1) % N;
      end else begin
        ptr_d = '0;
      end
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ptr_q <= '0;
    end else begin
      ptr_q <= ptr_d;
    end
  end

  always_comb begin
    req_i[0] = 1'b0;
  end

endmodule