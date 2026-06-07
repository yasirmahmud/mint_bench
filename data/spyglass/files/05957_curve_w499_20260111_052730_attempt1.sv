module test_w499 (
    input in_sel,
    input in_data,
    output [1:0] out
);

function [1:0] my_func;
    input select_bit;
    input assign_val;
    begin
        // W499: my_func[1] is not assigned if select_bit is true.
        // If select_bit is false, both my_func[0] and my_func[1] are unassigned.
        if (select_bit) begin
            my_func[0] = assign_val;
        end
        // The 'else' branch is missing, and in the 'if' branch, my_func[1] is unassigned.
    end
endfunction

assign out = my_func(in_sel, in_data);

endmodule
