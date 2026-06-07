module sub_ex1 (output out_undriven);
  assign out_undriven = 1'b0; // Drive the output to resolve 'empty definition' and potential undriven issues.
endmodule
