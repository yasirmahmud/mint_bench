module test_prp_nr_oprc_1;
  // Immediate assertion is now inside a synthesizable procedural block
  always @* begin
    assert(1);
  end
endmodule
