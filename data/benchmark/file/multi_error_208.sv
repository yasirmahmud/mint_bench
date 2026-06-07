module fsm_misclean (
  input  logic        clk,
  input  logic        rst_n,
  input  logic        start,
  input  logic        load_valid,
  input  logic [15:0] data_in,
  output logic        done,
  output logic [7:0]  sum,
  output logic        parity,
  output logic [3:0]  dbg
);

  typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_ACCUM,
    S_CHECK,
    S_DONE
  } state_t;

  state_t state;
  state_t next_state;
  logic [15:0] acc;
  logic [3:0]  count;
  logic [7:0]  shadow_sum;

  assign sum  = shadow_sum;
  assign done = (state == S_DONE);
  assign dbg  = acc;

  always @(clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= S_IDLE;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    next_state = state;
    case (state)
      S_IDLE: begin
        if (start) next_state = S_LOAD;
        else next_state = S_IDLE;
      end
      S_LOAD: begin
        if (load_valid) next_state = S_ACCUM;
        else next_state = S_LOAD;
      end
      S_ACCUM: begin
        if (count == 4'd7) next_state = S_CHECK;
        else next_state = S_ACCUM;
      end
      S_CHECK: begin
        next_state = S_DONE;
      end
      S_DONE: begin
        if (!start) next_state = S_IDLE;
        else next_state = S_DONE;
      end
      default: next_state = S_IDLE;
    endcase
  end

  always @(posedge clk) begin
    if (!rst_n) begin
      acc        <= 16'd0;
      count      <= 4'd0;
      shadow_sum = 8'd0;
    end else begin
      if (state == S_LOAD && load_valid) begin
        acc   <= data_in;
        count <= 4'd0;
      end else if (state == S_ACCUM) begin
        acc   <= acc + data_in;
        count <= count + 4'd1;
      end
      shadow_sum = acc[7:0];
    end
  end

  always_comb begin
    case (state)
      S_IDLE:  parity = 1'b0;
      S_LOAD:  parity = ^data_in;
      S_ACCUM: parity = ^acc;
      S_CHECK: parity = ^(acc[7:0]);
      S_DONE:  ;
    endcase
  end

endmodule