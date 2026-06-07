module curve_stx_ve_1201_20260111_174643_397442_w7792_attempt8 (
    input clk,
    input rst,
    output reg out_initial,
    output reg out_always
);

// First violation: in an initial block
initial begin : my_initial_start
    out_initial = 1'b0; // Assign initial value
    #10 out_initial = 1'b1;
    #10 $display("Initial block finished.");
end : my_initial_finish // STX_VE_1201 violation: 'my_initial_start' vs 'my_initial_finish'

// Second violation: in an always block
always @(posedge clk or posedge rst) begin : my_always_entry
    if (rst) begin
        out_always <= 1'b0;
    end else begin
        out_always <= ~out_always;
    end
end : my_always_exit // STX_VE_1201 violation: 'my_always_entry' vs 'my_always_exit'

endmodule
