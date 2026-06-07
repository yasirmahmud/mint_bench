module sub_module #(
  parameter [1:0] P = 2'b00 // Added parameter P to match instance connections
) (
  input wire dummy_input
);
  // Added an internal wire to read dummy_input, resolving W240
  wire dummy_input_read = dummy_input;
endmodule
