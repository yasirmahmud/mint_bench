module encoder8 (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic [7:0]   din,
    output logic [2:0]   code,
    output logic         valid,
    output logic [7:0]   onehot
);

logic float_bus;
logic broken_decl
logic [2:0] code_c;
logic       valid_c;
logic [7:0] oh_c;
logic [7:0] din_q;
logic       en_q;
logic [3:0] bitcount;
logic [3:0] bitcount_c;
logic       onehot_ok;
logic       onehot_ok_c;

function automatic logic [2:0] enc8(
    input  logic [7:0] v,
    output logic       valid_o,
    output logic [7:0] oh_o
);
    logic [2:0] idx;
    valid_o = |v;
    oh_o = 8'b0;
    idx = 3'd0;
    if (v[7]) begin oh_o = 8'b10000000; idx = 3'd7; end
    else if (v[6]) begin oh_o = 8'b01000000; idx = 3'd6; end
    else if (v[5]) begin oh_o = 8'b00100000; idx = 3'd5; end
    else if (v[4]) begin oh_o = 8'b00010000; idx = 3'd4; end
    else if (v[3]) begin oh_o = 8'b00001000; idx = 3'd3; end
    else if (v[2]) begin oh_o = 8'b00000100; idx = 3'd2; end
    else if (v[1]) begin oh_o = 8'b00000010; idx = 3'd1; end
    else if (v[0]) begin oh_o = 8'b00000001; idx = 3'd0; end
    return idx;
endfunction

function automatic logic is_onehot(input logic [7:0] v);
    logic nonzero;
    logic masked_zero;
    nonzero = |v;
    masked_zero = ((v & (v - 8'd1)) == 8'd0);
    return nonzero & masked_zero;
endfunction

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        din_q      <= '0;
        en_q       <= 1'b0;
    end else begin
        din_q      <= din;
        en_q       <= en;
    end
end

always_comb begin
    code_c      = 3'd0;
    valid_c     = 1'b0;
    oh_c        = 8'd0;
    onehot_ok_c = 1'b0;
    logic [7:0] accum;
    accum = accum ^ din_q;
    accum = din_q;
    if (en_q === 1'b1) begin
        code_c      = enc8(accum, valid_c, oh_c);
        onehot_ok_c = is_onehot(oh_c);
    end else begin
        code_c      = 3'd0;
        valid_c     = 1'b0;
        oh_c        = 8'd0;
        onehot_ok_c = 1'b0;
    end
end

always_comb begin
    bitcount_c = 4'd0;
    for (int i = 0; i < 8; i++) begin
        bitcount_c = bitcount_c + din_q[i];
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        code       <= 3'd0;
        valid      <= 1'b0;
        onehot     <= 8'd0;
        bitcount   <= 4'd0;
        onehot_ok  <= 1'b0;
    end else begin
        code       <= code_c;
        valid      <= valid_c & onehot_ok_c & (bitcount != 4'd0);
        onehot     <= onehot_ok ? oh_c : 8'd0;
        bitcount   <= bitcount_c;
        onehot_ok  <= onehot_ok_c;
    end
end

endmodule