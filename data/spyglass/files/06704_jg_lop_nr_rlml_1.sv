module LOP_NR_RLML_example1;
  reg [3:0] threshold_val;
  reg [3:0] count;

  initial begin
    threshold_val = 5; // A non-constant value
    count = 0;
    for (int i = 0; i < 12; i = i + 1) begin // Loop runs 12 times
      if (i < threshold_val) begin // Relational operation with loop var and non-constant
        count = count + 1;
      end
    end
  end
endmodule
