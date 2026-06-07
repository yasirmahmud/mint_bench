module top;
  int u; // Declare 'u' directly as an integer within the module to be compatible with Verilog/non-SystemVerilog elaboration.

  initial begin
    // The original design utilized SystemVerilog classes and randomization constructs (e.g., 'class MyClass', 'rand int u', 'obj.randomize()').
    // SpyGlass reported 'ELAB_6312: Unsupported SV constructs 'non-virtual class declaration'' and 'NoTopDUFound' errors
    // because these advanced SystemVerilog features are not supported by its elaboration engine in this context.
    //
    // To resolve these SpyGlass violations while preserving the functional intent of 'u' receiving a random value
    // (as 'obj.u = 10;' was immediately overwritten by 'void'(obj.randomize())' in the original code),
    // we replace the class-based randomization with the Verilog-2001 system function $urandom.
    // This change aligns with the mitigation strategy suggested in the design description:
    // "pre-calculate constrained values procedurally" or "simplify randomization logic".
    u = $urandom; // Assigns a random 32-bit unsigned integer to 'u'.
  end
endmodule
