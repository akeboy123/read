module mem_control
(
    input clk,
    input [7:0] addr,
    input read_en,

    output reg [7:0] data_out = 0,
    output reg [7:0] output_addr,
    output reg flag = 0
);

reg signed [1:0] i = 0;
reg [7:0] mem [15:0];
reg [7:0] buff [3:0];
reg [3:0] is_valid = 0;
reg [7:0] slct; 

integer j;
integer p;

initial
begin
    mem[0] = 8'd33;
    mem[1] = 14;
    mem[2] = 69;
    mem[3] = 11;
    mem[4] = 54;
    mem[5] = 47;
    mem[6] = 99;
    mem[7] = 96;
    mem[8] = 23;
    mem[9] = 1;
    mem[10] = 78;
    mem[11] = 52;
    mem[12] = 22;
    mem[13] = 13;
    mem[14] = 19;
    mem[15] = 17;
end

always @(posedge clk) 
    if (read_en)
    begin
        p=0;
        for (j=0; j < 4; j = j +1)
            if (is_valid[j] == 0)
                if (p == 0) 
                    begin
                        is_valid[j] <= 1;
                        buff[j] <= addr;
                        p=1;
                    end      
    end

always @(posedge clk)
begin
    p=0;
    flag = 0;
    for (j=0; j < 2; j = j +1)
    begin
        slct = $random%4;
        if (is_valid[slct])
            if (p==0)
                begin
                    data_out <= mem[buff[slct]];
                    p=1;
                    is_valid[slct] <= 0;
                    flag <= 1;
                    output_addr <= buff[slct];
                end    
    end
end


endmodule