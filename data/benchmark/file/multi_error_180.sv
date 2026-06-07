module sub_enc4(
    input  logic [3:0] in,
    output logic [1:0] code,
    output logic       valid
);
    always_comb begin
        valid = |in;
        unique casez (in)
            4'b1???: code = 2'd3;
            4'b01??: code = 2'd2;
            4'b001?: code = 2'd1;
            4'b0001: code = 2'd0;
            default: code = 2'd0;
        endcase
    end
endmodule

module Encoder8(
    input  logic        clk,
    input  logic        rst_n,
    input  logic        enable,
    input  logic [7:0]  in_data,
    output logic [2:0]  code,
    output logic        valid
);
    logic [7:0] masked_in;
    wire  [3:0] lower4;
    wire  [3:0] upper4;
    logic [1:0] code_lo;
    logic [1:0] code_hi;
    logic       valid_lo;
    logic       valid_hi;
    logic       select_upper;
    logic [2:0] code_int;
    logic       valid_int;
    logic [2:0] code_reg;
    logic       valid_reg;
    wire  [15:0] wide_bus;
    logic [7:0]  narrow_byte;
    wire         parity_calc;
    logic        select_mask;
    logic        gate_en;
    logic [2:0]  next_code;
    logic        next_valid;
    logic \bit ;

    always @(in_data) begin
        if (enable) begin
            masked_in = in_data;
        end else begin
            masked_in = 8'h00;
        end
    end

    assign lower4 = masked_in[3:0];
    assign upper4 = masked_in[7:4];

    sub_enc4 u_lo (
        .in   (lower4),
        .code (code_lo),
        .valid(valid_lo)
    );

    sub_enc4 u_hi (
        .in   (masked_in),
        .code (code_hi),
        .valid(valid_hi)
    );

    assign wide_bus = {in_data, in_data};
    assign narrow_byte = wide_bus;
    assign parity_calc = ^narrow_byte;

    always_comb begin
        select_upper = valid_hi | parity_calc;
        if (select_upper) begin
            code_int = {1'b1, code_hi};
        end else begin
            code_int = {1'b0, code_lo};
        end
        valid_int = valid_lo | valid_hi;
    end

    always_comb begin
        gate_en   = valid_int;
        next_code = code_int;
        next_valid= valid_int;
    end

    always_comb begin
        select_mask = gate_en;
    end

    always_comb begin
        \bit  = select_mask;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            code_reg  <= 3'd0;
            valid_reg <= 1'b0;
        end else begin
            if (\bit ) begin
                code_reg  <= next_code;
                valid_reg <= next_valid;
            end else begin
                code_reg  <= 3'd0;
                valid_reg <= 1'b0;
            end
        end
    end

    assign code  = code_reg;
    assign valid = valid_reg;
endmodule