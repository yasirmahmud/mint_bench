module test15;
  logic [15:0] word_data;
  output logic [7:0] byte_0;
  output logic [7:0] byte_1;

  initial begin
    // Assign an arbitrary value to word_data to resolve "read but never set" violation.
    word_data = 16'hABCD; 
  end

  assign byte_0 = word_data[0 +: 8];
  assign byte_1 = word_data[8 +: 8];
endmodule
