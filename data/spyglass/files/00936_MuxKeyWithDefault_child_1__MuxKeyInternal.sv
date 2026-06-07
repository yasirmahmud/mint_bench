module MuxKeyInternal #(
  parameter NR_KEY = 2,
  parameter KEY_LEN = 1,
  parameter DATA_LEN = 1,
  parameter MATCH_EN = 1
) (
  output [DATA_LEN-1:0] out,
  input [KEY_LEN-1:0] key,
  input [DATA_LEN-1:0] default_out,
  input [NR_KEY*(KEY_LEN + DATA_LEN)-1:0] lut
);

  reg [DATA_LEN-1:0] temp_out;
  reg match_found;

  localparam ENTRY_LEN = KEY_LEN + DATA_LEN;
  integer i;

  always @(*) begin
    temp_out = default_out; // Initialize with default value
    match_found = 1'b0;     // No match found yet

    if (MATCH_EN) begin
      for (i = 0; i < NR_KEY; i = i + 1) begin
        // Extract key for the current LUT entry: lut[i*ENTRY_LEN + KEY_LEN - 1 : i*ENTRY_LEN]
        // Extract data for the current LUT entry: lut[(i+1)*ENTRY_LEN - 1 : i*ENTRY_LEN + KEY_LEN]
        if ((key == lut[i*ENTRY_LEN + KEY_LEN - 1 : i*ENTRY_LEN]) && !match_found) begin
          temp_out = lut[(i+1)*ENTRY_LEN - 1 : i*ENTRY_LEN + KEY_LEN];
          match_found = 1'b1; // Mark that a match has been found, subsequent matches won't override (first match wins)
        end
      end
    end
  end

  assign out = temp_out; // Connect the internal temporary output to the module output

endmodule
