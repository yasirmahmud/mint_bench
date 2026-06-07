module flp_nr_indl_initial (
  input clk,
  input rst_n,
  input data_in,
  output reg q
);

  initial begin
    q = 1'b0; // Violates: flip-flop output 'q' initialized in initial block
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      q <= data_in;
    end
  end

endmodule
