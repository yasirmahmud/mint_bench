interface my_interface;
  // Using 'wire' is more compatible with Verilog-2001, though 'interface' itself is SystemVerilog.
  wire data;
endinterface

module top_module_synth_5245 (
  input wire clk,
  input wire in_data,
  output reg out_data
);
  // SYNTH_5245: This line directly declares a multi-dimensional array of interfaces,
  // which is an unsupported SystemVerilog construct for synthesis, triggering the violation.
  my_interface if_array [0:1][0:1] ();

  // Add minimal, synthesizable logic to the module. This is an attempt to ensure
  // the module is otherwise well-formed and synthesizable, hoping to prevent
  // generic synthesis failure errors (like ErrorAnalyzeBBox) that are sometimes
  // reported alongside specific SYNTH_ rules, while the core SYNTH_5245 violation remains.
  always @(posedge clk) begin
    out_data <= in_data;
  end

endmodule
