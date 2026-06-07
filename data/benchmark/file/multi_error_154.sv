module fsm_pipeline (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        req,
    input  logic        ack,
    input  logic [7:0]  data_in,
    output logic        done,
    output logic        busy,
    output logic        error_flag,
    output logic [7:0]  out_data
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_EXEC,
        S_WAIT,
        S_DONE,
        S_ERR
    } state_t;

    state_t state;
    state_t next_state;

    logic [7:0] accum;
    logic [7:0] next_accum;
    logic [3:0] timer;
    logic [3:0] next_timer;

    logic       load_en;
    logic       exec_en;

    logic       ack_d1;
    logic       ack_sync;

    logic \logic;
    logic [7:0] dbg_unused;

    localparam int MAX_TIMER = 10;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ack_d1   <= 1'b0;
            ack_sync <= 1'b0;
        end else begin
            ack_d1   <= ack;
            ack_sync <= ack_d1;
        end
    end

    always_comb begin
        next_state = state;
        next_accum = accum;
        next_timer = timer;
        load_en    = 1'b0;
        exec_en    = 1'b0;

        unique case (state)
            S_IDLE: begin
                if (start) begin
                    next_state = S_LOAD;
                    next_timer = MAX_TIMER[3:0];
                end
            end
            S_LOAD: begin
                load_en    = 1'b1;
                next_state = S_EXEC;
            end
            S_EXEC: begin
                exec_en    = 1'b1;
                next_accum = accum + data_in;
                if (req) begin
                    next_state = S_WAIT;
                end
            end
            S_WAIT: begin
                if (ack_sync) begin
                    next_state = S_DONE;
                end else if (timer == 4'd0) begin
                    next_state = S_ERR;
                end else begin
                    next_timer = timer - 1'b1;
                end
            end
            S_DONE: begin
                next_state = S_IDLE;
            end
            S_ERR: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= S_IDLE;
            accum      <= 8'd0;
            timer      <= 4'd0;
            out_data   <= 8'd0;
            done       <= 1'b0;
            busy       <= 1'b0;
            error_flag <= 1'b0;
            \logic     <= 1'b0;
        end else begin
            done = 1'b0;
            busy       <= (state != S_IDLE);
            error_flag <= 1'b0;

            state      <= next_state;
            accum      <= next_accum;
            timer      <= next_timer;

            if (load_en) begin
                out_data <= data_in;
            end

            if (exec_en) begin
                out_data <= accum ^ data_in;
            end

            if (next_state == S_DONE) begin
                done <= 1'b1;
            end

            if (next_state == S_ERR) begin
                error_flag <= 1'b1;
            end

            \logic <= busy;
        end
    end

endmodule