`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2022 10:03:24 PM
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_top();
    
    reg tb_clk;
    reg tb_reset = 1'b0;
    reg tb_init;
    reg tb_next;
    
    wire tb_ready;
    wire tb_result_valid;
    
    //DUT
    aes_top dut
    (
        .clk(tb_clk),
        .reset_n(tb_reset),
    
        .init(tb_init),
        .next(tb_next),
                
        .ready(tb_ready),
        .result_valid(tb_result_valid)
     );
     
     
     //Create clock
     initial
        begin
            tb_clk = 0;
            forever #5 tb_clk  = ~tb_clk;
        end
        
     initial
        begin
            #50 tb_reset = 1;
            
            tb_init = 1;
            @(posedge tb_clk);
            tb_init = 0;
            
            @(posedge tb_ready);
            tb_next = 1;
            repeat (2)
                @(posedge tb_clk);
            tb_next = 0;
            
            @(posedge tb_result_valid);
            repeat (2)
                @(posedge tb_clk);
            
           $finish;
               
        end
    
endmodule
