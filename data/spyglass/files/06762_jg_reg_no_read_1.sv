module unread_reg_example1 (
  input wire clk,
  input wire rst_n,
  input wire data_in
);

  reg my_unused_reg; // This will be assigned but not read

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      my_unused_reg <= 1'b0;
    end else begin
      my_unused_reg <= data_in;
    end
  end

endmodule
