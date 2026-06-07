module const_write_3;
  const real pi = 3.14;
  initial begin
    // The assignment to 'pi' was removed to resolve the STX_VE_300 violation.
    // A 'const' variable cannot be re-assigned after its initial declaration.
    // #10 pi = 3.14159;
  end
endmodule
