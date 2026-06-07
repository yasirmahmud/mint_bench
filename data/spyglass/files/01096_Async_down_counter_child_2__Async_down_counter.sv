module Async_down_counter(
    input clk,rst,
    output [3:0] q
    );
 
    wire t_enable = 1'b1; // Introduce a named wire for the constant 't' input
    
    t_flipflop1 a1(.t(t_enable),.clk(clk),.rst(rst),.q(q[0]));
    t_flipflop1 a2(.t(t_enable),.clk(q[0]),.rst(rst),.q(q[1]));
    t_flipflop1 a3(.t(t_enable),.clk(q[1]),.rst(rst),.q(q[2]));
    t_flipflop1 a4(.t(t_enable),.clk(q[2]),.rst(rst),.q(q[3]));
endmodule
