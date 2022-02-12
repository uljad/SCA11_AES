`timescale 1ns / 1ns
`include "rx_shift.v"

module Top_tb();
  reg clk;
  reg reset;
  reg [7:0] d_in;
  reg rx_done;
  wire [127:0] d_out;
  wire shift_done;

  rx_shift shifter(clk, reset, d_in, rx_done, d_out, shift_done);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1;
    clk <= 0;

    #80;

    d_in <= 8'h22;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h11;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h22;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h33;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h44;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h55;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h66;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h77;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h88;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h99;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hAA;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hBB;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hCC;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hDD;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hEE;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hFF;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hFF;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hEE;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hDD;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hCC;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hBB;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'hAA;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h99;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h88;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h77;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h66;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h55;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h44;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h33;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h22;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h11;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h00;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h00;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h00;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80

    d_in <= 8'h00;
    rx_done <= 1;
    #10;
    rx_done <= 0;
    #80
    $finish;
    end
endmodule
