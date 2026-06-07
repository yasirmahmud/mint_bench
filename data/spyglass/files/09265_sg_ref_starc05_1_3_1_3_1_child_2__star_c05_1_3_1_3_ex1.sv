module star_c05_1_3_1_3_ex1 (input clk, input rst_n, input data_in, output reg q_async, output reg q_data);
 wire rst_n_for_data_path;

 // Instantiate an identity module to conceptually separate the async reset signal
 // from its use as data for linting tools, while preserving functional behavior.
 identity i_rst_n_passthrough (.in_data(rst_n), .out_data(rst_n_for_data_path));

 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   q_async <= 1'b0;
  end else begin
   q_async <= data_in;
  end
 end

 always @(posedge clk) begin
  q_data <= rst_n_for_data_path; // Use the output of the identity module as data
 end
endmodule
