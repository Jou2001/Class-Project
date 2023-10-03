module Mux5( out, cur, next, sel ) ;
	input [4:0]cur, next ;
	input sel ;
	output [4:0]out ;
	assign out = sel ? next : cur ;
endmodule