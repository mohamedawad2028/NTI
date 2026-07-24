module controller ( phase , opcode , zero , sel , rd , ld_ir , halt , inc_pc , ld_ac , ld_pc , wr, data_e);

parameter INST_ADDR =3'b000;
parameter INST_FETCH=3'b001;
parameter INST_LOAD =3'b010;
parameter IDLE      =3'b011;
parameter OP_ADDR   =3'b100;
parameter OP_FETCH  =3'b101;
parameter ALU_OP    =3'b110;
parameter STORE     =3'b111;

    		// case(opcode)
    		// 3'b000 : alu_out= in_a;             //HLT
    		// 3'b001 : alu_out= in_a;            //SKZ
    		// 3'b010 : alu_out=in_a + in_b ;     //ADD
    		// 3'b011 : alu_out= in_a & in_b;     //AND
    		// 3'b100 : alu_out=in_a ^ in_b ;     //XOR
    		// 3'b101 : alu_out= in_b;	          //LDA 
    		// 3'b110 : alu_out= in_a;            //STO
    		// 3'b111 : alu_out=in_a ;			  //JMP
     		// endcase		

input [2:0] phase,opcode;
input zero;
output reg sel , rd , ld_ir , halt , inc_pc , ld_ac , ld_pc , wr, data_e;

always @(*) begin
	case(phase) 
		INST_ADDR:
		begin
			sel=1;
			rd=0;
			ld_ir=0;
			halt=0;
			inc_pc=0;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		INST_FETCH:
		begin
			sel=1;
			rd=1;
			ld_ir=0;
			halt=0;
			inc_pc=0;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		INST_LOAD:
		begin
			sel=1;
			rd=1;
			ld_ir=1;
			halt=0;
			inc_pc=0;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		IDLE:
		begin
			sel=1;
			rd=1;
			ld_ir=1;
			halt=0;
			inc_pc=0;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		OP_ADDR:
		begin
			sel=0;
			rd=0;
			ld_ir=0;
			if (opcode==3'b000) begin
				halt=1;
			end
			else begin
				halt=0;
			end
			inc_pc=1;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		OP_FETCH:
		begin
			sel=0;
			if (opcode==3'b010 || opcode==3'b011 || opcode==3'b100 || opcode==3'b101) begin  //ALUOP= 1 if opcode is ADD,AND,XOR or LDA//
				rd=1;
			end
			else begin
				rd=0;
			end
			ld_ir=0;
			halt=0;
			inc_pc=0;
			ld_ac=0;
			ld_pc=0;
			wr=0;
			data_e=0;
		end
		ALU_OP:
		begin
			sel=0;
			if (opcode==3'b010 || opcode==3'b011 || opcode==3'b100 || opcode==3'b101) begin  //ALUOP= 1 if opcode is ADD,AND,XOR or LDA//
				rd=1;
			end
			else begin
				rd=0;
			end
			ld_ir=0;
			halt=0;
			if (opcode==3'b001 && zero==1) begin
				inc_pc=1;
			end
			else begin
				inc_pc=0;
			end
			ld_ac=0;
			if (opcode==3'b111) begin
				ld_pc=1;
			end
			else begin
				ld_pc=0;
			end
			wr=0;
			if (opcode==3'b110) begin
				data_e=1;
			end
			else begin
				data_e=0;
			end
		end
		STORE:
		begin
			sel=0;
			if (opcode==3'b010 || opcode==3'b011 || opcode==3'b100 || opcode==3'b101) begin  //ALUOP= 1 if opcode is ADD,AND,XOR or LDA//
				rd=1;
			end
			else begin
				rd=0;
			end
			ld_ir=0;
			halt=0;
			inc_pc=0;
			sel=0;
			if (opcode==3'b010 || opcode==3'b011 || opcode==3'b100 || opcode==3'b101) begin  //ALUOP= 1 if opcode is ADD,AND,XOR or LDA//
				ld_ac=1;
			end
			else begin
				ld_ac=0;
			end

			if (opcode==3'b111) begin
				ld_pc=1;
			end
			else begin
				ld_pc=0;
			end
			if (opcode==3'b110) begin
				wr=1;
			end
			else begin
				wr=0;
			end			
			if (opcode==3'b110) begin
				data_e=1;
			end
			else begin
				data_e=0;
			end
		end
end
endmodule