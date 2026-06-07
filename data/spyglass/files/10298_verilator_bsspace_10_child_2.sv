module test10;
  logic data_in, data_out; // Declaration moved before use
  generate
    if (1) begin

      assign data_out = data_in;
    end
  endgenerate
endmodule
