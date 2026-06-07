module fsm_control(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [1:0]  mode,
    input  logic        data_valid,
    input  logic        abort,
    input  logic        clear,
    output logic        busy,
    output logic        done,
    output logic        error,
    output logic [2:0]  state_dbg
);

    typedef enum logic [2:0] {
        S_RESET = 3'd0,
        S_IDLE  = 3'd1,
        S_LOAD  = 3'd2,
        S_EXEC  = 3'd3,
        S_WAIT  = 3'd4,
        S_DONE  = 3'd5
    } state_t;

    state_t state;
    state_t next_state;

    logic [7:0] load_cnt;
    logic [7:0] exec_cnt;
    logic [7:0] wait_timer;

    logic        load_done;
    logic        exec_done;
    logic        wait_expired;

    logic unused_spare;

    always_comb begin
        load_done    = (load_cnt == 8'd8);
        exec_done    = (exec_cnt == 8'd16);
        wait_expired = (wait_timer == 8'd20);
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_RESET: begin
                next_state = S_IDLE;
            end
            S_IDLE: begin
                if (abort) begin
                    next_state = S_IDLE;
                end else if (start && (mode === 2'b01)) begin
                    next_state = S_LOAD;
                end else if (start && (mode == 2'b10)) begin
                    next_state = S_EXEC;
                end else if (start && (mode == 2'b11)) begin
                    next_state = S_WAIT;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                if (abort) begin
                    next_state = S_IDLE;
                end else if (clear) begin
                    next_state = S_IDLE;
                end else if (load_done && data_valid) begin
                    next_state = S_EXEC;
                end else begin
                    next_state = S_LOAD;
                end
            end
            S_EXEC: begin
                if (abort) begin
                    next_state = S_IDLE;
                end else if (exec_done) begin
                    next_state = S_WAIT;
                end else begin
                    next_state = S_EXEC;
                end
            end
            S_WAIT: begin
                if (abort) begin
                    next_state = S_IDLE;
                end else if (wait_expired && data_valid) begin
                    next_state = S_DONE;
                end else if (clear) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_DONE: begin
                if (clear) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_DONE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= S_RESET;
            load_cnt   <= 8'd0;
            exec_cnt   <= 8'd0;
            wait_timer <= 8'd0;
        end else begin
            state <= next_state;
            if (clear || abort || (next_state == S_IDLE)) begin
                load_cnt   <= 8'd0;
                exec_cnt   <= 8'd0;
                wait_timer <= 8'd0;
            end else begin
                if (state == S_LOAD) begin
                    load_cnt <= load_cnt + 8'd1;
                end
                if (state == S_EXEC) begin
                    exec_cnt <= exec_cnt + 8'd1;
                end
                if (state == S_WAIT) begin
                    wait_timer <= wait_timer + 8'd1;
                end
            end
        end
    end

    always_comb begin
        busy      = 1'b0;
        done      = 1'b0;
        error     = 1'b0;
        state_dbg = state;
        unique case (state)
            S_RESET: begin
                busy  = 1'b0;
                done  = 1'b0;
                error = 1'b0;
            end
            S_IDLE: begin
                busy  = 1'b0;
                done  = 1'b0;
                error = 1'b0;
            end
            S_LOAD: begin
                busy  = 1'b1;
                done  = 1'b0;
                error = 1'b0;
            end
            S_EXEC: begin
                busy  = 1'b1;
                done  = 1'b0;
                error = 1'b0;
            end
            S_WAIT: begin
                busy  = 1'b1;
                done  = 1'b0;
                error = 1'b0;
            end
            S_DONE: begin
                busy  = 1'b0;
                done  = 1'b1;
                error = 1'b0;
            end
            default: begin
                busy  = 1'b0;
                done  = 1'b0;
                error = 1'b1;
            end
        endcase
    end

endmodule