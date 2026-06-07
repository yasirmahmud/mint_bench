module w190_ex2;
 reg [7:0] data;
 initial begin data = 8'h00;
 end task my_unused_task;
 input [7:0] in_data;
 begin data = in_data;
 end endtask endmodule
