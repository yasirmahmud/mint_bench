module test11;
  always_comb begin
    case (sel) \

      2'b00: out = in0;
      default: out = 0;
    endcase
  end
  logic [1:0] sel; logic [7:0] in0, out;
endmodule
