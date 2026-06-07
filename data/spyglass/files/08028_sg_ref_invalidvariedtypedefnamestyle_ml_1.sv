module InvalidVariedTypedefNameStyle_ex1;
 typedef enum { STATE_IDLE, STATE_RUN } my_enum_type;
 my_enum_type current_state;
 initial begin current_state = STATE_IDLE;
 end endmodule
