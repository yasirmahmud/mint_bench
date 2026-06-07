module sim_race07_ex1 (input wire i_data, input wire i_control, output reg o_q);
 reg r_clock_path;
 always @(i_control) begin r_clock_path <= i_control;
 end always @(posedge r_clock_path) begin o_q <= i_data;
 end endmodule
