`timescale 1ns/1ns 
module MUX( ALUOut, HiOut, LoOut, Shifter, Signal, dataOut ) ;
	input [31:0] ALUOut ;
	input [31:0] HiOut ;
	input [31:0] LoOut ;
	input [31:0] Shifter ;
	input [5:0] Signal ;
	output [31:0] dataOut ;
	
	wire [31:0] temp_out ;
	
	parameter AND = 6'b100100;
	parameter OR  = 6'b100101;
	parameter ADD = 6'b100000;
	parameter SUB = 6'b100010;
	parameter SLT = 6'b101010;

	parameter SLL = 6'b000000;

	parameter DIVU= 6'b011011;
	parameter MFHI= 6'b010000;
	parameter MFLO= 6'b010010;
	
	assign temp_out = ( Signal == AND || Signal == OR || Signal == ADD || Signal == SUB || Signal == SLT || Signal == SLL) ? ALUOut : 
					  ( Signal == MFHI ) ? HiOut : ( Signal == MFLO ) ? LoOut : 32'd0 ;  
	
	assign dataOut = temp_out ;
	
endmodule
