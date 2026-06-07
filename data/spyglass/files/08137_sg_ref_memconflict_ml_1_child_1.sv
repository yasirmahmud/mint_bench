module MemConflict_ML_ex1 (input clk, input rst, input [3:0] addr1, input [3:0] addr2, input [7:0] data1, input [7:0] data2, output [7:0] out);
 reg [7:0] my_mem [0:15];

 always @(posedge clk or posedge rst) begin
  if (rst) begin
    // Highest priority: Asynchronous reset for my_mem[0].
    // All other write operations to `my_mem` are suppressed during reset.
    my_mem[0] <= 8'h00;
  end else begin
    // Synchronous operations when not in reset.
    // Consolidating writes into a single always block resolves the W415 multiple driver violation.
    // The two assignments imply two potential write ports. If the synthesis tool supports
    // dual-write port RAM inference, then my_mem[addr1] and my_mem[addr2] can be updated
    // simultaneously if addr1 != addr2.
    // If addr1 == addr2, the latter assignment (my_mem[addr2] <= data2) will take precedence
    // due to Verilog's non-blocking assignment scheduling, making the conflict deterministic.
    my_mem[addr1] <= data1;
    my_mem[addr2] <= data2;
  end
 end

 assign out = my_mem[0];

 endmodule
