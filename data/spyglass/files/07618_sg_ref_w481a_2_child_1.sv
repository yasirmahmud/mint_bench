module w481a_ex2();
 integer i; // W480: Changed 'i' to type 'integer'
 reg [3:0] j;
 initial begin
   j = 0; // 'i' is now initialized within the for loop
   for (i = 0; i < 4; i = i + 1) begin // W481a: Condition now uses step variable 'i'
     j = j + 1;
   end
 end
endmodule
