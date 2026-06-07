module W154_ex1(input a, output b);
 wire undeclared_net; // Declare 'undeclared_net' to resolve STX_VE_606
 assign b = a & undeclared_net;
 endmodule
