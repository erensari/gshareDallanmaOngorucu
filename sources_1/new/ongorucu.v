
module ongorucu(
    input clk,          
    input rst,          
    input [31:0] getir_ps,          
    input [31:0] getir_buyruk,      
    input getir_gecerli,            
    input [31:0] yurut_ps,          
    input [31:0] yurut_buyruk,      
    input yurut_dallan,             
    input [31:0] yurut_dallan_ps,   
    input yurut_gecerli,            
    output reg sonuc_dallan,        
    output reg [31:0] sonuc_dallan_ps
);
//gshare dallanma ongorucu

    localparam GECMIS_SAYACI_BITSAYISI = 9;
    localparam TAHMIN_TABLOSU_BOYUTU = 2 ** (GECMIS_SAYACI_BITSAYISI + 1);
    
    integer i = 0;
    reg tahmin_dallan;
    reg signed [31:0] imm;
    
    reg [1:0] tahmin_tablosu[0:TAHMIN_TABLOSU_BOYUTU-1]; 
    reg [GECMIS_SAYACI_BITSAYISI:0] gecmis_sayaci; 
    reg [GECMIS_SAYACI_BITSAYISI:0] index;
    reg [GECMIS_SAYACI_BITSAYISI:0] index_getir;
    
    
    
    initial begin
        for (i = 0; i < TAHMIN_TABLOSU_BOYUTU; i=i+1) begin
                tahmin_tablosu[i] <= 2'b10; // zayýf atlar
        end

    end
    
    always @(posedge rst) begin  
        for (i = 0; i < TAHMIN_TABLOSU_BOYUTU; i=i+1) begin
                tahmin_tablosu[i] <= 2'b10; // zayýf atlar
        end
        gecmis_sayaci <= 0;
        index <= 0;
        index_getir <= 0;
        tahmin_dallan <= 0;
        imm <= 0;
    end
    
    
    always @(*) begin
        if (yurut_gecerli) begin
            index <= yurut_ps[GECMIS_SAYACI_BITSAYISI:0] ^ gecmis_sayaci[GECMIS_SAYACI_BITSAYISI:0];
            
             if (tahmin_tablosu[index] == 2'b00) begin
                  if (yurut_dallan) begin
                    tahmin_tablosu[index] <= 2'b01;
                  end else begin
                    tahmin_tablosu[index] <= 2'b00;
                  end
                end else if (tahmin_tablosu[index] == 2'b01) begin
                  if (yurut_dallan) begin
                    tahmin_tablosu[index] <= 2'b10;
                  end else begin
                    tahmin_tablosu[index] <= 2'b00;
                  end
                end else if (tahmin_tablosu[index] == 2'b10) begin
                  if (yurut_dallan) begin
                    tahmin_tablosu[index] <= 2'b11;
                  end else begin
                    tahmin_tablosu[index] <= 2'b01;
                  end
                end else if (tahmin_tablosu[index] == 2'b11) begin
                  if (yurut_dallan) begin
                    tahmin_tablosu[index] <= 2'b11;
                  end else begin
                    tahmin_tablosu[index] <= 2'b10;
                  end
              end
    
            gecmis_sayaci <= {gecmis_sayaci[GECMIS_SAYACI_BITSAYISI-1:0], yurut_dallan};
        end
    end
    
    
    // Dallanma öngörüsü 
    always @(*) begin
        if (getir_gecerli) begin
            index_getir <= getir_ps[GECMIS_SAYACI_BITSAYISI:0] ^ gecmis_sayaci[GECMIS_SAYACI_BITSAYISI:0];
          
            if (tahmin_tablosu[index_getir] >= 2'b10) begin
                tahmin_dallan <= 1;
            end 
            else begin
                tahmin_dallan <= 0;
            end
            
            if (tahmin_dallan) begin
                imm = {{20{getir_buyruk[31]}},getir_buyruk[31],getir_buyruk[7],getir_buyruk[30:25],getir_buyruk[11:8],1'b0};
                sonuc_dallan_ps = getir_ps + imm;
                sonuc_dallan = 1;
            end
            else begin
                sonuc_dallan_ps = getir_ps + 4;
                sonuc_dallan = 0;
            end
        end
    end

endmodule
