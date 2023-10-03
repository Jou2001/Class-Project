module Mux2to1( out, cur, next, sel ) ;
	input cur, next, sel ;
	output out ;
	assign out = sel ? next : cur ;
endmodule