/* This multi-line comment is intentionally left unclosed.
   The parser will encounter the end of the file here without finding the closing '*/',
   leading to a 'Premature end of source' violation (STX_VE_850).
   Since the module itself is properly terminated with 'endmodule', this specific scenario
   aims to trigger STX_VE_850 without triggering WRN_1463, as WRN_1463 is typically
   associated with a missing 'endmodule' keyword.
