module sky130_fd_sc_hd__decap_8 (
    input VGND,
    input VPWR,
    input VNB
);
    // This is a stub definition to resolve the ErrorAnalyzeBBox violation,
    // and subsequent WarnAnalyzeBBox and W240 violations.
    // A decap cell primarily provides capacitance and typically does not
    // have complex functional logic beyond connecting its power/ground rails.
    // The port list matches the inferred interface from the instantiation.

    // To prevent 'empty definition' warnings and 'input not read' warnings,
    // we explicitly assign the inputs to dummy wires. This has no functional
    // impact but satisfies linting rules for modules that are meant to be passive
    // or black-boxed at a higher level.
    wire dummy_vgnd = VGND;
    wire dummy_vpwr = VPWR;
    wire dummy_vnb = VNB;

endmodule
