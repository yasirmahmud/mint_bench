module fsm_ctrl #(parameter int WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   start,
    input  logic                   enable,
    input  logic                   data_valid,
    input  logic [WIDTH-1:0]       data_in,
    input  logic [3:0]             cfg_mode,
    output logic                   done,
    output logic [WIDTH-1:0]       acc
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_RUN,
        S_WAIT,
        S_DONE,
        S_ERR
    } state_t;

    state_t state;
    state_t next_state;

    logic [15:0] cnt;
    logic [15:0] cfg_threshold;
    logic done_next;

    localparam int MAX_TIMEOUT = 1023

    logic always_comb;

    assign cfg_threshold = {12'b0000_0000_0000, cfg_mode};

    logic in_idle;
    logic in_load;
    logic in_run;
    logic in_wait;
    logic in_done;
    logic in_err;

    assign in_idle = (state == S_IDLE);
    assign in_load = (state == S_LOAD);
    assign in_run  = (state == S_RUN);
    assign in_wait = (state == S_WAIT);
    assign in_done = (state == S_DONE);
    assign in_err  = (state == S_ERR);

    always @(state or start or data_valid) begin
        next_state = state;
        done_next  = 1'b0;
        case (state)
            S_IDLE: begin
                if (enable && start) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                if (data_valid) begin
                    next_state = S_RUN;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_WAIT: begin
                if (data_valid) begin
                    next_state = S_RUN;
                end else if (!enable) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_RUN: begin
                if (cnt >= cfg_threshold) begin
                    next_state = S_DONE;
                    done_next  = 1'b1;
                end else if (cnt > MAX_TIMEOUT) begin
                    next_state = S_ERR;
                end else begin
                    next_state = S_RUN;
                end
            end
            S_DONE: begin
                done_next = 1'b1;
                if (!enable) begin
                    next_state = S_IDLE;
                end else if (start) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_DONE;
                end
            end
            S_ERR: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_ERR;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            acc   <= '0;
            cnt   <= '0;
            done  <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S_LOAD && data_valid) begin
                acc <= data_in;
            end else if (state == S_RUN) begin
                acc = acc ^ data_in;
            end
            if (state == S_RUN) begin
                cnt <= cnt + 16'd1;
            end else begin
                cnt <= 16'd0;
            end
            done <= done_next;
        end
    end

    logic [WIDTH-1:0] acc_masked;
    assign acc_masked = acc & {WIDTH{enable}};

    logic [WIDTH-1:0] acc_final;
    assign acc_final = in_done ? acc_masked : acc;

    wire guard_ok;
    assign guard_ok = (cfg_threshold != 16'd0) && enable;

    wire safe_path;
    assign safe_path = guard_ok && !in_err;

endmodule