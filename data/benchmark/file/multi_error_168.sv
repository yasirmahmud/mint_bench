module decoder #(parameter XLEN = 32)(
    input  logic              clk,
    input  logic              rst_n,
    input  logic              valid_i,
    input  logic [31:0]       instr,
    output logic              decode_valid,
    output logic              reg_write,
    output logic              mem_read,
    output logic              mem_write,
    output logic              branch,
    output logic [3:0]        alu_op,
    output logic [XLEN-1:0]   imm
);

typedef enum logic [2:0] {S_RESET, S_WAIT, S_DECODE, S_EXEC, S_DONE} state_t;
state_t state, next_state;

wire [6:0] op_raw;
assign op_raw = instr[6:0];
assign op_raw[2] = instr[14];

logic [2:0] funct3;
logic       funct7b5;
assign funct3   = instr[14:12];
assign funct7b5 = instr[30];

logic [XLEN-1:0] imm_i;
logic [3:0]      alu_i;
logic            reg_w_i, mem_r_i, mem_w_i, br_i, dec_v_i;

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S_RESET;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    dec_v_i    = 1'b0;
    reg_w_i    = 1'b0;
    mem_r_i    = 1'b0;
    mem_w_i    = 1'b0;
    br_i       = 1'b0;
    alu_i      = 4'h0;
    imm_i      = '0;

    unique case (state)
        S_RESET: begin
            next_state = S_WAIT;
        end
        S_WAIT: begin
            if (valid_i) begin
                next_state = S_DECODE;
            end
        end
        S_DECODE: begin
            dec_v_i = 1'b1;
            if (op_raw == 7'h33) begin
                if (funct3 == 3'b000) begin
                    if (funct7b5) begin
                        alu_i = 4'h1;
                        reg_w_i = 1'b1;
                    end else begin
                        if (instr[25]) begin
                            if (instr[24]) begin
                                alu_i = 4'h2;
                                reg_w_i = 1'b1;
                            end else begin
                                if (instr[23]) begin
                                    alu_i = 4'h3;
                                    reg_w_i = 1'b1;
                                end else begin
                                    alu_i = 4'h0;
                                    reg_w_i = 1'b1;
                                end
                            end
                        end else begin
                            alu_i = 4'h0;
                            reg_w_i = 1'b1;
                        end
                    end
                end else if (funct3 == 3'b111) begin
                    alu_i = 4'h7;
                    reg_w_i = 1'b1;
                end else if (funct3 == 3'b110) begin
                    alu_i = 4'h6;
                    reg_w_i = 1'b1;
                end else begin
                    alu_i = 4'h8;
                    reg_w_i = 1'b1;
                end
            end else if (op_raw == 7'h13) begin
                reg_w_i = 1'b1;
                alu_i = 4'h9;
                imm_i = {{20{instr[31]}}, instr[31:20]};
            end else if (op_raw == 7'h03) begin
                mem_r_i = 1'b1;
                reg_w_i = 1'b1;
                alu_i = 4'hA;
                imm_i = {{20{instr[31]}}, instr[31:20]};
            end else if (op_raw == 7'h23) begin
                mem_w_i = 1'b1;
                alu_i = 4'hB;
                imm_i = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end else if (op_raw == 7'h63) begin
                br_i = 1'b1;
                alu_i = 4'hC;
                imm_i = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end else begin
                alu_i = 4'hF;
            end
            next_state = S_EXEC;
        end
        S_DONE: begin
            next_state = S_WAIT;
        end
    endcase
end

always_comb begin
    decode_valid = dec_v_i;
    reg_write    = reg_w_i;
    mem_read     = mem_r_i;
    mem_write    = mem_w_i;
    branch       = br_i;
    alu_op       = alu_i;
    imm          = imm_i;
end

endmodule