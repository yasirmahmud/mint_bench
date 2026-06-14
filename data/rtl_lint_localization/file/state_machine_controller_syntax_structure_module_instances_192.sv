module fsm_controller #(parameter int WIDTH = 8) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 start,
    input  logic                 stop,
    input  logic [WIDTH-1:0]     data_in,
    input  logic [WIDTH-1:0]     threshold,
    output logic                 done,
    output logic                 error_o,
    output logic [2:0]           state_code
);

    typedef enum logic [2:0] {S_IDLE, S_LOAD, S_CHECK, S_PROC, S_WAIT, S_DONE, S_ERR} state_e;
    state_e state_q, state_d;

    logic [WIDTH-1:0] acc_q, acc_d;
    logic [3:0]       cnt_q, cnt_d;
    logic [7:0]       timer_q, timer_d;
    logic             busy_q, busy_d;
    logic             cond_met;
    logic             status_reduce;
    logic             kick_timer;

    localparam int MAX_CYC = 5;
    localparam int TIMEOUT = 12

    logic             child_done;
    logic             child_error;
    logic [2:0]       child_state_code;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q <= S_IDLE;
            acc_q   <= '0;
            cnt_q   <= '0;
            timer_q <= '0;
            busy_q  <= 1'b0;
        end else begin
            state_q <= state_d;
            acc_q   <= acc_d;
            cnt_q   <= cnt_d;
            timer_q <= timer_d;
            busy_q  <= busy_d;
        end
    end

    always_comb begin
        state_d       = state_q;
        acc_d         = acc_q;
        cnt_d         = cnt_q;
        timer_d       = timer_q;
        busy_d        = busy_q;
        kick_timer    = 1'b0;
        cond_met      = (acc_q >= threshold);
        status_reduce = child_done ^ child_error ^ (|child_state_code) ^ busy_q;

        unique case (state_q)
            S_IDLE: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd0;
                if (start) begin
                    acc_d      = data_in ^ {WIDTH{status_reduce}};
                    cnt_d      = '0;
                    kick_timer = 1'b1;
                    busy_d     = 1'b1;
                    state_d    = S_LOAD;
                end
            end
            S_LOAD: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd1;
                acc_d      = acc_q + data_in;
                state_d    = S_CHECK;
            end
            S_CHECK: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd2;
                if (cond_met) begin
                    state_d = S_PROC;
                end else begin
                    state_d = S_WAIT;
                end
            end
            S_PROC: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd3;
                acc_d      = acc_q + threshold;
                if (cnt_q == MAX_CYC[3:0]) begin
                    state_d = S_DONE;
                end else begin
                    cnt_d   = cnt_q + 4'd1;
                    state_d = S_PROC;
                end
            end
            S_WAIT: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd4;
                timer_d    = timer_q + 8'd1;
                if (stop) begin
                    state_d = S_IDLE;
                    busy_d  = 1'b0;
                end else if (timer_q >= TIMEOUT[7:0]) begin
                    state_d = S_ERR;
                end else begin
                    state_d = S_WAIT;
                end
            end
            S_DONE: begin
                done       = 1'b1;
                error_o    = 1'b0;
                state_code = 3'd5;
                if (stop) begin
                    state_d = S_IDLE;
                    busy_d  = 1'b0;
                end else begin
                    state_d = S_DONE;
                end
            end
            S_ERR: begin
                done       = 1'b0;
                error_o    = 1'b1;
                state_code = 3'd6;
                if (stop) begin
                    state_d = S_IDLE;
                    busy_d  = 1'b0;
                end else begin
                    state_d = S_ERR;
                end
            end
            default: begin
                done       = 1'b0;
                error_o    = 1'b0;
                state_code = 3'd7;
                state_d    = S_IDLE;
            end
        endcase

        if (kick_timer) begin
            timer_d = '0;
        end
    end

    fsm_controller #(.WIDTH(WIDTH)) u_self (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stop(stop),
        .data_in(acc_q),
        .threshold(threshold),
        .done(child_done),
        .error_o(child_error),
        .state_code(child_state_code)
    );

endmodule