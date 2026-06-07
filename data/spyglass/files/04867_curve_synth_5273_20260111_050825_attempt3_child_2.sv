module curve_synth_5273_20260111_050825_attempt3_child_2 (
    input clk,
    input rst_n,
    input enable_write,
    input [9:0] write_addr, // 10 bits for 576 locations (0 to 575)
    input [63:0] write_data, // 64 bits wide
    input enable_read,
    input [9:0] read_addr, // 10 bits for 576 locations (0 to 575)
    output reg [63:0] read_data_out // 64 bits wide
);

  // This 'reg' array declares a memory named 'DataStore'.
  // It has 576 elements, each 64 bits wide.
  // Total number of bits = 64 * 576 = 36864 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // directly matching the specific bit count mentioned in the rule description
  // (36864 bits), which is expected to trigger a SYNTH_5273 violation.
  (* ram_style = "block" *) reg [63:0] DataStore [0:575];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      read_data_out <= 64'b0;
    end else begin
      if (enable_write)
        // Write operation
        DataStore[write_addr] <= write_data;
      if (enable_read)
        // Read operation
        read_data_out <= DataStore[read_addr];
    end
  end

endmodule
