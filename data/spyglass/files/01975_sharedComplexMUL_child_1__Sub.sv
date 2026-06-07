module Sub #(parameter WIDTH = 1) (
    input signed [WIDTH-1:0] i_a,
    input signed [WIDTH-1:0] i_b,
    output signed [WIDTH-1:0] o_res
);
    assign o_res = i_a - i_b; // Placeholder behavior
endmodule
