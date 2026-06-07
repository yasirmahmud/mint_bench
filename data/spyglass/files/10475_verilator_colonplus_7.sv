module test7;
  function automatic [7:0] get_part(input [15:0] val, input int start_idx);
    return val[start_idx :+ 8];
  endfunction
endmodule
