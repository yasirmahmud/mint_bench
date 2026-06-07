module task_in_always_ex2 (
  input clk,
  input reset,
  input [3:0] in_data,
  output reg [3:0] out_data
);

  task update_data_task (input [3:0] val);
    begin
      #2; // Time-controlling statement
      out_data = val;
    end
  endtask

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_data = 4'b0000;
    end else begin
      update_data_task(in_data); // Task used in always block
    end
  end

endmodule
