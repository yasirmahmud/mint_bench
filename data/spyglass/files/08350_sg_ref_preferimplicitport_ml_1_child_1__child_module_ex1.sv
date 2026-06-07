module child_module_ex1 (input data_in);
  wire unused_data_in;
  assign unused_data_in = data_in; // Assign input to an internal wire to resolve 'data_in' unread and empty module violations.
 endmodule
