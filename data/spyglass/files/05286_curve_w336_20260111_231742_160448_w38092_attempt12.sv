module curve_w336_20260111_231742_160448_w38092_attempt12 (
    input clk,
    input [7:0] data_in,
    output [7:0] data_out
);

reg [7:0] data_register;

// W336: Blocking assignment used inside a FlipFlop inferred sequential block
always @(posedge clk) begin
    data_register = data_in; 
end

assign data_out = data_register;

endmodule
