module W498_ex2 (
    output out_bit
);
 reg [7:0] my_signal;

 assign out_bit = my_signal[0];

 initial begin
    my_signal = 8'h00; // Initialize my_signal to resolve W123
 end

endmodule
