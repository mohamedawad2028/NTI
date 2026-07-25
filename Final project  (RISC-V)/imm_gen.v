module imm_gen #(parameter WIDTH = 32)
(
    input  wire [WIDTH-1:0] instr,   // Instruction 32 bit
    output reg  [WIDTH-1:0] imm_out  // Immediate values 32 bit
);
    always @(*) begin
        case (instr[6:0])
            
            // I-Type (e.g., ADDI, LW, JALR)
            7'b0010011, 7'b0000011, 7'b1100111: begin
                imm_out = {{20{instr[31]}}, instr[31:20]};
            end

            //  (SW)
            7'b0100011: begin
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end

            // B-Type / SB-Type ( BEQ, BNE)
            7'b1100011: begin
                imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end

            // U-Type ( LUI)
            7'b0110111, 7'b0010111: begin
                imm_out = {instr[31:12], 12'b0};
            end

            //  ( JAL)
            7'b1101111: begin
        imm_out = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};     
       end

            // Default case
            default: begin
                imm_out = 32'b0;
            end
            
        endcase
    end

endmodule