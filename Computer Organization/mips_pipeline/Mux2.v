module Mux2( out, cur, next, sel ) ;
	input [31:0]cur, next ;
	input sel ;
	output [31:0]out ;
	assign out = sel ? next : cur ;
endmodule