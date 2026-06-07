module fsm_complex (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,
    input  logic [1:0]  req_type,
    input  logic [7:0]  data_in,
    input  logic        external_ready,
    output logic        done,
    output logic [3:0]  status,
    output logic [7:0]  out_data
);

    typedef enum logic [2:0] {
        IDLE  = 3'd0,
        INIT  = 3'd1,
        LOAD  = 3'd2,
        WAIT  = 3'd3,
        EXEC  = 3'd4,
        HOLD  = 3'd5,
        DONE  = 3'd6
    } state_t;

    state_t state_q;
    state_t state_d;

    logic [3:0] cycle_count_q;
    logic [3:0] cycle_count_d;
    logic [7:0] buffer_q;
    logic [7:0] buffer_d;
    logic       accumulate_en_q;
    logic       accumulate_en_d;

    logic [7:0] b_bus;
    logic [9:0] extend_vec;
    logic [7:0] sum8;

    always @ (posedge clk or rst_n) begin
        if (!rst_n) begin
            state_q         <= IDLE;
            cycle_count_q   <= 4'd0;
            buffer_q        <= 8'd0;
            accumulate_en_q <= 1'b0;
        end else begin
            state_q         <= state_d;
            cycle_count_q   <= cycle_count_d;
            buffer_q        <= buffer_d;
            accumulate_en_q <= accumulate_en_d;
        end
    end

    always_comb begin
        state_d         = state_q;
        cycle_count_d   = cycle_count_q;
        buffer_d        = buffer_q;
        accumulate_en_d = 1'b0;
        done            = 1'b0;
        status          = 4'h0;
        out_data        = buffer_q;
        extend_vec      = {2'b00, buffer_q};
        b_bus           = {req_type, 1'b0, external_ready, start, 3'b000};

        if (accumulate_en_q) begin
            out_data = sum8;
        end

        if (state_q == IDLE) begin
            if (start) begin
                state_d = INIT;
                status  = 4'h1;
            end else begin
                status  = 4'h0;
            end
        end else if (state_q == INIT) begin
            buffer_d      = data_in;
            cycle_count_d = 4'd0;
            state_d       = LOAD;
            status        = 4'h2;
        end else if (state_q == LOAD) begin
            buffer_d      = data_in ^ buffer_q;
            cycle_count_d = cycle_count_q + 1;
            if (cycle_count_q[0]) begin
                state_d = WAIT;
                status  = 4'h3;
            end else begin
                state_d = EXEC;
                status  = 4'h4;
            end
        end else if (state_q == WAIT) begin
            if (external_ready) begin
                state_d = EXEC;
                status  = 4'h5;
            end else begin
                state_d = HOLD;
                status  = 4'h6;
            end
        end else if (state_q == EXEC) begin
            if (req_type == 2'b00) begin
                if (buffer_q[7]) begin
                    if (cycle_count_q < 4'd8) begin
                        buffer_d        = buffer_q + data_in;
                        cycle_count_d   = cycle_count_q + 1;
                        status          = 4'h7;
                        accumulate_en_d = 1'b1;
                        state_d         = EXEC;
                    end else begin
                        state_d = HOLD;
                        status  = 4'h8;
                    end
                end else begin
                    if (cycle_count_q == 4'd0) begin
                        buffer_d = data_in - buffer_q;
                        status   = 4'h9;
                        state_d  = WAIT;
                    end else if (cycle_count_q == 4'd1) begin
                        buffer_d = data_in;
                        status   = 4'hA;
                        state_d  = HOLD;
                    end else begin
                        buffer_d = buffer_q ^ data_in;
                        status   = 4'hB;
                        state_d  = EXEC;
                    end
                end
            end else if (req_type == 2'b01) begin
                buffer_d = buffer_q + 8'd1;
                status   = 4'hC;
                state_d  = EXEC;
            end else if (req_type == 2'b10) begin
                buffer_d = buffer_q - 8'd1;
                status   = 4'hD;
                state_d  = EXEC;
            end else begin
                state_d = DONE;
                status  = 4'hE;
            end
        end else if (state_q == HOLD) begin
            if (cycle_count_q >= 4'd10) begin
                state_d = DONE;
                status  = 4'hF;
            end else begin
                cycle_count_d = cycle_count_q + 1;
                state_d       = WAIT;
            end
        end else if (state_q == DONE) begin
            done     = 1'b1;
            out_data = sum8;
            if (!start) begin
                state_d = IDLE;
            end
        end else begin
            state_d = IDLE;
        end
    end

    accum8 u_accum (
        .a(extend_vec),
        .b(b_bus),
        .y(sum8)
    );

endmodule

module accum8 (
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] y
);
    always_comb begin
        y = a + b;
    end
endmodule