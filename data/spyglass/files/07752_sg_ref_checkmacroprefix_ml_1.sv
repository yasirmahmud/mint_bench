`define MY_VALUE 10
module CheckMacroPrefix_ex1;
  reg [3:0] data;
  initial begin
    data = `MY_VALUE;
  end
endmodule
