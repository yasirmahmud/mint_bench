module starc_1_1_1_5_ex1 (input my_signal);
 wire my_signal_int; // Renamed to avoid STARC-1.1.1.5 violation (case-insensitive port/internal name clash)
 assign my_signal_int = my_signal; // Reads 'my_signal', resolving W240 violation
 endmodule
