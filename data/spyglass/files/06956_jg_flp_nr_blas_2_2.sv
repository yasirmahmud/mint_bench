module blocking_flop_2 (
    input clk,
    input data_in,
    input en,
    output reg data_out
);

always @(posedge clk) begin
    if (en) begin
        data_out = data_in; // Violation: Blocking assignment to a flip-flop output
    end
end

endmodule
