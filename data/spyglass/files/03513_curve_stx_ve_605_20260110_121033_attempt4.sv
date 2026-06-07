module curve_stx_ve_605_20260110_121033_attempt4 ();

  // Declare a localparam with an initial value
  localparam MY_LOCAL_CONSTANT = 10;

  // Attempt to reassign the localparam within a task
  task my_modify_task;
    begin
      MY_LOCAL_CONSTANT = 20; // FATAL: Illegal attempt to assign to a localparam
    end
  endtask

  // Dummy signal to ensure MY_LOCAL_CONSTANT is used and avoid unused signal warnings
  reg [7:0] output_val;
  always @(*) begin
    output_val = MY_LOCAL_CONSTANT + 5;
  end

endmodule
