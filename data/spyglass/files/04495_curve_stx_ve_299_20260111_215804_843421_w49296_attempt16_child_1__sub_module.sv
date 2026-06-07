module sub_module;
  parameter P [1:0] = '{0,0}; // Modified P to be a 2-element unpacked array to correctly interpret the aggregate assignment '{1, 2}
endmodule
