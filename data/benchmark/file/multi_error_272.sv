module fsm_with_two_defects #(parameter COUNT_MAX = 4'd10) (
  input  logic        clk,
  input  logic        rst_n,
  input  logic        start,
  input  logic        stop,
  input  logic [1:0]  mode,
  input  logic [7:0]  data_in,
  input  logic [7:0]  threshold,
  output logic        ready,
  output logic        busy,
  output logic        error_flag,
  output logic [7:0]  data_out
);

typedef enum logic [2:0] {
  S_IDLE,
  S_LOAD,
  S_PROCESS,
  S_WAIT,
  S_DONE,
  S_ERROR,
  S_UNUSED
} state_t;

state_t state, next_state;
logic [3:0] counter;
logic [7:0] data_buf;
logic gate_enable;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state <= S_IDLE;
    counter <= 4'd0;
    data_buf <= 8'd0;
    data_out <= 8'd0;
  end else begin
    state <= next_state;
    case (state)
      S_IDLE: begin
        counter <= 4'd0;
      end
      S_LOAD: begin
        data_buf <= data_in;
        counter <= 4'd0;
      end
      S_PROCESS: begin
        counter <= counter + 4'd1;
        if (gate_enable) data_out <= data_buf ^ {6'd0, mode}; else data_out <= data_out;
      end
      S_WAIT: begin
        counter <= counter;
      end
      S_DONE: begin
        counter <= 4'd0;
      end
      S_ERROR: begin
        counter <= counter;
      end
      default: begin
        counter <= 4'd0;
      end
    endcase
  end
end

always_comb begin
  next_state = state;
  unique case (state)
    S_IDLE: begin
      if (start) next_state = S_LOAD;
    end
    S_LOAD: begin
      if (stop) next_state = S_ERROR; else next_state = S_PROCESS;
    end
    S_PROCESS: begin
      if (stop) next_state = S_ERROR;
      else if (counter >= COUNT_MAX) next_state = S_WAIT;
      else if (data_buf > threshold) next_state = S_WAIT;
    end
    S_WAIT: begin
      if (!stop && mode[1]) next_state = S_DONE;
      else if (!stop && !mode[1]) next_state = S_PROCESS;
      else next_state = S_ERROR;
    end
    S_DONE: begin
      next_state = S_IDLE;
    end
    S_ERROR: begin
      if (!stop) next_state = S_IDLE;
    end
    default: begin
      next_state = S_ERROR;
    end
  endcase
end

assign ready = (state == S_IDLE);
assign busy = (state == S_LOAD) || (state == S_PROCESS) || (state == S_WAIT);
assign error_flag = (state == S_ERROR);

always_comb begin
  if (state == S_PROCESS && mode[0]) gate_enable = 1'b1;
end

endmodule