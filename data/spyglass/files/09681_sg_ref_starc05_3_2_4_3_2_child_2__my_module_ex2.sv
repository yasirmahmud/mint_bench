module my_module_ex2;
 sub_module inst1 (.a(1'b0), .b()); // Output port 'b' is explicitly left unconnected to resolve W528.
 defparam inst1.WIDTH = 32;
 endmodule
