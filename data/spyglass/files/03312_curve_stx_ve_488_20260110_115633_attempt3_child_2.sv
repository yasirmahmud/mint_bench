module curve_stx_ve_488_20260110_115633_attempt3;
  // STX_VE_488: The original `include path `../my_included_file.v` was identified as a malformed include path (STX_VE_488) by SpyGlass, leading to file not found (STX_VE_485).
  // To resolve this, the relative parent directory reference ('../') is removed from the path.
  // It is assumed that the tool's include search path (`+incdir+`) will be configured externally
  // to include the directory containing 'my_included_file.v' to preserve functional behavior.
  `include "my_included_file.v"
endmodule
