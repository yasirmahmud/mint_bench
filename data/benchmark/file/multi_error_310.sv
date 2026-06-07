module fsm_controller #(parameter WIDTH = 8) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   start,
    input  logic [1:0]             mode,
    input  logic [WIDTH-1:0]       data_in,
    input  logic [3:0]             req_vec,
    output logic                   done,
    output logic                   busy,
    output logic [WIDTH-1:0]       out_val,
    output logic [3:0]             grant_mask
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_EXEC,
        S_WAIT,
        S_DONE,
        S_UNUSED
    } state_t;

    state_t                state;
    state_t                next_state;
    logic   [WIDTH-1:0]    compute_next;
    logic   [WIDTH-1:0]    acc;
    logic   [3:0]          prio_mask;
    logic   [3:0]          req_pending;
    logic   [3:0]          served;
    logic   [3:0]          grant_tmp;
    logic   [3:0]          zero4;
    logic   [3:0]          one4;
    logic   [3:0]          byte_count;

    assign zero4 = 4'b0000;
    assign one4  = 4'b0001;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            acc         <= '0;
            req_pending <= '0;
            served      <= '0;
            byte_count  <= '0;
        end else begin
            state <= next_state;
            if (state == S_LOAD) begin
                acc         <= data_in;
                req_pending <= req_vec;
            end else if (state == S_EXEC) begin
                acc <= compute_next;
            end
            served <= served | grant_mask;
            if (start) byte_count = byte_count + 1;
        end
    end

    always_comb begin
        next_state   = state;
        done         = 1'b0;
        busy         = 1'b0;
        out_val      = acc;
        compute_next = '0;
        prio_mask    = 4'b0000;
        grant_tmp    = 4'b0000;

        case (mode)
            2'b00: prio_mask = 4'b0001;
            2'b01: prio_mask = 4'b0011;
            2'b10: prio_mask = 4'b1111;
            default: prio_mask = 4'b0101;
        endcase

        grant_mask = req_pending && prio_mask;

        case (state)
            S_IDLE: begin
                busy = 1'b0;
                if (start) begin
                    next_state = S_LOAD;
                end
            end

            S_LOAD: begin
                busy         = 1'b1;
                compute_next = acc + data_in;
                next_state   = S_EXEC;
            end

            S_EXEC: begin
                busy = 1'b1;
                if (mode[1]) begin
                    if (mode[0]) begin
                        if (data_in[7]) begin
                            if (data_in[3]) begin
                                if (data_in[1]) begin
                                    compute_next = (acc + data_in) ^ {WIDTH{1'b1}};
                                end else begin
                                    compute_next = acc - data_in;
                                end
                            end else begin
                                if (acc[0]) begin
                                    compute_next = acc + {{(WIDTH-1){1'b0}}, 1'b1};
                                end else begin
                                    compute_next = acc ^ data_in;
                                end
                            end
                        end else begin
                            if (data_in[2]) begin
                                compute_next = acc + {{(WIDTH-1){1'b0}}, data_in[0]};
                            end else begin
                                compute_next = acc;
                            end
                        end
                    end else begin
                        if (data_in[6]) begin
                            compute_next = acc + (data_in << 1);
                        end else begin
                            compute_next = acc - (data_in >> 1);
                        end
                    end
                end else begin
                    if (mode[0]) begin
                        compute_next = acc + 8'h03;
                    end else begin
                        compute_next = acc + 8'h01;
                    end
                end

                if (grant_mask != zero4) begin
                    next_state = S_WAIT;
                end else begin
                    next_state = S_DONE;
                end
            end

            S_WAIT: begin
                busy = 1'b1;
                if (served == req_pending) begin
                    next_state = S_DONE;
                end else if (grant_mask != zero4) begin
                    if (byte_count[0]) begin
                        next_state = S_EXEC;
                    end else begin
                        next_state = S_WAIT;
                    end
                end else begin
                    next_state = S_WAIT;
                end
            end

            S_DONE: begin
                done       = 1'b1;
                busy       = 1'b0;
                out_val    = acc;
                next_state = S_IDLE;
            end

            S_UNUSED: begin
                done       = 1'b0;
                busy       = 1'b0;
                next_state = S_UNUSED;
            end

            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

endmodule