module fsm_current_state_name_ex1(input wire clk,input wire rst,input wire start_signal,output wire done_signal);
parameter IDLE=2'b00;
parameter STATE1=2'b01;
parameter STATE2=2'b10;
reg [1:0] current_state_vector_name_is_too_long_for_this_rule;
wire [1:0] next_state;
always @(posedge clk or posedge rst) begin if (rst) begin current_state_vector_name_is_too_long_for_this_rule <= IDLE;
 end else begin current_state_vector_name_is_too_long_for_this_rule <= next_state;
 end end always @(*) begin next_state = current_state_vector_name_is_too_long_for_this_rule;
 case (current_state_vector_name_is_too_long_for_this_rule) IDLE: begin if (start_signal) begin next_state = STATE1;
 end end STATE1: begin next_state = STATE2;
 end STATE2: begin next_state = IDLE;
 end default: begin next_state = IDLE;
 end endcase end assign done_signal = (current_state_vector_name_is_too_long_for_this_rule == STATE2);
endmodule
