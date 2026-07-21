module nvm_interface #(
    parameter int WordSize=128,
    parameter int AddrSize=24
)
(
    input logic clk,
    input logic rst_n,
    
    input logic data_ready,
    input logic[WordSize-1:0] Rdata_in,

    input logic W_req,
    input logic R_req,
    input logic[AddrSize-1:0] Addr_in,
    input logic[WordSize-1:0] Wdata_in,

    output logic W_enable,
    output logic req_out,
    output logic[AddrSize-1:0] Addr_out,
    output logic[WordSize-1:0] Wdata_out,

    output logic[WordSize-1:0] Rdata_out,
    output logic rvalid,
    output logic busy
);

logic req;

assign req = W_req || R_req;

always_ff@(posedge clk, negedge rst_n) begin
    if(!rst_n)begin
        W_enable <= 0';
        req_out <= 0';
        busy <= 0';
    end else begin
        W_enable <= W_req;
        req_out <= req;
        busy <= req || !data_ready;
    end
end

always_ff@(posedge clk, negedge rst_n) begin
    if(!rst_n)begin
        Addr_out <= 0';
        Wdata_out <= 0';
    end else if(!busy) begin
        Addr_out <= Addr_in;
        Wdata_out <= Wdata_in;
    end
end


always_ff@(posedge clk, negedge rst_n) begin
    if(!rst_n)begin
        Rdata_out <= 0';
        rvalid <= 0';
    end else if(data_ready) begin
        Rdata_out <= Rdata_in;
        rvalid <= 1'b1;
    end else begin
        rvalid <= 1'b0;
    end
end


endmodule 