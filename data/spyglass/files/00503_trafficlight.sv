module trafficlight  (clk,sa,sb,ra,rb,ya,yb,ga,gb);


	input clk,sa,sb;
	output reg ra,rb,ya,yb,ga,gb;

	reg[3:0] state,next_state;

	initial begin
		state=0;
		ga=1'b0;
		gb=1'b0;
		ra=1'b0;
		rb=1'b0;
		ya=1'b0;
		yb=1'b0;
		next_state=0;
	end	

  always@(state,sa,sb) begin
        ya=1'b0;
		yb=1'b0;
		case(state) 
			0:  begin next_state=1;ga=1'b1;rb=1'b1;ra=1'b0; end
			1:  begin next_state=2; end
			2:  begin next_state=3; end
			3:  begin next_state=4; end
          	4:  begin next_state=5; end
			5:	begin 
					
					if(sb==1)
						next_state=6;
					else	
						next_state=5;
					end
			6:  begin 
					ga=1'b0;ya=1'b1;rb=1'b1;
					next_state=7;
				end
			7:  begin next_state=8;gb=1'b1;ra=1'b1;rb=1'b0; end
			8:  begin next_state=9; end
			9:  begin next_state=10; end
			10: begin next_state=11; end
			11: begin 
					
              if(sb==1'b0 | sa==1'b1) next_state=12;
					else next_state=11;
				end
			12: begin gb=1'b0;ra=1'b1;yb=1'b1;next_state=0;end
		endcase
	end
  always@(posedge clk)
    state<=next_state;
endmodule
