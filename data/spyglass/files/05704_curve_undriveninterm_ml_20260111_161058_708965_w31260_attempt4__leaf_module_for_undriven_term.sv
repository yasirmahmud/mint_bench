// A simple leaf module used for instantiation to demonstrate an undriven input terminal.
module leaf_module_for_undriven_term (
    input wire clk_i,
    input wire input_pin_to_be_undriven,
    output reg output_pin
);

    // The 'input_pin_to_be_undriven' is used here, making its undriven nature critical.
    always @(posedge clk_i) begin
        output_pin <= input_pin_to_be_undriven;
    end

endmodule
