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

  localparam ENTRY_LEN = KEY_LEN + DATA_LEN;

  // Declare unpacked arrays for extracted key/data and match flags.
  // These will be assigned within the generate block using constant indices at elaboration time,
  // resolving the STX_VE_382 violation for the 'lut' part-selects.
  wire [DATA_LEN-1:0]  match_data_candidates [NR_KEY-1:0];
  wire                 match_flags [NR_KEY-1:0];

  genvar i_gen;
  generate
    if (MATCH_EN) begin
      for (i_gen = 0; i_gen < NR_KEY; i_gen = i_gen + 1) begin : gen_mux_entry
        // Calculate constant bit indices for the current LUT entry.
        // 'i_gen' is a compile-time constant within the generate loop iteration.
        localparam KEY_START = i_gen*ENTRY_LEN;
        localparam KEY_END = i_gen*ENTRY_LEN + KEY_LEN - 1;
        localparam DATA_START = i_gen*ENTRY_LEN + KEY_LEN;
        localparam DATA_END = (i_gen+1)*ENTRY_LEN - 1;

        // Extract key and data using constant part-selects from 'lut'.
        wire [KEY_LEN-1:0] current_lut_key  = lut[KEY_END : KEY_START];
        wire [DATA_LEN-1:0] current_lut_data = lut[DATA_END : DATA_START];

        // Assign results to the unpacked arrays. Accessing elements of unpacked arrays
        // with a variable index is generally allowed in Verilog-2001 for memories
        // and SystemVerilog for wires/regs, and does not trigger STX_VE_382.
        assign match_flags[i_gen] = (key == current_lut_key);
        assign match_data_candidates[i_gen] = current_lut_data;
      end
    end else begin : gen_mux_disabled
      // If MATCH_EN is 0, no matches should occur. Initialize flags to 0.
      for (i_gen = 0; i_gen < NR_KEY; i_gen = i_gen + 1) begin : gen_match_disabled
        assign match_flags[i_gen] = 1'b0;
        assign match_data_candidates[i_gen] = '0; // Data value is irrelevant if no match
      end
    end
  endgenerate

  reg [DATA_LEN-1:0] temp_out;
  reg match_found_internal;
  integer i_loop; // Loop variable for the always @(*) block

  always @(*) begin
    temp_out = default_out; // Initialize with default value
    match_found_internal = 1'b0;     // No match found yet

    if (MATCH_EN) begin
      for (i_loop = 0; i_loop < NR_KEY; i_loop = i_loop + 1) begin
        // The loop now iterates over the 'match_flags' and 'match_data_candidates' arrays,
        // which are unpacked arrays. Variable indexing on unpacked arrays is not subject
        // to the STX_VE_382 rule (which applies to part-selects on packed vectors).
        if (match_flags[i_loop] && !match_found_internal) begin
          temp_out = match_data_candidates[i_loop];
          match_found_internal = 1'b1; // Mark that a match has been found (first match wins)
        end
      end
    end
  end

  assign out = temp_out; // Connect the internal temporary output to the module output

endmodule
