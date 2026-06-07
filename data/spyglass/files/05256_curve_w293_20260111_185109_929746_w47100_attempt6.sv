module curve_w293_attempt6;

  function real get_log_value;
    input integer data_in;
    begin
      get_log_value = $ln($itor(data_in));
    end
  endfunction

endmodule
