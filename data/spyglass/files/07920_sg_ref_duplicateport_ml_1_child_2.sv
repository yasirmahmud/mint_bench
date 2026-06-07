module duplicate_port_ex1 (p1);
 input p1;
 wire unused_p1_read = p1; // Reads p1 to resolve W240 violation
 endmodule
