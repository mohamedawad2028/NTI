module fsm_t();

reg a, b, clk, reset;
wire y0, y1;

fsm_2 ins (a, b, clk, reset, y0, y1);

always #1 clk = ~clk;

reg pre_y0;
reg pre_y1;

task gen_compare();
begin
    pre_y0 = y0;
    pre_y1 = y1;
    @(negedge clk)
    a = $random;
    b = $random;

    // mealy

    #1;

    if (y0 != pre_y0) begin
        $display("Time %0t Mealy output changed from %b to %b",$time, pre_y0, y0);
        pre_y0 = y0;
    end
    else
        $display("Time %0t Mealy output remains", $time);

    if (y1 != pre_y1) begin
        $display("Time %0t Moore output changed from %b to %b",$time, pre_y1, y1);
        pre_y1 = y1;
    end
    else
        $display("Time %0t Moore output remains", $time);

    //moore


    #1;

    if (y0 != pre_y0)
        $display("Time %0t Mealy output changed from %b to %b",$time, pre_y0, y0);
    else
        $display("Time %0t Mealy output remains", $time);

    if (y1 != pre_y1)
        $display("Time %0t Moore output changed from %b to %b",$time, pre_y1, y1);
    else
        $display("Time %0t Moore output remains", $time);

end
endtask

initial begin
    reset = 0;
    clk = 0;
    #10;

    reset = 1;
    repeat (20) begin
        gen_compare();
    end
    #10;

    $stop;
end

endmodule