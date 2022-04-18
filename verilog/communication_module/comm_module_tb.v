`include "communication_module.v"

module Top_tb();
  reg clk;
  reg reset;

  reg [7:0] din_temp;
  reg tx_start_temp;

  sample_ticker temp_ticker(clk, reset, s_tick);
  UART_tx temp(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start_temp),
    .d_in(din_temp),
    .s_tick(s_tick),
    .tx_done_flag(tx_done_temp),
    .tx(serial)
  );

  reg aes_ready;
  reg [127:0] ct_from_aes;

  wire [127:0] pt_to_aes;

  wire [127:0] newKey;
  wire key_write_en;

  comm final(clk, reset, serial, tx, aes_ready, aes_start, pt_to_aes, ct_from_aes, newKey, key_write_en);

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

    din_temp <= 8'hDE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hAD;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hBE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hEF;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hDE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hAD;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hBE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hEF;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hDE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hAD;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hBE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hEF;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hDE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hAD;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hBE;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

    din_temp <= 8'hEF;
    tx_start_temp <= 1;
    #10;
    tx_start_temp <= 0;
    #100000;

////////////////////

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

////////////////

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'hFF;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

din_temp <= 8'h00;
tx_start_temp <= 1;
#10;
tx_start_temp <= 0;
#100000;

aes_ready <= 1;
ct_from_aes <= 128'hdeadbeefdeadbeefdeadbeefdeadbeef;



    #1000000;
    $finish;
  end

endmodule
