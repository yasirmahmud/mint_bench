module starc_2_1_8_1_ex1 (
    output [7:0] b
);
    reg [7:0] a;

    // Fix for violations UndrivenInTerm-ML and W123: 'a' is read but never set.
    // Initialize 'a' to resolve the undriven signal issue.
    initial begin
        a = 8'd0;
    end

    function [7:0] add_func;
        input [7:0] val1;
        input [7:0] val2;
        begin
            add_func = val1 + val2;
        end
    endfunction

    // Fix for violation W528: 'b' is set but not read.
    // Declare 'b' as an output port to indicate it's used externally.
    // This also implicitly makes 'b' a 'wire' type, which is appropriate
    // for a continuous assignment 'assign b = ...'.
    assign b = add_func(a, 8'd5);

endmodule
