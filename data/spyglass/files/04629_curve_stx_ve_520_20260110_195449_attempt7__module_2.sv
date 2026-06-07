// This `define directive is placed after the module definition.
// It contains an unterminated quoted string, which should trigger STX_VE_520.
// By placing it at the very end of the file, it prevents other keywords (like 'end' or 'endmodule')
// from being consumed by the unterminated string, thus avoiding cascading syntax errors.
`define UNTERMINATED_STRING_EXAMPLE "This string is intentionally missing its closing double quote
