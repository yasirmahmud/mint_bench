module SUB_ELAB3518 (
    input logic_in,
    output logic_out
  );
    parameter DATA_RATE_FACTOR = 100; // An integer parameter

    assign logic_out = logic_in; // Simple pass-through logic
  endmodule
