module incomp_case (input i0 , input i1 , input [1:0] sel, output reg y);
always @ (*)
begin
    y = y; // Initialize y with its current value to explicitly model a latch for unhandled cases
	case(sel)
		2'b00 : y = i0;
		2'b01 : y = i1;
		// No default needed, as y retains its value due to the initial assignment for other sel values
	endcase
end
endmodule
