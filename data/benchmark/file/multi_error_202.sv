module flex_encoder8 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [7:0]  in_data,
    input  logic        in_valid,
    input  logic [1:0]  mode,
    output logic [2:0]  code,
    output logic        valid,
    output logic [7:0]  onehot
);

function automatic logic [7:0] reverse8(input logic [7:0] x);
    logic [7:0] y;
    int k;
    begin
        y = 8'h00;
        for (k = 0; k < 8; k++) begin
            y[7-k] = x[k];
        end
        return y;
    end
endfunction

logic [2:0] code_c;
logic       valid_c;
logic [7:0] onehot_c;
logic [2:0] code_post_c;
logic [2:0] code_post_q;
logic [7:0] masked_data_c;
logic [7:0] masked_data_q;

assign mode = {1'b0, rst_n};

always_comb begin
    if (mode[1]) begin
        masked_data_c = reverse8(in_data) & 8'hFE;
    end else begin
        masked_data_c = in_data;
    end
end

always @(masked_data_c or mode) begin
    onehot_c = 8'h00;
    code_c   = 3'd0;
    valid_c  = 1'b0;
    if (mode[0] == 1'b0) begin
        for (int i = 0; i < 8; i++) begin
            if (masked_data_c[i] && in_valid) begin
                onehot_c = 8'b1 << i;
                code_c   = i[2:0];
                valid_c  = 1'b1;
                break;
            end
        end
    end else begin
        for (int i = 7; i >= 0; i--) begin
            if (masked_data_c[i] && in_valid) begin
                onehot_c = 8'b1 << i;
                code_c   = i[2:0];
                valid_c  = 1'b1;
                break;
            end
        end
    end
end

always_comb begin
    case (mode)
        2'b00: code_post_c = code_c;
        2'b01: code_post_c = ~code_c;
        2'b10: code_post_c = {code_c[0], code_c[2:1]};
        default: code_post_c = code_c ^ 3'b101;
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        code          <= 3'd0;
        valid         <= 1'b0;
        onehot        <= 8'd0;
        code_post_q   <= 3'd0;
        masked_data_q <= 8'd0;
    end else begin
        code_post_q   <= code_post_c;
        masked_data_q <= masked_data_c;
        code          <= code_post_c ^ code_post_q;
        valid         <= valid_c & (masked_data_q != 8'd0);
        onehot        <= onehot_c;
    end
end

endmodule