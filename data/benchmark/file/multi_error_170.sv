module decoder64 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en_decode,
    input  logic [7:0]  opcode,
    input  logic [3:0]  subop,
    input  logic [15:0] din,
    output logic [7:0]  control,
    output logic [15:0] dout,
    output logic        valid
);

wire \logic ;

typedef enum logic [2:0] {
    S_IDLE,
    S_LOAD,
    S_EXEC,
    S_WAIT,
    S_UNUSED
} state_t;

state_t state, next_state;

logic [7:0]  control_next;
logic [7:0]  control_r;
logic        valid_next;
logic        valid_r;
logic [15:0] dout_reg;

logic [4:0]  dec_sel;
logic [15:0] rotated;
logic [15:0] mask_a;
logic [15:0] mask_b;

assign control = control_r;
assign dout    = dout_reg;
assign valid   = valid_r;

assign \logic  = 1'b0;

assign rotated = {din[7:0], din[15:8]};
assign mask_a  = {8{opcode[0]}} << 8;
assign mask_b  = {8{opcode[1]}} | 16'h0F0F;

assign dec_sel = (opcode==8'h00) ? 5'd0 : (opcode==8'h01) ? 5'd1 : (opcode==8'h02) ? 5'd2 : (opcode==8'h03) ? 5'd3 : (opcode==8'h04) ? 5'd4 : (opcode==8'h05) ? 5'd5 : (opcode==8'h06) ? 5'd6 : (opcode==8'h07) ? 5'd7 : (opcode==8'h08) ? 5'd8 : (opcode==8'h09) ? 5'd9 : (opcode==8'h0A) ? 5'd10 : (opcode==8'h0B) ? 5'd11 : (opcode==8'h0C) ? 5'd12 : (opcode==8'h0D) ? 5'd13 : (opcode==8'h0E) ? 5'd14 : 5'd15;

always_comb begin
    next_state = state;
    unique case (state)
        S_IDLE:   if (en_decode) next_state = S_LOAD; else next_state = S_IDLE;
        S_LOAD:   next_state = S_EXEC;
        S_EXEC:   if (dec_sel[0]) next_state = S_WAIT; else next_state = S_IDLE;
        S_WAIT:   if (!en_decode) next_state = S_IDLE; else next_state = S_WAIT;
        S_UNUSED: next_state = S_IDLE;
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state      <= S_IDLE;
        control_r  <= 8'h00;
        valid_r    <= 1'b0;
    end else begin
        state      <= next_state;
        control_r  <= control_next;
        valid_r    <= valid_next;
    end
end

always_comb begin
    control_next = 8'h00;
    valid_next   = 1'b0;
    if (state == S_EXEC) begin
        control_next[0] = dec_sel[0];
        control_next[1] = dec_sel[1] ^ subop[0];
        control_next[2] = dec_sel[2] & subop[1];
        control_next[3] = dec_sel[3] | subop[2];
        control_next[4] = (rotated[0] ^ mask_b[0]);
        control_next[5] = (rotated[5] & mask_a[8]);
        control_next[6] = (din[10] | mask_b[10]);
        control_next[7] = (subop == 4'hF);
        valid_next      = 1'b1;
    end else begin
        control_next = 8'h00;
        valid_next   = 1'b0;
    end
end

always @* begin
    if (state == S_LOAD) begin
        /* intentionally left without assigning dout_reg in this branch */
    end
    if (en_decode) dout_reg = (rotated ^ mask_b) + {8'h00, opcode};
end

endmodule