module rca_32_generate #(parameter SIZE = 32) (input [(SIZE-1):0] a, input [(SIZE-1):0] b, input cin, output [(SIZE-1):0] sum, output cout);

	wire [(SIZE-1):0] c;

	genvar i;

	full_adder fa1(a[0],b[0],cin,sum[0],c[0]);
	
	generate
		for(i=1;i<SIZE;i=i+1)
		begin
			full_adder fa2(a[i], b[i], c[i-1], sum[i], c[i]);
		end
	endgenerate

	// full_adder fa3(a[`SIZE-1], b[`SIZE-1], c[`SIZE-2], sum[`SIZE-1], cout);
	assign cout = c[(SIZE-1)];

endmodule
