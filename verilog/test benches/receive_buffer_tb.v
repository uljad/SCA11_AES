`timescale 1ns / 1ns
`include "receive_buffer.v"

module Top_tb();
  reg clk;
  reg [7:0] din;
  reg ready;
  reg reset;
  reg re;

  wire [127:0] dout;
  wire empty;
  wire of;

  rx_buff buffer(clk, din, ready, reset, re, dout, empty, of);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1;
    clk <= 0;
    reset <= 0;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b01010101;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b10101010;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70;

    din <= 8'b11110001;
    ready <= 1;
    #20;
    ready <= 0;
    #70; // read_index is 0

    re <= 1;
    #10;
    re <= 0; // read_index is 1

    #70

    re <= 1;
    #10;
    re <= 0; // read_index is 2

    #100;

    $finish;
  end
endmodule
