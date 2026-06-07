module curve_w499_20260111_052730_attempt2 (
    input in_a,
    input in_b,
    input in_c,
    input [1:0] in_sel2,
    input [0:0] in_sel1,
    output [0:0] out_func_none,
    output [0:0] out_func_if_no_else_1bit,
    output [1:0] out_func_if_no_else_multibit_partial,
    output [2:0] out_func_if_else_partial_both,
    output [1:0] out_func_case_missing_no_default,
    output [1:0] out_func_case_partial_with_default,
    output [0:0] out_func_if_else_if_no_final_else,
    output [2:0] out_func_independent_ifs,
    output [2:0] out_func_complex_partial_assign
);

// W499 Violation 1: Function return value is never assigned.
function [0:0] func_none;
    // No assignment of func_none anywhere in the function body.
endfunction

// W499 Violation 2: 'if' statement without an 'else' branch; function unassigned if condition is false.
function [0:0] func_if_no_else_1bit;
    input a;
    begin
        if (a) begin
            func_if_no_else_1bit = 1'b1;
        end
        // If 'a' is false, func_if_no_else_1bit is unassigned.
    end
endfunction

// W499 Violation 3: Multi-bit function with 'if' but no 'else'; partial assignment in 'if' branch.
function [1:0] func_if_no_else_multibit_partial;
    input a;
    begin
        if (a) begin
            func_if_no_else_multibit_partial[0] = 1'b1; // func_if_no_else_multibit_partial[1] is unassigned.
        end
        // If 'a' is false, func_if_no_else_multibit_partial[1:0] are unassigned.
    end
endfunction

// W499 Violation 4: 'if-else' where both branches only partially assign the multi-bit function return.
function [2:0] func_if_else_partial_both;
    input a;
    begin
        if (a) begin
            func_if_else_partial_both[0] = 1'b1; // Bits [2:1] unassigned in this branch.
        end else begin
            func_if_else_partial_both[1] = 1'b1; // Bits [2] and [0] unassigned in this branch.
        end
    end
endfunction

// W499 Violation 5: 'case' statement with missing specific case items and no 'default' branch.
function [1:0] func_case_missing_no_default;
    input [1:0] sel;
    begin
        case (sel)
            2'b00: func_case_missing_no_default = 2'b00;
            2'b01: func_case_missing_no_default = 2'b01;
            // Cases 2'b10 and 2'b11 are missing, leading to unassigned function value.
        endcase
    end
endfunction

// W499 Violation 6: 'case' statement with a 'default', but a specific case only partially assigns.
function [1:0] func_case_partial_with_default;
    input [0:0] sel;
    begin
        case (sel)
            1'b0: func_case_partial_with_default[0] = 1'b1; // func_case_partial_with_default[1] is unassigned.
            default: func_case_partial_with_default = 2'b00; // This branch fully assigns.
        endcase
    end
endfunction

// W499 Violation 7: 'if-else if' chain missing a final 'else' branch.
function [0:0] func_if_else_if_no_final_else;
    input a, b;
    begin
        if (a) begin
            func_if_else_if_no_final_else = 1'b0;
        end else if (b) begin
            func_if_else_if_no_final_else = 1'b1;
        end
        // If '!a' and '!b', func_if_else_if_no_final_else is unassigned.
    end
endfunction

// W499 Violation 8: Multiple independent 'if' statements where not all bits or paths are covered.
function [2:0] func_independent_ifs;
    input a, b;
    begin
        if (a) begin
            func_independent_ifs[0] = 1'b1;
        end
        // If '!a', func_independent_ifs[0] is unassigned.
        if (b) begin
            func_independent_ifs[1] = 1'b1;
        end
        // If '!b', func_independent_ifs[1] is unassigned.
        // func_independent_ifs[2] is always unassigned regardless of 'a' or 'b'.
    end
endfunction

// W499 Violation 9: Complex conditional assignments for different bits where some bits remain unassigned.
function [2:0] func_complex_partial_assign;
    input a, b, c;
    begin
        if (a && b) begin
            func_complex_partial_assign[0] = 1'b1; // Bit 0 assigned only if 'a' AND 'b'.
        end
        if (a || c) begin
            func_complex_partial_assign[1] = 1'b1; // Bit 1 assigned only if 'a' OR 'c'.
        end
        // Bit 2 is never assigned under any conditions.
    end
endfunction

// Instantiating functions to ensure they are elaborated during analysis.
assign out_func_none = func_none();
assign out_func_if_no_else_1bit = func_if_no_else_1bit(in_a);
assign out_func_if_no_else_multibit_partial = func_if_no_else_multibit_partial(in_a);
assign out_func_if_else_partial_both = func_if_else_partial_both(in_a);
assign out_func_case_missing_no_default = func_case_missing_no_default(in_sel2);
assign out_func_case_partial_with_default = func_case_partial_with_default(in_sel1);
assign out_func_if_else_if_no_final_else = func_if_else_if_no_final_else(in_a, in_b);
assign out_func_independent_ifs = func_independent_ifs(in_a, in_b);
assign out_func_complex_partial_assign = func_complex_partial_assign(in_a, in_b, in_c);

endmodule
