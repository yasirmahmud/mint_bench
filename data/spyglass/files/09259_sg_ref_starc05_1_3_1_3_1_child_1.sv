module star_c05_1_3_1_3_ex1 (input clk, input rst_n, input data_in, output reg q_async, output reg q_data);
 wire rst_n_buffered;

 assign rst_n_buffered = rst_n; // Buffer rst_n for use as a data input

 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   q_async <= 1'b0;
  end else begin
   q_async <= data_in;
  end
 end

 always @(posedge clk) begin
  q_data <= rst_n_buffered; // Use the buffered signal as data
 end
endmodule
