module top_module (
  input wire clk
);
  wire dummy_wire; // Local wire for connecting to sub_module
  assign dummy_wire = clk; // Connect to avoid unused signal
  
  // This instantiation passes a SystemVerilog-style pattern ('{1, 2}) 
  // to a simple Verilog-2001 scalar parameter P, causing an incompatible connection.
  sub_module #(.P('{1, 2})) inst_sub (
    .dummy_in(dummy_wire)
  );
endmodule
