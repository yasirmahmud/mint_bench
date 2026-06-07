module priority_encoder8 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [7:0]  data_in,
    output logic [2:0]  code,
    output logic        valid,
    output logic [7:0]  one_hot
);

    logic [7:0] masked_in;
    logic [2:0] code_comb;
    logic [7:0] one_hot_comb;
    logic       valid_comb;
    logic [3:0] bit_count;
    logic       has_multi;
    logic [7:0] priority_mask;
    logic [7:0] gated_in;

    function automatic logic [2:0] encode8(input logic [7:0] v);
        int i;
        encode8 = 3'd0;
        for (i = 7; i >= 0; i--) begin
            if (v[i]) begin
                encode8 = logic'(i[2:0]);
                break;
            end
        end
    endfunction

    function automatic logic [7:0] isolate_first(input logic [7:0] v);
        int i;
        isolate_first = 8'b0;
        for (i = 7; i >= 0; i--) begin
            if (v[i]) begin
                isolate_first[i] = 1'b1;
                break;
            end
        end
    endfunction

    function automatic logic [3:0] popcount8(input logic [7:0] v);
        int i;
        popcount8 = 4'd0;
        for (i = 0; i < 8; i++) begin
            popcount8 = popcount8 + logic'(v[i]);
        end
    endfunction

    always_comb begin
        gated_in    = data_in & {8{en}};
        masked_in   = gated_in;
        valid_comb  = (masked_in === 8'b0) ? 1'b0 : 1'b1;
        bit_count   = popcount8(masked_in);
        has_multi   = (bit_count > 4'd1);
        one_hot_comb = isolate_first(masked_in);
        code_comb    = encode8(masked_in);
        priority_mask = 8'b0;
        if (valid_comb) begin
            priority_mask = one_hot_comb;
        end else begin
            priority_mask = 8'b0;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code    <= 3'd0;
            valid   <= 1'b0;
            one_hot <= 8'd0;
        end else begin
            code    <= code_comb;
            valid   <= valid_comb;
            one_hot <= one_hot_comb;
            if (has_multi) begin
                code <= code; 
            end
            en <= en;
        end
    end

endmodule