module Shifter( A, B, dataOut, Signal, reset ) ;
	input reset ;
	input [31:0] A ;
	input [31:0] B ;
	input [5:0] Signal ;
	output [31:0] dataOut ;
	wire [31:0]temp1, temp2, temp3, temp4, temp_out, temp_out1 ;
	parameter SLL = 6'b000000;
	
	// 左移1bit 第一層移位
	Mux2to1 M1_1( temp1[0], A[0], 1'b0, B[0] ) ;
	Mux2to1 M1_2( temp1[1], A[1], A[0], B[0] ) ;
	Mux2to1 M1_3( temp1[2], A[2], A[1], B[0] ) ;
	Mux2to1 M1_4( temp1[3], A[3], A[2], B[0] ) ;
	Mux2to1 M1_5( temp1[4], A[4], A[3], B[0] ) ;
	Mux2to1 M1_6( temp1[5], A[5], A[4], B[0] ) ;
	Mux2to1 M1_7( temp1[6], A[6], A[5], B[0] ) ;
	Mux2to1 M1_8( temp1[7], A[7], A[6], B[0] ) ;

	Mux2to1 M1_9( temp1[8], A[8], A[7], B[0] ) ;
	Mux2to1 M1_10( temp1[9], A[9], A[8], B[0] ) ;
	Mux2to1 M1_11( temp1[10], A[10], A[9], B[0] ) ;
	Mux2to1 M1_12( temp1[11], A[11], A[10], B[0] ) ;
	Mux2to1 M1_13( temp1[12], A[12], A[11], B[0] ) ;
	Mux2to1 M1_14( temp1[13], A[13], A[12], B[0] ) ;
	Mux2to1 M1_15( temp1[14], A[14], A[13], B[0] ) ;
	Mux2to1 M1_16( temp1[15], A[15], A[14], B[0] ) ;

	Mux2to1 M1_17( temp1[16], A[16], A[15], B[0] ) ;
	Mux2to1 M1_18( temp1[17], A[17], A[16], B[0] ) ;
	Mux2to1 M1_19( temp1[18], A[18], A[17], B[0] ) ;
	Mux2to1 M1_20( temp1[19], A[19], A[18], B[0] ) ;
	Mux2to1 M1_21( temp1[20], A[20], A[19], B[0] ) ;
	Mux2to1 M1_22( temp1[21], A[21], A[20], B[0] ) ;
	Mux2to1 M1_23( temp1[22], A[22], A[21], B[0] ) ;
	Mux2to1 M1_24( temp1[23], A[23], A[22], B[0] ) ;

	Mux2to1 M1_25( temp1[24], A[24], A[23], B[0] ) ;
	Mux2to1 M1_26( temp1[25], A[25], A[24], B[0] ) ;
	Mux2to1 M1_27( temp1[26], A[26], A[25], B[0] ) ;
	Mux2to1 M1_28( temp1[27], A[27], A[26], B[0] ) ;
	Mux2to1 M1_29( temp1[28], A[28], A[27], B[0] ) ;
	Mux2to1 M1_30( temp1[29], A[29], A[28], B[0] ) ;
	Mux2to1 M1_31( temp1[30], A[30], A[29], B[0] ) ;
	Mux2to1 M1_32( temp1[31], A[31], A[30], B[0] ) ;
	
	// 第二層移位
	Mux2to1 M2_1( temp2[0], temp1[0], 1'b0, B[1] ) ;
	Mux2to1 M2_2( temp2[1], temp1[1], 1'b0, B[1] ) ;
	Mux2to1 M2_3( temp2[2], temp1[2], temp1[0], B[1] ) ;
	Mux2to1 M2_4( temp2[3], temp1[3], temp1[1], B[1] ) ;
	Mux2to1 M2_5( temp2[4], temp1[4], temp1[2], B[1] ) ;
	Mux2to1 M2_6( temp2[5], temp1[5], temp1[3], B[1] ) ;
	Mux2to1 M2_7( temp2[6], temp1[6], temp1[4], B[1] ) ;
	Mux2to1 M2_8( temp2[7], temp1[7], temp1[5], B[1] ) ;

	Mux2to1 M2_9( temp2[8], temp1[8], temp1[6], B[1] ) ;
	Mux2to1 M2_10( temp2[9], temp1[9], temp1[7], B[1] ) ;
	Mux2to1 M2_11( temp2[10], temp1[10], temp1[8], B[1] ) ;
	Mux2to1 M2_12( temp2[11], temp1[11], temp1[9], B[1] ) ;
	Mux2to1 M2_13( temp2[12], temp1[12], temp1[10], B[1] ) ;
	Mux2to1 M2_14( temp2[13], temp1[13], temp1[11], B[1] ) ;
	Mux2to1 M2_15( temp2[14], temp1[14], temp1[12], B[1] ) ;
	Mux2to1 M2_16( temp2[15], temp1[15], temp1[13], B[1] ) ;

	Mux2to1 M2_17( temp2[16], temp1[16], temp1[14], B[1] ) ;
	Mux2to1 M2_18( temp2[17], temp1[17], temp1[15], B[1] ) ;
	Mux2to1 M2_19( temp2[18], temp1[18], temp1[16], B[1] ) ;
	Mux2to1 M2_20( temp2[19], temp1[19], temp1[17], B[1] ) ;
	Mux2to1 M2_21( temp2[20], temp1[20], temp1[18], B[1] ) ;
	Mux2to1 M2_22( temp2[21], temp1[21], temp1[19], B[1] ) ;
	Mux2to1 M2_23( temp2[22], temp1[22], temp1[20], B[1] ) ;
	Mux2to1 M2_24( temp2[23], temp1[23], temp1[21], B[1] ) ;

	Mux2to1 M2_25( temp2[24], temp1[24], temp1[22], B[1] ) ;
	Mux2to1 M2_26( temp2[25], temp1[25], temp1[23], B[1] ) ;
	Mux2to1 M2_27( temp2[26], temp1[26], temp1[24], B[1] ) ;
	Mux2to1 M2_28( temp2[27], temp1[27], temp1[25], B[1] ) ;
	Mux2to1 M2_29( temp2[28], temp1[28], temp1[26], B[1] ) ;
	Mux2to1 M2_30( temp2[29], temp1[29], temp1[27], B[1] ) ;
	Mux2to1 M2_31( temp2[30], temp1[30], temp1[28], B[1] ) ;
	Mux2to1 M2_32( temp2[31], temp1[31], temp1[29], B[1] ) ;	
	
	// 第三層移位
	Mux2to1 M3_1( temp3[0], temp2[0], 1'b0, B[2] ) ;
	Mux2to1 M3_2( temp3[1], temp2[1], 1'b0, B[2] ) ;
	Mux2to1 M3_3( temp3[2], temp2[2], 1'b0, B[2] ) ;
	Mux2to1 M3_4( temp3[3], temp2[3], 1'b0, B[2] ) ;
	Mux2to1 M3_5( temp3[4], temp2[4], temp2[0], B[2] ) ;
	Mux2to1 M3_6( temp3[5], temp2[5], temp2[1], B[2] ) ;
	Mux2to1 M3_7( temp3[6], temp2[6], temp2[2], B[2] ) ;
	Mux2to1 M3_8( temp3[7], temp2[7], temp2[3], B[2] ) ;

	Mux2to1 M3_9( temp3[8], temp2[8], temp2[4], B[2] ) ;
	Mux2to1 M3_10( temp3[9], temp2[9], temp2[5], B[2] ) ;
	Mux2to1 M3_11( temp3[10], temp2[10], temp2[6], B[2] ) ;
	Mux2to1 M3_12( temp3[11], temp2[11], temp2[7], B[2] ) ;
	Mux2to1 M3_13( temp3[12], temp2[12], temp2[8], B[2] ) ;
	Mux2to1 M3_14( temp3[13], temp2[13], temp2[9], B[2] ) ;
	Mux2to1 M3_15( temp3[14], temp2[14], temp2[10], B[2] ) ;
	Mux2to1 M3_16( temp3[15], temp2[15], temp2[11], B[2] ) ;

	Mux2to1 M3_17( temp3[16], temp2[16], temp2[12], B[2] ) ;
	Mux2to1 M3_18( temp3[17], temp2[17], temp2[13], B[2] ) ;
	Mux2to1 M3_19( temp3[18], temp2[18], temp2[14], B[2] ) ;
	Mux2to1 M3_20( temp3[19], temp2[19], temp2[15], B[2] ) ;
	Mux2to1 M3_21( temp3[20], temp2[20], temp2[16], B[2] ) ;
	Mux2to1 M3_22( temp3[21], temp2[21], temp2[17], B[2] ) ;
	Mux2to1 M3_23( temp3[22], temp2[22], temp2[18], B[2] ) ;
	Mux2to1 M3_24( temp3[23], temp2[23], temp2[19], B[2] ) ;

	Mux2to1 M3_25( temp3[24], temp2[24], temp2[20], B[2] ) ;
	Mux2to1 M3_26( temp3[25], temp2[25], temp2[21], B[2] ) ;
	Mux2to1 M3_27( temp3[26], temp2[26], temp2[22], B[2] ) ;
	Mux2to1 M3_28( temp3[27], temp2[27], temp2[23], B[2] ) ;
	Mux2to1 M3_29( temp3[28], temp2[28], temp2[24], B[2] ) ;
	Mux2to1 M3_30( temp3[29], temp2[29], temp2[25], B[2] ) ;
	Mux2to1 M3_31( temp3[30], temp2[30], temp2[26], B[2] ) ;
	Mux2to1 M3_32( temp3[31], temp2[31], temp2[27], B[2] ) ;	

	// 第四層移位
	Mux2to1 M4_1( temp4[0], temp3[0], 1'b0, B[3] ) ;
	Mux2to1 M4_2( temp4[1], temp3[1], 1'b0, B[3] ) ;
	Mux2to1 M4_3( temp4[2], temp3[2], 1'b0, B[3] ) ;
	Mux2to1 M4_4( temp4[3], temp3[3], 1'b0, B[3] ) ;
	Mux2to1 M4_5( temp4[4], temp3[4], 1'b0, B[3] ) ;
	Mux2to1 M4_6( temp4[5], temp3[5], 1'b0, B[3] ) ;
	Mux2to1 M4_7( temp4[6], temp3[6], 1'b0, B[3] ) ;
	Mux2to1 M4_8( temp4[7], temp3[7], 1'b0, B[3] ) ;

	Mux2to1 M4_9( temp4[8], temp3[8], temp3[0], B[3] ) ;
	Mux2to1 M4_10( temp4[9], temp3[9], temp3[1], B[3] ) ;
	Mux2to1 M4_11( temp4[10], temp3[10], temp3[2], B[3] ) ;
	Mux2to1 M4_12( temp4[11], temp3[11], temp3[3], B[3] ) ;
	Mux2to1 M4_13( temp4[12], temp3[12], temp3[4], B[3] ) ;
	Mux2to1 M4_14( temp4[13], temp3[13], temp3[5], B[3] ) ;
	Mux2to1 M4_15( temp4[14], temp3[14], temp3[6], B[3] ) ;
	Mux2to1 M4_16( temp4[15], temp3[15], temp3[7], B[3] ) ;

	Mux2to1 M4_17( temp4[16], temp3[16], temp3[8], B[3] ) ;
	Mux2to1 M4_18( temp4[17], temp3[17], temp3[9], B[3] ) ;
	Mux2to1 M4_19( temp4[18], temp3[18], temp3[10], B[3] ) ;
	Mux2to1 M4_20( temp4[19], temp3[19], temp3[11], B[3] ) ;
	Mux2to1 M4_21( temp4[20], temp3[20], temp3[12], B[3] ) ;
	Mux2to1 M4_22( temp4[21], temp3[21], temp3[12], B[3] ) ;
	Mux2to1 M4_23( temp4[22], temp3[22], temp3[13], B[3] ) ;
	Mux2to1 M4_24( temp4[23], temp3[23], temp3[14], B[3] ) ;

	Mux2to1 M4_25( temp4[24], temp3[24], temp3[15], B[3] ) ;
	Mux2to1 M4_26( temp4[25], temp3[25], temp3[16], B[3] ) ;
	Mux2to1 M4_27( temp4[26], temp3[26], temp3[17], B[3] ) ;
	Mux2to1 M4_28( temp4[27], temp3[27], temp3[18], B[3] ) ;
	Mux2to1 M4_29( temp4[28], temp3[28], temp3[19], B[3] ) ;
	Mux2to1 M4_30( temp4[29], temp3[29], temp3[20], B[3] ) ;
	Mux2to1 M4_31( temp4[30], temp3[30], temp3[21], B[3] ) ;
	Mux2to1 M4_32( temp4[31], temp3[31], temp3[22], B[3] ) ;		
	
	// 第五層移位
	Mux2to1 M5_1( temp_out[0], temp4[0], 1'b0, B[4] ) ;
	Mux2to1 M5_2( temp_out[1], temp4[1], 1'b0, B[4] ) ;
	Mux2to1 M5_3( temp_out[2], temp4[2], 1'b0, B[4] ) ;
	Mux2to1 M5_4( temp_out[3], temp4[3], 1'b0, B[4] ) ;
	Mux2to1 M5_5( temp_out[4], temp4[4], 1'b0, B[4] ) ;
	Mux2to1 M5_6( temp_out[5], temp4[5], 1'b0, B[4] ) ;
	Mux2to1 M5_7( temp_out[6], temp4[6], 1'b0, B[4] ) ;
	Mux2to1 M5_8( temp_out[7], temp4[7], 1'b0, B[4] ) ;

	Mux2to1 M5_9( temp_out[8], temp4[8], 1'b0, B[4] ) ;
	Mux2to1 M5_10( temp_out[9], temp4[9], 1'b0, B[4] ) ;
	Mux2to1 M5_11( temp_out[10], temp4[10], 1'b0, B[4] ) ;
	Mux2to1 M5_12( temp_out[11], temp4[11], 1'b0, B[4] ) ;
	Mux2to1 M5_13( temp_out[12], temp4[12], 1'b0, B[4] ) ;
	Mux2to1 M5_14( temp_out[13], temp4[13], 1'b0, B[4] ) ;
	Mux2to1 M5_15( temp_out[14], temp4[14], 1'b0, B[4] ) ;
	Mux2to1 M5_16( temp_out[15], temp4[15], 1'b0, B[4] ) ;

	Mux2to1 M5_17( temp_out[16], temp4[16], temp4[0], B[4] ) ;
	Mux2to1 M5_18( temp_out[17], temp4[17], temp4[1], B[4] ) ;
	Mux2to1 M5_19( temp_out[18], temp4[18], temp4[2], B[4] ) ;
	Mux2to1 M5_20( temp_out[19], temp4[19], temp4[3], B[4] ) ;
	Mux2to1 M5_21( temp_out[20], temp4[20], temp4[4], B[4] ) ;
	Mux2to1 M5_22( temp_out[21], temp4[21], temp4[5], B[4] ) ;
	Mux2to1 M5_23( temp_out[22], temp4[22], temp4[6], B[4] ) ;
	Mux2to1 M5_24( temp_out[23], temp4[23], temp4[7], B[4] ) ;

	Mux2to1 M5_25( temp_out[24], temp4[24], temp4[8], B[4] ) ;
	Mux2to1 M5_26( temp_out[25], temp4[25], temp4[9], B[4] ) ;
	Mux2to1 M5_27( temp_out[26], temp4[26], temp4[10], B[4] ) ;
	Mux2to1 M5_28( temp_out[27], temp4[27], temp4[11], B[4] ) ;
	Mux2to1 M5_29( temp_out[28], temp4[28], temp4[12], B[4] ) ;
	Mux2to1 M5_30( temp_out[29], temp4[29], temp4[13], B[4] ) ;
	Mux2to1 M5_31( temp_out[30], temp4[30], temp4[14], B[4] ) ;
	Mux2to1 M5_32( temp_out[31], temp4[31], temp4[15], B[4] ) ;	
	
	assign temp_out1 = ( B >= 32'd32 ) ? 32'b0 : temp_out ;
	assign dataOut = reset ? 32'b0 : ( Signal == SLL ) ? temp_out1 : 32'b0 ;
	 
	
endmodule