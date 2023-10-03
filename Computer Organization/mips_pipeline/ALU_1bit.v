`timescale 1ns/1ns
module ALU_1bit( A, B, Cin, sel, less, less_out, Cout, dataOut, reset );
	// 各種訊號
	//   sel 
	//   AND  : 000
	//   OR   : 001
	//   ADD  : 010
	//   SUB  : 110
	//   SLT  : 111
	
	input [2:0]sel ;
	input A, B, Cin, reset, less ;
	output Cout, dataOut, less_out;
	wire and_res, or_res, add_sub ; 
	wire invert_B ;
	
	assign and_res = A & B ;
	assign or_res = A | B ;
	
	// 加減法
	assign invert_B = sel[2] ? ~B : B ;			// invert 訊號為 1 invert_B = Not B 
	FA f( A, invert_B, Cin, Cout, add_sub ) ;
	
 
	assign less_out = add_sub ;
	assign dataOut = ( sel == 3'b000 ) ? and_res : ( sel == 3'b001 ) ? or_res : ( sel == 3'b110 || sel == 3'b010 ) ? add_sub : less ;
	
	
endmodule 