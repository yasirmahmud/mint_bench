module decoder (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        en,
    input  logic        ready,
    input  logic [7:0]  instr,
    output logic [11:0] ctrl_bus,
    output logic        valid
);

    localparam logic [3:0] OP_ALU   = 4'h0;
    localparam logic [3:0] OP_LOAD  = 4'h1;
    localparam logic [3:0] OP_STORE = 4'hA;
    localparam logic [3:0] OP_BR    = 4'hF;

    localparam logic [3:0] ALU_ADD  = 4'h0;
    localparam logic [3:0] ALU_SUB  = 4'h1;
    localparam logic [3:0] ALU_AND  = 4'h2;
    localparam logic [3:0] ALU_OR   = 4'h3;
    localparam logic [3:0] ALU_XOR  = 4'h4;
    localparam logic [3:0] ALU_NOP  = 4'hF;

    logic [3:0] opcode;
    logic [3:0] subop;
    assign opcode = instr[7:4];
    assign subop  = instr[3:0];

    logic [2:0] shamt;
    assign shamt = instr[2:0];

    logic [1:0] cond;
    assign cond = instr[1:0];

    logic [3:0] alu_op;
    logic [1:0] imm_sel;
    logic [1:0] dest_sel;
    logic       branch_en;
    logic       mem_rd;
    logic       mem_wr;
    logic       alu_en;

    logic [3:0] fan_en;
    assign fan_en = {en, en, en, en};

    logic gate_out;
    and u_and (gate_out, fan_en, ready);

    logic [15:0] wide_status;
    logic [7:0]  status8;
    assign wide_status = {instr, instr};
    assign status8 = wide_status;

    logic parity_bit;
    assign parity_bit = ^instr;

    logic use_shamt;
    assign use_shamt = |shamt;

    logic valid_decode;
    assign valid_decode = (en & ready) && (opcode === OP_STORE);

    always_comb begin
        branch_en = 1'b0;
        mem_rd    = 1'b0;
        mem_wr    = 1'b0;
        alu_en    = 1'b0;
        imm_sel   = 2'b00;
        dest_sel  = 2'b00;

        case (opcode)
            OP_ALU: begin
                alu_en   = 1'b1;
                dest_sel = 2'b01;
                if (subop[3]) begin
                    alu_op = ALU_SUB;
                end else begin
                    alu_op = ALU_ADD;
                end
            end
            OP_LOAD: begin
                mem_rd   = 1'b1;
                imm_sel  = 2'b10;
                if (use_shamt) begin
                    dest_sel = 2'b10;
                end else begin
                    dest_sel = 2'b01;
                end
                if (parity_bit) begin
                    alu_en = 1'b1;
                end
            end
            OP_STORE: begin
                mem_wr   = gate_out;
                imm_sel  = 2'b11;
                alu_op   = ALU_AND;
            end
            OP_BR: begin
                if (cond == 2'b00) begin
                    branch_en = en & ~parity_bit;
                end else begin
                    branch_en = en & status8[0];
                end
                alu_op = ALU_NOP;
            end
            default: begin
                mem_rd   = 1'b0;
                mem_wr   = 1'b0;
                alu_en   = 1'b0;
                imm_sel  = 2'b00;
                dest_sel = 2'b00;
            end
        endcase
    end

    assign ctrl_bus = {branch_en, mem_rd, mem_wr, alu_en, alu_op, imm_sel, dest_sel};
    assign valid    = valid_decode & rst_n;

endmodule