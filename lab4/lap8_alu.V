module alu(in_a,in_b,opcode,alu_out,a_is_zero);
parameter N=8;  
input [N-1:0] in_a,in_b ;
input [2:0] opcode;
output reg[N-1:0] alu_out ;
output reg a_is_zero;

always @(*) begin
	if (~in_a)begin
		a_is_zero=1'b1;
	end
	else begin
		a_is_zero=1'b0;
    
    		case(opcode)
    		3'b000 : alu_out= in_a;             //HLT
    		3'b001 : alu_out= in_a;            //SKZ
    		3'b010 : alu_out=in_a + in_b ;     //ADD
    		3'b011 : alu_out= in_a & in_b;     //
    		3'b100 : alu_out=in_a ^ in_b ;
    		3'b101 : alu_out= in_b;	
    		3'b110 : alu_out= in_a;
    		3'b111 : alu_out=in_a ;			
     		default: alu_out=0 ;
     		endcase					
	end
end
endmodule