`default_nettype none

module bound_flash_tb;
reg clk;
reg flick;
wire [15:0] lamp;

bound_flash uut
(
    .clk (clk),
    .flick (flick),
    .lamp (lamp)
);
localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("bound_flash_tb.vcd");
    $dumpvars(0, bound_flash_tb);
end

initial begin
    #1 
    assign flick = 0;
    #1
    assign clk = 0;
    repeat(12) @(posedge clk);
    $stop;
end

endmodule