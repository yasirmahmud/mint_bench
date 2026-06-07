module my_module_1();
  integer count;

  initial begin
    count = 0;
    #10 count = count + 1;
  end
endmodule
