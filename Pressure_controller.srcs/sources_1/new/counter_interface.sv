module counter_interface(
    input logic data_i,
    input logic done_i,
    input logic rst_n_i,
    input logic clk_i,
    output logic [3:0] pressure_o,
    output logic end_stb_o
    );
    
logic [3:0] counter;

always_ff @(posedge clk_i, negedge rst_n_i) begin
    if (done_i == 0) begin
        if (~rst_n_i) begin
            counter <= 0;
        end
        else begin
            if (data_i == 1) begin
                counter <= counter + 1;
            end
        end
    end else begin 
        pressure_o <= counter;
        counter <= 0;
        end_stb_o <= 1; //se semnaleaza finalizarea
    end
end    
    
endmodule
