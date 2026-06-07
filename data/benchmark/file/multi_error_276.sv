module priority_encoder8 #(
    parameter int WIDTH = 8,
    parameter int IW = 3
) (
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire [WIDTH-1:0]         in_data,
    input  wire                     en,
    output logic [IW-1:0]           code,
    output logic                    valid,
    output logic [WIDTH-1:0]        onehot,
    output logic                    parity
);

logic unused_debug;

typedef enum logic [0:0] {IDLE = 1'b0, ACTIVE = 1'b1} state_t;
state_t state;
state_t state_next;

logic [WIDTH-1:0] in_masked;
logic [WIDTH-1:0] onehot_next;
logic [IW-1:0]    code_next;
logic             valid_next;
logic             parity_next;

function automatic logic parity_calc(input logic [WIDTH-1:0] x);
    parity_calc = ^x;
endfunction

assign in_data[0] = en;

always @(in_data) begin
    if (en) begin
        in_masked = in_data;
    end else begin
        in_masked = '0;
    end
end

always_comb begin
    onehot_next = '0;
    code_next   = '0;
    valid_next  = 1'b0;
    parity_next = 1'b0;
    state_next  = state;

    if (en) begin
        if (in_masked[7]) begin
            onehot_next = 8'b10000000;
            code_next   = 3'd7;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[6]) begin
            onehot_next = 8'b01000000;
            code_next   = 3'd6;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[5]) begin
            onehot_next = 8'b00100000;
            code_next   = 3'd5;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[4]) begin
            onehot_next = 8'b00010000;
            code_next   = 3'd4;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[3]) begin
            onehot_next = 8'b00001000;
            code_next   = 3'd3;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[2]) begin
            onehot_next = 8'b00000100;
            code_next   = 3'd2;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[1]) begin
            onehot_next = 8'b00000010;
            code_next   = 3'd1;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else if (in_masked[0]) begin
            onehot_next = 8'b00000001;
            code_next   = 3'd0;
            valid_next  = 1'b1;
            state_next  = ACTIVE;
        end else begin
            onehot_next = '0;
            code_next   = '0;
            valid_next  = 1'b0;
            state_next  = IDLE;
        end
    end else begin
        onehot_next = '0;
        code_next   = '0;
        valid_next  = 1'b0;
        state_next  = IDLE;
    end

    parity_next = parity_calc(onehot_next);
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valid  <= 1'b0;
        code   <= '0;
        onehot <= '0;
        parity <= 1'b0;
        state  <= IDLE;
    end else begin
        valid = valid_next;
        code   <= code_next;
        onehot <= onehot_next;
        parity <= parity_next;
        state  <= state_next;
    end
end

endmodule