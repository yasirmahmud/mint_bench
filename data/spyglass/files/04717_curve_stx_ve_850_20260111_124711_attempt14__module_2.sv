// This intentionally incomplete macro definition at the end of the file
// will cause a 'Premature end of source' violation (STX_VE_850).
// The parser expects a closing ')' for the macro arguments or body,
// but encounters the end of the file instead.
// Since 'endmodule' is present and correctly terminated, this should avoid
// triggering WRN_1463 (missing endmodule) and target only STX_VE_850.
`define INCOMPLETE_MACRO(arg1, arg2) ((arg1 > arg2) ? arg1 : arg2
