module my_module_ex1 (p_in);
  input p_in;
  // Removed 'dummy_signal' and its assignment as it was set but never read (W528 violation).
endmodule
