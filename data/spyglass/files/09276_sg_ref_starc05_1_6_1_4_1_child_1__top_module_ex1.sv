module top_module_ex1 ();
 // Need to generate the master clock and reset signals for simulation purposes,
 // as 'clockgenmodule' now expects these inputs to be synthesizable.
 reg sim_clk;
 reg sim_rst_n;
 wire my_clk;

 // Generate a master clock (sim_clk) with a period of 1 time unit (e.g., 1ns).
 // This clock will drive the 'clockgenmodule' to produce 'my_clk' with a 10-time-unit period.
 always #0.5 sim_clk = ~sim_clk;

 // Generate a reset signal for simulation.
 initial begin
   sim_clk = 1'b0;    // Initialize clock to 0
   sim_rst_n = 1'b0;  // Assert reset initially
   #10;               // Hold reset for 10 time units
   sim_rst_n = 1'b1;  // Deassert reset
   #100;              // Run simulation for some time after reset
   $finish;           // Terminate simulation
 end

 intermediate_module_ex1 im_inst (.i_clk(sim_clk), .i_rst_n(sim_rst_n), .int_clk(my_clk));

 // Fix W528: Variable 'my_clk' set but not read.
 // In a typical design, 'my_clk' would be connected to clock inputs of other modules.
 // For this example, a simple dummy usage resolves the linting warning.
 wire unused_my_clk_usage;
 assign unused_my_clk_usage = my_clk;

endmodule
