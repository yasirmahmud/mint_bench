module fsm_next_state_ex1(input clk,input rst_n,input start_signal,output reg done_signal);
parameter IDLE=2'b00;
parameter ACTIVE=2'b01;
reg [1:0] current_state;
wire [1:0] next_state_vector_name_is_too_long_for_the_default_rule;
always @(posedge clk or negedge rst_n) begin if (!rst_n) begin current_state <= IDLE;
 end else begin current_state <= next_state_vector_name_is_too_long_for_the_default_rule;
 end end always @(*) begin case (current_state) IDLE: begin if (start_signal) begin next_state_vector_name_is_too_long_for_the_default_rule = ACTIVE;
 end else begin next_state_vector_name_is_too_long_for_the_default_rule = IDLE;
 end end ACTIVE: begin next_state_vector_name_is_too_long_for_the_default_rule = IDLE;
 end default: begin next_state_vector_name_is_too_long_for_the_default_rule = IDLE;
 end endcase end always @(*) begin if (current_state == ACTIVE) begin done_signal = 1'b1;
 end else begin done_signal = 1'b0;
 end end endmodule
