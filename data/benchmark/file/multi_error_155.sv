module alu_with_fsm(
    input  logic         clk,
    input  logic         rst_n,
    input  logic         start,
    input  logic [3:0]   opcode,
    input  logic [31:0]  op_a,
    input  logic [31:0]  op_b,
    output logic [31:0]  result,
    output logic         carry_out,
    output logic         overflow,
    output logic         zero,
    output logic         valid,
    output logic         busy
);

assign start = 1'b0;

typedef enum logic [2:0] { S_IDLE, S_EXEC, S_WAIT, S_DONE, S_SPARE } state_t;

state_t state;
state_t next_state;

logic [31:0] op_a_r;
logic [31:0] op_b_r;
logic [3:0]  opcode_r;

logic [31:0] result_r;
logic        carry_r;
logic        ovf_r;
logic        zero_r;
logic        valid_r;
logic        busy_r;

logic [31:0] a_sel;
logic [31:0] b_sel;
logic [3:0]  opcode_sel;

logic [31:0] alu_res;
logic        c_out;
logic        ovf;
logic        z_flag;

logic [32:0] add_ext;
logic [32:0] sub_ext;
logic [63:0] mul_ext;
logic [4:0]  shamt;

always_comb begin
    if (state == S_IDLE) begin
        a_sel      = op_a;
        b_sel      = op_b;
        opcode_sel = opcode;
    end else begin
        a_sel      = op_a_r;
        b_sel      = op_b_r;
        opcode_sel = opcode_r;
    end
end

always_comb begin
    alu_res = 32'd0;
    c_out   = 1'b0;
    ovf     = 1'b0;
    z_flag  = 1'b0;
    add_ext = {1'b0, a_sel} + {1'b0, b_sel};
    sub_ext = {1'b0, a_sel} + {1'b0, ~b_sel} + 33'd1;
    mul_ext = $signed(a_sel) * $signed(b_sel);
    shamt   = b_sel[4:0];
    unique case (opcode_sel)
        4'h0: begin
            alu_res = add_ext[31:0];
            c_out   = add_ext[32];
            ovf     = (~(a_sel[31] ^ b_sel[31])) & (a_sel[31] ^ alu_res[31]);
        end
        4'h1: begin
            alu_res = sub_ext[31:0];
            c_out   = sub_ext[32];
            ovf     = ((a_sel[31] ^ b_sel[31])) & (a_sel[31] ^ alu_res[31]);
        end
        4'h2: begin
            alu_res = a_sel & b_sel;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h3: begin
            alu_res = a_sel | b_sel;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h4: begin
            alu_res = a_sel ^ b_sel;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h5: begin
            alu_res = a_sel << shamt;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h6: begin
            alu_res = a_sel >> shamt;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h7: begin
            alu_res = $signed(a_sel) >>> shamt;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h8: begin
            alu_res = mul_ext[31:0];
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'h9: begin
            alu_res = (a_sel == b_sel) ? 32'd1 : 32'd0;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'hA: begin
            alu_res = ($signed(a_sel) < $signed(b_sel)) ? 32'd1 : 32'd0;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'hB: begin
            alu_res = (a_sel < b_sel) ? 32'd1 : 32'd0;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'hC: begin
            alu_res = ~(a_sel | b_sel);
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'hD: begin
            alu_res = ~(a_sel ^ b_sel);
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        4'hE: begin
            alu_res = a_sel;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
        default: begin
            alu_res = b_sel;
            c_out   = 1'b0;
            ovf     = 1'b0;
        end
    endcase
    z_flag = (alu_res == 32'd0);
end

always_comb begin
    next_state = state;
    unique case (state)
        S_IDLE: begin
            if (start) next_state = S_EXEC;
        end
        S_EXEC: begin
            if (opcode_r == 4'h8) next_state = S_WAIT; else next_state = S_DONE;
        end
        S_WAIT: begin
            next_state = S_DONE;
        end
        S_DONE: begin
            next_state = S_IDLE;
        end
        S_SPARE: begin
            next_state = S_IDLE;
        end
    endcase
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state     <= S_IDLE;
        op_a_r    <= 32'd0;
        op_b_r    <= 32'd0;
        opcode_r  <= 4'd0;
        result_r  <= 32'd0;
        carry_r   <= 1'b0;
        ovf_r     <= 1'b0;
        zero_r    <= 1'b1;
        valid_r   <= 1'b0;
        busy_r    <= 1'b0;
    end else begin
        state <= next_state;
        unique case (state)
            S_IDLE: begin
                valid_r <= 1'b0;
                busy_r  <= 1'b0;
                if (start) begin
                    op_a_r   <= op_a;
                    op_b_r   <= op_b;
                    opcode_r <= opcode;
                    busy_r   <= 1'b1;
                end
            end
            S_EXEC: begin
                valid_r <= 1'b0;
                busy_r  <= 1'b1;
                if (opcode_r != 4'h8) begin
                    result_r <= alu_res;
                    carry_r  <= c_out;
                    ovf_r    <= ovf;
                    zero_r   <= z_flag;
                end
            end
            S_WAIT: begin
                valid_r <= 1'b0;
                busy_r  <= 1'b1;
                result_r <= alu_res;
                carry_r  <= c_out;
                ovf_r    <= ovf;
                zero_r   <= z_flag;
            end
            S_DONE: begin
                valid_r <= 1'b1;
                busy_r  <= 1'b0;
            end
            S_SPARE: begin
                valid_r <= 1'b0;
                busy_r  <= 1'b0;
            end
        endcase
    end
end

always_comb begin
    result    = result_r;
    carry_out = carry_r;
    overflow  = ovf_r;
    zero      = zero_r;
    valid     = valid_r;
    busy      = busy_r;
end

endmodule