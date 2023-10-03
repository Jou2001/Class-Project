module mips_pipeline(clk, rst) ;
	input clk, rst ;
	wire [31:0] ALUOut, HiOut, LoOut ;
	wire [31:0] dataOut ;
	wire [63:0] DivAns ;
	wire[31:0] instr, extend_immed ;
	
	wire [31:0] pc, nor_pc, pc_next, b_tgt_out, branch_nor, jump_addr, ex_pc, b_tgt ;
    wire [31:0] ID_newPC, ID_instr, RD1, RD2, wb_wd, ex_RD1, ex_RD2, ex_immed ;
	
	wire [4:0] wb_dst_out, ex_Rd, ex_Rt, reg_dst, mem_reg_dst, Rt, Rs, Rd, shamt, shamt_out ;
	
	wire [31:0] immed_sl2, ALU_op2, ALU_result, mem_ALU_result, mem_WD, mem_rd, wb_RD, wb_ALU_result ;
	wire [5:0] Signal ; 
	
	wire PCSrc, RegWrite, RegDst, ALUsrc, eq, ne, MemRead, MemWrite, MemtoReg, EQ_NE, branch, mem_eq, mem_ne, eq_ne_result, Jump;
	wire [5:0] opcode, funct ;
	
	wire [1:0] WB_ctl, ex_WB, ALUop, mem_WB ; 
	wire [3:0]	MEM_ctl, EX_ctl, ex_MEM ;
	
    wire [25:0] jumpoffset;
	
	assign opcode = ID_instr[31:26] ;
	assign Rs = ID_instr[25:21] ;
	assign Rt = ID_instr[20:16] ;
	assign Rd = ID_instr[15:11] ;
	assign shamt = ID_instr[10:6] ;
	assign funct = ID_instr[5:0] ;

	assign jumpoffset = instr[25:0];
	assign Jump = ( instr[31:26] == 6'd2 ) ? 1 : 0 ;
	
	assign jump_addr = { nor_pc[31:28], jumpoffset << 2 };
	
	PC pc1( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) ) ;
	
	memory InstrMem( .clk(clk), .MemRead( 1'b1 ), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) ) ;
	
	add pcAdd( .a(pc), .b(32'd4), .result(nor_pc) ) ;
	
    Mux2 PCMUX( .sel(PCSrc), .cur(nor_pc), .next(b_tgt_out), .out(branch_nor) );
	
	Mux2 JMUX( .sel(Jump), .cur(branch_nor), .next(jump_addr), .out(pc_next) );	
	
	IF_ID_reg if_id_reg( .rd_out(ID_instr), .newPC_out(ID_newPC), .rd_in(instr), .newPC_in(nor_pc), .clk(clk), .rst(rst) ) ;  
	

	control Control( .opcode(ID_instr[31:26]), .EX_ctl(EX_ctl), .MEM_ctl(MEM_ctl), .WB_ctl(WB_ctl) ) ;
	
	reg_file reg_file( .clk(clk), .RegWrite(RegWrite), .RN1(ID_instr[25:21]), .RN2(ID_instr[20:16]), .WN(wb_dst_out), .WD(wb_wd), .RD1(RD1), .RD2(RD2) ) ;
	
	extend Extend( .immed(ID_instr[15:0]), .opcode(ID_instr[31:26]), .ext_immed_out(extend_immed) ) ;
	
	ID_EX_reg id_ex_reg( .WB_ctl_in(WB_ctl), .MEM_ctl_in(MEM_ctl), .EX_ctl_in(EX_ctl), .pc_in(ID_newPC), .RD1_in(RD1), .RD2_in(RD2), .immed_exted_in(extend_immed), .Rt_in(ID_instr[20:16]), .Rd_in(ID_instr[15:11]), .shamt(shamt), .clk(clk), .rst(rst), .WB_ctl_out(ex_WB), .MEM_ctl_out(ex_MEM), .ALUop(ALUop), .ALUsrc(ALUsrc), .RegDst(RegDst), .pc_out(ex_pc), .RD1_out(ex_RD1), .RD2_out(ex_RD2), .immed_exted_out(ex_immed), .Rt_out(ex_Rt), .Rd_out(ex_Rd), .shamt_out(shamt_out) ) ;
	
	assign immed_sl2 = ex_immed << 2 ;	
	
	add branAdd(.a(ex_pc), .b(immed_sl2), .result(b_tgt) ) ;
	
	Mux2 ALUsrcMux( .out(ALU_op2), .cur(ex_RD2), .next(ex_immed), .sel(ALUsrc) ) ;
	
	ALU_ctl ALUControl( .ALUOp(ALUop), .Funct(ex_immed[5:0]), .ALUOperation(Signal) ) ;
	
	// ALU
	ALU ALU( .dataA(ex_RD1), .dataB(ALU_op2), .Signal(Signal), .dataOut(ALUOut), .shamt(shamt_out),.reset(rst), .eq(eq), .ne(ne) );
	
	// Divider
	Divider Divider( .clk(clk), .dataA(ex_RD1), .dataB(ALU_op2), .Signal(Signal), .dataOut(DivAns), .reset(rst) );
	
	// HiLo
	HiLo HiLo( .clk(clk), .DivAns(DivAns), .HiOut(HiOut), .LoOut(LoOut), .reset(rst) );
	
	// MUX
	MUX MUX( .ALUOut(ALUOut), .HiOut(HiOut), .LoOut(LoOut), .Signal(Signal), .dataOut(ALU_result) );
	
	Mux5 RegDstMux( .out(reg_dst), .cur(ex_Rt), .next(ex_Rd), .sel(RegDst) ) ;
	
	EX_MEM_reg ex_mem_reg( .WB_ctl_in(ex_WB), .MEM_ctl_in(ex_MEM), .bran_PC(b_tgt), .eq_in(eq), .ne_in(ne), .ALU_result(ALU_result), .RD2_in(ex_RD2), .reg_dst(reg_dst), .clk(clk), .rst(rst), .WB_ctl_out(mem_WB), .MEMRead(MemRead), .MEMWrite(MemWrite), .Branch(branch), .bran_PC_out(b_tgt_out), .EQ_NE(eq_ne), .eq_out(mem_eq), .ne_out(mem_ne), .ALU_result_out(mem_ALU_result), .WD(mem_WD), .reg_dst_out(mem_reg_dst) ) ;
	
	Mux2to1 eq_neMux( .out(eq_ne_result), .cur(mem_ne), .next(mem_eq), .sel(eq_ne) ) ;
	
	and br_nor( PCSrc, branch, eq_ne_result ) ;
	
	memory dataMEM( .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(mem_WD), .addr(mem_ALU_result), .rd(mem_rd) ) ;
	
	MEM_WB_reg mem_wb_reg( .WB_ctl_in(mem_WB), .RD_in(mem_rd), .ALU_result_in( mem_ALU_result), .regdst_in(mem_reg_dst), .clk(clk), .rst(rst), .RegWrite(RegWrite), .MEMtoReg(MEMtoReg), .RD_out(wb_RD), .ALU_result_out(wb_ALU_result), .regdst_out(wb_dst_out) ) ;
	
	Mux2 mem2reg( .out(wb_wd), .cur(wb_RD), .next(wb_ALU_result), .sel(MEMtoReg) ) ;
	
endmodule