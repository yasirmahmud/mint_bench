module mx4_clr_reg_33 (inp3, inp2, inp1, inp0,
                       sel,  clr,  clk,  out);
 
input  [32:0]  inp3;
input  [32:0]  inp2;
input  [32:0]  inp1;
input  [32:0]  inp0;
input  [1:0]   sel;
input          clr;
input          clk;
output reg [32:0]  out; // Changed 'out' to reg as it's driven by a sequential block

wire   [32:0]  mux_1;
wire   [32:0]  next;
// Removed: wire   [32:0]  out; // 'out' is now declared as reg
 
// Replaced mx4_33 instantiation with equivalent combinational logic
always @* begin // Use always @* for synthesizable combinational logic
  case (sel)
    2'b00: mux_1 = inp0;
    2'b01: mux_1 = inp1;
    2'b10: mux_1 = inp2;
    2'b11: mux_1 = inp3;
    default: mux_1 = inp0; // Default case for full coverage
  endcase  
end

// Replaced an2_33 instantiation with equivalent combinational logic
assign next = {33{!clr}} & mux_1; // Gates mux_1 with !clr

// Replaced ff_s_33 instantiation with equivalent sequential logic
always @(posedge clk) begin
   out <= next; // Registers 'next' on the rising edge of 'clk'
end
 
endmodule
