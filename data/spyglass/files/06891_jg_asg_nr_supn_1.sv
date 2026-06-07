module assign_to_supply0_net (
  input wire data_in
);
  supply0 my_gnd;
  assign my_gnd = data_in; // Attempting to assign to a supply0 net
endmodule
