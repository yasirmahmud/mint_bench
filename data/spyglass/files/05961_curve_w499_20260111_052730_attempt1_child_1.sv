module test_w499 (
    input in_sel,
    input in_data,
    output [1:0] out
);

function [1:0] my_func;
    input select_bit;
    input assign_val;
    begin
        // Initialize function return value to 'X' to represent unassigned bits.
        // This preserves the original functional behavior where unassigned bits default to 'X'.
        my_func = 2'bxx;

        if (select_bit) begin
            my_func[0] = assign_val;
            // my_func[1] remains 'X', matching the original unassigned behavior.
        end
        // If select_bit is false, both my_func[0] and my_func[1] remain 'X',
        // matching the original unassigned behavior.
    end
endfunction

assign out = my_func(in_sel, in_data);

endmodule
