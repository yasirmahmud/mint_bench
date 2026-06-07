// Interface definition (SystemVerilog construct)
// While 'interface' is a SystemVerilog construct, this rule specifically targets
// multi-dimensional arrays of interfaces when processing in a Verilog-2001 context.
interface my_simple_if_synth5245;
  logic data;
  logic clk;
  logic reset;
endinterface

// Verilog-2001 module header and basic structure
module top_level_synth_5245 (
  input wire clk_i,
  input wire rst_n_i,
  input wire data_in_i,
  output wire data_out_o
);

  // SYNTH_5245: Instantiating a multi-dimensional array of interfaces
  // This line declares a two-dimensional array of the 'my_simple_if_synth5245' interface type.
  // Such a construct is unsupported in a Verilog-2001 synthesis context and triggers SYNTH_5245.
  my_simple_if_synth5245 if_inst_array_md [0:2][0:1] (); // A 3x2 two-dimensional array of interfaces

  // Minimal synthesizable logic to prevent other rules related to empty modules
  // or unused ports/signals (e.g., UNU_0001, EMP_0001).
  // This logic is Verilog-2001 compliant and does not trigger additional violations.
  reg dummy_reg;

  always @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
      dummy_reg <= 1'b0;
    end else begin
      dummy_reg <= data_in_i;
    end
  end

  assign data_out_o = dummy_reg;

endmodule
