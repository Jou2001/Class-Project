/*
	Title:	ALU Control Unit
	Author: Garfield (Computer System and Architecture Lab, ICE, CYCU)
	Input Port
		1. ALUOp: 控制alu是要用+還是-或是其他指令
		2. Funct: 如果是其他指令則用這邊6碼判斷
	Output Port
		1. ALUOperation: 最後解碼完成之指令
*/

module ALU_ctl(ALUOp, Funct, ALUOperation);
    input [1:0] ALUOp;
    input [5:0] Funct;
    output [5:0] ALUOperation;
    reg    [5:0] ALUOperation;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_sll = 6'd00;
	parameter F_divu = 6'd27;
	parameter F_mfhi= 6'b010000;
	parameter F_mflo= 6'b010010;

    // symbolic constants for ALU Operations
    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;
	parameter ALU_sll = 3'b101 ;
	parameter ALU_divu = 3'b100 ;

    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = F_add;
            2'b01 : ALUOperation = F_sub;
			2'b11 : ALUOperation = F_or ;		// 為了ori
            2'b10 : case (Funct) 
                        F_add : ALUOperation = F_add;
                        F_sub : ALUOperation = F_sub;
                        F_and : ALUOperation = F_and;
                        F_or  : ALUOperation = F_or;
                        F_slt : ALUOperation = F_slt;
						F_sll : ALUOperation = F_sll ;
						F_divu : ALUOperation = F_divu ;
						F_mfhi : ALUOperation = F_mfhi ;
						F_mflo : ALUOperation = F_mflo ;
                        default ALUOperation = 6'bxxxxxx;
                    endcase
            default ALUOperation = 6'bxxxxxx;
        endcase
    end
endmodule

