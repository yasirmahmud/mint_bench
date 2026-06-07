module spi_module_interp(din0,din1,din2,din3,CLK,Reset,dout,load);


input [9:0]din0,din1,din2,din3;

input CLK,Reset;
input load;

output reg [9:0]dout;
reg [9:0] din_reg [3:0];

reg [1:0] cnt;//Counter for Parallel out
always @(posedge CLK or posedge Reset or posedge load)

begin
	if(Reset==1'b1)
		begin
			dout<=10'd0;
			din_reg[0]<=10'd0;
			din_reg[1]<=10'd0;
			din_reg[2]<=10'd0;	
			din_reg[3]<=10'd0;
			cnt<=2'd0;
		end

	else
		begin
			if(load==1'b1)
				begin
					din_reg[0]<=din0;
					din_reg[1]<=din1;
					din_reg[2]<=din2;	
					din_reg[3]<=din3;
				end

			else begin
                                case(cnt)
                                2'd0:begin
                                        dout<=din_reg[3];
                                        cnt<=cnt+2'd1;
                                      end
                                2'd1:begin
                                        dout<=din_reg[2];
                                        cnt<=cnt+2'd1;
                                     end
                                2'd2:begin
                                        dout<=din_reg[1];
                                        cnt<=cnt+2'd1;
                                     end
                                2'd3:begin
                                       dout<=din_reg[0];
                                        cnt<=2'd0;
                                     end
                                default:begin
                                        din_reg[3]<=din_reg[3];
                                        din_reg[2]<=din_reg[2];
                                        din_reg[1]<=din_reg[1];
                                        din_reg[0]<=din_reg[0];
                                        cnt<=cnt;
                                        end
                                endcase				
		        end
	        end
end

endmodule
