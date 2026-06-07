// Interface definition (SystemVerilog construct)
// While 'interface' is a SystemVerilog construct, the SYNTH_5245 rule
// specifically targets multi-dimensional arrays of interfaces when
// processed in a Verilog-2001 synthesis context.
interface simple_data_interface;
  logic [7:0] data;
  logic valid;
endinterface

// Verilog-2001 module header and basic structure
module curve_synth_5245_20260112_001230_572149_w44756_attempt15 (
  input wire clk,
  input wire rst_n,
  input wire [7:0] input_val,
  output wire [7:0] output_val
);

  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces.
  // This line declares a 2x3 two-dimensional array of the 'simple_data_interface' type.
  // This SystemVerilog construct is explicitly unsupported in a Verilog-2001 synthesis
  // context, thereby triggering the SYNTH_5245 violation.
  simple_data_interface interface_array_md [0:1][0:2] (); // A 2x3 two-dimensional array of interfaces

  // Minimal synthesizable logic to prevent other rules related to empty modules
  // or unused ports/signals. The actual functionality is trivial.
  reg [7:0] data_reg;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_reg <= 8'h00;
    end else begin
      data_reg <= input_val;
    end
  end

  assign output_val = data_reg;

endmodule
