module mem_cgc_ex1 (input clk_in, input en_in, input reset_n_in, input [7:0] data_in, output [7:0] data_out);
 reg latch_q;
 wire gated_clk;
 always @(negedge clk_in or negedge reset_n_in) begin if (!reset_n_in) latch_q <= 1'b0;
 else if (!clk_in) latch_q <= en_in;
 end assign gated_clk = clk_in & latch_q;
 reg [7:0] mem_array [0:3];
 reg [1:0] addr;
 always @(posedge gated_clk or negedge reset_n_in) begin if (!reset_n_in) begin addr <= 2'b00;
 end else begin mem_array[addr] <= data_in;
 addr <= addr + 1;
 end end assign data_out = mem_array[addr];
 endmodule
