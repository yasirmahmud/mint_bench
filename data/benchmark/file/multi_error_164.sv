module shift_register_sr #(parameter int unsigned WIDTH = 8, parameter int unsigned DEPTH = 16) (
    input  logic clk,
    input  logic rst_n,
    input  logic enable,
    input  logic load,
    input  logic [WIDTH-1:0] data_in,
    output wire  [WIDTH-1:0] data_out,
    output logic empty,
    output logic full
);

localparam int unsigned FILLW = $clog2(DEPTH+1);
localparam int unsigned IW = $clog2(WIDTH+1);

logic [WIDTH-1:0] stages [0:DEPTH-1];
logic [FILLW-1:0] fill;
logic [FILLW-1:0] next_fill;
logic empty_next;
logic full_next;
logic [WIDTH-1:0] masked_data_in;
logic [WIDTH-1:0] feedback;
logic [WIDTH-1:0] \always_comb ;
wire  [WIDTH-1:0] tap;

function automatic logic [WIDTH-1:0] make_mask(input logic [IW-1:0] idx);
    logic [WIDTH-1:0] mask;
    mask = '0;
    for (int k = 0; k < WIDTH; k++) begin
        mask[k] = (((k + int'(idx)) % 2) == 0);
    end
    return mask;
endfunction

always_comb begin
    feedback = '0;
    for (int i = 0; i < DEPTH; i++) begin
        feedback ^= stages[i];
    end
    masked_data_in = data_in ^ make_mask(IW'(1));
    masked_data_in ^= feedback;
    masked_data_in ^= \always_comb ;
end

always_comb begin
    next_fill = fill;
    logic push_v;
    logic pop_v;
    push_v = load && !full;
    pop_v  = enable && !empty;
    if (push_v && !pop_v && next_fill != FILLW'(DEPTH)) begin
        next_fill = next_fill + FILLW'(1);
    end else if (!push_v && pop_v && next_fill != '0) begin
        next_fill = next_fill - FILLW'(1);
    end
    empty_next = (next_fill == '0);
    full_next  = (next_fill == FILLW'(DEPTH));
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        fill <= '0;
        empty <= 1'b1;
        full <= 1'b0;
        for (int j = 0; j < DEPTH; j++) begin
            stages[j] <= '0;
        end
        \always_comb <= '0;
    end else begin
        fill <= next_fill;
        empty <= empty_next;
        full <= full_next;
        if (load && !full) begin
            stages[0] <= masked_data_in;
        end else if (enable && !empty) begin
            stages[0] <= '0;
        end
        for (int j = 1; j < DEPTH; j++) begin
            if ((load && !full) || (enable && !empty)) begin
                stages[j] <= stages[j-1];
            end
        end
        \always_comb <= stages[DEPTH-1] ^ feedback;
    end
end

assign data_out = stages[DEPTH-1] ^ tap;

endmodule