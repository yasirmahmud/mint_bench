module Async_down_counter(
    input clk,rst,
    output [3:0] q
    );
 
    
    // Instantiate T-flip-flops for a 4-bit ripple down counter
    // Asynchronous reset to 7 (0111_2) means:
    // q[0] resets to 1
    // q[1] resets to 1
    // q[2] resets to 1
    // q[3] resets to 0
    // For a down counter, subsequent FFs are clocked by the inverted output of the previous stage.
    t_flipflop1 a1(.t(1'b1),.clk(clk),.rst(rst),.reset_val(1'b1),.q(q[0]));
    t_flipflop1 a2(.t(1'b1),.clk(~q[0]),.rst(rst),.reset_val(1'b1),.q(q[1]));
    t_flipflop1 a3(.t(1'b1),.clk(~q[1]),.rst(rst),.reset_val(1'b1),.q(q[2]));
    t_flipflop1 a4(.t(1'b1),.clk(~q[2]),.rst(rst),.reset_val(1'b0),.q(q[3]));
endmodule
