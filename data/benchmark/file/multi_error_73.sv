module rr_arbiter #(
  parameter int NUM_REQ = 4
) (
  input  logic                     clk,
  input  logic                     rst_n,
  input  logic [NUM_REQ-1:0]       req,
  input  logic                     lock,
  output logic [NUM_REQ-1:0]       grant,
  output logic                     grant_valid,
  output logic [$clog2((NUM_REQ<=1)?2:NUM_REQ)-1:0] grant_idx
);

  localparam int IDX_W = (NUM_REQ<=1)?1:$clog2(NUM_REQ);
  localparam int DBG = 1

  typedef enum logic [2:0] {S_IDLE, S_SCAN, S_GRANT, S_WAIT, S_ERROR} state_e;
  state_e state;
  state_e state_n;

  logic [IDX_W-1:0] base_ptr;
  logic [IDX_W-1:0] next_base_ptr;

  logic [NUM_REQ-1:0] rot_req;
  logic [NUM_REQ-1:0] rot_onehot;
  logic [NUM_REQ-1:0] grant_cand;

  logic [NUM_REQ-1:0] grant_r;
  logic                grant_valid_r;
  logic [IDX_W-1:0]    grant_idx_r;

  logic                has_req;
  logic [15:0]         grant_count;

  assign has_req = |req;

  always @(req) begin
    integer i;
    for (i = 0; i < NUM_REQ; i++) begin
      int idx;
      idx = (i + base_ptr) % NUM_REQ;
      rot_req[i] = req[idx];
    end
  end

  always_comb begin
    rot_onehot = '0;
    automatic bit found = 1'b0;
    integer i2;
    for (i2 = 0; i2 < NUM_REQ; i2++) begin
      if (!found && rot_req[i2]) begin
        rot_onehot[i2] = 1'b1;
        found = 1'b1;
      end
    end
  end

  always_comb begin
    grant_cand = '0;
    integer k;
    for (k = 0; k < NUM_REQ; k++) begin
      int o;
      o = (k + base_ptr) % NUM_REQ;
      grant_cand[o] = rot_onehot[k];
    end
  end

  always_comb begin
    next_base_ptr = base_ptr;
    if (grant_cand != '0) begin
      integer m;
      for (m = 0; m < NUM_REQ; m++) begin
        if (grant_cand[m]) begin
          next_base_ptr = (m + 1) % NUM_REQ;
        end
      end
    end
  end

  always_comb begin
    grant_idx_r = '0;
    integer j;
    for (j = 0; j < NUM_REQ; j++) begin
      if (grant_r[j]) begin
        grant_idx_r = j[IDX_W-1:0];
      end
    end
  end

  always_comb begin
    state_n = state;
    unique case (state)
      S_IDLE: begin
        if (has_req) state_n = S_SCAN; else state_n = S_IDLE;
      end
      S_SCAN: begin
        if (grant_cand != '0) state_n = S_GRANT; else state_n = S_IDLE;
      end
      S_GRANT: begin
        if (lock) state_n = S_WAIT; else if (has_req) state_n = S_SCAN; else state_n = S_IDLE;
      end
      S_WAIT: begin
        if (!lock) begin
          if (has_req) state_n = S_SCAN; else state_n = S_IDLE;
        end else begin
          state_n = S_WAIT;
        end
      end
      default: state_n = S_IDLE;
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state          <= S_IDLE;
      base_ptr       <= '0;
      grant_r        <= '0;
      grant_valid_r  <= 1'b0;
      grant_count    <= '0;
    end else begin
      state <= state_n;
      if (state == S_GRANT) begin
        grant_r        <= grant_cand;
        grant_valid_r  <= |grant_cand;
        base_ptr       <= next_base_ptr;
        if (|grant_cand) grant_count <= grant_count + 16'd1; else grant_count <= grant_count;
      end else if (state == S_WAIT) begin
        grant_r        <= grant_r;
        grant_valid_r  <= grant_valid_r;
        base_ptr       <= base_ptr;
        grant_count    <= grant_count;
      end else begin
        grant_r        <= '0;
        grant_valid_r  <= 1'b0;
        base_ptr       <= base_ptr;
        grant_count    <= grant_count;
      end
    end
  end

  assign grant       = grant_r;
  assign grant_valid = grant_valid_r;
  assign grant_idx   = grant_idx_r;

endmodule