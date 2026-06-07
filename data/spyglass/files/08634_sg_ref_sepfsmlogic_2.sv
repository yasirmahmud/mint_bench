module sep_fsm_logic_ex2(clk,reset,in_data,non_fsm_in,fsm_out,non_fsm_out);
input clk,reset,in_data,non_fsm_in;
output fsm_out,non_fsm_out;
reg [1:0] current_state,next_state;
parameter S0=2'b00,S1=2'b01,S2=2'b10;
always @(posedge clk or posedge reset) begin if(reset) current_state<=S0;
else current_state<=next_state;
end always @(*) begin next_state=current_state;
fsm_out=1'b0;
case(current_state)S0:begin if(in_data) next_state=S1;
fsm_out=1'b0;
end S1:begin if(in_data) next_state=S2;
else next_state=S0;
fsm_out=1'b1;
end S2:begin next_state=S0;
fsm_out=1'b0;
end endcase end assign non_fsm_out=non_fsm_in;
endmodule
