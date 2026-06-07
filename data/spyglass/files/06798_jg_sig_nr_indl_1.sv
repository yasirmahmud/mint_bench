module sig_nr_indl_example1 (
  input clk,
  input rst_n,
  input in_data,
  output reg out_data
);

  reg [7:0] counter = 8'h00; // Violation: Initialized in declaration

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 8'h00;
      out_data <= 1'b0;
    end else begin
      counter <= counter + 1;
      out_data <= in_data;
    end
  end

endmodule
