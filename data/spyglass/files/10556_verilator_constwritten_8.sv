module const_write_8;
  const int arr[2] = '{1, 2};
  initial begin
    arr[0] = 3;
  end
endmodule
