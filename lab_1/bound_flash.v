module bound_flash(clk, flick, lamp);

input wire clk;
input wire flick;

output reg [15:0] lamp;

localparam s0 = 4'b0000;
localparam s1 = 4'b0001;
localparam s2 = 4'b0010;
localparam s3 = 4'b0011;
localparam s4 = 4'b0100;    
localparam s5 = 4'b0101;
localparam s6 = 4'b0110;
localparam s7 = 4'b0111;
localparam s8 = 4'b1000;
localparam s9 = 4'b1001;
localparam s10 = 4'b1010;

reg [3:0] state = 4'b0000;
reg [3:0] bit_shifted = 4'b0000;
reg [3:0] n_bit_shift = 4'b0000;

always @(posedge clk) begin
    // state 0
    if (state == s0) begin
        lamp <= 0;
        if (flick) begin
            state = s1;
            bit_shifted = 0;
            n_bit_shift = 5;
        end
    end
    // state 1
    else if (state == s1) begin
        if (bit_shifted < n_bit_shift)begin
            lamp <= (lamp << 1) + 1;
            bit_shifted <= bit_shifted + 1;
        end else begin
            state <= s2;
            bit_shifted <= 0;
            n_bit_shift <= 5;
        end
    end
    // state 2
    else if (state == s2) begin
        if (bit_shifted < n_bit_shift)begin
            lamp = lamp >> 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = s10;
            bit_shifted = 0;
            n_bit_shift = 5;
        end
    end
    // state 3
    else if (state == s3) begin
        if (bit_shifted < n_bit_shift)begin
            lamp = (lamp << 1) + 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = flick ? s4 : s5;
            bit_shifted = 0;
            n_bit_shift = (state == s4) ? 11 : 5;
        end
    end
    // state 4
    else if (state == s4) begin
        if (bit_shifted < n_bit_shift)begin
            lamp = lamp >> 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = s4;
        end
    end
    // state 5
    else if (state == s5) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = lamp >> 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = s6;
            bit_shifted = 0;
            n_bit_shift = 1;
        end
    end
    // state 6
    else if (state == s6) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = (lamp << 1) + 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = flick ? s7 : s9;
            bit_shifted = 0;
            n_bit_shift = (state == s7) ? 1 : 5;
        end
    end
    // state 7
    else if (state == s7) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = lamp >> 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = 6;
            bit_shifted = 0;
            n_bit_shift = 1;
        end
    end
    // state 8
    else if (state == s8) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = (lamp << 1) + 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = s0;
        end
    end
    // state 9
    else if (state == s9) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = (lamp << 1) + 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = flick ? s5 : s8;
            bit_shifted = 0;
            n_bit_shift = 6;
        end
    end
    // state 10
    else if (state == s10) begin
        if (bit_shifted < n_bit_shift) begin
            lamp = (lamp << 1) + 1;
            bit_shifted = bit_shifted + 1;
        end else begin
            state = flick ? s2 : s3;
            bit_shifted = 0;
            n_bit_shift = 6;
        end
    end
end

endmodule