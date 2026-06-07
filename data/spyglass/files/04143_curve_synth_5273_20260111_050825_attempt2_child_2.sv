module curve_synth_5273_20260111_050825_attempt2 (
    input clk,
    input rst_n,
    input enable_write,
    input [8:0] write_addr, // 9 bits for 288 locations (0 to 287)
    input [127:0] write_data, // 128 bits wide
    input enable_read,
    input [8:0] read_addr, // 9 bits for 288 locations (0 to 287)
    output reg [127:0] read_data_out // 128 bits wide
);

  // This 'reg' array declares a memory named 'KernMem'.
  // It has 288 elements, each 128 bits wide.
  // Total number of bits = 128 * 288 = 36864 bits.
  // This size significantly exceeds the default 'mthresh' value of 4096,
  // directly matching the specific bit count mentioned in the rule description
  // for 'KernMem', which is expected to trigger a SYNTH_5273 violation.
  // Adding a synthesis attribute to explicitly guide the tool to infer this as a block RAM.
  (* ram_style = "block" *) reg [127:0] KernMem [0:287];

  // Separate always block for write operation. This helps in clear inference
  // of the memory block, as the memory array (KernMem) itself typically does not
  // have an asynchronous reset on all its cells.
  always @(posedge clk) begin
    if (enable_write) begin
      KernMem[write_addr] <= write_data;
    end
  end

  // Separate always block for read operation and output register update.
  // The output register (read_data_out) retains its asynchronous reset behavior
  // as specified in the original design, ensuring functional equivalence.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      read_data_out <= 128'b0;
    end else begin
      if (enable_read) begin
        read_data_out <= KernMem[read_addr];
      end
    end
  end

endmodule
