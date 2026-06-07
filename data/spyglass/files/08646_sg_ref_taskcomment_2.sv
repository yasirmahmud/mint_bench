module my_module_ex2;
 reg [7:0] data;
 initial begin data = 8'h00;
 my_task(data);
 end task my_task(input [7:0] in_data);
 begin $display("Task received data: %h", in_data);
 end endtask endmodule
