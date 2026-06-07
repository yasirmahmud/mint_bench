module dummy_sink #(parameter WIDTH = 1) (input [WIDTH-1:0] input_data);
    // This module is a dummy sink to consume unused signals.
    // It prevents 'W240: Unused input' and 'W528: Variable set but not read'
    // warnings for signals that are genuinely unused but must remain in the port list.
    // It has no functional impact on the design.
endmodule
