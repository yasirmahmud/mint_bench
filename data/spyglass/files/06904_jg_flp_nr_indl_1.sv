module flp_nr_indl_decl (
  input clk,
  input rst_n,
  input data_in,
  output reg q = 1'b0 // Violates: flip-flop output 'q' initialized in declaration
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      q <= data_in;
    end
  end

endmodule
