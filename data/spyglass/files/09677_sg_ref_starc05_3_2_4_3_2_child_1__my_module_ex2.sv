module my_module_ex2;
 wire b_unused; // Added to resolve W287b: Instance output port 'b' is not connected
 sub_module inst1 (.a(1'b0), .b(b_unused));
 defparam inst1.WIDTH = 32;
 endmodule
