module pc_reg(

    input wire clk,
    input wire rst,

    input wire jump_flag_i,                 // è·³è½¬æ å¿
    input wire[`InstAddrBus] jump_addr_i,   // è·³è½¬å°å
    input wire[`Hold_Flag_Bus] hold_flag_i, // æµæ°´çº¿æåæ å¿
    input wire jtag_reset_flag_i,           // å¤ä½æ å¿

    output reg[`InstAddrBus] pc_o           // PCæé

    );


    always @ (posedge clk) begin
        // å¤ä½
        if (rst == `RstEnable || jtag_reset_flag_i == 1'b1) begin
            pc_o <= `CpuResetAddr;
        // è·³è½¬
        end else if (jump_flag_i == `JumpEnable) begin
            pc_o <= jump_addr_i;
        // æå
        end else if (hold_flag_i >= `Hold_Pc) begin
            pc_o <= pc_o;
        // å°åå 4
        end else begin
            pc_o <= pc_o + 4'h4;
        end
    end

endmodule
