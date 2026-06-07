module example_ifc_no_senl_2 (
    input a,
    input b,
    input c, // This signal will cause the warning
    output reg out_val
);

always @(a or b) begin
    // c is used in the if condition but is not in the sensitivity list
    if (c) begin
        out_val = a & b;
    end else begin
        out_val = a | b;
    end
end

endmodule
