module w66_ex1();
 reg [3:0] dynamic_val;
 initial begin dynamic_val = 5;
 repeat (dynamic_val) begin $display("Loop iteration");
 end end endmodule
