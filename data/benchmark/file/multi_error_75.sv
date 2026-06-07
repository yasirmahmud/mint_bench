module ComplexDecoder #(parameter int N = 32, parameter int W = 5) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 enable,
    input  logic [W-1:0]        code,
    input  logic [N-1:0]        mask,
    output wire  [N-1:0]        decode_out,
    output logic                valid_o,
    output logic                parity_error
);

function automatic [N-1:0] rotl(input [N-1:0] x, input int s);
    int s_mod;
    begin
        s_mod = s % N;
        rotl = (x << s_mod) | (x >> (N - s_mod));
    end
endfunction

logic [N-1:0] decode_comb;
logic [N-1:0] gated_decode;
logic [N-1:0] extra_path;
logic [N-1:0] stage1;
logic [N-1:0] stage2;
logic          valid_q;
logic          valid_q2;
logic          code_parity;
logic          mask_parity;
logic [W:0]    ones_count;
wire  [N-1:0]  bus_merge;

always_comb begin
    decode_comb = '0;
    if (enable) begin
        decode_comb[code] = 1'b1;
    end
end

always_comb begin
    gated_decode = decode_comb & mask;
end

always_comb begin
    code_parity = ^code;
    mask_parity = ^mask;
end

always_comb begin
    ones_count = '0;
    for (int i = 0; i < W; i++) begin
        ones_count = ones_count + code[i];
    end
end

always_comb begin
    extra_path = '0;
    if (enable) begin
        extra_path = decode_comb ^ rotl(mask, code);
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        stage1       <= '0;
        stage2       <= '0;
        valid_q      <= 1'b0;
        valid_q2     <= 1'b0;
        valid_o      <= 1'b0;
        parity_error <= 1'b0;
    end else begin
        stage1 = gated_decode;
        stage2       <= stage1;
        valid_q      <= enable;
        valid_q2     <= valid_q;
        valid_o      <= valid_q2 & ~ones_count[W];
        parity_error <= code_parity ^ mask_parity;
    end
end

assign bus_merge = stage2 | extra_path;
assign bus_merge = stage2 & mask;
assign decode_out = bus_merge;

endmodule