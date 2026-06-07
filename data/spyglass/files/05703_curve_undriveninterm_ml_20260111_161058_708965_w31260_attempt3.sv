module curve_undriveninterm_ml_20260111_161058_708965_w31260_attempt3 (
    input wire undriven_input_port,
    output reg output_a,
    output reg output_b
);

    // This combinatorial block attempts to drive an 'input wire' port from within the module.
    // Driving an input port internally is illegal in Verilog.
    // SpyGlass identifies this construct as an 'UndrivenInTerm-ML' violation for 'undriven_input_port',
    // interpreting its external connection as effectively undriven or overridden by this illegal internal driver.
    always @* begin
        output_a <= output_b <= undriven_input_port <= 1'b0;
    end

endmodule
