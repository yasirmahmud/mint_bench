module example_9 (
  output reg [1:0] mode
);
  always_comb begin
    mode = 2'b00;
    if (1) begin // Constant condition
      mode = 2'b01;
    end
  end
endmodule
