module arbiter_sv #(parameter int N = 4) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic       [N-1:0]     req,
    input  logic       [N-1:0]     lock,
    input  logic       [N-1:0]     priority,
    output logic       [N-1:0]     grant,
    output logic                   valid,
    output logic [$clog2(N)-1:0]   grant_idx
);

  localparam int IDX_W = $clog2(N);

  function automatic logic [N-1:0] rotate_left(
      input logic [N-1:0] v,
      input logic [IDX_W-1:0] s
  );
    logic [N-1:0] r;
    int i;
    int j;
    begin
      r = '0;
      for (i = 0; i < N; i++) begin
        j = i - s;
        if (j < 0) j = j + N;
        r[i] = v[j];
      end
      return r;
    end
  endfunction

  function automatic logic [N-1:0] rotate_right(
      input logic [N-1:0] v,
      input logic [IDX_W-1:0] s
  );
    logic [N-1:0] r;
    int i;
    int j;
    begin
      r = '0;
      for (i = 0; i < N; i++) begin
        j = i + s;
        if (j >= N) j = j - N;
        r[i] = v[j];
      end
      return r;
    end
  endfunction

  function automatic logic [N-1:0] pick_first_one(
      input logic [N-1:0] v
  );
    logic [N-1:0] r;
    int i;
    begin
      r = '0;
      for (i = 0; i < N; i++) begin
        if (v[i] && r == '0) r[i] = 1'b1;
      end
      return r;
    end
  endfunction

  logic [IDX_W-1:0] rr_pointer;
  logic [IDX_W-1:0] next_rr_pointer;
  logic [N-1:0]     rot_req;
  logic [N-1:0]     sel_rot;
  logic [N-1:0]     sel_unrot;

  always_comb begin
    rot_req = rotate_left(req & ~lock, rr_pointer);
  end

  always @(priority) begin
    logic [N-1:0] cand_pri;
    logic [N-1:0] cand_any;
    cand_pri = rot_req & priority;
    cand_any = rot_req;
    if (cand_pri != '0) begin
      sel_rot = pick_first_one(cand_pri);
    end else begin
      sel_rot = pick_first_one(cand_any);
    end
  end

  always_comb begin
    sel_unrot = rotate_right(sel_rot, rr_pointer);
    grant = sel_unrot;
  end

  assign valid = |grant;

  assign grant_idx = grant;

  always_comb begin
    next_rr_pointer = rr_pointer;
    if (valid) begin
      next_rr_pointer = rr_pointer + 1'b1;
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rr_pointer <= '0;
    end else begin
      rr_pointer <= next_rr_pointer;
    end
  end

endmodule