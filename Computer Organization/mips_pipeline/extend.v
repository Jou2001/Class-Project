module extend( immed, opcode, ext_immed_out ) ;
	input [5:0] opcode ;
	input [15:0] immed ;
	output [31:0] ext_immed_out;
	wire [31:0] sign_ext_immed_out, unsig_ext_immed_out ;
	
	parameter ORI = 6'd13;

	assign sign_ext_immed_out = { {16{immed[15]}}, immed };
	assign unsig_ext_immed_out = { 16'd0, immed } ;
	
	// 選擇做有號數擴充或無號數擴充
	assign ext_immed_out = ( opcode == ORI ) ? unsig_ext_immed_out : sign_ext_immed_out ; 
	
endmodule