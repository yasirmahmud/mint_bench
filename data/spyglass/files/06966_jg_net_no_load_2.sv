module net_no_load_example2 (
  input wire clk,
  input wire reset,
  input wire data_in,
  output wire data_out
);

  reg unused_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      unused_reg <= 1'b0;
    end else begin
      unused_reg <= data_in; // 'unused_reg' is driven but not loaded
    end
  end

  assign data_out = 1'b0; // Dummy output to make module complete

endmodule
