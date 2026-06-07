module top10 (
  output logic [(`DATA_WIDTH-1):0] output_data
);
  `define DATA_WIDTH 16
  logic [(`DATA_WIDTH-1):0] input_data;
  assign input_data = 0;
  assign output_data = input_data; // Resolves W528 by reading 'input_data'
endmodule
