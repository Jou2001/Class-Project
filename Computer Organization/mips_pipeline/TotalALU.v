`timescale 1ns/1ns
module TotalALU( clk, dataA, dataB, Signal, Output, reset, ne, eq );
	input reset ;
	input clk ;
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [5:0] Signal ;
	output [31:0] Output ;
	wire [31:0] temp ;
	output wire ne, eq ;
	
	parameter AND = 6'b100100;
	parameter OR  = 6'b100101;
	parameter ADD = 6'b100000;
	parameter SUB = 6'b100010;
	parameter SLT = 6'b101010;

	parameter SLL = 6'b000000;

	parameter DIVU= 6'b011011;
	parameter MFHI= 6'b010000;
	parameter MFLO= 6'b010010;
	
	wire [5:0]  SignaltoALU ;
	wire [5:0]  SignaltoSHT ;
	wire [5:0]  SignaltoDIV ;
	wire [5:0]  SignaltoMUX ;
	wire [31:0] ALUOut, HiOut, LoOut, ShifterOut ;
	wire [31:0] dataOut ;
	wire [63:0] DivAns ;
	
	// ALUControl
	ALUControl ALUControl( .clk(clk), .Signal(Signal), .SignaltoALU(SignaltoALU), .SignaltoSHT(SignaltoSHT), .SignaltoDIV(SignaltoDIV), .SignaltoMUX(SignaltoMUX) );
	
	// ALU
	ALU ALU( .dataA(dataA), .dataB(dataB), .Signal(SignaltoALU), .dataOut(ALUOut), .reset(reset), .eq(eq), .ne(ne) );
	
	// Divider
	Divider Divider( .clk(clk), .dataA(dataA), .dataB(dataB), .Signal(SignaltoDIV), .dataOut(DivAns), .reset(reset) );
	
	// Shifter 
	Shifter Shifter( .A(dataA), .B(dataB), .dataOut(ShifterOut), .Signal(SignaltoSHT), .reset(reset) );
	
	// HiLo
	HiLo HiLo( .clk(clk), .DivAns(DivAns), .HiOut(HiOut), .LoOut(LoOut), .reset(reset) );
	
	// MUX
	MUX MUX( .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .Shifter(ShifterOut), .Signal(SignaltoMUX), .dataOut(dataOut) );
	
	assign Output = reset ? 32'b0 : dataOut ;
endmodule