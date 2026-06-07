module top_module_ex1;
 wire undriven_sig;

 // To resolve W287a (Input 'undriven_sig' of instance 'inst_child' is undriven)
 // and UndrivenInTerm-ML (Detected undriven input terminal),
 // we drive the 'undriven_sig' with a constant value.
 assign undriven_sig = 1'b0;

 child_module inst_child (.in_a(undriven_sig));
 endmodule
