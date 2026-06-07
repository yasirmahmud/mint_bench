module curve_w415a_20260111_160035_923474_w21676_attempt1 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output reg [7:0] result
);

  integer i; // Loop variable

  // Intermediate combinatorial signal to count set bits in data_in
  // This block uses blocking assignments and is purely combinatorial.
  reg [7:0] data_in_set_bits_count;

  always @(*) begin
    data_in_set_bits_count = 8'd0; // Initialize for combinatorial evaluation
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i]) begin
        data_in_set_bits_count = data_in_set_bits_count + 1; // Blocking assignments within combinatorial logic
      end
    end
  end

  // Sequential block to register the final result
  // This block uses non-blocking assignments exclusively for 'result'.
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      result <= 8'd0;
    end else begin
      result <= data_in_set_bits_count; // Non-blocking assignment to register the combinatorial count
    end
  end

endmodule
