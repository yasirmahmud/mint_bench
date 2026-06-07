// Interface definition (SystemVerilog construct)
// While 'interface' is a SystemVerilog construct, this rule specifically targets
// multi-dimensional arrays of interfaces when processing in a Verilog-2001 context.
interface data_link_if_synth5245;
  logic enable;
  logic [7:0] data;
endinterface

// Verilog-2001 module header and basic structure
module top_synth_5245_example9 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_data,
  output wire [7:0] output_data
);

  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces
  // This line declares a 1x1x3 three-dimensional array of the 'data_link_if_synth5245' interface type.
  // This construct is unsupported in a Verilog-2001 synthesis context and triggers SYNTH_5245.
  data_link_if_synth5245 if_md_link_array [0:0][0:0][0:2] (); // A 1x1x3 three-dimensional array of interfaces

  // Minimal synthesizable logic to prevent other rules (e.g., unused ports/signals).
  reg [7:0] data_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 8'h00;
    end else begin
      data_reg <= input_data;
    end
  end

  assign output_data = data_reg;

endmodule
