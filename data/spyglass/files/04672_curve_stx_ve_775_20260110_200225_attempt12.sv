module curve_stx_ve_775_20260110_200225_attempt12 (
  input wire dummy_in,
  output wire dummy_out
);

  // Simple connection to avoid unused port warnings
  assign dummy_out = dummy_in;

  // First occurrence of STX_VE_775
  // Initial statements are not allowed within function scopes in Verilog.
  function automatic integer my_function_a;
    initial begin // STX_VE_775: Initial statement not allowed in this scope
      $display("This message will not be synthesized and is illegal in a function.");
    end
    my_function_a = 1; // Function must assign a return value
  endfunction

  // Second occurrence of STX_VE_775
  // Initial statements are not allowed within function scopes in Verilog.
  function automatic integer my_function_b;
    initial begin // STX_VE_775: Initial statement not allowed in this scope
      $display("This is another illegal initial block.");
    end
    my_function_b = 2; // Function must assign a return value
  endfunction

  // Use the functions to prevent "unused function" warnings.
  // The actual logic is irrelevant for STX_VE_775, which triggers at declaration.
  integer result_a;
  integer result_b;

  always @(*) begin
    result_a = my_function_a();
    result_b = my_function_b();
  end

endmodule
