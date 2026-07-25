module RV32I_TOP (
input  wire               clk,
input  wire              rstn,
output wire   [31:0] reg_data
);

wire [31:0]          oprand1;
wire [31:0]          oprand2;
wire  [3:0]           opcode;
wire [31:0]       alu_result;
wire               zero_flag;

wire [31:0] data_memory_read;

wire [31:0]   mem_to_reg_out;
wire [31:0]       immGen_out; // offset

wire [31:0]           pcNext;
wire [31:0]            pcOut;

wire [31:0]         pc_plus4;
wire [31:0]    branch_target;
wire [31:0]         JALR_out;
wire [31:0]         in3_garb = 'b0;
wire  [1:0]           pc_sel;


wire [31:0]              rs1;
wire [31:0]              rs2;
wire [31:0]      instruction;

wire  [1:0]           ALU_OP;


wire               jump_ctrl;
wire             branch_ctrl;
wire         mem_to_reg_ctrl;
wire          mem_wirte_ctrl;
wire           mem_read_ctrl;
wire             aluSrc_ctrl;
wire           regWrite_ctrl;


assign reg_data = alu_result;


adder pc_plus4Adder ( .in1(pcOut), .in2(4), .sum(pc_plus4));

adder JAL ( .in1(pcOut), .in2(immGen_out), .sum(branch_target));

adder JALR ( .in1(rs1), .in2(immGen_out), .sum(JALR_out));

pc_sel_logic src_sel ( .branch(branch_ctrl), .jump(jump_ctrl), .inst(instruction[3]), .zero_flg(zero_flag), .funct3(instruction[14:12]), .sel(pc_sel));

MUX32_2 pcSrc_mux ( .in0(pc_plus4), .in1(branch_target), .in2(JALR_out), .in3(in3_garb), .sel(pc_sel), .out(pcNext));

MUX32 MemToReg ( .in0(alu_result), .in1(data_memory_read), .sel(mem_to_reg_ctrl),.out(mem_to_reg_out));

data_memory data_memory_top ( .clk(clk), .rst_n(rstn), .addr(alu_result), .write_data(rs2), .MemWrite(mem_wirte_ctrl) , .MemRead(mem_read_ctrl), .read_data(data_memory_read));

ALU alu_top ( .a(oprand1) , .b(oprand2) , .alu_ctrl(opcode) , .result(alu_result) , .zero(zero_flag));

MUX32 ALUSrc2 ( .in0(rs1), .in1(pcOut), .sel(aluSrc_ctrl),.out(oprand1));

MUX32 ALUSrc1 ( .in0(rs2), .in1(immGen_out), .sel(aluSrc_ctrl),.out(oprand2));

imm_gen immGen_top( .instr(instruction),  .imm_out(immGen_out));

register reg_file ( .clk(clk) , .rd1_addr(instruction[19:15]) , .rd2_addr(instruction[24:20]) , .wr_addr(instruction[11:7]) , .wr_data(mem_to_reg_out) , .wr_en(regWrite_ctrl) , .rd1_data(rs1) , .rd2_data(rs2));

instr_memory inst_memory_top ( .addr(pcOut), .instr(instruction));

program_counter PC_TOP ( .clk(clk), .rstn(rstn), .pc_next(pcNext), .pc_out(pcOut));

Control_unit ctrlUnit_top ( .opcode(instruction[6:0]), .RegWrite(regWrite_ctrl),.MemWrite(mem_wirte_ctrl), .MemRead(mem_read_ctrl), .MemtoReg(mem_to_reg_ctrl), .ALUSrc(aluSrc_ctrl),.Branch(branch_ctrl), .Jump(jump_ctrl), .ALUOp(ALU_OP));

ALU_control alu_ctrl ( .ALUOp(ALU_OP), .funct3(instruction[14:12]), .funct7_5(instruction[30]), .alu_ctrl(opcode));


endmodule