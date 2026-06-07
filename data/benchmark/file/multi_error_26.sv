module complex_decoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [5:0]  addr,
    input  logic [3:0]  opcode,
    input  logic [7:0]  data_in,
    input  logic        cfg_bypass,
    output logic        valid,
    output logic [63:0] dec_out
);

logic [63:0] dec_next;
logic        valid_next;
logic [63:0] dec_reg;
logic        valid_reg;
logic [2:0]  op_class;
logic [63:0] format_mask;
logic [63:0] gate_mask;
logic \logic;

assign \logic = ~cfg_bypass;

always_comb begin
    op_class = 3'd0;
    if (opcode[3]) begin
        if (opcode[2]) begin
            if (opcode[1]) begin
                if (opcode[0]) op_class = 3'd7;
                else op_class = 3'd6;
            end else begin
                if (opcode[0]) op_class = 3'd5;
                else op_class = 3'd4;
            end
        end else begin
            if (opcode[1]) begin
                if (opcode[0]) op_class = 3'd3;
                else op_class = 3'd2;
            end else begin
                if (opcode[0]) op_class = 3'd1;
                else op_class = 3'd0;
            end
        end
    end else begin
        if (opcode[2]) begin
            if (opcode[1]) begin
                if (opcode[0]) op_class = 3'd3;
                else op_class = 3'd2;
            end else begin
                if (opcode[0]) op_class = 3'd1;
                else op_class = 3'd0;
            end
        end else begin
            if (opcode[1]) begin
                if (opcode[0]) op_class = 3'd1;
                else op_class = 3'd0;
            end else begin
                if (opcode[0]) op_class = 3'd0;
                else op_class = 3'd0;
            end
        end
    end
end

always_comb begin
    format_mask = 64'hFFFF_FFFF_FFFF_FFFF;
    unique case (opcode)
        4'h0: format_mask = 64'hFFFF_FFFF_FFFF_FFFF;
        4'h1: format_mask = 64'h0000_0000_0000_00FF;
        4'h2: format_mask = 64'h0000_0000_00FF_00FF;
        4'h3: format_mask = {56'd0, data_in};
        4'h4: format_mask = 64'h0000_FFFF_0000_FFFF;
        default: format_mask = 64'hFFFF_FFFF_FFFF_FFFF;
    endcase
end

always_comb begin
    gate_mask = 64'hFFFF_FFFF_FFFF_FFFF;
    if (data_in[7]) begin
        gate_mask = gate_mask & 64'h00FF_00FF_00FF_00FF;
    end else begin
        gate_mask = gate_mask & 64'hFF00_FF00_FF00_FF00;
    end
end

always @(en or opcode) begin
    dec_next   = 64'b0;
    valid_next = 1'b0;
    if (en && \logic) begin
        dec_next = 64'h1 << addr;
        case (op_class)
            3'd0: dec_next = dec_next & format_mask;
            3'd1: dec_next = (dec_next | (dec_next << 1)) & format_mask;
            3'd2: dec_next = (dec_next | (dec_next << 8)) & format_mask;
            3'd3: dec_next = (dec_next | (dec_next << 16)) & format_mask;
            3'd4: dec_next = (dec_next | (dec_next << 32)) & format_mask;
            3'd5: dec_next = dec_next ^ (64'hFFFF_FFFF_FFFF_FFFF & format_mask);
            3'd6: dec_next = ~dec_next & format_mask;
            default: dec_next = dec_next & format_mask;
        endcase
        dec_next = dec_next & gate_mask;
        valid_next = 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dec_reg   <= 64'b0;
        valid_reg <= 1'b0;
    end else begin
        if (cfg_bypass) begin
            dec_reg   <= 64'b0;
            valid_reg <= 1'b0;
        end else begin
            dec_reg   <= dec_next;
            valid_reg <= valid_next;
        end
    end
end

assign dec_out = dec_reg;
assign valid   = valid_reg;

endmodule