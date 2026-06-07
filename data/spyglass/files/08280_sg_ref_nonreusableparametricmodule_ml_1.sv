module nonreusable_param_ex1(input clk);
 parameter NUM_PORTS = 3;
 logic [3:0] SigA;
 assign SigA = NUM_PORTS;
 endmodule
