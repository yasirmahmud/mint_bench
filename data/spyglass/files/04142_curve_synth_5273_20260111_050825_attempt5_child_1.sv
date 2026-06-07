module curve_synth_5273_20260111_050825_attempt5 (
    input clk,
    input rst_n,
    input we,           // Write enable
    input [7:0] wa,     // Write address (0 to 255 needs 8 bits)
    input [143:0] wdata, // Write data (144 bits)
    input re,           // Read enable
    input [7:0] ra,     // Read address (0 to 255 needs 8 bits)
    output reg [143:0] rdata_out // Read data output (144 bits)
);

  reg [143:0] DataMem [0:255];

  // Synchronous write logic for DataMem
  // DataMem itself does not have an explicit reset
  always @(posedge clk) begin
    if (we) begin
      DataMem[wa] <= wdata; // Synchronous write operation
    end
  end

  // Synchronous read logic for rdata_out with asynchronous reset
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rdata_out <= 144'b0; // Asynchronous reset for read output
    end else begin
      if (re) begin
        rdata_out <= DataMem[ra]; // Registered synchronous read operation
      end
    end
  end

endmodule
