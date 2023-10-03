module IF_ID_reg( rd_out, newPC_out, rd_in, newPC_in, clk, rst ) ;
	//reg [63:0]IF_ID ;
	input [31:0] rd_in, newPC_in ;
	output reg [31:0] newPC_out, rd_out ;
	input clk, rst ;
	
	always@( posedge clk ) 
	begin
		if ( rst == 1'b1 ) 
		begin
			newPC_out <= 32'd0 ;
			rd_out <= 32'd0 ;
		end 
		else 
		begin
			newPC_out <= newPC_in ;
			rd_out <= rd_in ;
		end 
	end 
	
endmodule