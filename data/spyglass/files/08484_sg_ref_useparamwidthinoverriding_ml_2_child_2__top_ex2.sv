module top_ex2 ();
 // Modified parameter override to explicitly use the parameter's width (64-bit)
 // to adhere to the SpyGlass rule UseParamWidthInOverriding-ML, as per design description.
 sub_ex2 #(.P(64'd10)) u_sub_ex2 ();
 endmodule
