module sv_construct_ex1;
 typedef enum { S0, S1 } state_t;
 state_t current_state;
 initial begin current_state = S0;
 end endmodule
