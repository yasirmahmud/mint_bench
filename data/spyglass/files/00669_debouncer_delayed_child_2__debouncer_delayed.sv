module debouncer_delayed #(parameter WAIT = 1_999_999) (
input clk, 
input reset_n,
input noisy,
output debounced
);


wire timer_done;
wire timer_reset_out; // FSM output, active high to reset/disable timer

debouncer_delayed_fsm FSM0(
.clk(clk),
.reset_n(reset_n),
.noisy(noisy),
.timer_done(timer_done),
.timer_reset(timer_reset_out),
.debounced(debounced)
);


timer_parameter #(.N(WAIT)) T0(
.clk(clk),
.reset_n(~timer_reset_out), // Active low reset for timer
.en(~timer_reset_out),      // Active high enable for timer
.done(timer_done)
);

endmodule
