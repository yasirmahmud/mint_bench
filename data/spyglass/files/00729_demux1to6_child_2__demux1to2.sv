// Definition of the 1-to-2 demultiplexer sub-module
module demux1to2 #(parameter WIDTH = 1) (
    input [WIDTH-1:0] din,
    input sel,
    output [WIDTH-1:0] out0,
    output [WIDTH-1:0] out1
);
    // If sel is 0, din goes to out0, out1 gets 0.
    // If sel is 1, din goes to out1, out0 gets 0.
    assign out0 = sel ? {WIDTH{1'b0}} : din;
    assign out1 = sel ? din : {WIDTH{1'b0}};
endmodule
