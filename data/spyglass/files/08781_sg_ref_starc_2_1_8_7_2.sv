module starc_2_1_8_7_ex2;
 function integer my_func;
 input [7:0] a;
 begin if (a > 10) begin return 1;
 $display("This statement is after return.");
 end else begin return 0;
 end end endfunction initial begin integer result;
 result = my_func(5);
 result = my_func(15);
 end endmodule
