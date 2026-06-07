module test5 (
  output logic [15:0] temp_vec
);
  logic [63:0] long_vec;

  initial begin
    long_vec = '0; // Initialize long_vec to resolve 'read but never set' (W123) error
  end

  always @* begin
    temp_vec = long_vec[32 +: 16]; // Correct ':+ ' to '+: ' to resolve Verilator COLONPLUS warning
  end
endmodule
