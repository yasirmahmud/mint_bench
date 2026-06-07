module ex15;
  reg o;
  function automatic [0:0] my_func;
    input val;
    begin
      o = val;
      o <= ~val;
      my_func = o;
    end
  endfunction
  initial begin
    o = my_func(1'b1);
  end
endmodule
