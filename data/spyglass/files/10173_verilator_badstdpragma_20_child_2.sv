module test_20;
  pragma protect begin
    // The original attributes for the protected section are now correctly structured
    // within a 'pragma protect data_block' as per IEEE 1800-2023.
    pragma protect data_block
      pragma protect id = "my_id"
      pragma protect key_method = "rsa"
      pragma protect key_public_key = "my_key.pem"
      pragma protect encrypt_method = "aes128"
      pragma protect digest_method = "sha256"
  pragma protect end
endmodule
