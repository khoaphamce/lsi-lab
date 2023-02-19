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

    always #5 clk = ~clk;

    initial begin
        
    end

    initial begin
        clk = 0;
        flick = 0;
        reset = 1;
        #100 flick = 1'b1;
        #50 flick = 1'b0;
        #450 flick = 1'b1;
        #400 flick = 1'b0;
        #50 flick = 1'b1;
        #250 flick = 1'b0;
        #100 flick = 1'b1;
        #100 flick = 1'b0;
        #100 flick = 1'b1;
        #100 flick = 1'b0;
        #200 flick = 1'b1;
        #100 flick = 1'b0;
        #50 flick = 1'b1;
        #100 flick = 1'b0;
        #300 
        assign flick = 1;
        #10
        repeat(5) @ (clk);
        #10
        assign flick = 0;
        #10
        repeat(70) @ (clk);
        #10
        assign flick = 1;
        #10
        repeat(90) @ (clk);
        #10
        assign flick = 0;
        #10
        assign flick = 0;
        #10
        repeat(90) @ (clk);
        #10
        assign flick = 1;
        #10
        repeat(90) @ (clk);
        $finish;
    end
endmodule