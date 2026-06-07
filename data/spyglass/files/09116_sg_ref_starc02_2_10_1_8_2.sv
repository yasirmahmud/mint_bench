module ram_case_ex2(input clk, input [1:0] addr, output reg [3:0] ram_out, output reg [3:0] case_out);
 reg [3:0] my_ram[0:3];
 initial begin my_ram[0]=4'b0000;
 my_ram[1]=4'b0001;
 my_ram[2]=4'b0010;
 my_ram[3]=4'b0011;
 end always @(posedge clk) begin ram_out <= my_ram[addr];
 end always @(*) begin case (ram_out) 4'b0000: case_out = 4'b0001;
 4'b0001: case_out = 4'b0010;
 4'b0010: case_out = 4'b0011;
 default: case_out = 4'b1111;
 endcase end endmodule
