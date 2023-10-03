module EX_MEM_reg( WB_ctl_in, MEM_ctl_in, bran_PC, eq_in, ne_in, ALU_result, RD2_in, reg_dst, clk, rst,
				   WB_ctl_out, MEMRead, MEMWrite, Branch, EQ_NE, bran_PC_out, eq_out, ne_out, ALU_result_out, WD, reg_dst_out ) ;
				   
	input [1:0] WB_ctl_in ;
	input [3:0] MEM_ctl_in ;
	input [31:0] bran_PC, ALU_result, RD2_in;
	input eq_in, ne_in, clk, rst ;
	input [4:0] reg_dst ;
	
	reg [108:0] EX_MEM ;
	
	output reg [1:0] WB_ctl_out ;
	output reg [31:0] bran_PC_out, ALU_result_out, WD;
	output reg eq_out, ne_out, MEMRead, MEMWrite, Branch, EQ_NE ;
	output reg [4:0] reg_dst_out ;	

	always@( posedge clk )
	begin
		if ( rst == 1'b1 ) 
		begin 
			reg_dst_out <= 5'd0 ;
			WD <= 32'd0 ;
			ALU_result_out <= 32'd0 ;
			ne_out <= 1'd0 ;
			eq_out <= 1'd0  ;
			bran_PC_out <= 32'd0 ;
			EQ_NE <= 1'd0 ;
			Branch <= 1'd0 ;
			MEMRead	<= 1'd0 ;
			MEMWrite <= 1'd0 ;
			WB_ctl_out <= 2'd0  ;
		end
		
		else 
		begin 
			reg_dst_out <= reg_dst ;
			WD <= RD2_in ;
			ALU_result_out <= ALU_result ;
			ne_out <= ne_in ;
			eq_out <= eq_in ;
			bran_PC_out <= bran_PC ;
			EQ_NE <= MEM_ctl_in[3] ;
			Branch <= MEM_ctl_in[2] ;
			MEMRead <= MEM_ctl_in[1] ;
			MEMWrite <= MEM_ctl_in[0] ;
			WB_ctl_out <= WB_ctl_in ;
		end
	end 


endmodule
