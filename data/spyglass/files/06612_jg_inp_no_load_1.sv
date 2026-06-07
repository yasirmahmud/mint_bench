module unused_input_port (
  input wire clk,
  input wire rst_n,
  input wire data_in, // This port is declared but not read
  output wire data_out
);

  reg q;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 1'b0;
    end else begin
      q <= 1'b1; // data_in is not used here
    end
  end

  assign data_out = q;

endmodule
