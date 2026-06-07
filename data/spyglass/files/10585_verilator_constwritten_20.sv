module const_write_20;
  const int loop_var = 0;
  initial begin
    forever begin
      loop_var = 1;
      #1;
    end
  end
endmodule
