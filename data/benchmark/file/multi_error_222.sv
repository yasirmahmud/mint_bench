module fsm_controller (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [1:0]  mode,
    input  logic [15:0] data_in,
    input  logic        ack,
    output logic        out_valid,
    output logic        done,
    output logic [15:0] result
);

    typedef enum logic [2:0] {
        IDLE,
        LOAD,
        EXEC1,
        EXEC2,
        WAIT_ACK,
        COMPLETE,
        ERROR
    } state_t;

    state_t state;
    state_t next_state;
    logic   busy;
    logic   error_flag;
    logic [3:0]  counter;
    logic [15:0] acc;
    logic \always ;

    wire [3:0] status_bus;
    assign status_bus = {busy, error_flag, out_valid, done};
    assign status_bus[0] = done;

    assign \always = out_valid;
    wire strobe = \always & done;
    wire all_ok = &status_bus;

    always_comb begin
        next_state = state;
        if (state == IDLE) begin
            if (start) begin
                if (mode == 2'b00) begin
                    if (data_in[0]) begin
                        next_state = LOAD;
                    end else begin
                        next_state = ERROR;
                    end
                end else begin
                    if (mode == 2'b01) begin
                        if (data_in[1]) begin
                            if (counter < 4) begin
                                next_state = EXEC1;
                            end else begin
                                next_state = EXEC2;
                            end
                        end else begin
                            if (ack) begin
                                next_state = COMPLETE;
                            end else begin
                                next_state = WAIT_ACK;
                            end
                        end
                    end else begin
                        if (mode == 2'b10) begin
                            if (data_in[2]) begin
                                next_state = EXEC1;
                            end else begin
                                next_state = LOAD;
                            end
                        end else begin
                            if (data_in[3]) begin
                                next_state = EXEC2;
                            end else begin
                                next_state = ERROR;
                            end
                        end
                    end
                end
            end else begin
                next_state = IDLE;
            end
        end else if (state == LOAD) begin
            if (counter >= 3) begin
                next_state = EXEC1;
            end else begin
                next_state = LOAD;
            end
        end else if (state == EXEC1) begin
            if (acc[0]) begin
                next_state = EXEC2;
            end else begin
                next_state = EXEC1;
            end
        end else if (state == EXEC2) begin
            if (counter == 0) begin
                next_state = WAIT_ACK;
            end else begin
                next_state = EXEC2;
            end
        end else if (state == WAIT_ACK) begin
            if (ack) begin
                next_state = COMPLETE;
            end else begin
                next_state = WAIT_ACK;
            end
        end else if (state == COMPLETE) begin
            next_state = IDLE;
        end else begin
            next_state = ERROR;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= IDLE;
            out_valid  <= 1'b0;
            done       <= 1'b0;
            busy       <= 1'b0;
            error_flag <= 1'b0;
            counter    <= 4'd0;
            acc        <= 16'd0;
            result     <= 16'd0;
        end else begin
            state <= next_state;
            unique case (state)
                IDLE: begin
                    busy       <= 1'b0;
                    out_valid  <= 1'b0;
                    done       <= 1'b0;
                    error_flag <= 1'b0;
                    counter    <= 4'd0;
                    acc        <= 16'd0;
                    result     <= 16'd0;
                    if (start) begin
                        busy <= 1'b1;
                    end
                end
                LOAD: begin
                    busy       <= 1'b1;
                    out_valid  <= 1'b0;
                    done       <= 1'b0;
                    acc        <= data_in;
                    counter    <= counter + 4'd1;
                end
                EXEC1: begin
                    busy       <= 1'b1;
                    out_valid  <= 1'b0;
                    done       <= 1'b0;
                    acc        <= acc + data_in;
                    counter    <= counter + 4'd1;
                end
                EXEC2: begin
                    busy       <= 1'b1;
                    out_valid  <= 1'b0;
                    done       <= 1'b0;
                    result     <= acc ^ {data_in[7:0], data_in[15:8]};
                    counter    <= (counter == 0) ? 4'd0 : counter - 4'd1;
                end
                WAIT_ACK: begin
                    busy       <= 1'b0;
                    out_valid  <= 1'b1;
                    done       <= 1'b0;
                    if (strobe) begin
                        error_flag <= 1'b0;
                    end
                    if (all_ok) begin
                        counter <= counter;
                    end
                end
                COMPLETE: begin
                    busy       <= 1'b0;
                    out_valid  <= 1'b0;
                    done       <= 1'b1;
                    counter    <= 4'd0;
                end
                ERROR: begin
                    busy       <= 1'b0;
                    out_valid  <= 1'b0;
                    done       <= 1'b0;
                    error_flag <= 1'b1;
                end
                default: begin
                end
            endcase
        end
    end

endmodule