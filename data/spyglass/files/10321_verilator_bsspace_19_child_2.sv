`timescale 1ns/1ps

module test19;
  parameter int DELAY = 10;

  initial #DELAY $display("Delayed message");
endmodule
