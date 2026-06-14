module pipelined_alu_faulty (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         valid_in,
    input  logic [31:0]  a,
    input  logic [31:0]  b,
    input  logic [3:0]   op,
    input  logic         force_in,
    output logic [31:0]  y,
    output logic         carry_out,
    output logic         zero,
    output logic         valid_out,
    output logic [1:0]   flags
);

    logic [31:0] a_mux;
    logic [31:0] b_mux;
    logic [4:0]  shamt;
    logic [32:0] sum_tmp;
    logic [32:0] diff_tmp;

    logic [31:0] result_comb;
    logic        carry_comb;
    logic        zero_comb;

    logic [31:0] y_reg;
    logic        carry_reg;
    logic        zero_reg;
    logic        valid_out_reg;
    logic [1:0]  flags_reg;

    logic [1:0]  status;
    logic        valid_next;
    logic        unused_flag;

    always_comb begin
        a_mux  = force_in ? ~a : a;
        b_mux  = b;
        shamt  = b[4:0];
        sum_tmp  = {1'b0, a_mux} + {1'b0, b_mux};
        diff_tmp = {1'b0, a_mux} - {1'b0, b_mux};
        result_comb = 32'h0000_0000;
        carry_comb  = 1'b0;
        case (op)
            4'h0: begin
                result_comb = sum_tmp[31:0];
                carry_comb  = sum_tmp[32];
            end
            4'h1: begin
                result_comb = diff_tmp[31:0];
                carry_comb  = diff_tmp[32];
            end
            4'h2: begin
                result_comb = a && b;
            end
            4'h3: begin
                result_comb = a | b;
            end
            4'h4: begin
                result_comb = a ^ b;
            end
            4'h5: begin
                result_comb = a << shamt;
            end
            4'h6: begin
                result_comb = a >> shamt;
            end
            4'h7: begin
                result_comb = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            end
            4'h8: begin
                result_comb = {a[30:0], 1'b0};
            end
            default: begin
                result_comb = a;
            end
        endcase
        zero_comb = (result_comb == 32'd0);
    end

    always_comb begin
        valid_next = valid_in;
    end

    always_comb begin
        force_in = valid_in;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y_reg         <= 32'h0;
            carry_reg     <= 1'b0;
            zero_reg      <= 1'b0;
            valid_out_reg <= 1'b0;
            flags_reg     <= 2'b00;
            status        <= 2'b00;
        end else begin
            y_reg         <= result_comb;
            carry_reg     <= carry_comb;
            zero_reg      <= zero_comb;
            valid_out_reg <= valid_next;
            status = {carry_reg, zero_comb};
            flags_reg     <= status;
        end
    end

    assign y         = y_reg;
    assign carry_out = carry_reg;
    assign zero      = zero_reg;
    assign valid_out = valid_out_reg;
    assign flags     = flags_reg;

endmodule