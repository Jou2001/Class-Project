module ID_EX_reg( WB_ctl_in, MEM_ctl_in, EX_ctl_in, pc_in, RD1_in, RD2_in, immed_exted_in, Rt_in, Rd_in, shamt, clk, rst,
			  WB_ctl_out, MEM_ctl_out, ALUop, ALUsrc, RegDst, pc_out, RD1_out, RD2_out, immed_exted_out, Rt_out, Rd_out, shamt_out) ;
	
	input [1:0] WB_ctl_in ;
	input [3:0] MEM_ctl_in, EX_ctl_in ;
	input [31:0] pc_in, RD1_in, RD2_in, immed_exted_in ;
	input [4:0] Rt_in, Rd_in ;
	input clk, rst ;
	input [4:0] shamt ;
	
	output reg [1:0] WB_ctl_out ;
	output reg [3:0] MEM_ctl_out ;
	output reg [1:0] ALUop ;
	output reg RegDst, ALUsrc ;
	output reg [31:0] pc_out, RD1_out, RD2_out, immed_exted_out ;
	output reg[4:0] Rt_out, Rd_out, shamt_out ;
	
	always@( posedge clk )
	begin
		if ( rst == 1'b1 ) 
		begin
			Rd_out <= 5'd0 ;
			Rt_out <= 5'd0 ;
			immed_exted_out <= 32'd0 ;
			RD2_out <= 32'd0 ;
			RD1_out <= 32'd0 ;
			pc_out <= 32'd0 ;
			RegDst <= 1'd0 ;
			ALUop <= 2'd0 ;
			ALUsrc <= 1'd0 ;
			MEM_ctl_out <= 4'd0 ;
			WB_ctl_out <= 2'd0 ;
			shamt_out <= 5'd0 ;
		end
		
		else 
		begin
			Rd_out <= Rd_in ;
			Rt_out <= Rt_in ;
			immed_exted_out <= immed_exted_in ;
			RD2_out <= RD2_in ;
			RD1_out <= RD1_in ;
			pc_out <= pc_in ;
			RegDst <= EX_ctl_in[3] ;
			ALUop <= EX_ctl_in[2:1] ;
			ALUsrc <= EX_ctl_in[0] ;
			MEM_ctl_out <= MEM_ctl_in ;
			WB_ctl_out <= WB_ctl_in ;
			shamt_out <= shamt ;
		end
	end 

endmodule