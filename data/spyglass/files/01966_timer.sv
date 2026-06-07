module timer(clk, reset, reconfig, setDigit, decrement, do_not_borrow_nextDigit, do_not_borrow_currentDigit, borrow, digit);
input clk, reset;
input reconfig;
input [3:0] setDigit;
input decrement;
input do_not_borrow_nextDigit;
output reg do_not_borrow_currentDigit;
output reg borrow;
output reg [3:0] digit;

always @ (posedge clk)
	begin
		if(reset == 0)
			begin
				do_not_borrow_currentDigit <= 1;
				borrow <= 0;
				digit <= 4'b0000;
			end
		else
			begin
				if(reconfig == 1)
					begin
						do_not_borrow_currentDigit <= 0;
						if(setDigit > 9)
							begin
								digit <= 4'b1001;
							end
						///////////////////////////////////////////////////////////// to fix the single digit bug where it counts another 10 seconds if the digit is 1 seconds
						else if (setDigit == 0)
							begin
								do_not_borrow_currentDigit <= 1;
							end
						//////////////////////////////////////////////////////////////
						else
							begin
								digit <= setDigit;
							end
					end
				else
					begin
						if(decrement == 1)
							begin
								if(digit == 4'b0000)
									begin
										if(do_not_borrow_nextDigit == 1)
											begin
												//digit <= 4'b0000;
												do_not_borrow_currentDigit <= 1;
											end
										else
											begin
												borrow <= 1;
												digit <= 4'b1001;
											end
									end
								else
									begin             
										borrow <= 0;
										digit <= digit - 1;       
										if(digit == 1)        
											begin
												if(do_not_borrow_nextDigit == 1)
													begin
														do_not_borrow_currentDigit <= 1;
													end
											end
														
										
									end
							end
						else
							begin
								digit <= digit;
								borrow <= 0;
							end
					end
			end
	end
endmodule
