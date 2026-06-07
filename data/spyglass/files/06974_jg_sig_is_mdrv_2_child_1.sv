module multidrive_always (
  input wire clk,
  input wire reset,
  input wire data1,
  input wire data2,
  output logic q
);

  // Original design had two always blocks driving 'q', leading to a multiple-driver violation.
  // To resolve this, the logic has been consolidated into a single always block.
  // When reset is active, 'q' is set to 0. When reset is inactive, 'q' will take the value of 'data2'.
  // This resolves the conflict by prioritizing the reset condition and then the 'data2' assignment,
  // which was an independent driver in the original code, effectively making it the primary data path.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1'b0;
    end else begin
      q <= data2;
    end
  end

endmodule
