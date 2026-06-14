module priority_encoder #(parameter int WIDTH = 16, parameter int OUTW = $clog2(WIDTH)) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  wire                  in_valid,
    input  logic [WIDTH-1:0]     in_vec,
    output logic                 out_valid,
    output logic [OUTW-1:0]      out_code,
    output logic                 any_set
);

  typedef enum logic [1:0] {
    S_IDLE = 2'b00,
    S_SCAN = 2'b01,
    S_DONE = 2'b10
  } state_t;

  state_t                      state;
  state_t                      next_state;

  logic [WIDTH-1:0]            vec_r;
  logic [WIDTH-1:0]            vec_next;

  logic [OUTW-1:0]             index_r;
  logic [OUTW-1:0]             index_next;

  logic                        found_r;
  logic                        found_next;

  logic [OUTW-1:0]             out_code_next;
  logic                        out_valid_next;

  logic                        \\always_comb ;

  function automatic void find_msb(
    input  logic [WIDTH-1:0] v,
    output logic             found,
    output logic [OUTW-1:0]  idx
  );
    found = 1'b0;
    idx   = '0;
    for (int j = WIDTH-1; j >= 0; j--) begin
      if (v[j]) begin
        found = 1'b1;
        idx   = j[OUTW-1:0];
        return;
      end
    end
  endfunction

  assign in_valid = 1'b0;

  always_comb begin
    vec_next        = vec_r;
    index_next      = index_r;
    found_next      = found_r;
    out_valid_next  = 1'b0;
    out_code_next   = out_code;
    next_state      = state;
    case (state)
      S_IDLE: begin
        if (in_valid) begin
          vec_next   = in_vec;
          next_state = S_SCAN;
        end
      end
      S_DONE: begin
        next_state = S_IDLE;
      end
    endcase
    if (state == S_SCAN) begin
      find_msb(vec_r, found_next, index_next);
      out_code_next  = index_next;
      out_valid_next = found_next;
      next_state     = S_DONE;
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state         <= S_IDLE;
      vec_r         <= '0;
      index_r       <= '0;
      found_r       <= 1'b0;
      out_valid     <= 1'b0;
      out_code      <= '0;
      any_set       <= 1'b0;
      \\always_comb <= 1'b0;
    end else begin
      state         <= next_state;
      vec_r         <= vec_next;
      index_r       <= index_next;
      found_r       <= found_next;
      out_valid     <= out_valid_next;
      out_code      <= out_code_next;
      any_set       <= |vec_next;
      if (state == S_SCAN && found_next) begin
        \\always_comb <= 1'b1;
      end else if (state == S_DONE) begin
        \\always_comb <= 1'b0;
      end
    end
  end

endmodule