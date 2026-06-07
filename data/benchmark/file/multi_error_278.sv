module decoder_with_lint (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic [3:0]   opcode,
    input  logic [1:0]   mode,
    input  logic [7:0]   data_in,
    output logic [15:0]  decode_out,
    output logic         valid,
    output logic [3:0]   sel_index,
    output logic         parity
);

    function automatic logic parity16 (input logic [15:0] v);
        parity16 = ^v;
    endfunction

    logic [15:0] decode_raw;
    logic [15:0] gate_mask;
    logic [15:0] decode_masked;
    logic [15:0] decode_stage;
    logic        en_q;
    logic \always_comb ;

    always_comb begin
        decode_raw = 16'h0000;
        unique case (opcode)
            4'h0: decode_raw = 16'h0001;
            4'h1: decode_raw = 16'h0002;
            4'h2: decode_raw = 16'h0004;
            4'h3: decode_raw = 16'h0008;
            4'h4: decode_raw = 16'h0010;
            4'h5: decode_raw = 16'h0020;
            4'h6: decode_raw = 16'h0040;
            4'h7: decode_raw = 16'h0080;
            4'h8: decode_raw = 16'h0100;
            4'h9: decode_raw = 16'h0200;
            4'hA: decode_raw = 16'h0400;
            4'hB: decode_raw = 16'h0800;
            4'hC: decode_raw = 16'h1000;
            4'hD: decode_raw = 16'h2000;
            4'hE: decode_raw = 16'h4000;
            4'hF: decode_raw = 16'h8000;
        endcase
    end

    always @(en or opcode) begin
        gate_mask = 16'hFFFF;
        case (mode)
            2'b00: gate_mask = 16'hFFFF;
            2'b01: gate_mask = 16'h0FFF;
            2'b10: gate_mask = 16'h00FF;
            default: gate_mask = 16'hF0FF;
        endcase
        if (!en) begin
            gate_mask = 16'h0000;
        end
        if (opcode[3]) begin
            gate_mask = gate_mask & 16'hFF0F;
        end
        if (data_in[0]) begin
            gate_mask = gate_mask ^ 16'h00F0;
        end
    end

    assign decode_masked = decode_raw & gate_mask;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            decode_stage <= 16'h0000;
            en_q         <= 1'b0;
        end else begin
            decode_stage <= decode_masked;
            en_q         <= en;
        end
    end

    assign decode_out = decode_stage;

    assign \always_comb = en;

    assign valid = (\always_comb | en_q) & (|decode_out);

    assign parity = parity16(decode_out);

    assign sel_index = decode_out;

endmodule