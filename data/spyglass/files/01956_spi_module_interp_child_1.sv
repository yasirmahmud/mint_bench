module spi_module_interp(din0,din1,din2,din3,CLK,Reset,dout,load);

input [9:0]din0,din1,din2,din3;

input CLK,Reset;
input load;

output reg [9:0]dout;
reg [9:0] din_reg [3:0];

reg [1:0] cnt;//Counter for Parallel out

always @(posedge CLK or posedge Reset)

begin
	if(Reset==1'b1) begin
		dout        <= 10'd0;
		din_reg[0]  <= 10'd0;
		din_reg[1]  <= 10'd0;
		din_reg[2]  <= 10'd0;	
		din_reg[3]  <= 10'd0;
		cnt         <= 2'd0;
	end
	else begin
		// All registers (dout, din_reg, cnt) must be assigned in all synchronous branches
		// to prevent latch inference. 'load' is now a synchronous enable.
		if(load==1'b1) begin
			// Load new data into din_reg
			din_reg[0] <= din0;
			din_reg[1] <= din1;
			din_reg[2] <= din2;	
			din_reg[3] <= din3;
			// When loading, reset the counter to prepare for outputting din_reg[3] next.
			// dout is set to 0 during load cycle to avoid latch, as its value is undefined by description.
			cnt        <= 2'd0;
			dout       <= 10'd0;
		end
		else begin
			// When load is low, din_reg must explicitly hold its value to avoid latch.
			din_reg[0] <= din_reg[0];
			din_reg[1] <= din_reg[1];
			din_reg[2] <= din_reg[2];
			din_reg[3] <= din_reg[3];

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
            default:begin // Robustness for undefined states
                    dout<=10'd0;
                    cnt<=2'd0;
                    end
            endcase				
		end
	end
end

endmodule
