module curve_w415a_20260111_160035_923474_w21676_attempt1 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output reg [7:0] result
);

  integer i; // Loop variable

  // Intermediate combinatorial signal to count set bits in data_in
  // Changed 'data_in_set_bits_count' to a 'wire' and introduced a local 'reg' 
  // within the always block to resolve the multiple assignment violation (W415a).
  // The wire is assigned only once at the end of the always block.
  wire [7:0] data_in_set_bits_count;

  always @(*) begin
    reg [7:0] temp_set_bits_count; // Local reg to accumulate the count
    temp_set_bits_count = 8'd0; // Initialize for combinatorial evaluation
    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i]) begin
        temp_set_bits_count = temp_set_bits_count + 1; // Blocking assignments within local reg
      end
    end
    data_in_set_bits_count = temp_set_bits_count; // Assign the final count to the wire once
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
