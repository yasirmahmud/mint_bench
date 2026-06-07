module example_1 (
  input wire in_data,
  output reg out_data
);

  // out_data is read here in the conditional statement
  always @(*) begin
    if (in_data) begin
      out_data = 1'b1;
    end else if (out_data) begin // Reading out_data
      out_data = 1'b0;
    end else begin
      out_data = 1'b1;
    end
  end

endmodule
