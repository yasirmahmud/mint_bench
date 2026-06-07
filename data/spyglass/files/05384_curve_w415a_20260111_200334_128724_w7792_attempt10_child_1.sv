module curve_w415a_20260111_200334_128724_w7792_attempt10 (
  input wire [7:0] data_in,
  output reg [3:0] count_out
);

  integer i;
  reg [3:0] count_reg; 

  always @(*) begin
    reg [3:0] local_count;
    local_count = 4'b0000; 

    for (i = 0; i < 8; i = i + 1) begin
      if (data_in[i] == 1'b1) begin
        local_count = local_count + 1;
      end
    end
    count_reg = local_count; 
    count_out = count_reg;
  end

endmodule
