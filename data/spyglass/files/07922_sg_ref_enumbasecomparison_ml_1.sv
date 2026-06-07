module enum_base_comparison_ex1;
 parameter S_IDLE=2'b00, S_RUN=2'b01;
 reg [1:0] state_val;
 parameter C_RED=2'b00, C_GREEN=2'b01;
 reg [1:0] color_val;
 initial begin state_val=S_IDLE;
 color_val=C_RED;
 if(state_val==color_val) $display("Match");
 end endmodule
