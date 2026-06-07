module mem_cgc_ex1 (input clk_in, input en_in, input reset_n_in, input [7:0] data_in, output [7:0] data_out);
 reg latch_q;
 wire gated_clk;

 // Original code for latch_q was ambiguous, mixing edge-triggered sensitivity
 // with a level-sensitive condition ('else if (!clk_in)').
 // Interpreting this as a negative-edge triggered D-flipflop with asynchronous active-low reset
 // resolves the W122 (sensitivity list) and W414 (non-blocking in combinational) violations.
 // The 'negedge clk_in' implies a flip-flop, and at the negative edge, '!clk_in' is true,
 // making the 'else if (!clk_in)' redundant for a DFF and simplifying to a direct data assignment.
 always @(negedge clk_in or negedge reset_n_in) begin
   if (!reset_n_in) begin
     latch_q <= 1'b0;
   end else begin
     latch_q <= en_in;
   end
 end

 assign gated_clk = clk_in & latch_q;

 reg [7:0] mem_array [0:3];
 reg [1:0] addr;

 // To resolve the STARC05-1.3.1.3 violation, the original single 'always' block 
 // that controlled both 'addr' and 'mem_array' is split into two. 
 // This ensures that 'reset_n_in' is used purely as an asynchronous reset for 'addr'
 // and as a synchronous enable for 'mem_array' writes.
 // The functional behavior of asynchronously resetting 'addr' to 0 and
 // synchronously writing to 'mem_array' and incrementing 'addr' when 'reset_n_in' is high
 // on the positive edge of 'gated_clk' is preserved.
 
 // Block for address generation: 'addr' is asynchronously reset, then synchronously increments.
 always @(posedge gated_clk or negedge reset_n_in) begin
   if (!reset_n_in) begin
     addr <= 2'b00; // Asynchronous reset for addr
   end else begin
     addr <= addr + 1; // Synchronous increment when not in reset, on gated_clk
   end
 end

 // Block for memory writes: 'mem_array' writes are purely synchronous to 'gated_clk',
 // and synchronously enabled by 'reset_n_in' being high (meaning not in reset).
 // The 'gated_clk' can only transition high when 'reset_n_in' is high (due to 'latch_q'),
 // making the 'if (reset_n_in)' condition effectively redundant for functionality
 // but explicitly clarifies the synchronous gating for linting tools.
 always @(posedge gated_clk) begin
   if (reset_n_in) begin // Synchronous enable for writing when reset is deasserted
     mem_array[addr] <= data_in;
   end
 end

 assign data_out = mem_array[addr];
 endmodule
