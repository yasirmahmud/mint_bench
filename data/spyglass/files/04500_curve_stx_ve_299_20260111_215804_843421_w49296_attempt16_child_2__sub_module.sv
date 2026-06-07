module sub_module (
  input dummy_in // Added to resolve "empty definition" warning
);
  parameter P [1:0] = '{0,0}; // Modified P to be a 2-element unpacked array to correctly interpret the aggregate assignment '{1, 2}
endmodule
