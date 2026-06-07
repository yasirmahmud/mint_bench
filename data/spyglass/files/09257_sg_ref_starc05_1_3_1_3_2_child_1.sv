module star_c05_1_3_1_3_ex2 (input clk, input async_rst_n, input data_in, output reg q_ff1, output reg q_ff2);
 wire async_rst_n_data; // Introduce an intermediate wire to separate the reset signal from data path usage

 assign async_rst_n_data = async_rst_n; // This wire will carry the value of async_rst_n

 always @(posedge clk or negedge async_rst_n) begin
  if (!async_rst_n) q_ff1 <= 1'b0;
  else q_ff1 <= data_in;
 end

 always @(posedge clk) begin
  q_ff2 <= async_rst_n_data; // Use the new wire as data input for q_ff2
 end
endmodule
