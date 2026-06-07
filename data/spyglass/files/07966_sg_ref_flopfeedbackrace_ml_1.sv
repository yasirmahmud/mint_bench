module FlopFeedbackRace_ML_ex1 (input data_in, input reset, output reg q_out);
 always @(posedge q_out or posedge reset) begin if (reset) begin q_out <= 1'b0;
 end else begin q_out <= data_in;
 end end endmodule
