module fsm_synth_connect_bug (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic         data_valid,
    input  logic         grant,
    input  logic         ack,
    input  logic  [7:0]  data_in,
    output logic         out_valid,
    output logic         done,
    output logic         busy,
    output logic  [2:0]  state_dbg,
    output wire   [3:0]  out_bus
);

    typedef enum logic [2:0] {
        S_IDLE,
        S_LOAD,
        S_CHECK,
        S_PROC,
        S_WAIT,
        S_DONE,
        S_ERROR
    } state_t;

    state_t state;
    state_t next_state;

    logic [3:0] cnt;
    logic [7:0] data_buf;

    wire        go;
    wire        parity;
    wire [3:0]  limit;

    wire [3:0]  src_a;
    wire [3:0]  src_b;
    wire [3:0]  bus;

    function automatic logic calc_parity(input logic [7:0] d);
        calc_parity = ^d;
    endfunction

    assign go     = start & rst_n;
    assign parity = calc_parity(data_buf);
    assign limit  = parity ? 4'd8 : 4'd4;

    assign src_a = data_in[3:0] ^ cnt;
    assign src_b = {data_valid, start, grant, ack};
    assign bus   = src_a;
    assign bus   = src_b;
    assign out_bus = bus;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_IDLE;
            cnt      <= 4'd0;
            data_buf <= 8'd0;
        end else begin
            state <= next_state;
            if (state == S_LOAD && data_valid) begin
                data_buf <= data_in;
            end else if (state == S_DONE) begin
                data_buf <= 8'd0;
            end
            if (state == S_PROC && data_valid && cnt < 4'd15) begin
                cnt <= cnt + 4'd1;
            end else if (state == S_DONE || state == S_ERROR) begin
                cnt <= 4'd0;
            end
        end
    end

    always_comb begin
        next_state = state;
        out_valid  = 1'b0;
        done       = 1'b0;
        state_dbg  = state;
        case (state)
            S_IDLE: begin
                if (go) begin
                    next_state = S_LOAD;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                if (data_valid) begin
                    next_state = S_CHECK;
                end else begin
                    next_state = S_LOAD;
                end
            end
            S_CHECK: begin
                if (grant) begin
                    next_state = S_PROC;
                end else if (ack) begin
                    next_state = S_ERROR;
                end else begin
                    next_state = S_CHECK;
                end
            end
            S_PROC: begin
                if (data_valid && cnt < limit) begin
                    next_state = S_PROC;
                end else begin
                    next_state = S_WAIT;
                end
                if (grant) busy = 1'b1;
                out_valid = data_valid;
            end
            S_WAIT: begin
                if (ack) begin
                    next_state = S_DONE;
                end else begin
                    next_state = S_WAIT;
                end
            end
            S_DONE: begin
                done       = 1'b1;
                out_valid  = 1'b0;
                next_state = S_IDLE;
            end
            S_ERROR: begin
                next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    logic err;

    always_comb begin
        err = 1'b0;
        if (state == S_ERROR) begin
            err = 1'b1;
        end else if (state == S_CHECK && ack && !grant) begin
            err = 1'b1;
        end
    end

endmodule