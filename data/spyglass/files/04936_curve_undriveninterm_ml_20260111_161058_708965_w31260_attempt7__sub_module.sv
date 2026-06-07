module sub_module (
    input wire [31:0] MEM [0:31],
    output wire [31:0] sub_out
);
    // Consume selected elements of MEM to ensure they are 'used' within the sub_module.
    // The goal is to detect that MEM[31] is undriven from *outside* the instance.
    assign sub_out = MEM[0] ^ MEM[31]; // Simple usage of both MEM[0] and MEM[31]
endmodule
