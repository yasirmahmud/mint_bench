module invalid_repeat_condition_ex1();
 initial begin repeat (2'b0z) begin $display("This should not be reached.");
 end end endmodule
