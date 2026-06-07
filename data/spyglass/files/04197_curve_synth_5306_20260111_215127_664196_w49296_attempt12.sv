module curve_synth_5306_20260111_215127_664196_w49296_attempt12 (
  input wire clk,
  input wire rst,
  input wire start_process,
  output reg process_done
);

  reg [7:0] counter_val;

  // This is a module-level named block (an always block with a name).
  // Its scope is the module itself.
  always @(posedge clk) begin : main_processing_block
    if (!rst) begin
      counter_val <= 8'd0;
      process_done <= 1'b0;
    end else if (start_process) begin
      counter_val <= counter_val + 1'b1;
      if (counter_val == 8'd10) begin
        process_done <= 1'b1;
      end else begin
        process_done <= 1'b0;
      end
    end
  end

  // This is a module-level task.
  // A named block like 'main_processing_block' that is defined directly
  // in the module scope is not considered to be in the lexical scope of
  // a module-level task.
  task try_disable_processing;
    begin
      // SYNTH_5306 violation: 'main_processing_block' is not in the lexical scope
      // of this task. A task cannot disable a named block at the same module level.
      disable main_processing_block;
    end
  endtask

  // This always block calls the task, ensuring the task's contents are analyzed.
  always @(posedge clk) begin
    if (start_process) begin
      try_disable_processing;
    end
  end

endmodule
