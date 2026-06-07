module test10;
  generate
    if (1) begin \

      assign data_out = data_in;
    end
  endgenerate
  logic data_in, data_out;
endmodule
