`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset );
	input clk ;
	input reset ;
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [5:0] Signal ;
	output reg [63:0] dataOut ;

	reg [63:0] temp, tempA ;
	reg [31:0] divA, divB ;
	parameter DIVU = 6'b011011;
	parameter OUT = 6'b111111;
	reg [5:0] counter ;
	reg [31:0] quot, rem ;

	always@( posedge clk or reset ) 
	begin
		if ( reset ) 
		begin
			counter = 6'd0 ; 
			temp = 64'd0 ;
		end
		
		else 
		begin 
			if ( Signal == DIVU )
			begin
				counter = 6'd0 ;
				divA = dataA ;
				divB = dataB ;
				//tempA = { 32'd0, divA } ;		// 將dataA擴充為64 bit
				// temp = tempA << 1 ;				// 先移第一次
			end 
			
			if ( counter == 6'd0 ) 
			begin
				tempA = { 32'd0, divA } ;		// 將dataA擴充為64 bit
				temp = tempA << 1 ;				// 先移第一次
			end 
			
			
			counter = counter + 1 ;				
			
			if ( counter == 6'd33 ) 
			begin
					temp[63:32] = temp[63:32] >> 1 ;		// 除完餘數右移 1bit
					counter = 6'd0 ;						// counter 重設
					dataOut = temp ;						// 設定dataOut
			end			
			
			temp[63:32] = temp[63:32] - divB ;
			
			if ( temp[63] == 1'b0 ) 
			begin
				temp = temp << 1 ;	// 全部左移 1bit
				temp[0] = 1'b1 ;	// 最低位元設為 1
			end 
			
			else if ( temp[63] == 1'b1 ) 
			begin
				temp[63:32] = temp[63:32] + divB ;		// 減完為負 加回去
				temp = temp << 1 ;						// 左移 1bit
				temp[0] = 1'b0 ;						// 最低位元設為0
			end
			
			


			rem = temp[63:32] ;
			quot = temp[31:0] ;
		end
	end 
	
	
endmodule 