module syncro(
    input logic input_signal,
    input logic clock_signal,
    input logic reset_signal,
    output logic sync_sig
    );

logic stage1;
logic stage2;

always_ff @(posedge clock_signal, negedge reset_signal) begin
    if (~reset_signal) begin
        stage1 <= 0;
        stage2 <= 2;
    end
    else begin
        stage1 <= input_signal;
        stage2 <= stage1;
    end
end   

always_ff @(posedge clock_signal, negedge reset_signal) begin
    if (~reset_signal) begin
        sync_sig <= 0;
    end
    else begin
        sync_sig <= stage2;
    end
end 
    
endmodule
