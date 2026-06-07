module idu(
    input [31:0] inst,
    output reg [2:0] ExtOP,
    output reg [3:0] ALUctr,
    output reg Wen,
    output reg ALUAsrc,
    output reg ALUBsrc,
    output reg [2:0] wdctr,
    output reg [3:0] pcctr,
    output reg datawen,
    output reg valid,
    output reg [7:0] datamask
);

    wire [6:0] op = inst[6:0];
    wire [2:0] func3 = inst[14:12];
    wire func7_bit = inst[30];
    wire [7:0] mask;
    wire [3:0] alusel;

    // MuxKeyWithDefault for datamask
    // Renamed instance from masksel to mask_mux_inst to avoid potential conflict
    MuxKeyWithDefault #(5, 3, 8) mask_mux_inst( // Parameters: #(NUM_PAIRS, KEY_WIDTH, DATA_WIDTH)
        .out(mask),
        .key(func3),
        .default_val(8'b00000000),
        .pairs({
            3'b010, 8'b00001111, // sw lw
            3'b001, 8'b00000011, // sh lh
            3'b000, 8'b00000001, // sb lb
            3'b100, 8'b00000001, // lbu
            3'b101, 8'b00000011  // lhu
        })
    );

    // MuxKeyWithDefault for ALU control selection
    // Renamed instance from andsel to alu_mux_inst to avoid potential conflict
    MuxKeyWithDefault #(3, 3, 4) alu_mux_inst( // Parameters: #(NUM_PAIRS, KEY_WIDTH, DATA_WIDTH)
        .out(alusel),
        .key(func3),
        .default_val(4'b0010),
        .pairs({
            3'b111, 4'b0010, // and andi
            3'b110, 4'b0011, // or ori
            3'b100, 4'b0100  // xor xori
        })
    );

    always @(*) begin
        // Initialize all outputs to default values matching the original's top-level default case
        ExtOP = 3'b000;
        Wen = 0;
        ALUAsrc = 1; // Default to 1 (read rs1)
        ALUBsrc = 0;
        ALUctr = 4'b0000;
        wdctr = 3'b010; // Default to 2 (PC+4 for writeback)
        pcctr = 4'b0000;
        datawen = 0;
        valid = 0;
        datamask = 8'b00000000;

        case(op)
            7'b0110111, 7'b0010111: begin // U-type: LUI, AUIPC
                ExtOP = 3'b001;
                Wen = 1;
                ALUAsrc = 0;
                ALUBsrc = 0;
                wdctr = {1'b0, op[6:5]}; // U-type uses immediate as data
            end
            7'b0010011: begin // I-type (arithmetic/logical with immediate)
                Wen = 1;
                ALUAsrc = 1;
                case(func3)
                    3'b000: begin // addi
                        ExtOP = 3'b000;
                    end
                    3'b101: begin // srli, srai
                        ExtOP = 3'b000;
                        ALUctr = {3'b011, func7_bit};
                    end
                    3'b001: begin // slli
                        ExtOP = 3'b000;
                        ALUctr = 4'b0101;
                    end
                    3'b011: begin // sltiu pseudo instruction seqz
                        ExtOP = 3'b000;
                        wdctr = 3'b100;
                    end
                    3'b111, 3'b110, 3'b100: begin // andi ori xori
                        ExtOP = 3'b000;
                        ALUctr = alusel;
                    end
                    default: begin // For any other func3, assume addi-like behavior
                        ExtOP = 3'b000;
                    end
                endcase
            end

            7'b0000011: begin // I-type load (LB, LH, LW, LBU, LHU)
                ExtOP = 3'b000;
                Wen = 1;
                ALUAsrc = 1;
                wdctr = 3'b011; // Special writeback for load operations
                valid = 1;
                datamask = mask; // Use mask from MuxKeyWithDefault
            end
            7'b0100011: begin // S-type (store instructions)
                ExtOP = 3'b010;
                Wen = 0;
                ALUAsrc = 1;
                datawen = 1;
                valid = 1;
                datamask = mask; // Use mask from MuxKeyWithDefault
            end
            7'b0110011: begin // R-type (arithmetic/logical register-to-register)
                Wen = 1;
                ALUAsrc = 1;
                ALUBsrc = 1;
                case(func3)
                    3'b000: begin // add or sub (funct7_bit differentiates)
                        ALUctr = {3'b000, func7_bit};
                    end
                    3'b010: begin // slt
                        ALUAsrc = 0; // slt, sltu use operand directly as comparison
                        ALUBsrc = 0;
                        ALUctr = 4'b0010;
                        wdctr = 3'b110;
                    end
                    3'b001: begin // sll
                        ALUctr = 4'b0101;
                    end
                    3'b101: begin // srl sra (funct7_bit differentiates)
                        ALUctr = {func7_bit, 3'b110};
                    end
                    3'b011: begin // sltu
                        ALUAsrc = 0;
                        ALUBsrc = 0;
                        ALUctr = 4'b0010;
                        wdctr = 3'b101;
                    end
                    3'b111, 3'b110, 3'b100: begin // and or xor
                        ALUctr = alusel;
                    end
                    default: begin // Default R-type is add
                        // ALUctr = 4'b0000; // Already default
                    end
                endcase
            end
            7'b1100011: begin // B-type (branch instructions)
                ExtOP = 3'b011;
                Wen = 0;
                ALUAsrc = 1;
                ALUBsrc = 1;
                case(func3)
                    3'b000: begin pcctr = 4'b0011; end // beq
                    3'b001: begin pcctr = 4'b0100; end // bne
                    3'b100: begin pcctr = 4'b0110; end // blt
                    3'b101: begin pcctr = 4'b0111; end // bge
                    3'b110: begin pcctr = 4'b0101; end // bltu
                    3'b111: begin pcctr = 4'b1000; end // bgeu
                    default: begin pcctr = 4'b0011; end // Default to beq
                endcase
            end
            7'b1100111: begin // jalr (Jump and Link Register)
                ExtOP = 3'b000;
                Wen = 1;
                ALUAsrc = 1;
                wdctr = 3'b010; // Write PC+4 to rd
                pcctr = 4'b0010; // PC update for JALR
            end
            7'b1101111: begin // jal (Jump and Link)
                ExtOP = 3'b100;
                Wen = 1;
                ALUAsrc = 0;
                ALUBsrc = 0;
                wdctr = 3'b010; // Write PC+4 to rd
                pcctr = 4'b0001; // PC update for JAL
            end
            default: begin // Default case for unknown opcodes
                // Values initialized at the top of the always block already match the original default
                // ExtOP = 3'b000;
                // Wen = 0;
                // ALUAsrc = 1;
                // ALUBsrc = 0;
                // ALUctr = 4'b0000;
                // wdctr = 3'b010;
                // pcctr = 4'b0000;
                // datawen = 0;
                // valid = 0;
                // datamask = 8'b00000000;
            end
        endcase
    end
endmodule
