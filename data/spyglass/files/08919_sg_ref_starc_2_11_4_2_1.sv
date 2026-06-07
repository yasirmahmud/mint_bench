module star_2_11_4_2_ex1 (input clk, input rst_n, input in_signal, output out_signal);
 reg [1:0] current_state;
 wire [1:0] next_state;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) current_state <= 2'b00;
 else current_state <= next_state;
 end always @* begin next_state = current_state;
 case (current_state) 2'b00: if (in_signal) next_state = 2'b01;
 2'b01: if (!in_signal) next_state = 2'b00;
 default: next_state = 2'b00;
 endcase end assign out_signal = (current_state == 2'b01);
 endmodule
