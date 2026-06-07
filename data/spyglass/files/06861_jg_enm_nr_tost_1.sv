module enum_2state_example_1;
  typedef enum bit {
    STATE_IDLE,
    STATE_ACTIVE,
    STATE_DONE
  } fsm_state_t;

  fsm_state_t current_state;

  initial begin
    current_state = STATE_IDLE;
  end
endmodule
