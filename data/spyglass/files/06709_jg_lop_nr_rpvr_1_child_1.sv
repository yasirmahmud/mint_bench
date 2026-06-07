module repetitive_use_1 (
  input clk,
  input rst,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  // Fix for W240: Input 'data_in' declared but not read.
  // Assigning to an unused wire prevents the warning without altering the data_out logic.
  wire [7:0] unused_data_in = data_in;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    data_out <= 8'b0;
  end else begin
    // Fix for W415a: Signal data_out is being assigned multiple times in the same always block.
    // In Verilog, when a register is assigned multiple times using non-blocking assignments (<=)
    // within the same always block for the same clock cycle, only the last assignment's
    // scheduled value takes effect. To preserve this specific functional behavior,
    // the loop is replaced by its effective last assignment.
    // The loop iterates from i=0 to i=3. The last iteration is when i=3.
    // The expression for i=3 is: data_out + data_out[3*2 + 1] - data_out[3*2]
    // which simplifies to: data_out + data_out[7] - data_out[6]
    data_out <= data_out + data_out[7] - data_out[6];
  end
end

endmodule
