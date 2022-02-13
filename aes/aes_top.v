`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2022 03:25:44 PM
// Design Name: 
// Module Name: aes_top
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


module aes_top(
            input wire            clk,
            input wire            reset_n,

            input wire            init,
            input wire            next,
            
            output wire           ready,
            output wire           result_valid
    );
    
    reg [255:0] key = 256'h000102030405060708090a0b0c0d0e0f00000000000000000000000000000000;
    reg keylen = 1'h0; // 0 implies 128 bit key
    reg [127:0] pt_block = 128'h00112233445566778899aabbccddeeff;
    reg [127:0] ct_block = 0;
    wire [127:0] result_w;
    
    aes_core aes_core_inst
    (
        .clk(clk),
        .reset_n(reset_n),
    
        .init(init),
        .next(next),
        .ready(ready),
    
        .key(key),
        .keylen(keylen),

        .block(pt_block),
        .result(result_w),
        .result_valid(result_valid)
    );
    
    always @ (posedge clk)
    begin:update_result
    
        if (result_valid == 1'b1) 
            ct_block  <= result_w;
    end
    
endmodule
