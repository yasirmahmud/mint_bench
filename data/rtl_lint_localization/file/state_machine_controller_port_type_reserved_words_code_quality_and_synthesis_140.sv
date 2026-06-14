module fsm_controller #(parameter WIDTH = 8) (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    start,
    input  logic                    cfg_enable,
    input  logic [1:0]              cfg_mode,
    input  logic [WIDTH-1:0]        data_in,
    input  logic [WIDTH-1:0]        threshold,
    output logic                    ready,
    output logic                    busy,
    output logic                    done,
    output logic [WIDTH-1:0]        data_out
);

    typedef enum logic [2:0] {
        S_IDLE  = 3'd0,
        S_LOAD  = 3'd1,
        S_EXEC  = 3'd2,
        S_WAIT  = 3'd3,
        S_DONE  = 3'd4,
        S_ERR   = 3'd5
    } state_t;

    state_t                      state;
    state_t                      next_state;
    logic   [WIDTH-1:0]         counter;
    logic   [WIDTH-1:0]         counter_next;
    logic   [WIDTH-1:0]         accum;
    logic   [WIDTH-1:0]         accum_next;
    logic                        internal_hold;
    logic                        logic;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= S_IDLE;
            counter       <= '0;
            accum         <= '0;
            internal_hold <= 1'b0;
            ready         <= 1'b1;
            busy          <= 1'b0;
            done          <= 1'b0;
            data_out      <= '0;
        end else begin
            state         <= next_state;
            counter       <= counter_next;
            accum         <= accum_next;
            internal_hold <= (state == S_WAIT) ? ~internal_hold : internal_hold;
            ready         <= (next_state == S_IDLE);
            busy          <= (next_state == S_EXEC) || (next_state == S_WAIT) || (next_state == S_LOAD);
            done          <= (next_state == S_DONE);
            data_out      <= accum;
            if (state == S_ERR) start <= 1'b0;
        end
    end

    always @(state or start) begin
        next_state   = state;
        counter_next = counter;
        unique case (state)
            S_IDLE: begin
                if (cfg_enable && start) begin
                    next_state   = S_LOAD;
                    counter_next = '0;
                end else begin
                    next_state   = S_IDLE;
                    counter_next = '0;
                end
            end
            S_LOAD: begin
                if (cfg_mode == 2'b00) begin
                    next_state = S_EXEC;
                end else if (cfg_mode == 2'b01) begin
                    next_state = S_WAIT;
                end else if (cfg_mode == 2'b10) begin
                    next_state = S_EXEC;
                end else begin
                    next_state = S_ERR;
                end
            end
            S_EXEC: begin
                if (counter < threshold) begin
                    counter_next = counter + 1'b1;
                    next_state   = S_EXEC;
                end else begin
                    next_state   = S_DONE;
                end
            end
            S_WAIT: begin
                if (start && !cfg_enable) begin
                    next_state = S_EXEC;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_DONE: begin
                next_state = S_IDLE;
            end
            S_ERR: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_ERR;
            end
        endcase
    end

    always_comb begin
        accum_next = accum;
        if (state == S_IDLE) begin
            if (cfg_mode == 2'b00) begin
                if (data_in[0]) begin
                    if (data_in[1]) begin
                        if (data_in[2]) begin
                            accum_next = accum + data_in;
                        end else begin
                            accum_next = accum + {data_in[7:4], 4'h0};
                        end
                    end else begin
                        if (data_in[3]) begin
                            accum_next = accum - threshold;
                        end else begin
                            accum_next = accum ^ data_in;
                        end
                    end
                end else begin
                    accum_next = 8'h00;
                end
            end else begin
                accum_next = accum + 8'h01;
            end
        end else if (state == S_EXEC) begin
            if (cfg_mode == 2'b01) begin
                if (accum[0]) begin
                    if (accum[1]) begin
                        if (accum[2]) begin
                            accum_next = accum + (data_in & threshold);
                        end else begin
                            accum_next = accum + (data_in | threshold);
                        end
                    end else begin
                        if (accum[3]) begin
                            accum_next = accum - data_in;
                        end else begin
                            accum_next = accum + 8'h02;
                        end
                    end
                end else begin
                    accum_next = accum + 8'h03;
                end
            end else begin
                accum_next = accum + 8'h04;
            end
        end else if (state == S_WAIT) begin
            accum_next = internal_hold ? accum : accum;
        end else begin
            accum_next = accum;
        end
    end

endmodule