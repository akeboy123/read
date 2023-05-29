module tb;
    reg clk = 0;
    reg read_en = 0;

    reg [7:0] addr;

    initial 
    begin
        forever #20 clk = ~clk; 
    end

    initial
    begin
        #10
        addr = 8'd2;
        #40
        addr = 8'd11;
        #40
        addr = 8'd1;
        #40
        addr = 8'd13;
        #20
        read_en = 1;
    end

    initial
    begin
        #10
        read_en = 1;
        #20
        read_en = 0;
        #20
        read_en = 1;
        #20
        read_en = 0;
        #20
        read_en = 1;
        #20
        read_en = 0;
        #20
        read_en = 1;
        #20
        read_en = 0;
    end

    initial
    begin
        #500 $finish;
    end

    initial
    begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    mem_control mem0 (
        .clk(clk),
        .read_en(read_en),
        .addr(addr)
    );

endmodule
