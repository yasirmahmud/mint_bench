`define MY_MACRO 1
module my_module_ex1;
 wire a; // Changed from 'reg' to 'wire' to allow continuous assignment
 assign a = `MY_MACRO; // Added backtick to correctly expand the macro. The original 'MY_MACRO' without backtick was treated as an undeclared identifier.
 endmodule
