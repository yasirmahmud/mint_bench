module test_15;
  `pragma protect begin protected section id = "my_id" key_method = "rsa" key_public_key_file = "dummy.pem"
  // This is an empty protected section. The content itself does not define functional behavior.
  `pragma protect end protected
endmodule
