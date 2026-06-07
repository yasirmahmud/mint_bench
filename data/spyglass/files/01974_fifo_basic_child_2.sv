module fifo_basic(
		clk,
		rst,
		data_in,
		read,
		write,
		enable,
		data_out,
		empty,
		full
		);

input  		clk;
input 		rst;
input 		read;
input 		write;
input 		enable;
input   [7:0]	data_in;
output 		empty;
output		full;
output  [7:0] 	data_out;

reg     [7:0] 	data_out;
reg     [7:0] 	fifo [7:0]; // 8-entry array, indices 0 to 7

reg     [3:0]  	counter;    // Corrected size to [3:0] to hold value 8
reg 	[2:0] 	rd_counter; // Pointers 0 to 7
reg	[2:0]   wr_counter; // Pointers 0 to 7

// Output assignments based on state
assign empty = (counter == 0);
assign full  = (counter == 8);

// Internal next state logic for sequential elements (resolved multiple assignments)
reg [2:0] rd_counter_next;
reg [2:0] wr_counter_next;
reg [3:0] counter_next;
reg [7:0] data_out_next;

// Flag to indicate if a write operation occurs, for fifo memory update
reg do_fifo_write;

// Intermediate variables to simulate the cascading effect of blocking assignments
// from the original code's single always block. (Declarations moved to module scope)
reg [2:0] temp_rd_counter_0;
reg [2:0] temp_wr_counter_0;
reg [7:0] temp_data_out_0;

reg [2:0] temp_rd_counter_1;
reg [2:0] temp_wr_counter_1;

// Combinational logic to determine next state values and write enable for fifo
always @ (*) begin
  // Default assignments: hold current state values for the next cycle
  rd_counter_next = rd_counter;
  wr_counter_next = wr_counter;
  counter_next    = counter;
  data_out_next   = data_out;
  do_fifo_write   = 1'b0; // Default no fifo write

  // Initialize temp variables here as they are no longer implicitly reset by redeclaration
  temp_rd_counter_0 = rd_counter;
  temp_wr_counter_0 = wr_counter;
  temp_data_out_0   = data_out;
  temp_rd_counter_1 = rd_counter;
  temp_wr_counter_1 = wr_counter;

  // --- Simulate the first block of original always statement ---
  // The original 'if (enable == 0); else' makes the 'else' block (the main logic)
  // effectively always active on posedge clk. This behavior is preserved.
  if (rst) begin
    temp_rd_counter_0 = 0;
    temp_wr_counter_0 = 0;
    temp_data_out_0   = 8'b0;
    // Note: The original code's first block only updates rd_counter and wr_counter on rst.
    // counter is separately reset in the sequential block.
  end else begin
    // Default to current values for this intermediate stage (already done above)

    // Original's priority: read over write
    if (read == 1'b1 && counter != 0) begin // Valid read condition
      temp_data_out_0   = fifo[rd_counter];
      temp_rd_counter_0 = rd_counter + 1; // Original increment
    end else if (write == 1'b1 && counter < 8) begin // Valid write condition
      temp_wr_counter_0 = wr_counter + 1; // Original increment
      do_fifo_write     = 1'b1; // Flag this cycle for a fifo write
    end
  end

  // --- Simulate the second block (pointer wrapping logic) ---
  // This block implicitly used the *updated* values from the first block due to blocking assignments.
  temp_rd_counter_1 = temp_rd_counter_0;
  temp_wr_counter_1 = temp_wr_counter_0;

  if (temp_wr_counter_0 == 8) begin // Priority: wr_counter wrap
    temp_wr_counter_1 = 0;
  end else if (temp_rd_counter_0 == 8) begin // Next priority: rd_counter wrap
    temp_rd_counter_1 = 0;
  end
  // If neither matches, they retain their `temp_X_0` values.

  // --- Simulate the third block (counter calculation logic) ---
  // This block implicitly used the *updated* values from the second block.
  if (temp_rd_counter_1 > temp_wr_counter_1) begin
    counter_next = temp_rd_counter_1 - temp_wr_counter_1;
  end else if (temp_wr_counter_1 > temp_rd_counter_1) begin
    counter_next = temp_wr_counter_1 - temp_rd_counter_1;
  end else begin
    // Original had 'else;' here, meaning counter holds its value if pointers are equal.
    // This preserves the original (potentially ambiguous) functional behavior.
    counter_next = counter;
  end

  // Assign final calculated values to the `_next` registers
  rd_counter_next = temp_rd_counter_1;
  wr_counter_next = temp_wr_counter_1;
  data_out_next   = temp_data_out_0; // data_out is only affected by the first block's logic
end

// Sequential block for all register updates
always @ (posedge clk) begin
  if (rst) begin
    rd_counter <= 0;
    wr_counter <= 0;
    counter    <= 0;    // Reset counter explicitly
    data_out   <= 8'b0; // Reset data_out as good practice
  end else begin
    // Update all state registers with their calculated next values using non-blocking assignments
    rd_counter <= rd_counter_next;
    wr_counter <= wr_counter_next;
    counter    <= counter_next;
    data_out   <= data_out_next;

    // Handle FIFO memory write separately with non-blocking assignment
    // The `wr_counter` used here is the CURRENT value of the register at the clock edge,
    // which is the intended address for the write operation.
    if (do_fifo_write) begin
      fifo[wr_counter] <= data_in;
    end
  end
end

endmodule
