module bound_flasher_tb;
    reg clk;
    reg flick;
    reg reset;
    wire [15:0] lamp;

    bound_flasher uut
    (
        .clk (clk),
        .flick (flick),
        .reset(reset),
        .lamp (lamp)
    );

    initial begin
        $dumpfile("bound_flash_tb.vcd");
        $dumpvars(0, bound_flasher_tb);
    end

    initial begin
        clk = 0;
        reset = 1;
    end

    always #10 clk = ~clk;

    initial begin
        #10 
        reset = 0;
        #10
        assign flick = 1;
        #10
        repeat(20) @ (clk);
        #10
        assign flick = 0;
        #10
        repeat(90) @ (clk);
        #10
        assign flick = 1;
        #10
        repeat(90) @ (clk);
        #10
        assign reset = 1;
        #10
        assign reset = 0;
        repeat(90) @ (clk);
        $finish;
    end
endmodule