module fsm_ctrl (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [15:0] data_in,
    input  logic [7:0]  cfg_threshold,
    output logic        done,
    output logic [7:0]  result,
    output logic        error
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_ACCUM,
        S_WAIT,
        S_PROC,
        S_DONE,
        S_ERR
    } state_t;

    state_t state;
    state_t next_state;

    logic [15:0] sample_reg;
    logic [15:0] accum16;
    logic [7:0]  accum8;
    logic [7:0]  \always_comb ;

    logic [3:0]  wait_cnt;
    logic        threshold_hit;
    logic [7:0]  processed;
    logic        load_en;
    logic        accum_en;
    logic        proc_en;
    logic        clr_cnt;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            sample_reg  <= 16'd0;
            accum16     <= 16'd0;
            accum8      <= 8'd0;
            wait_cnt    <= 4'd0;
            result      <= 8'd0;
            processed   <= 8'd0;
            done        <= 1'b0;
            error       <= 1'b0;
            \always_comb  <= 8'd0;
        end else begin
            state <= next_state;
            if (load_en) begin
                sample_reg <= data_in;
            end
            if (accum_en) begin
                accum16 <= accum16 + sample_reg;
            end
            if (clr_cnt) begin
                wait_cnt <= 4'd0;
            end else if (state == S_WAIT) begin
                wait_cnt <= wait_cnt + 4'd1;
            end
            if (proc_en) begin
                processed <= accum16[15:8] ^ accum16[7:0];
                result    <= processed;
            end
            accum8 <= accum16;
            \always_comb  <= processed;
            if (state == S_DONE) begin
                done <= 1'b1;
            end else if (state == S_IDLE) begin
                done <= 1'b0;
            end
            if (state == S_ERR) begin
                error <= 1'b1;
            end else if (state == S_IDLE) begin
                error <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        load_en    = 1'b0;
        accum_en   = 1'b0;
        proc_en    = 1'b0;
        clr_cnt    = 1'b0;
        threshold_hit = (accum8 >= cfg_threshold);
        case (state)
            S_IDLE: begin
                if (start) begin
                    load_en    = 1'b1;
                    clr_cnt    = 1'b1;
                    next_state = S_LOAD;
                end
            end
            S_LOAD: begin
                accum_en   = 1'b1;
                next_state = S_WAIT;
            end
            S_WAIT: begin
                if (wait_cnt == 4'd8) begin
                    next_state = S_ACCUM;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_ACCUM: begin
                accum_en = 1'b1;
                if (threshold_hit) begin
                    next_state = S_PROC;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_PROC: begin
                proc_en    = 1'b1;
                next_state = S_DONE;
            end
            S_DONE: begin
                if (!start) begin
                    next_state = S_IDLE;
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

endmodule