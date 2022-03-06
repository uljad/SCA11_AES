module control_block(
  // board signals
  input clk,
  input reset,

  // rx_buffer signals
  input [127:0] pt,       // incoming aes block
  input rx_empty,         // to know if there is data to encrypt
  output reg rx_read,     // tells the buffer to output the next block

  // tx_buffer signals
  input tx_overflow,      // determines if the tx_buffer has space
  output reg tx_write,    // writes ct to the tx_buffer
  output reg [127:0] ct,  // cipher text written to the tx_buffer

  // aes signals
  input aes_ready,              // shows us when aes module is idle OR done with previous encryption operation
  output reg aes_start,         // trigger to start encryption
  output reg [127:0] pt_to_aes, // plaintext sent to aes
  input [127:0] ct_from_aes     // cipher text we get back from aes
);

  reg [1:0] state;
  reg [1:0] state_next;

  always @(posedge clk) begin
    if(!reset) begin
      rx_read <= 0;

      tx_write <= 0;
      ct <= 0;

      aes_start <= 0;
      pt_to_aes <= 0;

      state <= 0;
      state_next <= 0;
    end
    else begin
      state <= state_next;
      aes_start <= 0;
      tx_write <= 0;
      rx_read <= 0;

      if(state == 0) begin  // idle state
        if(!rx_empty) begin
          pt_to_aes <= pt;
          rx_read <= 1;
          state_next <= 1;
        end
      end

      if(state == 1) begin  // loading state
        if(aes_ready) begin
          aes_start <= 1;
          state_next <= 2;
        end
      end

      if(state == 2) begin  // wait for encryption to be done state
        if(aes_ready) begin
          ct <= ct_from_aes;
          state_next <= 3;
        end
      end

      if(state == 3) begin  // send data to tx_buffer and go back to idle state...state
        if(!tx_overflow) begin
          tx_write <= 1;
          state_next <= 0;
        end
      end
    end
  end

endmodule
