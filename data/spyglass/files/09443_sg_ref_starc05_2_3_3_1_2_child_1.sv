module multiple_clocks_ex2 (input CLK1, input CLK2, input IN1, output reg OUT1);
  // The original design uses edges of multiple clocks (CLK1 and CLK2)
  // in the same always block's sensitivity list. This violates STARC05-2.3.3.1
  // and W422, as it leads to un-synthesizable or unpredictable hardware.
  // A single output register (reg) must be driven by a single clock domain.
  // To resolve these violations while adhering to synthesizable RTL principles,
  // the register OUT1 must be made synchronous to only one clock.
  // We will arbitrarily choose CLK1 as the clock for OUT1.
  // Note: Strictly preserving the behavior of updating on *either* CLK1 or CLK2
  // for a single synthesizable register is fundamentally impossible under standard
  // RTL design rules. This fix prioritizes synthesizability and compliance with
  // mandatory linting rules over the problematic dual-clock sensitivity.
  
  always @(posedge CLK1) begin 
    OUT1 = IN1;
  end 
endmodule
