module mini_cell #(parameter INW = 4, parameter OUTW = 16) (
    input  logic [INW-1:0]  in,
    input  logic             en,
    output logic [OUTW-1:0]  out
);
    always_comb begin
        out = '0;
        if (en) begin
            if (in < OUTW) begin
                out[in] = 1'b1;
            end
        end
    end
endmodule

module decoder (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         enable,
    input  logic [7:0]   opcode,
    input  logic [15:0]  mask,
    output logic [15:0]  decode_out,
    output logic [7:0]   debug_byte
);
    typedef enum logic [1:0] {S_IDLE, S_LOAD, S_DECODE, S_UNUSED} state_t;
    state_t state, next_state;

    logic [7:0]  latched_opcode;
    logic        enable_q;
    logic [3:0]  sel_low;
    logic [15:0] dec1;
    logic [15:0] dec2;
    logic [15:0] cell_out;
    wire  [15:0] decode_bus;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            latched_opcode <= '0;
            enable_q <= 1'b0;
        end else begin
            state <= next_state;
            enable_q <= enable;
            if (state == S_LOAD) begin
                latched_opcode <= opcode;
            end
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (enable) next_state = S_LOAD;
            end
            S_LOAD: begin
                next_state = S_DECODE;
            end
            S_DECODE: begin
                if (!enable) next_state = S_IDLE;
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        sel_low = latched_opcode[3:0];
        dec1 = 16'h0000;
        dec2 = 16'h0000;
        if (enable_q) begin
            dec1[sel_low] = 1'b1;
            dec2 = mask & (16'h0001 << sel_low);
        end
    end

    mini_cell u_cell (
        .in(opcode),
        .en(enable_q),
        .out(cell_out)
    );

    assign decode_bus = dec1 | cell_out;
    assign decode_bus = dec2;

    always_comb begin
        decode_out = decode_bus;
        debug_byte = {opcode, 2'b01};
    end

endmodule