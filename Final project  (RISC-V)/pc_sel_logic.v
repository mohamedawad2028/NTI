module pc_sel_logic (
input wire       branch,
input wire         jump,
input wire         inst,
input wire     zero_flg,
input wire  [2:0]funct3,
output reg  [1:0]   sel
);

wire         jalr;
wire          BEQ;
wire 		  BNE;
wire          jal;
wire taken_branch;
wire    cond_chck;

assign BEQ = ((funct3==3'b000)&(zero_flg));
assign BNE = ((funct3==3'b001)&(~zero_flg));
assign cond_chck = BEQ | BNE;
assign jal = jump&inst;
assign jalr = jump|(~inst);
assign taken_branch = branch&cond_chck;


always @ (*) begin
if (jalr) sel=2'b10;
else if((taken_branch)|(jal)) sel=2'b01;
else sel=2'b00;
end
endmodule