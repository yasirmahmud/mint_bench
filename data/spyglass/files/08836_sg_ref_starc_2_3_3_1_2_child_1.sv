module multiple_clocks_ex2(input CLK1, input CLK2, input IN1, output reg OUT1);
  // The original design uses edges of multiple clocks in a single always block,
  // which is unsynthesizable and violates STARC05-2.3.3.1 and W422.
  // A single flip-flop cannot be clocked by two independent clocks in synthesizable RTL.
  // To resolve this violation while preserving as much of the original intent as possible
  // for a single output register, a primary clock must be chosen for the output register.
  // This solution arbitrarily selects CLK1 as the clock for OUT1.
  // If updates from CLK2 are also strictly required for the 'OUT1' register,
  // a more complex Clock Domain Crossing (CDC) mechanism with arbitration or clock enabling
  // would be necessary, which would significantly alter the simple 'OUT1 = IN1' logic.
  
  always @(posedge CLK1) begin
    OUT1 <= IN1;
  end
endmodule
