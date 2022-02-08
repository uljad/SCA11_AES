module control_block(
  input clk,
  input reset,
  input [127:0] d_in_rx,
  input rx_empty,
  output reg [127:0] d_out_aes,
  input [127:0] d_in_aes,
  output reg [127:0] d_out_tx,
  input tx_hasSpace,
  input aes_done,
  output reg aes_start
);

  reg state [1:0];
  reg state_next [1:0];

  reg [127:0] buffer;

  always @(reset) begin
    state <= 0;
    state_next <= 0;

    d_out_aes <= 0;
    d_out_tx <= 0;

    aes_start <= 0;
  end

  always @(posedge clk) begin
    state <= state_next;

    if(state == 0) begin    // idle state
      if(!rx_empty) begin
        d_out_aes <= d_in_rx;
        aes_start <= 1;
        state_next <= 1;
      end
    end

    if(state == 1) begin    // waiting state
      aes_start <= 0;
      if(aes_done) begin
        buffer <= d_in_aes;
        state_next <= 2;
      end else begin
        state_next <= 1;
      end
    end

    if(state == 2) begin    // returning state
      if(tx_hasSpace) begin
        d_out_tx <= buffer;
        // assert ready signal
        state_next <= 0;
      end else begin
        state_next <= 2;
      end
    end
  end
endmodule
