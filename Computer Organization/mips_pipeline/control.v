/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. opcode: 輸入的指令代號，據此產生對應的控制訊號
	Input Port
		1. RegDst: 控制RFMUX
		2. ALUSrc: 控制ALUMUX
		3. MemtoReg: 控制WRMUX
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
*/
module control( opcode, EX_ctl, MEM_ctl, WB_ctl);
    input[5:0] opcode;
    output reg [3:0] EX_ctl ;		
	output reg [3:0] MEM_ctl ;      		// MEM_ctl ::: beq(1) or bne(0), branch, memRead, memWrite
    output reg [1:0] WB_ctl ;
	
    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
	parameter BNE = 6'd5 ;
	parameter J = 6'd2;
	parameter ORI = 6'd13;

    always @( opcode ) begin
        case ( opcode )
          R_FORMAT :  
          begin
				EX_ctl = 4'b1100; MEM_ctl = 4'bx000; WB_ctl = 2'b11 ; 
          end
		  
          LW :		
          begin
				EX_ctl = 4'b0001 ; MEM_ctl = 4'bx010 ; WB_ctl = 2'b10 ;
          end
		  
          SW :		
          begin
				EX_ctl = 4'bx001 ; MEM_ctl = 4'bx001 ; WB_ctl = 2'b0x ;
          end
		  
          BEQ :		
          begin
				EX_ctl = 4'bx010 ; MEM_ctl = 4'b1100 ; WB_ctl = 2'b0x ;
          end

          BNE :		
          begin
				EX_ctl = 4'bx010 ; MEM_ctl = 4'b0100 ; WB_ctl = 2'b0x ;
          end
		  
		  J :		
		  begin
				EX_ctl = 4'bx010 ; MEM_ctl = 4'bx000 ; WB_ctl = 2'b0x ;
		  end
		  
		  ORI :		
		  begin 
				EX_ctl = 4'b0111 ; MEM_ctl = 4'bx000 ; WB_ctl = 2'b11 ; 
		  end 
		  
          default
          begin
				$display("control_single unimplemented opcode %d", opcode);
				EX_ctl = 4'bxxxx ; MEM_ctl = 4'bxxxx ; WB_ctl = 2'bxx ; 

          end

        endcase
    end
endmodule