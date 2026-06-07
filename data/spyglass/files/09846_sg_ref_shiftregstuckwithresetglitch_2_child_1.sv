module shift_reg_stuck_ex2 (input clk, input rst_n, input shift_en, input data_in, output reg data_out);
 reg [2:0] shift_count;
 reg [3:0] sreg;

 wire [2:0] shift_count_next;

 // Combinational next-state logic for shift_count
 always @(*) begin
  if (shift_en) begin
   if (shift_count == 3'b000) begin
    shift_count_next = 3'b000;
   end else begin
    shift_count_next = shift_count + 1;
   end
  end else begin
   shift_count_next = 3'b000;
  end
 end

 // Sequential update logic for shift_count and sreg
 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   shift_count <= 3'b000;
   sreg <= 4'b0000;
  end else begin
   shift_count <= shift_count_next;
   if (shift_en) begin
    sreg <= {sreg[2:0], data_in};
   end
  end
 end

 assign data_out = sreg[3];
 endmodule
