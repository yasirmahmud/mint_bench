// Define a simple sub-module within the same file. This module has an input port
// named 'MEM', explicitly matching the rule description, and an output 'sub_out'
// to ensure 'MEM' is consumed within the sub_module's context.
module sub_module (
    input wire [31:0] MEM,     // This input port 'MEM' will be flagged as undriven by its source
    output wire sub_out        // An output to consume 'MEM' and avoid 'unused input' within sub_module
);

    // Use a portion of the 'MEM' input to drive 'sub_out'. This ensures 'MEM'
    // is not flagged as an unused input within this 'sub_module' context.
    // The goal is for the *connection* to 'MEM' to be flagged as undriven in the parent scope.
    assign sub_out = MEM[0]; // Example usage of the input 'MEM'

endmodule
