module top(
    input logic data_i,
    input logic ready_i,
    input logic rst_n_i,
    input logic clk_i,
    output logic led_0_o, led_1_o, led_2_o,
    input logic test_i
    );
    
logic data_del1_s, data_sync_s;
logic ready_del1_s, ready_sync_s;
logic [3:0] pressure_stb_s;
logic start_stb_s;
logic test_del1_s, test_sync_s;    
    
re_det data_detector (
    .input_signal (data_i),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .re_detected (data_del1_s)
);

syncro data_sync (
    .input_signal (data_del1_s),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .sync_sig (data_sync_s)
);

re_det ready_detector (
    .input_signal (ready_i),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .re_detected (ready_del1_s)
);

syncro ready_sync (
    .input_signal (ready_del1_s),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .sync_sig (ready_sync_s)
);
re_det test_detector (
    .input_signal (test_i),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .re_detected (test_del1_s)
);

syncro test_sync (
    .input_signal (test_del1_s),
    .clock_signal (clk_i),
    .reset_signal (rst_i),
    .sync_sig (test_sync_s)
);  

counter_interface counter (
    .data_i (data_sync_s),
    .done_i (ready_sync_s),
    .rst_n_i (rst_n_i),
    .clk_i (clk_i),
    .pressure_o (pressure_stb_s),
    .end_stb_o (start_stb_s)
);

pressure_controller contr (
    .clk (clk_i),
    .rst (rst_i),
    .pressure_i (pressure_stb_s),
    .start_stb_i (start_stb_s),
    .testmode (test_sync_s),
    .captured_o (led_0_o),
    .stable_flag_o (led_1_o),
    .test_flag_o (led_2_o)
);
  
    
endmodule
