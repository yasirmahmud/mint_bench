module direct_interc (
    input [0:0] in,
    output [0:0] out
);
    // This module acts as a direct connection (wire/buffer)
    assign out = in;
endmodule
