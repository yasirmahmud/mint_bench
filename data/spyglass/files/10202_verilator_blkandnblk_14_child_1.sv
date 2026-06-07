module ex14;
  reg n_blocking;   // New variable for storing the result of a blocking assignment
  reg n_nonblocking; // New variable for storing the result of a non-blocking assignment

  // The task now modifies its local output registers, not global module variables directly.
  task my_task_process;
    output reg result_blocking;    // Local register for blocking result
    output reg result_nonblocking; // Local register for non-blocking result
    input val;
    begin
      // Blocking assignment to a local task output register
      result_blocking = val;        
      // Non-blocking assignment to a local task output register
      result_nonblocking <= ~val;   
    end
  endtask

  initial begin
    reg local_blocking_val;     // Temporary local register to receive blocking result from task
    reg local_nonblocking_val;  // Temporary local register to receive non-blocking result from task

    // Call the task, passing local registers to receive the results.
    // This prevents the task from directly modifying module-level global variables (resolves W426).
    my_task_process(local_blocking_val, local_nonblocking_val, 1'b1);

    // Assign the local task results to the module-level registers.
    // n_blocking takes the immediate blocking result.
    n_blocking = local_blocking_val;

    // Wait for one time unit to ensure all non-blocking assignments (like to local_nonblocking_val)
    // within the current timestep have completed (resolves potential race for non-blocking value).
    #1;
    // n_nonblocking takes the value that was set by the non-blocking assignment in the previous timestep.
    n_nonblocking = local_nonblocking_val; 

    // Display the values to show they are now deterministically set and read (resolves W528).
    $display("At time %0t: n_blocking = %b, n_nonblocking = %b", $time, n_blocking, n_nonblocking);
  end
endmodule
