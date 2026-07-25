`timescale 1ns / 1ps

module top_tb();

    // Signal Declarations
    reg         clk;
    reg         rst_n;       
    wire [31:0] reg_data;  

    // DUT Instantiation
    RV32I_TOP DUT (
        .clk(clk),
        .rstn(rst_n),      
        .reg_data(reg_data) 
    );

    // Clock Generation
    initial 
    begin
        clk = 0;
        forever #5 clk = ~clk; 
    end
    
    // Program 1 (ALU & Shifts)
    task test_program1();
    begin
        $display("--------------------------------------------------");
        $display("Running Program 1: ALU & Shifts...");
        
        // Assert Reset
        rst_n = 0; 
        
        // Read from instruction memory (Updated extension)
        $readmemh("program1_alu.hex.txt", DUT.inst_memory_top.mem); 
        
        @(negedge clk)
        @(negedge clk)
        
         rst_n = 1; 
        
        repeat (20) @(negedge clk); 
        
        $display("Checking Arithmetic...");
        if (DUT.reg_file.mem[3] == 32'd15) $display("[PASS] ADD: x3 is 15.");
        else $display("[FAIL] ADD: x3 = %0d (Expected 15)", DUT.reg_file.mem[3]);
            
        if (DUT.reg_file.mem[4] == 32'd5) $display("[PASS] SUB: x4 is 5.");
        else $display("[FAIL] SUB: x4 = %0d (Expected 5)", DUT.reg_file.mem[4]);

        $display("Checking Logic...");
        if (DUT.reg_file.mem[5] == 32'd0) $display("[PASS] AND: x5 is 0.");
        else $display("[FAIL] AND: x5 = %0d (Expected 0)", DUT.reg_file.mem[5]);

        if (DUT.reg_file.mem[6] == 32'd15) $display("[PASS] OR: x6 is 15.");
        else $display("[FAIL] OR: x6 = %0d (Expected 15)", DUT.reg_file.mem[6]);

        if (DUT.reg_file.mem[7] == 32'd15) $display("[PASS] XOR: x7 is 15.");
        else $display("[FAIL] XOR: x7 = %0d (Expected 15)", DUT.reg_file.mem[7]);

        $display("Checking SLT...");
        if (DUT.reg_file.mem[8] == 32'd1) $display("[PASS] SLT: x8 is 1.");
        else $display("[FAIL] SLT: x8 = %0d (Expected 1)", DUT.reg_file.mem[8]);

        $display("Checking Shifts...");
        if (DUT.reg_file.mem[10] == 32'd10) $display("[PASS] SLL: x10 is 10.");
        else $display("[FAIL] SLL: x10 = %0d (Expected 10)", DUT.reg_file.mem[10]);

        if (DUT.reg_file.mem[11] == 32'd5) $display("[PASS] SRL: x11 is 5.");
        else $display("[FAIL] SRL: x11 = %0d (Expected 5)", DUT.reg_file.mem[11]);

        if (DUT.reg_file.mem[12] == 32'd5) $display("[PASS] SRA: x12 is 5.");
        else $display("[FAIL] SRA: x12 = %0d (Expected 5)", DUT.reg_file.mem[12]);
    end
    endtask 

    // Program 2 (Control Flow)
    task test_program2();
    begin
        $display("--------------------------------------------------");
        $display("Running Program 2: Control Flow (BEQ, BNE, JAL)...");
        
        rst_n = 0;

        // Read from instruction memory (Updated extension)
        $readmemh("program2_control.hex.txt", DUT.inst_memory_top.mem); 
        
        @(negedge clk)
        @(negedge clk)
        
         rst_n = 1;
        
        repeat (25) @(negedge clk); 
        
        if (DUT.reg_file.mem[4] == 32'd1) $display("[PASS] BEQ taken successfully.");
        else $display("[FAIL] BEQ failed. x4 = %0d", DUT.reg_file.mem[4]);

        if (DUT.reg_file.mem[5] == 32'd1) $display("[PASS] BNE taken successfully.");
        else $display("[FAIL] BNE failed. x5 = %0d", DUT.reg_file.mem[5]);

        if (DUT.reg_file.mem[7] == 32'd1) $display("[PASS] JAL taken successfully.");
        else $display("[FAIL] JAL failed. x7 = %0d", DUT.reg_file.mem[7]);
    end
    endtask

    // Program 3 (Memory Store/Load & LUI)
    task test_program3();
    begin
        $display("--------------------------------------------------");
        $display("Running Program 3: Memory & LUI...");
        
        rst_n = 0;

        // Read from instruction memory (Updated extension)
        $readmemh("program3_mem.hex.txt", DUT.inst_memory_top.mem); 
        
        @(negedge clk)
        @(negedge clk)
        
         rst_n = 1;
        
        repeat (100) @(negedge clk); 
        
        if (DUT.reg_file.mem[1] == 32'h00001000) $display("[PASS] LUI: x1 is 0x1000.");
        else $display("[FAIL] LUI: x1 = 0x%0h (Expected 0x1000)", DUT.reg_file.mem[1]);

        if (DUT.data_memory_top.mem[0] == 32'd100) $display("[PASS] SW: Memory Address 0 holds 100.");
        else $display("[FAIL] SW: MEM[0] = %0d (Expected 100)", DUT.data_memory_top.mem[0]);
            
        if (DUT.reg_file.mem[3] == 32'd100) $display("[PASS] LW: x3 successfully loaded 100.");
        else $display("[FAIL] LW: x3 = %0d (Expected 100)", DUT.reg_file.mem[3]);

        if (DUT.reg_file.mem[5] == 32'd24) $display("[PASS] JALR: x5 successfully set return address.");
        else $display("[FAIL] JALR: x5 = %0d (Expected 20)", DUT.reg_file.mem[5]);
    end
    endtask

    initial 
    begin
        test_program1();
        @(negedge clk);
        
        test_program2();
        repeat(2) @(negedge clk);
        
        test_program3();
        repeat(3) @(negedge clk);
        
        $display("--------------------------------------------------");
        $display("Verification Sequence Completed Successfully.");
        $stop; 
    end

endmodule