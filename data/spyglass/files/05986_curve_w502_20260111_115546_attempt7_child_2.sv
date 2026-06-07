module curve_w502_20260111_115546_attempt7 (
    input wire d,
    input wire en,
    output reg q
);

    // This always block implements a D-latch.
    // The W502 rule is triggered when a signal is modified inside an always block,
    // particularly when it's explicitly assigned its own value. The original code
    // had 'q = q;' in the 'else' branch and 'q' in the sensitivity list,
    // both contributing to W502 violations.
    // To resolve this, the sensitivity list is changed to 'd or en', and the
    // explicit self-assignment 'q = q;' is removed. In Verilog, a 'reg' variable
    // that is not assigned in all execution paths of a combinational 'always' block
    // will implicitly hold its value, thereby inferring a latch.
    // This change preserves the D-latch's functional behavior.
    always @(d or en) begin 
        if (en) begin
            q = d;
        end
        // else: q implicitly holds its value (latch behavior)
    end

endmodule
