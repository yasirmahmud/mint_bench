module define_typedef_structure_ml_ex1 ();
  struct {
    byte a;
    reg b;
  } struct_inst;

  initial begin
    struct_inst = '{10,0}; // Initial assignment moved to an initial block
    // Read variables to resolve 'set but not read' warnings (W528)
    $display("struct_inst.a = %0d, struct_inst.b = %0d", struct_inst.a, struct_inst.b);
  end
endmodule
