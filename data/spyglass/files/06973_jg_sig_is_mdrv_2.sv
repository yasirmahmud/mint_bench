module multidrive_always (
  input wire clk,
  input wire reset,
  input wire data1,
  input wire data2,
  output logic q
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1'b0;
    end else begin
      q <= data1;
    end
  end

  always @(posedge clk) begin
    q <= data2;
  end

endmodule
