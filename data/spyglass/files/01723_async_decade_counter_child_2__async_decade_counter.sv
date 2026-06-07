module async_decade_counter(input clk, rst, input [1:0]J,K, output [3:0] Q);
  
  wire w1,w2;
  wire Q1_for_data_path; // New wire to separate Q[1]'s data usage
  
  jk_ff JK1(J[0],K[0], clk ,rst, Q[0]);
  assign w1 = ~Q[3];
  jk_ff JK2(w1,w1,Q[0],rst, Q[1]);
  
  jk_ff JK3(J[1],K[1] , Q[1] ,rst,Q[2]); // Q[1] remains used as clock for JK3
  assign Q1_for_data_path = Q[1];       // Assign Q[1] to a new wire for its data path usage
  assign w2 = Q1_for_data_path & Q[2];  // Use the new wire for data logic
  jk_ff JK4(w2 , ~w1 , Q[0] ,rst, Q[3]);

endmodule
