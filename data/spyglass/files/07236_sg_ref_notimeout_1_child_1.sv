`timescale 1ns/1ps
module NoTimeOut_ex1 (
  input some_signal // Added as input to resolve W123
);
  // `some_signal` is now an input, so no `reg` declaration is needed here.
  initial begin
    fork
      begin
        wait(some_signal);
      end
      begin
        #100;
      end
    join_any;
  end
endmodule
