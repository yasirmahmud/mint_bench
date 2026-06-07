module curve_undriveninterm_ml_20260111_231420_258424_w15680_attempt11 (
    input wire clk,
    input wire undriven_input_port, // This input terminal is the target of the violation
    output reg output_a
);

    // This code attempts to assign a value to an input port (`undriven_input_port`).
    // In Verilog, an input port is expected to be driven externally and cannot be
    // assigned to internally within a module. This constitutes an illegal assignment
    // and also creates a multiple-driver situation if the port is connected externally.
    // SpyGlass likely flags this as 'UndrivenInTerm-ML' because the input terminal
    // is either considered 'undriven' from its legitimate external source due to this
    // internal override, or the illegal internal driving makes its state indeterminate,
    // classifying it as effectively undriven or improperly driven.
    always @(posedge clk) begin
        undriven_input_port <= 1'b1; // Illegal assignment to an input port
        output_a <= undriven_input_port; // Use the value, potentially after the illegal assignment
    end

endmodule
