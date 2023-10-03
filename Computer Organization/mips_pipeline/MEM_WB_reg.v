module MEM_WB_reg( WB_ctl_in, RD_in, ALU_result_in, regdst_in, clk, rst,
				   RegWrite, MEMtoReg, RD_out, ALU_result_out, regdst_out ) ;
				   
	input [1:0] WB_ctl_in ;
	input [31:0] RD_in, ALU_result_in ;
	input [4:0] regdst_in ;
	input clk,rst ;
		
	output reg RegWrite, MEMtoReg ;
	output reg [31:0] RD_out, ALU_result_out ;
	output reg [4:0] regdst_out ;
	
	always@( posedge clk ) 
	begin
		if ( rst == 1'b1 ) 
		begin
			regdst_out <= 5'd0 ;
			ALU_result_out <= 32'd0 ;
			RD_out <= 32'd0 ;
			RegWrite <= 1'd0 ;
			MEMtoReg <= 1'd0 ;
		end
		
		else 
		begin
			regdst_out <= regdst_in ;
			ALU_result_out <= ALU_result_in ;
			RD_out <= RD_in ;
			RegWrite <= WB_ctl_in[1] ;
			MEMtoReg <= WB_ctl_in[0] ;
		end
	end 
	
endmodule