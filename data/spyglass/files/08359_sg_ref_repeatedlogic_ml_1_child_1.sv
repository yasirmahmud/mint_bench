module RepeatedLogic_ML_ex1;
reg [7:0] data_in;
reg [7:0] result;
integer i;
parameter P1 = 8;
parameter P2 = 4;
always @(*) begin
  reg [7:0] temp_result; // Declare a temporary variable
  temp_result = 0;
  for (i = 0; i < 10; i = i + 1) begin
    temp_result = temp_result + (P1 + P2);
  end
  result = temp_result; // Assign to 'result' only once after the loop
end
endmodule
