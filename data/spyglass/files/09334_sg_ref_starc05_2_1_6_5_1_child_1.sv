module star_ex1 (
  input clk,
  input rst_n
);
  reg [7:0] data_array [0:3];
  wire [7:0] data_array_read_dummy;

  // Resolves W528: Variable 'data_array' set but not read.
  // This ensures 'data_array' is read, allowing synthesis tools to optimize 'data_array_read_dummy' away if it's unused.
  assign data_array_read_dummy = data_array[0];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Resolves STARC05-2.1.6.5: For an array index x and z should not be used.
      // The '2'bx' index is replaced with a valid integer index '0'.
      // Resolves SYNTH_5143: Initial block is ignored for synthesis.
      // The initial block is replaced with synthesizable reset logic to initialize 'data_array[0]'.
      data_array[0] <= 8'hFF;
    end
  end
endmodule
