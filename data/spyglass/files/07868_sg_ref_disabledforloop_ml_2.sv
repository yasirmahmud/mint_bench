module disabled_for_loop_ex2();
 initial begin integer i;
 for(i=0; i<0; i=i+1) begin $display("This loop never executes.");
 end end endmodule
