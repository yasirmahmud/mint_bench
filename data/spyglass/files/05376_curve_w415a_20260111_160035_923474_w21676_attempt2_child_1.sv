module curve_w415a_20260111_160035_923474_w21676_attempt2 (
  input wire [7:0] data_in,
  output reg [7:0] result
);

  reg [7:0] temp_val;
  reg [7:0] local_bit_count; // Temporary variable to accumulate count
  integer i;

  always @* begin
    local_bit_count = 8'd0; // Initialize the temporary accumulator

    // Accumulate the count of set bits in 'local_bit_count'
    for (i = 0; i < 8; i = i + 1) {
      if (data_in[i]) begin
        local_bit_count = local_bit_count + 1;
      end
    }
    
    // Assign to 'temp_val' only once after the loop completes
    temp_val = local_bit_count;
    result = temp_val;
  end

endmodule
