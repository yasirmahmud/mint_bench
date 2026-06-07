module FSM_no_initial_state_ex2 (clk, rst_n, enable);
 input clk;
 input rst_n;
 input enable;
 parameter [2:0] ST_IN = 3'b000, ST_S1 = 3'b001, ST_S2 = 3'b010, ST_S3 = 3'b011;
 reg [2:0] rw_cs;
 reg [2:0] rw_ns;
 reg control;
 reg y;
 always @ (rw_cs or control) begin case (rw_cs) ST_IN: begin if (control == 1'b1) rw_ns = ST_S1;
 else rw_ns = ST_S3;
 end ST_S1: begin rw_ns = ST_S2;
 end ST_S2: begin rw_ns = ST_S3;
 end ST_S3: begin rw_ns = ST_IN;
 y = 1;
 end default: begin end endcase end always @ (posedge clk) begin rw_cs <= rw_ns;
 end always @ (negedge rst_n or posedge clk) begin if (!rst_n) control <= 1'b0;
 else control <= 1'b1;
 end endmodule
