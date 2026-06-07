module lemming (
  input wire [2:0] data_in,
  input wire [1:0] sel_case,
  output wire [2:0] latched_output
);

  reg [2:0] ns; // This register will infer a latch

  always @(data_in or sel_case) begin
    case (sel_case)
      2'b00: ns = data_in;
      2'b01: ns = {data_in[1:0], data_in[2]}; // Example transformation
      // For sel_case values 2'b10 or 2'b11, ns is not explicitly assigned,
      // causing it to hold its previous value and inferring a latch.
    endcase
  end

  assign latched_output = ns;

endmodule
