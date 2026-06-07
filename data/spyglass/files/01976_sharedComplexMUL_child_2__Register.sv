module Register #(parameter WIDTH = 1) (
    input signed [WIDTH-1:0] i_data,
    input             i_load,
    input             CLK,
    output reg signed [WIDTH-1:0] o_data
);
    always @(posedge CLK) begin
        if (i_load) begin
            o_data <= i_data;
        end
    end
endmodule
