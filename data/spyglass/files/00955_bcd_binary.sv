module bcd_binary(bcd,binary);
input [7:0] bcd;
output reg [4:0] binary;
always@(bcd)
begin
case(bcd)
8'b00000000: binary = 5'd0;
8'b00000001: binary = 5'd1;
8'b00000010: binary = 5'd2;
8'b00000011: binary = 5'd3;
8'b00000100: binary = 5'd4;
8'b00000101: binary = 5'd5;
8'b00000110: binary = 5'd6;
8'b00000111: binary = 5'd7;
8'b00001000: binary = 5'd8;
8'b00001001: binary = 5'd9;
8'b00010000: binary = 5'd10;
8'b00010001: binary = 5'd11;
8'b00010010: binary = 5'd12;
8'b00010011: binary = 5'd13;
8'b00010100: binary = 5'd14;
8'b00010101: binary = 5'd15;
8'b00010110: binary = 5'd16;
8'b00010111: binary = 5'd17;
8'b00011000: binary = 5'd18;
8'b00011001: binary = 5'd19;
endcase
end
endmodule
