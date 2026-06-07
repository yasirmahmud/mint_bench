module undefined_module_type;
    parameter MY_PARAM = 0; // Added to enable defparam and resolve empty module warnings
    // This module is defined as a placeholder to resolve ErrorAnalyzeBBox.
    // Its functional behavior is an empty module, preserving the structural intent
    // of having an instance 'sub_inst' that accepts a defparam.
endmodule
