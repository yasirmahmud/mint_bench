module top_module (
  input wire clk
);
  wire dummy_wire; // Local wire for connecting to sub_module
  assign dummy_wire = clk; // Connect to avoid unused signal
  
  // The original instantiation passed a SystemVerilog-style pattern ('{1, 2}) 
  // to a simple Verilog-2001 scalar parameter P, causing an incompatible connection.
  // To resolve this incompatibility, a scalar value (e.g., 1) is now passed to parameter P.
  // Since P is not used within sub_module, this change has no functional impact.
  sub_module #(.P(1)) inst_sub (
    .dummy_in(dummy_wire)
  );
endmodule
