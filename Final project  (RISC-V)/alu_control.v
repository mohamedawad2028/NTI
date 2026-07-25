`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 07:36:20 PM
// Design Name: 
// Module Name: ALU_control
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


module ALU_control(
    input wire [1:0] ALUOp,
    input wire [2:0] funct3,
    input wire funct7_5,
    output reg [3:0] alu_ctrl
);
    localparam  
        // ***** ALUOP input from Control unit *****
        ALUOP_MEM    = 2'b00, // LW/SW/JAL/JALR/ADDI I_TYPE (Force ADD)
        ALUOP_BRANCH = 2'b01, // Branches: BEQ/BNE (Force SUB)
        ALUOP_RTYPE  = 2'b10, // R-Type (Select From funct3 & funct7)
        ALUOP_LUI    = 2'b11, // LUI (Forces PASS B)
        
        // ****** ALU CONTROL SIGNALS ***********
        ADD          = 4'b0000, // A + B  
        SUB          = 4'b0001, // A - B 
        XOR          = 4'b0010, // Bitwise logic
        OR           = 4'b0011,
        AND          = 4'b0100, 
        ALU_SRL      = 4'b0101, // Shift Right Logical
        ALU_SLL      = 4'b0110, // Shift Left Logical
        ALU_SLA      = 4'b1101, // Shift Left Arthematic
        XNOR         = 4'b0111, // XNOR 
        ALU_SLT      = 4'b1011, // Set Less Than
        ALU_SRA      = 4'b1100, // Shift Right Arthematic
        ALU_PASS_a   = 4'b1110, 
        ALU_PASS_b   = 4'b1111,
        
        // funct3 Signals - Most on R-Type
        ADD_SUB    = 3'b000, // ADD/SUB/ADDI/BEQ
        SHIFT_L    = 3'b001, // BNE/SLL/SLA
        SLT_FUNCT3 = 3'b010, // LW/SW/SLT
        XNOR_AB    = 3'b011, // XNOR
        XOR_AB     = 3'b100, // XOR
        SHIFT_R    = 3'b101, // SRL/SRA
        OR_AB      = 3'b110, // OR
        AND_AB     = 3'b111; // AND
 
    always @(*) begin
	
        alu_ctrl = 4'b0000; 
        
        case(ALUOp)
            ALUOP_MEM:      // LW/SW/JAL/JALR/ADDI I_TYPE (Force ADD)
                alu_ctrl = ADD;
                
            ALUOP_BRANCH:   // Branches: BEQ/BNE (Force SUB)
                alu_ctrl = SUB;
                
            ALUOP_RTYPE: begin // R-Type (Select From funct3 & funct7)
                case(funct3)
                    ADD_SUB: begin
                        if(!funct7_5)
                            alu_ctrl = ADD;
                        else 
                            alu_ctrl = SUB;
                    end
                    
                    SHIFT_L: begin // SLL/SLA
                        if(!funct7_5)
                            alu_ctrl = ALU_SLL;
                        else 
                            alu_ctrl = ALU_SLA;
                    end
                    
                    SLT_FUNCT3: // SLT
                        alu_ctrl = ALU_SLT;
                        
                    XNOR_AB:
                        alu_ctrl = XNOR;
                        
                    XOR_AB:
                        alu_ctrl = XOR;
                        
                    SHIFT_R: begin // SRL/SRA
                        if(!funct7_5)
                            alu_ctrl = ALU_SRL;
                        else 
                            alu_ctrl = ALU_SRA;
                    end
                    
                    OR_AB:
                        alu_ctrl = OR;
                        
                    AND_AB:
                        alu_ctrl = AND;
                        
                    default: 
                        alu_ctrl = 4'b0000;
                endcase
            end
            
            ALUOP_LUI:      // LUI ( PASS B)
                alu_ctrl = ALU_PASS_b;
                
            default: 
                alu_ctrl = 4'b0000;
        endcase
    end
endmodule