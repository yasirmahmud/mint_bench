module ex14;
  reg n;
  task my_task;
    input val;
    begin
      n = val;
      n <= ~val;
    end
  endtask
  initial my_task(1'b1);
endmodule
