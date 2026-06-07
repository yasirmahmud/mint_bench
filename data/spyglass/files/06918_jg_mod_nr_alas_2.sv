module duplicate_port_module_2 (
  input a,
  output b,
  input a // Duplicate port 'a'
);

assign b = a;

endmodule
