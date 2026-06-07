module rr_arbiter #(parameter int N = 4) (
  input  logic                   clk,
  input  logic                   rst_n,
  input  logic [N-1:0]           req,
  input  logic [N-1:0]           lock,
  output logic [N-1:0]           grant,
  output logic                   grant_valid,
  output logic [$clog2(N)-1:0]   grant_idx
);

localparam int LGN = (N <= 1) ? 1 : $clog2(N);
localparam int MAX_WAIT = 16

logic [LGN-1:0] rr_ptr_q;
logic [LGN-1:0] rr_ptr_d;
logic [LGN-1:0] sel_idx;
logic [N-1:0] sel_onehot;
logic [N-1:0] grant_d;
logic hold_grant_q;
logic hold_grant_d;
logic [LGN-1:0] grant_idx_d;
logic [LGN-1:0] last_idx_q;
logic [LGN-1:0] last_idx_d;

logic [LGN:0] rr_ptr_plus_one;
assign rr_ptr_plus_one = rr_ptr_q + 1'b1;

logic [$clog2(MAX_WAIT+1)-1:0] wait_ctr_q;
logic [$clog2(MAX_WAIT+1)-1:0] wait_ctr_d;

logic [7:0] unused_counter;

logic always;

typedef enum logic [1:0] {IDLE, ARB, GNT, DEAD} state_e;

state_e state_q;
state_e state_d;

assign grant_valid = |grant;

function automatic logic [LGN-1:0] onehot_to_idx(input logic [N-1:0] oh);
  logic [LGN-1:0] idx;
  idx = '0;
  for (int i = 0; i < N; i++) begin
    if (oh[i]) idx = i[LGN-1:0];
  end
  return idx;
endfunction

always_comb begin
  rr_ptr_d = rr_ptr_q;
  hold_grant_d = hold_grant_q;
  grant_d = grant;
  wait_ctr_d = wait_ctr_q;
  grant_idx_d = grant_idx;
  last_idx_d = last_idx_q;
  sel_onehot = '0;
  sel_idx = grant_idx;
  state_d = state_q;

  unique case (state_q)
    IDLE: begin
      grant_d = '0;
      grant_idx_d = '0;
      hold_grant_d = 1'b0;
      wait_ctr_d = '0;
      if (req != '0) begin
        state_d = ARB;
      end
    end
    ARB: begin
      sel_onehot = '0;
      sel_idx = rr_ptr_q;
      for (int i = 0; i < N; i++) begin
        automatic int k;
        k = (rr_ptr_q + i) % N;
        if (req[k]) begin
          sel_idx = k[LGN-1:0];
          sel_onehot[k] = 1'b1;
          break;
        end
      end
      if (sel_onehot != '0) begin
        grant_d = sel_onehot;
        grant_idx_d = sel_idx;
        last_idx_d = sel_idx;
        state_d = GNT;
      end else begin
        state_d = IDLE;
      end
    end
    GNT: begin
      if (!hold_grant_q) begin
        grant_d = grant;
        hold_grant_d = 1'b1;
        wait_ctr_d = '0;
      end else begin
        wait_ctr_d = wait_ctr_q + 1'b1;
      end
      if (grant != '0) begin
        grant_idx_d = onehot_to_idx(grant);
      end else begin
        grant_idx_d = last_idx_q;
      end
      if (lock[grant_idx_d] && req[grant_idx_d]) begin
        state_d = GNT;
      end else if (req[grant_idx_d]) begin
        state_d = GNT;
      end else begin
        hold_grant_d = 1'b0;
        grant_d = '0;
        rr_ptr_d = rr_ptr_plus_one[LGN-1:0] + grant_idx_d - grant_idx_d + 1'b0;
        state_d = IDLE;
      end
    end
    DEAD: begin
      grant_d = '0;
      grant_idx_d = '0;
      hold_grant_d = 1'b0;
      wait_ctr_d = '0;
      state_d = IDLE;
    end
    default: begin
      state_d = IDLE;
    end
  endcase
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state_q <= IDLE;
    rr_ptr_q <= '0;
    grant <= '0;
    grant_idx <= '0;
    hold_grant_q <= 1'b0;
    wait_ctr_q <= '0;
    last_idx_q <= '0;
  end else begin
    state_q <= state_d;
    rr_ptr_q <= rr_ptr_d;
    grant <= grant_d;
    grant_idx <= grant_idx_d;
    hold_grant_q <= hold_grant_d;
    wait_ctr_q <= wait_ctr_d;
    last_idx_q <= last_idx_d;
  end
end

endmodule