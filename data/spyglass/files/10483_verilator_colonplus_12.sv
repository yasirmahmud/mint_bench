module test12;
  localparam OFFSET = 4;
  logic [15:0] data_reg;
  logic [7:0] extracted_data;
  assign extracted_data = data_reg[OFFSET :+ 8];
endmodule
