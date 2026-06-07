module mealy_ex1 (input clk, rst, in_sig, output reg out_sig);
 reg [1:0] state;
 always @(posedge clk or posedge rst) begin if (rst) state <= 2'b00;
 else case (state) 2'b00: state <= in_sig ? 2'b01 : 2'b00;
 2'b01: state <= 2'b00;
 default: state <= 2'b00;
 endcase end always @(*) begin case (state) 2'b00: out_sig = in_sig;
 2'b01: out_sig = 1'b1;
 default: out_sig = 1'b0;
 endcase end endmodule
