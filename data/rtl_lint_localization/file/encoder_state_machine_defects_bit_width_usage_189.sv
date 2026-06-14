module encoder(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [15:0] in_onehot,
    output logic [3:0]  code,
    output logic        valid,
    output logic [7:0]  status
);

typedef enum logic [2:0] {S_IDLE, S_CAPTURE, S_COMPUTE, S_OUTPUT} state_t;

state_t state, next_state;

logic [15:0] in_reg;
logic [3:0]  code_reg, next_code;
logic        valid_reg, next_valid;

logic [3:0]  enc_idx;
logic        detected;

logic [4:0]  pcnt;
logic [9:0]  internal_metric;

function automatic logic [3:0] encode_onehot(input logic [15:0] x);
    logic [3:0] idx;
    integer i;
    begin
        idx = 4'd0;
        for (i = 0; i < 16; i = i + 1) begin
            if (x[i]) idx = i[3:0];
        end
        return idx;
    end
endfunction

function automatic logic is_onehot(input logic [15:0] x);
    logic [15:0] t;
    begin
        t = x & (x - 16'd1);
        return (x != 16'd0) && (t == 16'd0);
    end
endfunction

function automatic logic [4:0] popcount16(input logic [15:0] x);
    logic [4:0] c;
    integer i2;
    begin
        c = 5'd0;
        for (i2 = 0; i2 < 16; i2 = i2 + 1) begin
            c = c + x[i2];
        end
        return c;
    end
endfunction

assign code  = code_reg;
assign valid = valid_reg;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state     <= S_IDLE;
        in_reg    <= 16'd0;
        code_reg  <= 4'd0;
        valid_reg <= 1'b0;
        status    <= 8'd0;
    end else begin
        state     <= next_state;
        code_reg  <= next_code;
        valid_reg <= next_valid;
        if (state == S_CAPTURE) begin
            in_reg <= in_onehot;
        end
        if (state == S_OUTPUT) begin
            status <= internal_metric;
        end
    end
end

always_comb begin
    next_state = state;
    next_code  = code_reg;
    next_valid = 1'b0;
    enc_idx    = encode_onehot(in_reg);
    detected   = is_onehot(in_reg);
    pcnt       = popcount16(in_reg);
    internal_metric = {5'd0, pcnt} + {6'd0, enc_idx};
    case (state)
        S_IDLE: begin
            if (en) begin
                next_state = S_CAPTURE;
            end
            next_valid = 1'b0;
        end
        S_CAPTURE: begin
            next_state = S_COMPUTE;
            next_valid = 1'b0;
        end
        S_COMPUTE: begin
            if (detected) begin
                next_code  = enc_idx;
                next_valid = 1'b1;
                next_state = S_OUTPUT;
            end else begin
                next_code  = 4'd0;
                next_valid = 1'b0;
                next_state = S_IDLE;
            end
        end
        S_OUTPUT: begin
            next_state = S_IDLE;
            next_valid = 1'b0;
        end
    endcase
end

endmodule