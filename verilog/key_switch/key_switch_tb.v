`timescale 1ns / 1ns
`include "key_switch.v"

module Top_tb();
  reg clk;
  reg reset;
  reg [127:0] block;
  reg write_en;

  wire [127:0] pt_block;
  wire pt_write;

  wire [127:0] key_block;
  wire key_write;

  keySelect select(
    .clk(clk),
    .reset(reset),

    .block(block),
    .write_en(write_en),

    .pt_block(pt_block),
    .pt_write(pt_write),

    .key_block(key_block),
    .key_write(key_write)
  );

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    clk <= 0;
    reset <= 0;
    #10;
    reset <= 1;

    block <= 128'h00112233445566778899AABBCCDDEEFF;
    write_en <= 1;
    #10;
    write_en <= 0;

    #50;

    block <= 128'hFFEEDDCCBBAA99887766554433221100;
    write_en <= 1;
    #10;
    write_en <= 0;

    #50;

    block <= 128'hDEADBEEFDEADBEEFDEADBEEFDEADBEEF;
    write_en <= 1;
    #10;
    write_en <= 0;

    #50;

    block <= 128'hFF00FF00FF00FF00FF00FF00FF00FF00;
    write_en <= 1;
    #10;
    write_en <= 0;

    #50;
    $finish;
  end
endmodule
