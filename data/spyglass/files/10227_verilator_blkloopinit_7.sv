module top7;
  logic [7:0] data[0:3];
  initial begin
    foreach (data[i]) begin
      data[i] <= 8'hEE;
    end
  end
endmodule
