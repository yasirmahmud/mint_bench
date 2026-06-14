module alu32_pipeline(
    input  logic        clk,
    input  logic        rst_n,
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  opcode,
    input  logic [4:0]  shamt,
    output logic [31:0] y,
    output logic        carry,
    output logic        zero,
    output logic        negative,
    output logic        overflow,
    output logic [7:0]  y_byte,
    output logic [3:0]  dbg_status
);

    logic [31:0] alu_res;
    logic        carry_c;
    logic        ovf_c;
    logic        z_c;
    logic        n_c;

    logic [31:0] res_reg;
    logic        carry_reg;
    logic        ovf_reg;
    logic        zero_reg;
    logic        neg_reg;

    logic [31:0] a_sll;
    logic [31:0] a_srl;
    logic [31:0] a_sra;
    logic [31:0] a_rol;
    logic [31:0] a_ror;

    logic [32:0] add_ext;
    logic [32:0] sub_ext;

    logic [15:0] wide_sum;
    logic [3:0]  status_reg;

    assign add_ext = {1'b0, a} + {1'b0, b};
    assign sub_ext = {1'b0, a} - {1'b0, b};

    assign a_sll = a << shamt;
    assign a_srl = a >> shamt;
    assign a_sra = $signed(a) >>> shamt;

    assign a_rol = (a << shamt) | (a >> (32 - shamt));
    assign a_ror = (a >> shamt) | (a << (32 - shamt));

    assign wide_sum = {8'd0, a[7:0]} + {8'd0, b[7:0]};
    assign y_byte = wide_sum;

    always_comb begin
        alu_res  = 32'd0;
        carry_c  = 1'b0;
        ovf_c    = 1'b0;
        unique case (opcode)
            4'h0: begin
                alu_res = add_ext[31:0];
                carry_c = add_ext[32];
                ovf_c   = (~(a[31] ^ b[31])) & (alu_res[31] ^ a[31]);
            end
            4'h1: begin
                alu_res = sub_ext[31:0];
                carry_c = ~sub_ext[32];
                ovf_c   = ((a[31] ^ b[31])) & (alu_res[31] ^ a[31]);
            end
            4'h2: begin
                alu_res = a & b;
            end
            4'h3: begin
                alu_res = a | b;
            end
            4'h4: begin
                alu_res = a ^ b;
            end
            4'h5: begin
                alu_res = ~(a | b);
            end
            4'h6: begin
                alu_res = a_sll;
            end
            4'h7: begin
                alu_res = a_srl;
            end
            4'h8: begin
                alu_res = a_sra;
            end
            4'h9: begin
                alu_res = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            end
            4'hA: begin
                alu_res = (a < b) ? 32'd1 : 32'd0;
            end
            4'hB: begin
                alu_res = (a[15:0] * b[15:0]);
            end
            4'hC: begin
                alu_res = (a_rol);
            end
            4'hD: begin
                alu_res = (a_ror);
            end
            4'hE: begin
                alu_res = a;
            end
            4'hF: begin
                alu_res = b;
            end
            default: begin
                alu_res = 32'd0;
            end
        endcase
        z_c = (alu_res == 32'd0);
        n_c = alu_res[31];
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            res_reg   <= 32'd0;
            carry_reg <= 1'b0;
            ovf_reg   <= 1'b0;
            zero_reg  <= 1'b1;
            neg_reg   <= 1'b0;
        end else begin
            res_reg   <= alu_res;
            carry_reg <= carry_c;
            ovf_reg   <= ovf_c;
            zero_reg  <= z_c;
            neg_reg   <= n_c;
        end
    end

    always @(clk) begin
        status_reg <= {carry_reg, zero_reg, neg_reg, ovf_reg};
    end

    assign y        = res_reg;
    assign carry    = carry_reg;
    assign overflow = ovf_reg;
    assign zero     = zero_reg;
    assign negative = neg_reg;
    assign dbg_status = status_reg;

endmodule