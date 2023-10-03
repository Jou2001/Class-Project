`timescale 1ns/1ns
module ALU( dataA, dataB, Signal, dataOut, shamt, reset, eq, ne );
	input [4:0] shamt ;
	input reset ;
	input [31:0] dataA ;
	input [31:0] dataB ;
	input [5:0] Signal ;
	output [31:0] dataOut ;
	output ne, eq ;
	
	wire [31:0] temp_out, ShifterOut, shamt_extd ;
	wire [2:0]sel ;
	wire invert ;
	wire [31:0]Cout, less ; 	// less[31:0] 用來存sub的結果,把第31位元的結果給到第0位元的less
	wire overflow ;
		
	parameter SLL = 6'b000000;
	parameter AND = 6'b100100;
	parameter OR  = 6'b100101;
	parameter ADD = 6'b100000;
	parameter SUB = 6'b100010;
	parameter SLT = 6'b101010;
	
	assign sel = ( Signal == AND ) ? 3'b000 : ( Signal == OR ) ? 3'b001 : ( Signal == SUB ) ? 3'b110 : ( Signal == ADD ) ? 3'b010 : ( Signal == SLT ) ? 3'b111 : 3'bxxx ;
	
	// SUB || SLT => invert = 1, 其他為 0
	assign invert = ( Signal == SUB || Signal == SLT ) ? 1 : 0 ;
	assign Cout[0] = invert ;
 	assign shamt_extd = { 27'd0, shamt } ;
	
	ALU_1bit alu_1(.A(dataA[0]), .B(dataB[0]), .Cin(Cout[0]), .sel(sel), .less(less[31]), .less_out(less[0]) , .Cout(Cout[1]), .dataOut(temp_out[0])  , .reset(reset));
	ALU_1bit alu_2(.A(dataA[1]), .B(dataB[1]), .Cin(Cout[1]), .sel(sel), .less(1'b0), .less_out(less[1]) , .Cout(Cout[2]), .dataOut(temp_out[1])  , .reset(reset));
	ALU_1bit alu_3(.A(dataA[2]), .B(dataB[2]), .Cin(Cout[2]), .sel(sel), .less(1'b0), .less_out(less[2]) , .Cout(Cout[3]), .dataOut(temp_out[2])  , .reset(reset));
	ALU_1bit alu_4(.A(dataA[3]), .B(dataB[3]), .Cin(Cout[3]), .sel(sel), .less(1'b0), .less_out(less[3]) , .Cout(Cout[4]), .dataOut(temp_out[3])  , .reset(reset));
	ALU_1bit alu_5(.A(dataA[4]), .B(dataB[4]), .Cin(Cout[4]), .sel(sel), .less(1'b0), .less_out(less[4]) , .Cout(Cout[5]), .dataOut(temp_out[4])  , .reset(reset));
	ALU_1bit alu_6(.A(dataA[5]), .B(dataB[5]), .Cin(Cout[5]), .sel(sel), .less(1'b0), .less_out(less[5]) , .Cout(Cout[6]), .dataOut(temp_out[5])  , .reset(reset));
	ALU_1bit alu_7(.A(dataA[6]), .B(dataB[6]), .Cin(Cout[6]), .sel(sel), .less(1'b0), .less_out(less[6]) , .Cout(Cout[7]), .dataOut(temp_out[6])  , .reset(reset));
	ALU_1bit alu_8(.A(dataA[7]), .B(dataB[7]), .Cin(Cout[7]), .sel(sel), .less(1'b0), .less_out(less[7]) , .Cout(Cout[8]), .dataOut(temp_out[7])  , .reset(reset));

	ALU_1bit alu_9(.A(dataA[8]), .B(dataB[8]), .Cin(Cout[8]), .sel(sel), .less(1'b0), .less_out(less[8]) , .Cout(Cout[9]), .dataOut(temp_out[8])  , .reset(reset));
	ALU_1bit alu_10(.A(dataA[9]), .B(dataB[9]), .Cin(Cout[9]), .sel(sel), .less(1'b0), .less_out(less[9]) , .Cout(Cout[10]), .dataOut(temp_out[9])  , .reset(reset));
	ALU_1bit alu_11(.A(dataA[10]), .B(dataB[10]), .Cin(Cout[10]), .sel(sel), .less(1'b0), .less_out(less[10]) , .Cout(Cout[11]), .dataOut(temp_out[10])  , .reset(reset));
	ALU_1bit alu_12(.A(dataA[11]), .B(dataB[11]), .Cin(Cout[11]), .sel(sel), .less(1'b0), .less_out(less[11]) , .Cout(Cout[12]), .dataOut(temp_out[11])  , .reset(reset));
	ALU_1bit alu_13(.A(dataA[12]), .B(dataB[12]), .Cin(Cout[12]), .sel(sel), .less(1'b0), .less_out(less[12]) , .Cout(Cout[13]), .dataOut(temp_out[12])  , .reset(reset));
	ALU_1bit alu_14(.A(dataA[13]), .B(dataB[13]), .Cin(Cout[13]), .sel(sel), .less(1'b0), .less_out(less[13]) , .Cout(Cout[14]), .dataOut(temp_out[13])  , .reset(reset));
	ALU_1bit alu_15(.A(dataA[14]), .B(dataB[14]), .Cin(Cout[14]), .sel(sel), .less(1'b0), .less_out(less[14]) , .Cout(Cout[15]), .dataOut(temp_out[14])  , .reset(reset));
	ALU_1bit alu_16(.A(dataA[15]), .B(dataB[15]), .Cin(Cout[15]), .sel(sel), .less(1'b0), .less_out(less[15]) , .Cout(Cout[16]), .dataOut(temp_out[15])  , .reset(reset));

	ALU_1bit alu_17(.A(dataA[16]), .B(dataB[16]), .Cin(Cout[16]), .sel(sel), .less(1'b0), .less_out(less[15]) , .Cout(Cout[17]), .dataOut(temp_out[16])  , .reset(reset));
	ALU_1bit alu_18(.A(dataA[17]), .B(dataB[17]), .Cin(Cout[17]), .sel(sel), .less(1'b0), .less_out(less[17]) , .Cout(Cout[18]), .dataOut(temp_out[17])  , .reset(reset));
	ALU_1bit alu_19(.A(dataA[18]), .B(dataB[18]), .Cin(Cout[18]), .sel(sel), .less(1'b0), .less_out(less[18]) , .Cout(Cout[19]), .dataOut(temp_out[18])  , .reset(reset));
	ALU_1bit alu_20(.A(dataA[19]), .B(dataB[19]), .Cin(Cout[19]), .sel(sel), .less(1'b0), .less_out(less[19]) , .Cout(Cout[20]), .dataOut(temp_out[19])  , .reset(reset));
	ALU_1bit alu_21(.A(dataA[20]), .B(dataB[20]), .Cin(Cout[20]), .sel(sel), .less(1'b0), .less_out(less[20]) , .Cout(Cout[21]), .dataOut(temp_out[20])  , .reset(reset));
	ALU_1bit alu_22(.A(dataA[21]), .B(dataB[21]), .Cin(Cout[21]), .sel(sel), .less(1'b0), .less_out(less[21]) , .Cout(Cout[22]), .dataOut(temp_out[21])  , .reset(reset));
	ALU_1bit alu_23(.A(dataA[22]), .B(dataB[22]), .Cin(Cout[22]), .sel(sel), .less(1'b0), .less_out(less[22]) , .Cout(Cout[23]), .dataOut(temp_out[22])  , .reset(reset));
	ALU_1bit alu_24(.A(dataA[23]), .B(dataB[23]), .Cin(Cout[23]), .sel(sel), .less(1'b0), .less_out(less[23]) , .Cout(Cout[24]), .dataOut(temp_out[23])  , .reset(reset));

	ALU_1bit alu_25(.A(dataA[24]), .B(dataB[24]), .Cin(Cout[24]), .sel(sel), .less(1'b0), .less_out(less[24]) , .Cout(Cout[25]), .dataOut(temp_out[24])  , .reset(reset));
	ALU_1bit alu_26(.A(dataA[25]), .B(dataB[25]), .Cin(Cout[25]), .sel(sel), .less(1'b0), .less_out(less[25]) , .Cout(Cout[26]), .dataOut(temp_out[25])  , .reset(reset));
	ALU_1bit alu_27(.A(dataA[26]), .B(dataB[26]), .Cin(Cout[26]), .sel(sel), .less(1'b0), .less_out(less[26]) , .Cout(Cout[27]), .dataOut(temp_out[26])  , .reset(reset));
	ALU_1bit alu_28(.A(dataA[27]), .B(dataB[27]), .Cin(Cout[27]), .sel(sel), .less(1'b0), .less_out(less[27]) , .Cout(Cout[28]), .dataOut(temp_out[27])  , .reset(reset));
	ALU_1bit alu_29(.A(dataA[28]), .B(dataB[28]), .Cin(Cout[28]), .sel(sel), .less(1'b0), .less_out(less[28]) , .Cout(Cout[29]), .dataOut(temp_out[28])  , .reset(reset));
	ALU_1bit alu_30(.A(dataA[29]), .B(dataB[29]), .Cin(Cout[29]), .sel(sel), .less(1'b0), .less_out(less[29]) , .Cout(Cout[30]), .dataOut(temp_out[29])  , .reset(reset));
	ALU_1bit alu_31(.A(dataA[30]), .B(dataB[30]), .Cin(Cout[30]), .sel(sel), .less(1'b0), .less_out(less[30]) , .Cout(Cout[31]), .dataOut(temp_out[30])  , .reset(reset));
	ALU_1bit alu_32(.A(dataA[31]), .B(dataB[31]), .Cin(Cout[31]), .sel(sel), .less(1'b0), .less_out(less[31]) , .Cout(overflow), .dataOut(temp_out[31])  , .reset(reset));
	
	
	Shifter Shifter( .A(dataB), .B(shamt_extd), .dataOut(ShifterOut), .Signal(Signal), .reset(reset) );

	// 如果reset = 1 ouput設為0
	assign dataOut = reset ? 32'd0 : ( Signal == AND || Signal == SUB || Signal == ADD || Signal == OR || Signal == SLT ) ? temp_out :( Signal == SLL ) ? ShifterOut : 32'd0;
	assign eq = ( dataA == dataB ) ? 1 : 0 ;
	assign ne = ( dataA != dataB ) ? 1 : 0 ;
endmodule 