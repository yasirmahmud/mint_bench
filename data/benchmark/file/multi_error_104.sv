module complex_decoder #(parameter int OUT_W = 16) (
    input  logic              clk,
    input  logic              rst_n,
    input  logic [7:0]        opcode,
    input  logic [2:0]        funct3,
    input  logic [6:0]        funct7,
    output logic [OUT_W-1:0]  ctrl,
    output logic              illegal
);

localparam logic [7:0] OPC_ALU   = 8'h33;
localparam logic [7:0] OPC_ALUI  = 8'h13;
localparam logic [7:0] OPC_LD    = 8'h03;
localparam logic [7:0] OPC_ST    = 8'h23;
localparam logic [7:0] OPC_BR    = 8'h63;
localparam logic [7:0] OPC_SYS   = 8'h73;
localparam logic [7:0] OPC_LUI   = 8'h37;
localparam logic [7:0] OPC_AUIPC = 8'h17;
localparam logic [7:0] OPC_JAL   = 8'h6F;
localparam logic [7:0] OPC_JALR  = 8'h67;

logic [OUT_W-1:0] ctrl_next;
logic              illegal_next;
logic [OUT_W-1:0] ctrl_reg
logic              illegal_reg;

always_comb begin
    ctrl_next    = '0;
    illegal_next = 1'b0;

    if (opcode == OPC_ALU) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[10] = 1'b1;
        ctrl_next[14] = 1'b1;
        ctrl_next[1]  = 1'b1;
        ctrl_next[0]  = 1'b1;
        if (funct7 == 7'h00) begin
            if (funct3 == 3'h0) begin
                ctrl_next[9:8] = 2'b00;
                ctrl_next[7]   = 1'b0;
                ctrl_next[6]   = 1'b0;
            end else if (funct3 == 3'h4) begin
                ctrl_next[9:8] = 2'b01;
                ctrl_next[7]   = 1'b0;
                ctrl_next[6]   = 1'b0;
            end else if (funct3 == 3'h6) begin
                ctrl_next[9:8] = 2'b10;
                ctrl_next[7]   = 1'b0;
                ctrl_next[6]   = 1'b0;
            end else if (funct3 == 3'h7) begin
                ctrl_next[9:8] = 2'b11;
                ctrl_next[7]   = 1'b0;
                ctrl_next[6]   = 1'b0;
            end else begin
                illegal_next    = 1'b1;
            end
        end else if (funct7 == 7'h20) begin
            if (funct3 == 3'h0) begin
                ctrl_next[9:8] = 2'b00;
                ctrl_next[7]   = 1'b0;
                ctrl_next[6]   = 1'b0;
            end else begin
                illegal_next    = 1'b1;
            end
        end else if (funct7 == 7'h01) begin
            if (funct3 == 3'h0) begin
                ctrl_next[7]   = 1'b1;
                ctrl_next[6]   = 1'b0;
            end else if (funct3 == 3'h4) begin
                ctrl_next[7]   = 1'b1;
                ctrl_next[6]   = 1'b0;
            end else if (funct3 == 3'h6) begin
                ctrl_next[7]   = 1'b1;
                ctrl_next[6]   = 1'b0;
            end else begin
                illegal_next    = 1'b1;
            end
        end else begin
            illegal_next        = 1'b1;
        end
    end else if (opcode == OPC_ALUI) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[10] = 1'b1;
        ctrl_next[14] = 1'b1;
        ctrl_next[0]  = 1'b1;
        ctrl_next[5]  = 1'b1;
        if (funct3 == 3'h0) begin
            ctrl_next[9:8] = 2'b00;
        end else if (funct3 == 3'h6) begin
            ctrl_next[9:8] = 2'b10;
        end else if (funct3 == 3'h7) begin
            ctrl_next[9:8] = 2'b11;
        end else begin
            illegal_next    = 1'b1;
        end
    end else if (opcode == OPC_LD) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[12] = 1'b1;
        ctrl_next[0]  = 1'b1;
        ctrl_next[5]  = 1'b1;
        if (funct3 == 3'h0) begin
            ctrl_next[4:3] = 2'b00;
            ctrl_next[2]   = 1'b1;
        end else if (funct3 == 3'h1) begin
            ctrl_next[4:3] = 2'b01;
            ctrl_next[2]   = 1'b1;
        end else if (funct3 == 3'h2) begin
            ctrl_next[4:3] = 2'b10;
            ctrl_next[2]   = 1'b1;
        end else if (funct3 == 3'h4) begin
            ctrl_next[4:3] = 2'b00;
            ctrl_next[2]   = 1'b0;
        end else if (funct3 == 3'h5) begin
            ctrl_next[4:3] = 2'b01;
            ctrl_next[2]   = 1'b0;
        end else begin
            illegal_next    = 1'b1;
        end
    end else if (opcode == OPC_ST) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[11] = 1'b1;
        ctrl_next[1]  = 1'b1;
        ctrl_next[0]  = 1'b1;
        if (funct3 == 3'h0) begin
            ctrl_next[4:3] = 2'b00;
        end else if (funct3 == 3'h1) begin
            ctrl_next[4:3] = 2'b01;
        end else if (funct3 == 3'h2) begin
            ctrl_next[4:3] = 2'b10;
        end else begin
            illegal_next    = 1'b1;
        end
    end else if (opcode == OPC_BR) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[13] = 1'b1;
        ctrl_next[1]  = 1'b1;
        ctrl_next[0]  = 1'b1;
    end else if (opcode == OPC_JAL) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[13] = 1'b1;
        ctrl_next[14] = 1'b1;
    end else if (opcode == OPC_JALR) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[13] = 1'b1;
        ctrl_next[14] = 1'b1;
        ctrl_next[0]  = 1'b1;
    end else if (opcode == OPC_LUI) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[5]  = 1'b1;
    end else if (opcode == OPC_AUIPC) begin
        ctrl_next[15] = 1'b1;
        ctrl_next[5]  = 1'b1;
    end else if (opcode == OPC_SYS) begin
        ctrl_next[15] = 1'b1;
    end else begin
        illegal_next    = 1'b1;
    end
end

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ctrl_reg    <= '0;
        illegal_reg <= 1'b0;
    end else begin
        ctrl_reg    <= ctrl_next;
        illegal_reg <= illegal_next;
    end
end

assign ctrl    = ctrl_reg;
assign illegal = illegal_reg;

endmodule