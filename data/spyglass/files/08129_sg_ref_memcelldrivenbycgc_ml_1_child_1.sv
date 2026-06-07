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

 // This block's functional behavior remains unchanged.
 always @(posedge gated_clk or negedge reset_n_in) begin
   if (!reset_n_in) begin
     addr <= 2'b00;
   end else begin
     mem_array[addr] <= data_in;
     addr <= addr + 1;
   end
 end

 assign data_out = mem_array[addr];
 endmodule
