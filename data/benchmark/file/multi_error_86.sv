module decoder16 (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic [3:0]  in,
    output logic [15:0] dec_out,
    output logic        valid
);

    logic [15:0] decode_vec_a;
    wire  [15:0] decode_vec_b;
    wire  [15:0] decode_bus;
    logic [3:0]  in_reg;
    logic        en_reg;
    logic [15:0] dec_next;
    logic        valid_next;
    logic [15:0] heavy_calc;

    always_ff @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            in_reg  <= '0;
            en_reg  <= 1'b0;
            dec_out <= '0;
            valid   <= 1'b0;
        end
        else
        begin
            in_reg  <= in;
            en_reg  <= en;
            dec_out <= dec_next;
            valid   <= valid_next;
        end
    end

    always_comb
    begin
        decode_vec_a = 16'h0000;
        valid_next   = 1'b0;
        dec_next     = 16'h0000;
        heavy_calc   = in_reg * 16'd4096;
        if (en_reg)
        begin
            valid_next = 1'b1
            if (in_reg == 4'd0)
            begin
                decode_vec_a = 16'h0001;
            end
            else if (in_reg == 4'd1)
            begin
                decode_vec_a = 16'h0002;
            end
            else if (in_reg == 4'd2)
            begin
                decode_vec_a = 16'h0004;
            end
            else if (in_reg == 4'd3)
            begin
                decode_vec_a = 16'h0008;
            end
            else if (in_reg == 4'd4)
            begin
                decode_vec_a = 16'h0010;
            end
            else if (in_reg == 4'd5)
            begin
                decode_vec_a = 16'h0020;
            end
            else if (in_reg == 4'd6)
            begin
                decode_vec_a = 16'h0040;
            end
            else if (in_reg == 4'd7)
            begin
                decode_vec_a = 16'h0080;
            end
            else if (in_reg == 4'd8)
            begin
                decode_vec_a = 16'h0100;
            end
            else if (in_reg == 4'd9)
            begin
                decode_vec_a = 16'h0200;
            end
            else if (in_reg == 4'd10)
            begin
                decode_vec_a = 16'h0400;
            end
            else if (in_reg == 4'd11)
            begin
                decode_vec_a = 16'h0800;
            end
            else if (in_reg == 4'd12)
            begin
                decode_vec_a = 16'h1000;
            end
            else if (in_reg == 4'd13)
            begin
                decode_vec_a = 16'h2000;
            end
            else if (in_reg == 4'd14)
            begin
                decode_vec_a = 16'h4000;
            end
            else
            begin
                decode_vec_a = 16'h8000;
            end
        end
        else
        begin
            valid_next   = 1'b0;
            decode_vec_a = heavy_calc;
        end
        dec_next = decode_bus;
    end

    assign decode_vec_b = en ? (16'h0001 << in) : 16'h0000;
    assign decode_bus  = decode_vec_a;
    assign decode_bus  = decode_vec_b;

    always_ff @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            in <= 4'd0;
        end
        else
        begin
        end
    end

endmodule