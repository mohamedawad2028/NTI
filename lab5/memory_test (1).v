module memory_test;

  localparam integer AWIDTH=5;
  localparam integer DWIDTH=8;

  reg               clk   ;
  reg               wr    ;
  reg               rd    ;
  reg  [AWIDTH-1:0] addr_reg  ;
  reg  [DWIDTH-1:0] data_in_dut ;
  wire [DWIDTH-1:0] data_out_dut  ;


  memory
  #(
    .Awidth ( AWIDTH ),
    .Dwidth ( DWIDTH ) 
   )
  memory_inst
   (
    .clk  ( clk  ),
    .wr   ( wr   ),
    .rd   ( rd   ),
    .addr ( addr_reg ),
    .data_in ( data_in_dut ),
    .data_out ( data_out_dut ) 
   );

  task expect;
    input [DWIDTH-1:0] exp_data;
    if (data_out_dut !== exp_data) begin
      $display("TEST FAILED");
      $display("At time %0d addr=%b data=%b", $time, addr_reg, data_out_dut);
      $display("data should be %b", exp_data);
      $finish;
    end
    else begin
      $timeformat(-9, 0,"ns", 4);
      $display("%t addr=%b, exp_data= %b, data=%b", $time, addr_reg, exp_data, data_out_dut);
   end
  endtask

task write;
 input [AWIDTH-1:0] addr ;
 input [DWIDTH-1:0] data_in;
  begin 
    wr=1;
    rd=0;
    addr_reg=addr;
    data_in_dut=data_in;
    @(posedge clk);
    wr=0;
  end
endtask  

task read;
 input [AWIDTH-1:0] addr ;
 output [DWIDTH-1:0] data_out;
  begin 
    wr=0;
    rd=1;
    addr_reg=addr;
    #1;
    data_out=data_out_dut;
  end
endtask  
  initial repeat (67) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin : TEST
    reg [AWIDTH-1:0] addr;
    reg [DWIDTH-1:0] data_in;
    reg [DWIDTH-1:0] data_out;

       
    addr=-1; data_in=0;
    while ( addr ) begin
      write(addr,data_in);
      addr=addr-1;
      data_in=data_in+1;
    end
    addr=-1; data_out=0;
    while ( addr ) begin
      read(addr,data_out);
      expect(data_out);
      addr=addr-1;
      data_out=data_out+1;
    end
    $display("TEST PASSED");
    $finish;
  end
endmodule
