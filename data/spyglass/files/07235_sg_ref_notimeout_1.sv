module NoTimeOut_ex1;
 reg some_signal;
 initial begin fork begin wait(some_signal);
 end begin #100;
 end join_any;
 end endmodule
