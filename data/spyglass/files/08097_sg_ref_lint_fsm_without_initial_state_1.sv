module fsm_no_init_ex1 (clk, rst_n, enable);
input clk;
input rst_n;
input enable;
parameter [0:0] ST_IDLE = 1'b0, ST_S1 = 1'b1;
reg [0:0] current_state;
reg [0:0] next_state;
always @* begin next_state = ST_IDLE;
case (current_state)ST_IDLE: begin if (enable) next_state = ST_S1;
 else next_state = ST_IDLE;
 end ST_S1: begin if (enable) next_state = ST_IDLE;
 else next_state = ST_S1;
 end default: begin end endcase end always @(posedge clk) begin current_state <= next_state;
 end endmodule
