module test();

logic data_i;
logic ready_i;
logic rst_n_i;
logic clk_i;
logic led_0_o, led_1_o, led_2_o;
logic test_i;

top DUT (
    .data_i (data_i),
    .ready_i (ready-i),
    .rst_n_i (rst_n_i),
    .clk_i (clk_i),
    .led_0_o (led_0_o),
    .led_1_o (led_1_o),
    .led_2_o (led_2_o),
    .test_i (test_i) 
);

initial begin
    clk_i = 0;
    forever #1 clk_i = ~clk_i;
end

initial begin
    rst_n_i = 0;
    ready_i = 0;
    data_i = 1;
#2  data_i = 0;
#2  data_i = 1;
#2  data_i = 0;
#2  data_i = 1;
#2  data_i = 0;
#5  ready_i = 1;
#6  ready_i = 0;
#20 $stop;
end


endmodule
