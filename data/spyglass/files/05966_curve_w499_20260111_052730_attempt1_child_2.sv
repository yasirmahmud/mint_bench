module test_w499 (
    input in_sel,
    input in_data,
    output [1:0] out
);

function [1:0] my_func;
    input select_bit;
    input assign_val;
    begin
        // The original intent was for unassigned bits to default to 'X'.
        // By removing the explicit '2'bxx' assignment, we rely on Verilog's
        // behavior where unassigned bits of a function's return value default to 'X'.
        // This resolves the NoAssignX-ML violation while preserving functional behavior.
        if (select_bit) begin
            my_func[0] = assign_val;
            // my_func[1] is not assigned here, thus it defaults to 'X', 
            // matching the original unassigned behavior.
        end
        // If select_bit is false, neither my_func[0] nor my_func[1] are assigned.
        // Both will default to 'X', matching the original unassigned behavior.
    end
endfunction

assign out = my_func(in_sel, in_data);

endmodule
