module w326_trigger_ex2;
 event my_event;
 reg q;
 always @(my_event) begin q <= 1'b0;
 end endmodule
