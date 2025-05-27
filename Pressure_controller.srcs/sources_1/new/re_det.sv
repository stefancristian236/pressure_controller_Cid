module re_det(
    input logic input_signal,
    input logic clock_signal,
    input logic reset_signal,
    output logic re_detected
    );
    
logic prev_sig;

always_ff @(posedge clock_signal, negedge reset_signal) begin
    if (~reset_signal) begin
        re_detected <= 0;
    end
    else begin
        prev_sig <= input_signal;
        re_detected <= (prev_sig == 0) && (input_signal == 1); // pt re
    end
end
    
    
endmodule
