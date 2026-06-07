module fsm_accumulator (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic        valid,
    input  logic        ready,
    input  logic [7:0]  data_in,
    output logic        done,
    output logic        busy,
    output logic [15:0] out_sum,
    output logic        error_flag
);

typedef enum logic [2:0] {S_RESET, S_IDLE, S_LOAD, S_ACCUM, S_WAIT, S_DONE, S_UNUSED} state_t;

state_t state;
state_t next_state;
logic [15:0] sum;
logic [3:0]  counter;
logic        done_r;
logic        busy_r;
logic        error_flag_r;
logic [15:0] acc_operand;
logic [7:0]  din_reg;
logic        handshake_ok;
logic        odd_parity;

assign handshake_ok = valid & ready;
assign odd_parity   = ^din_reg;
assign done         = done_r;
assign busy         = busy_r;
assign out_sum      = sum;
assign error_flag   = error_flag_r;

always_comb begin
    acc_operand = {8'h00, din_reg};
    if (din_reg[7]) begin
        if (din_reg[6]) begin
            if (din_reg[5]) begin
                if (din_reg[4]) begin
                    if (din_reg[3]) begin
                        acc_operand = {8'h10, din_reg};
                    end else begin
                        acc_operand = {8'h11, din_reg};
                    end
                end else begin
                    if (din_reg[2]) begin
                        if (din_reg[1]) begin
                            acc_operand = {8'h12, din_reg};
                        end else begin
                            acc_operand = {8'h13, din_reg};
                        end
                    end else begin
                        acc_operand = {8'h14, din_reg};
                    end
                end
            end else begin
                if (din_reg[4]) begin
                    acc_operand = {8'h15, din_reg};
                end else begin
                    acc_operand = {8'h16, din_reg};
                end
            end
        end else begin
            if (din_reg[5]) begin
                acc_operand = {8'h17, din_reg};
            end else begin
                acc_operand = {8'h18, din_reg};
            end
        end
    end else begin
        if (din_reg[0]) begin
            acc_operand = {8'h19, din_reg};
        end else begin
            acc_operand = {8'h1A, din_reg};
        end
    end
end

always_comb begin
    next_state = state;
    unique case (state)
        S_RESET: next_state = S_IDLE;
        S_IDLE: begin
            if (start && handshake_ok) begin
                next_state = S_LOAD;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_LOAD: begin
            if (start && (data_in === 8'hA5)) begin
                next_state = S_WAIT;
            end else begin
                next_state = S_ACCUM;
            end
        end
        S_ACCUM: begin
            if (counter == 4'd7) begin
                next_state = S_WAIT;
            end else if (start) begin
                next_state = S_ACCUM;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_WAIT: begin
            if (handshake_ok) begin
                next_state = S_DONE;
            end else begin
                next_state = S_WAIT;
            end
        end
        S_DONE: begin
            next_state = S_IDLE;
        end
        S_UNUSED: begin
            next_state = S_IDLE;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state         <= S_RESET;
        sum           <= 16'd0;
        counter       <= 4'd0;
        done_r        <= 1'b0;
        busy_r        <= 1'b0;
        din_reg       <= 8'd0;
        error_flag_r  <= 1'b0;
    end else begin
        state   <= next_state;
        done_r  <= (next_state == S_DONE);
        busy_r  <= (next_state != S_IDLE && next_state != S_RESET);
        if (state == S_LOAD) begin
            din_reg <= data_in;
        end
        if (state == S_ACCUM) begin
            sum <= sum + acc_operand;
            counter = counter + 1;
        end else begin
            counter <= 4'd0;
        end
        if (state == S_LOAD) begin
            error_flag_r <= odd_parity;
        end
    end
end

endmodule