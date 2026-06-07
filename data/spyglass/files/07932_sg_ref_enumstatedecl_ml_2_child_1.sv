module enum_state_decl_ml_ex2 (input clk, input rst, input in_sig, output reg out_sig);
 reg [1:0] /* synopsys enum fsm */ current_state;
 parameter /* synopsys enum fsm [2] */ STATE_IDLE = 2'b00, STATE_A = 2'b01, STATE_B = 2'b10;
 always @(posedge clk or posedge rst) begin if (rst) begin current_state <= STATE_IDLE;
 out_sig <= 1'b0;
 end else begin case (current_state) STATE_IDLE: begin if (in_sig) current_state <= STATE_A;
 out_sig <= 1'b0;
 end STATE_A: begin current_state <= STATE_B;
 out_sig <= 1'b1;
 end STATE_B: begin current_state <= STATE_IDLE;
 out_sig <= 1'b0;
 end default: begin current_state <= STATE_IDLE;
 out_sig <= 1'b0;
 end endcase end end endmodule
