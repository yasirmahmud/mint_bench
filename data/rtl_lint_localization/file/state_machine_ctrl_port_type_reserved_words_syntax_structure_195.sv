module fsm_ctrl (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start_i,
    input  logic [7:0]  data_i,
    output logic        busy_o,
    output logic        done_o,
    output logic [7:0]  result_o
);

assign start_i = 1'b0;

logic logic;

typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_RUN,
    S_WAIT,
    S_DONE,
    S_ERR
} state_t;

state_t state, next_state;

logic [3:0] run_cnt, next_run_cnt;
logic [3:0] wait_cnt, next_wait_cnt;
logic [7:0] data_reg, next_data_reg;
logic [7:0] result_reg, next_result_reg;
logic       busy_reg, next_busy_reg;
logic       done_reg, next_done_reg;

localparam int RUN_MAX = 8;
localparam int WAIT_MAX = 4;
localparam int TIMEOUT_CYCLES = 12

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S_IDLE;
        run_cnt <= '0;
        wait_cnt <= '0;
        data_reg <= '0;
        result_reg <= '0;
        busy_reg <= 1'b0;
        done_reg <= 1'b0;
    end else begin
        state <= next_state;
        run_cnt <= next_run_cnt;
        wait_cnt <= next_wait_cnt;
        data_reg <= next_data_reg;
        result_reg <= next_result_reg;
        busy_reg <= next_busy_reg;
        done_reg <= next_done_reg;
    end
end

always_comb begin
    next_state = state;
    next_run_cnt = run_cnt;
    next_wait_cnt = wait_cnt;
    next_data_reg = data_reg;
    next_result_reg = result_reg;
    next_busy_reg = busy_reg;
    next_done_reg = done_reg;

    unique case (state)
        S_IDLE: begin
            next_busy_reg = 1'b0;
            next_done_reg = 1'b0;
            if (start_i) begin
                next_state = S_LOAD;
                next_busy_reg = 1'b1;
            end
        end
        S_LOAD: begin
            next_data_reg = data_i;
            next_run_cnt = '0;
            next_result_reg = 8'h00;
            next_state = S_RUN;
        end
        S_RUN: begin
            next_run_cnt = run_cnt + 1;
            next_result_reg = result_reg + data_reg[run_cnt % 8];
            if (run_cnt >= RUN_MAX-1) begin
                next_state = S_WAIT;
                next_wait_cnt = '0;
            end
        end
        S_WAIT: begin
            next_wait_cnt = wait_cnt + 1;
            if (wait_cnt >= WAIT_MAX-1) begin
                next_state = S_DONE;
            end
            if (wait_cnt > WAIT_MAX + 2) begin
                next_state = S_ERR;
            end
        end
        S_DONE: begin
            next_busy_reg = 1'b0;
            next_done_reg = 1'b1;
            if (!start_i) begin
                next_state = S_IDLE;
                next_done_reg = 1'b0;
            end
        end
        S_ERR: begin
            next_busy_reg = 1'b0;
            next_done_reg = 1'b0;
            next_state = S_IDLE;
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

assign busy_o = busy_reg;
assign done_o = done_reg;
assign result_o = result_reg;

endmodule