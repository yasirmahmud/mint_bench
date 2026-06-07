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
				// Default assignments for this clock cycle (if not overridden by specific conditions)
				digit <= digit; // Hold its current value
				borrow <= 0; // Default to not borrowing
				do_not_borrow_currentDigit <= 0; // Default to potentially needing to borrow from next digit

				if(reconfig == 1)
					begin
						// do_not_borrow_currentDigit <= 0; // Already set by default
						// borrow <= 0; // Already set by default
						if(setDigit > 9)
							begin
								digit <= 4'b1001;
							end
						else if (setDigit == 0)
							begin
								do_not_borrow_currentDigit <= 1; // Override default
								digit <= 4'b0000; // Override default hold
							end
						else // 1 <= setDigit <= 9
							begin
								digit <= setDigit; // Override default hold
							end
					end
				else // reconfig == 0
					begin
						if(decrement == 1)
							begin
								if(digit == 4'b0000)
									begin
										if(do_not_borrow_nextDigit == 1)
											begin
												digit <= 4'b0000; // Explicitly keep at 0, overriding default hold
												do_not_borrow_currentDigit <= 1; // Override default
												// borrow <= 0; // Default already 0
											end
										else // do_not_borrow_nextDigit == 0
											begin
												borrow <= 1; // Override default
												digit <= 4'b1001; // Override default hold
												// do_not_borrow_currentDigit <= 0; // Default already 0
											end
									end
								else // digit != 0 (1 to 9)
									begin             
										digit <= digit - 1; // Override default hold
										// borrow <= 0; // Default already 0
										// do_not_borrow_currentDigit <= 0; // Default already 0
										if(digit == 1) // If digit was 1, it will become 0 on the next cycle
											begin
												if(do_not_borrow_nextDigit == 1)
													begin
														do_not_borrow_currentDigit <= 1; // Override default
													end
											end
									end
							end
						// else (decrement == 0):
						// All 3 registers take their default values set at the beginning of the 'else' block:
						// digit <= digit;
						// borrow <= 0;
						// do_not_borrow_currentDigit <= 0;
						// This correctly implies a hold for digit, no borrow out, and 'can borrow' for do_not_borrow_currentDigit.
					end
			end
	end
endmodule
