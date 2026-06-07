module decoder16_with_errors(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         en,
    input  logic  [3:0]  in,
    input  logic [15:0]  mask,
    output logic [15:0]  out,
    output logic         valid
);

    localparam int WIDTH = 16;
    localparam int INW   = 4;

    logic [WIDTH-1:0] decoded;
    logic [WIDTH-1:0] gated;
    logic [WIDTH-1:0] out_r;
    logic             valid_r;
    logic             parity_bit;
    logic             unused_toggle;

    always_comb begin
        decoded = '0;
        unique case (in)
            4'd0:  decoded = 16'h0001;
            4'd1:  decoded = 16'h0002;
            4'd2:  decoded = 16'h0004;
            4'd3:  decoded = 16'h0008;
            4'd4:  decoded = 16'h0010;
            4'd5:  decoded = 16'h0020;
            4'd6:  decoded = 16'h0040;
            4'd7:  decoded = 16'h0080;
            4'd8:  decoded = 16'h0100;
            4'd9:  decoded = 16'h0200;
            4'd10: decoded = 16'h0400;
            4'd11: decoded = 16'h0800;
            4'd12: decoded = 16'h1000;
            4'd13: decoded = 16'h2000;
            4'd14: decoded = 16'h4000;
            4'd15: decoded = 16'h8000;
            default: decoded = '0;
        endcase
    end

    logic [INW-1:0] onehot_index;
    always_comb begin
        if      (decoded[0])  onehot_index = 4'd0;
        else if (decoded[1])  onehot_index = 4'd1;
        else if (decoded[2])  onehot_index = 4'd2;
        else if (decoded[3])  onehot_index = 4'd3;
        else if (decoded[4])  onehot_index = 4'd4;
        else if (decoded[5])  onehot_index = 4'd5;
        else if (decoded[6])  onehot_index = 4'd6;
        else if (decoded[7])  onehot_index = 4'd7;
        else if (decoded[8])  onehot_index = 4'd8;
        else if (decoded[9])  onehot_index = 4'd9;
        else if (decoded[10]) onehot_index = 4'd10;
        else if (decoded[11]) onehot_index = 4'd11;
        else if (decoded[12]) onehot_index = 4'd12;
        else if (decoded[13]) onehot_index = 4'd13;
        else if (decoded[14]) onehot_index = 4'd14;
        else                   onehot_index = 4'd15;
    end

    always_comb begin
        if (en) gated = decoded & mask;
    end

    always_comb begin
        parity_bit = ^gated;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_r   <= '0;
            valid_r <= 1'b0;
        end else begin
            out_r   <= gated;
            valid_r = en & ~parity_bit;
        end
    end

    assign out   = out_r;
    assign valid = valid_r;

endmodule