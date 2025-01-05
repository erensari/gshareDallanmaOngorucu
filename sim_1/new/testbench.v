`timescale 1ns / 1ns

module testbench;

reg clk;
reg rst;
reg [31:0] getir_ps;
reg [31:0] getir_buyruk;
reg getir_gecerli;
reg [31:0] yurut_ps;
reg [31:0] yurut_buyruk;
reg yurut_dallan;
reg [31:0] yurut_dallan_ps;
reg yurut_gecerli;

wire sonuc_dallan;
wire [31:0] sonuc_dallan_ps;

// �ng�r�c�y� �a��r
ongorucu ongorucu(
    .clk(clk),
    .rst(rst),
    .getir_ps(getir_ps),
    .getir_buyruk(getir_buyruk),
    .getir_gecerli(getir_gecerli),
    .yurut_ps(yurut_ps),
    .yurut_buyruk(yurut_buyruk),
    .yurut_dallan(yurut_dallan),
    .yurut_dallan_ps(yurut_dallan_ps),
    .yurut_gecerli(yurut_gecerli),
    .sonuc_dallan(sonuc_dallan),
    .sonuc_dallan_ps(sonuc_dallan_ps)
);

// Sim�lasyon i�in zamanlama
initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);

    // Saat sinyalini ba�lat
    clk = 0;
    rst = 1;
    getir_ps = 0;
    getir_buyruk = 0;
    getir_gecerli = 0;
    yurut_ps = 0;
    yurut_buyruk = 0;
    yurut_dallan = 0;
    yurut_dallan_ps = 0;
    yurut_gecerli = 0;

    // Reset sinyalini uygula
    #10 rst = 0;

    // Senaryo 1: �ng�r� do�ru, y�r�tme sonucu do�ru
    #10;
    $display("Senaryo 1: �ng�r� do�ru, y�r�tme sonucu do�ru");
    getir_ps = 32'h100;
    getir_buyruk = 32'h1234;
    getir_gecerli = 1;
    yurut_ps = 32'h100;
    yurut_buyruk = 32'h1234;
    yurut_dallan = 1;
    yurut_dallan_ps = 32'h104;
    yurut_gecerli = 1;
    #10;
    $display("Beklenen ��kt�: Dallanma �ng�r�s�: 1, Atlanacak Adres: 00000104");
    $display("Ger�ekle�en ��kt�: Dallanma �ng�r�s�: %b, Atlanacak Adres: %h", sonuc_dallan, sonuc_dallan_ps);

    // Senaryo 2: �ng�r� yanl��, y�r�tme sonucu do�ru
    #10;
    $display("Senaryo 2: �ng�r� yanl��, y�r�tme sonucu do�ru");
    getir_ps = 32'h200;
    getir_buyruk = 32'h5678;
    getir_gecerli = 1;
    yurut_ps = 32'h200;
    yurut_buyruk = 32'h5678;
    yurut_dallan = 1;
    yurut_dallan_ps = 32'h204;
    yurut_gecerli = 1;
    #10;
    $display("Beklenen ��kt�: Dallanma �ng�r�s�: 0, Atlanacak Adres: 00000204");
    $display("Ger�ekle�en ��kt�: Dallanma �ng�r�s�: %b, Atlanacak Adres: %h", sonuc_dallan, sonuc_dallan_ps);

    // Senaryo 3: �ng�r� do�ru, y�r�tme sonucu yanl��
    #10;
    $display("Senaryo 3: �ng�r� do�ru, y�r�tme sonucu yanl��");
    getir_ps = 32'h300;
    getir_buyruk = 32'h9ABC;
    getir_gecerli = 1;
    yurut_ps = 32'h300;
    yurut_buyruk = 32'h9ABC;
    yurut_dallan = 0;
    yurut_dallan_ps = 32'h308;
    yurut_gecerli = 1;
    #10;
    $display("Beklenen ��kt�: Dallanma �ng�r�s�: 1, Atlanacak Adres: 00000308");
    $display("Ger�ekle�en ��kt�: Dallanma �ng�r�s�: %b, Atlanacak Adres: %h", sonuc_dallan, sonuc_dallan_ps);

    // Senaryo 4: �ng�r� yanl��, y�r�tme sonucu yanl��
    #10;
    $display("Senaryo 4: �ng�r� yanl��, y�r�tme sonucu yanl��");
    getir_ps = 32'h400;
    getir_buyruk = 32'hDEAD;
    getir_gecerli = 1;
    yurut_ps = 32'h400;
    yurut_buyruk = 32'hDEAD;
    yurut_dallan = 0;
    yurut_dallan_ps = 32'h40C;
    yurut_gecerli = 1;
    #10;
    $display("Beklenen ��kt�: Dallanma �ng�r�s�: 0, Atlanacak Adres: 0000040C");
    $display("Ger�ekle�en ��kt�: Dallanma �ng�r�s�: %b, Atlanacak Adres: %h", sonuc_dallan, sonuc_dallan_ps);

    // Senaryo 5: Reset durumu
    #10;
    $display("Senaryo 5: Reset durumu");
    rst = 1;
    #10;
    $display("Beklenen ��kt�: Dallanma �ng�r�s�: 0, Atlanacak Adres: 00000000");
    $display("Ger�ekle�en ��kt�: Dallanma �ng�r�s�: %b, Atlanacak Adres: %h", sonuc_dallan, sonuc_dallan_ps);

    // Reset sinyalini kapat
    #10;
    rst = 0;

    // Sim�lasyonu durdur
    #10;
    $finish;
end

// Saat sinyalini olu�tur
always #5 clk = ~clk;
endmodule
