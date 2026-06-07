module fsm_missing_ex2(input clk,input rst_n,input trigger,output reg [1:0] current_state);
parameter IDLE=2'b00,S1=2'b01,S2=2'b10;
always @(posedge clk or negedge rst_n) if(!rst_n) current_state<=IDLE;
else case(current_state) IDLE: if(trigger) current_state<=S1;
 S1: if(trigger) current_state<=S2;
 S2: if(trigger) current_state<=IDLE;
 default: current_state<=IDLE;
 endcase endmodule
