module LOP_NR_RLML_example2;
  reg [3:0] dynamic_limit;
  reg [3:0] match_count;

  initial begin
    dynamic_limit = 7; // Non-constant value
    match_count = 0;
    for (int j = 0; j <= 11; j = j + 1) begin // Loop runs 12 times (0 to 11)
      if (j == dynamic_limit) begin // Relational operation with loop var and non-constant
        match_count = match_count + 1;
      end
    end
  end
endmodule
