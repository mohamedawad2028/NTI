`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 07:36:20 PM
// Design Name: 
// Module Name: Control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control_unit(
    input wire [6:0] opcode,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg MemtoReg,
    output reg ALUSrc,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALUOp
    );
    // Instruction Opcodes (7-bit) | opcode = instr[6:0]
	
    localparam 
	 OP_R_TYPE = 7'b0110011,
     OP_I_TYPE = 7'b0010011,
     OP_LOAD_LW   = 7'b0000011,
     OP_STORE_SW  = 7'b0100011,
     OP_BRANCH_B_TYPE = 7'b1100011,
     OP_LUI    = 7'b0110111,
     OP_JAL    = 7'b1101111,
     OP_JALR   = 7'b1100111,
	 
    // ALUOp Signals (2-bit) - From Control Unit to ALU Control
     ALUOP_MEM    = 2'b00, // LW/SW/JAL/JALR/ADDI I_TYPE (Force ADD)
     ALUOP_BRANCH = 2'b01, // Branches: BEQ/BNE (Force SUB)
     ALUOP_RTYPE  = 2'b10, // R-Type (Select From funct3 & funct7)
     ALUOP_LUI  = 2'b11; // LUI (Forces PASS B)
	 
	
	always@(*)
	begin
	RegWrite = 0;
	MemWrite = 0;
	MemRead =  0;
	MemtoReg = 0;
	ALUSrc =   0;
	Branch =   0;
	Jump =	   0;
	ALUOp =    2'b00;
	case(opcode)
	
		OP_R_TYPE: 
		begin
			RegWrite = 1;
			ALUOp = ALUOP_RTYPE;
			end 

		OP_I_TYPE:
		begin
			RegWrite = 1;
			ALUSrc = 1;
			ALUOp = ALUOP_MEM;
			end
		OP_LOAD_LW: 
		begin
			RegWrite = 1;
			ALUSrc =   1;
			MemRead =  1;
			MemtoReg = 1;
			ALUOp = ALUOP_MEM;
		
			end
		OP_STORE_SW:
		begin
			ALUSrc = 1;
			MemWrite =  1;
			ALUOp = ALUOP_MEM;
			end
 
		OP_BRANCH_B_TYPE: 
		begin
			Branch =  1;
			ALUOp = ALUOP_BRANCH;
			end
		OP_LUI:   
		begin
			RegWrite = 1;
			ALUSrc = 1;
			ALUOp = ALUOP_LUI;
		end
		OP_JAL:   
		begin
			RegWrite = 1;
			ALUSrc = 1;
			Jump=1;
			ALUOp = ALUOP_MEM;
			end
		OP_JALR: 
		begin
			RegWrite = 1;
			ALUSrc = 1;
			Jump=1;
			ALUOp = ALUOP_MEM;	
			end
		default: 
			begin
                RegWrite = 0;
                MemWrite = 0;
                MemRead  = 0;
                MemtoReg = 0;
                ALUSrc   = 0;
                Branch   = 0;
                Jump     = 0;
                ALUOp    = 2'b00;
            end
	endcase
	
	end
endmodule
