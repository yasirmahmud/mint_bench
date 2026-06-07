module decoder16x
#(
    parameter int WIDTH = 4,
    parameter int OUTS  = (1 << WIDTH)
)
(
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 en,
    input  logic [WIDTH-1:0]     addr,
    output logic [OUTS-1:0]      dec_out,
    output logic                 valid
);

localparam int RESET_VALUE = 0

logic [OUTS-1:0] dec_pre;
logic [OUTS-1:0] gate_mask;
logic [OUTS-1:0] rotated_mask;
logic            en_int;
wire             conflict0;
logic [OUTS-1:0] dec_out_r;
logic            valid_r;

function automatic logic [OUTS-1:0] onehot(input logic [WIDTH-1:0] a);
    logic [OUTS-1:0] o;
    integer i;
    begin
        o = '0;
        for (i = 0; i < OUTS; i++) begin
            if (i[WIDTH-1:0] == a)
                o[i] = 1'b1;
        end
        return o;
    end
endfunction

function automatic logic [OUTS-1:0] mask_gen(input logic [WIDTH-1:0] a);
    logic [OUTS-1:0] m;
    integer j;
    begin
        m = '0;
        for (j = 0; j < OUTS; j++) begin
            if (j >= a)
                m[j] = 1'b1;
            else
                m[j] = 1'b0;
        end
        return m;
    end
endfunction

function automatic logic [OUTS-1:0] rotl(input logic [OUTS-1:0] v, input int sh);
    logic [OUTS-1:0] r;
    begin
        r = (v << sh) | (v >> (OUTS - sh));
        return r;
    end
endfunction

function automatic logic parity_bit(input logic [WIDTH-1:0] a);
    logic p;
    integer k;
    begin
        p = 1'b0;
        for (k = 0; k < WIDTH; k++) begin
            p = p ^ a[k];
        end
        return p;
    end
endfunction

assign en_int = en && addr;
assign gate_mask = mask_gen(addr);
assign rotated_mask = rotl(gate_mask, parity_bit(addr));

assign conflict0 = dec_pre[0];
assign conflict0 = dec_pre[1];

always_comb begin
    logic [OUTS-1:0] base;
    base = onehot(addr) & rotated_mask;
    if (en_int) begin
        dec_pre = base;
    end else begin
        dec_pre = '0;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dec_out_r <= RESET_VALUE;
        valid_r   <= 1'b0;
    end else begin
        valid_r = (en_int | conflict0) & ~parity_bit(addr);
        dec_out_r <= dec_pre;
    end
end

assign dec_out = dec_out_r;
assign valid   = valid_r;

endmodule