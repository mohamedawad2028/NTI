module memory_tb2();
parameter AWIDTH=5;
parameter DWIDTH=8;
reg [AWIDTH-1:0] addr;
reg wr,rd,clk;
reg [DWIDTH-1:0]data_in;
wire [DWIDTH-1:0]data_out;


  assign data=rdata;

  memory memory_DUT(.clk(clk) , .wr(wr) , .rd(rd) , .addr(addr) , .data_in(data_in) , .data_out(data_out));

  task expect;
    input [DWIDTH-1:0] exp_data_out;
    if (data_out !== exp_data_out) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b", $time, addr, data);
      $display("data should be %b", exp_data_out);
      $finish;
    end
    else begin
      $timeformat(-9, 0,"ns", 4);
      $display("%t addr=%b, exp_data_out= %b, data=%b", $time, addr, exp_data_out, data);
   end
  endtask

////////////////////////////////////////////
//TO-DO: CODE THE WRITE TASK AS INSTRUCTED//
////////////////////////////////////////////
task write;
input [AWIDTH-1:0] addr;
input [DWIDTH-1:0] data;

begin
    wr = 1;
    rd = 0;
    memory_tb2.addr = addr;
    data_in = data;

    @(posedge clk);
    wr = 1'b0;
end
endtask 

////////////////////////////////////////////
//TO-DO: CODE THE READ TASK AS INSTRUCTED///
////////////////////////////////////////////
  task read;
input [AWIDTH-1:0] addr;
input [DWIDTH-1:0] exp_data_out;

begin
    wr = 1'b0;
    rd = 1'b1;
    memory_tb2.addr = addr;

    @(posedge clk);

    expect(exp_data_out);
    rd = 1'b0;
end
endtask



  
  initial repeat (67) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin : TEST
    reg [AWIDTH-1:0] addr;
    reg [DWIDTH-1:0] data;
       
    addr=-1; data=0;
    while ( addr ) begin
      write(addr,data);
      addr=addr-1;
      data=data+1;
    end
    addr=-1; data=0;
    while ( addr ) begin
      read(addr,data);
      addr=addr-1;
      data=data+1;
    end
    $display("TEST PASSED");
    $finish;
  end

endmodule



endmodule