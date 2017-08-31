/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Apr 25 20:39:24 2017
/////////////////////////////////////////////////////////////


module controller_ahb_slave ( HCLK, HRESETn, HREADY, HWRITE, status, 
        decode_size_enable, decode_source_enable, decode_dest_enable, 
        read_enable, write_enable );
  output [2:0] status;
  input HCLK, HRESETn, HREADY, HWRITE;
  output decode_size_enable, decode_source_enable, decode_dest_enable,
         read_enable, write_enable;
  wire   n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n4, n5, n6, n10, n12;
  wire   [2:0] state;
  wire   [2:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[1]) );
  NAND2X1 U15 ( .A(n15), .B(n16), .Y(next_state[2]) );
  NAND2X1 U16 ( .A(n17), .B(n16), .Y(next_state[1]) );
  OAI21X1 U17 ( .A(decode_source_enable), .B(n6), .C(HREADY), .Y(n17) );
  OAI21X1 U18 ( .A(n5), .B(n16), .C(n18), .Y(next_state[0]) );
  AOI22X1 U19 ( .A(n19), .B(HREADY), .C(HWRITE), .D(n4), .Y(n18) );
  AOI21X1 U20 ( .A(decode_dest_enable), .B(HREADY), .C(n20), .Y(n15) );
  OR2X1 U21 ( .A(read_enable), .B(write_enable), .Y(n20) );
  NAND3X1 U22 ( .A(n21), .B(n22), .C(n23), .Y(n16) );
  NOR2X1 U23 ( .A(n6), .B(n19), .Y(n23) );
  NOR2X1 U24 ( .A(state[0]), .B(state[2]), .Y(n19) );
  NAND3X1 U25 ( .A(n12), .B(n10), .C(state[0]), .Y(n24) );
  NOR2X1 U26 ( .A(decode_dest_enable), .B(read_enable), .Y(n21) );
  NAND2X1 U27 ( .A(status[2]), .B(state[0]), .Y(n22) );
  NOR2X1 U28 ( .A(n25), .B(state[0]), .Y(read_enable) );
  NOR2X1 U29 ( .A(n13), .B(n5), .Y(decode_dest_enable) );
  NOR2X1 U30 ( .A(n13), .B(state[0]), .Y(decode_source_enable) );
  NOR2X1 U31 ( .A(n14), .B(n26), .Y(decode_size_enable) );
  NAND2X1 U32 ( .A(n13), .B(n25), .Y(n26) );
  NAND2X1 U33 ( .A(state[2]), .B(n12), .Y(n25) );
  NAND2X1 U34 ( .A(state[1]), .B(n10), .Y(n13) );
  OAI21X1 U35 ( .A(n10), .B(n12), .C(state[0]), .Y(n14) );
  INVX2 U6 ( .A(n15), .Y(n4) );
  INVX2 U7 ( .A(state[0]), .Y(n5) );
  INVX2 U8 ( .A(n24), .Y(n6) );
  INVX2 U9 ( .A(n22), .Y(write_enable) );
  INVX2 U10 ( .A(n14), .Y(status[0]) );
  INVX2 U11 ( .A(n13), .Y(status[1]) );
  INVX2 U12 ( .A(state[2]), .Y(n10) );
  INVX2 U13 ( .A(n25), .Y(status[2]) );
  INVX2 U14 ( .A(state[1]), .Y(n12) );
endmodule


module decoder_ahb ( HCLK, HRESETn, decode_size_enable, decode_source_enable, 
        decode_dest_enable, HWDATA, HADDR, length, width, source_addr, 
        dest_addr );
  input [31:0] HWDATA;
  input [31:0] HADDR;
  output [15:0] length;
  output [15:0] width;
  output [31:0] source_addr;
  output [31:0] dest_addr;
  input HCLK, HRESETn, decode_size_enable, decode_source_enable,
         decode_dest_enable;
  wire   n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, n1, n3,
         n5, n7, n9, n11, n13, n15, n17, n19, n21, n23, n25, n27, n29, n31,
         n33, n35, n37, n39, n41, n43, n45, n47, n49, n51, n53, n55, n57, n59,
         n61, n63, n65, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104,
         n105, n106, n107, n108, n109, n110, n111, n112, n113, n114, n115,
         n116, n117, n118, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n134, n136, n138, n140, n142, n144,
         n146, n148, n150, n152, n154, n156, n158, n160, n162, n164, n166,
         n168, n170, n172, n174, n176, n178, n180, n182, n184, n186, n188,
         n190, n192, n194, n196, n262, n264, n266, n268, n270, n272, n274,
         n276, n278, n280, n282, n284, n286, n288, n290, n292, n294, n296,
         n298, n300, n302, n304, n306, n308, n310, n312, n314, n316, n318,
         n320, n322, n324, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40,
         n42, n44, n46, n48, n50, n52, n54, n56, n58, n60, n62, n64, n66, n132,
         n198, n200, n202, n204, n206, n208, n210, n212, n214, n216, n218,
         n220, n222, n224, n226, n228, n230, n232, n234, n236, n238, n240,
         n242, n244, n246, n248, n250, n252, n254, n256, n258, n260, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360;

  DFFSR \dest_addr_reg[31]  ( .D(n324), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[31]) );
  DFFSR \dest_addr_reg[30]  ( .D(n322), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[30]) );
  DFFSR \dest_addr_reg[29]  ( .D(n320), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[29]) );
  DFFSR \dest_addr_reg[28]  ( .D(n318), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[28]) );
  DFFSR \dest_addr_reg[27]  ( .D(n316), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[27]) );
  DFFSR \dest_addr_reg[26]  ( .D(n314), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[26]) );
  DFFSR \dest_addr_reg[25]  ( .D(n312), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[25]) );
  DFFSR \dest_addr_reg[24]  ( .D(n310), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[24]) );
  DFFSR \dest_addr_reg[23]  ( .D(n308), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[23]) );
  DFFSR \dest_addr_reg[22]  ( .D(n306), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[22]) );
  DFFSR \dest_addr_reg[21]  ( .D(n304), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[21]) );
  DFFSR \dest_addr_reg[20]  ( .D(n302), .CLK(HCLK), .R(n202), .S(1'b1), .Q(
        dest_addr[20]) );
  DFFSR \dest_addr_reg[19]  ( .D(n300), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[19]) );
  DFFSR \dest_addr_reg[18]  ( .D(n298), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[18]) );
  DFFSR \dest_addr_reg[17]  ( .D(n296), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[17]) );
  DFFSR \dest_addr_reg[16]  ( .D(n294), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[16]) );
  DFFSR \dest_addr_reg[15]  ( .D(n292), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[15]) );
  DFFSR \dest_addr_reg[14]  ( .D(n290), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[14]) );
  DFFSR \dest_addr_reg[13]  ( .D(n288), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[13]) );
  DFFSR \dest_addr_reg[12]  ( .D(n286), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[12]) );
  DFFSR \dest_addr_reg[11]  ( .D(n284), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[11]) );
  DFFSR \dest_addr_reg[10]  ( .D(n282), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[10]) );
  DFFSR \dest_addr_reg[9]  ( .D(n280), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[9]) );
  DFFSR \dest_addr_reg[8]  ( .D(n278), .CLK(HCLK), .R(n200), .S(1'b1), .Q(
        dest_addr[8]) );
  DFFSR \dest_addr_reg[7]  ( .D(n276), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[7]) );
  DFFSR \dest_addr_reg[6]  ( .D(n274), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[6]) );
  DFFSR \dest_addr_reg[5]  ( .D(n272), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[5]) );
  DFFSR \dest_addr_reg[4]  ( .D(n270), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[4]) );
  DFFSR \dest_addr_reg[3]  ( .D(n268), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[3]) );
  DFFSR \dest_addr_reg[2]  ( .D(n266), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[2]) );
  DFFSR \dest_addr_reg[1]  ( .D(n264), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[1]) );
  DFFSR \dest_addr_reg[0]  ( .D(n262), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        dest_addr[0]) );
  DFFSR \length_reg[15]  ( .D(n204), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        length[15]) );
  DFFSR \length_reg[14]  ( .D(n206), .CLK(HCLK), .R(n198), .S(1'b1), .Q(
        length[14]) );
  DFFSR \length_reg[13]  ( .D(n208), .CLK(HCLK), .R(n198), .S(1'b1), .Q(n361)
         );
  DFFSR \length_reg[12]  ( .D(n210), .CLK(HCLK), .R(n198), .S(1'b1), .Q(n362)
         );
  DFFSR \length_reg[11]  ( .D(n212), .CLK(HCLK), .R(n132), .S(1'b1), .Q(
        length[11]) );
  DFFSR \length_reg[10]  ( .D(n214), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n363)
         );
  DFFSR \length_reg[9]  ( .D(n216), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n364)
         );
  DFFSR \length_reg[8]  ( .D(n218), .CLK(HCLK), .R(n132), .S(1'b1), .Q(
        length[8]) );
  DFFSR \length_reg[7]  ( .D(n220), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n365)
         );
  DFFSR \length_reg[6]  ( .D(n222), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n366)
         );
  DFFSR \length_reg[5]  ( .D(n224), .CLK(HCLK), .R(n132), .S(1'b1), .Q(
        length[5]) );
  DFFSR \length_reg[4]  ( .D(n226), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n367)
         );
  DFFSR \length_reg[3]  ( .D(n228), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n368)
         );
  DFFSR \length_reg[2]  ( .D(n230), .CLK(HCLK), .R(n132), .S(1'b1), .Q(
        length[2]) );
  DFFSR \length_reg[1]  ( .D(n232), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n369)
         );
  DFFSR \length_reg[0]  ( .D(n234), .CLK(HCLK), .R(n132), .S(1'b1), .Q(n370)
         );
  DFFSR \width_reg[15]  ( .D(n236), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[15]) );
  DFFSR \width_reg[14]  ( .D(n238), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[14]) );
  DFFSR \width_reg[13]  ( .D(n240), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[13]) );
  DFFSR \width_reg[12]  ( .D(n242), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[12]) );
  DFFSR \width_reg[11]  ( .D(n244), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[11]) );
  DFFSR \width_reg[10]  ( .D(n246), .CLK(HCLK), .R(n66), .S(1'b1), .Q(
        width[10]) );
  DFFSR \width_reg[9]  ( .D(n248), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[9])
         );
  DFFSR \width_reg[8]  ( .D(n250), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[8])
         );
  DFFSR \width_reg[7]  ( .D(n252), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[7])
         );
  DFFSR \width_reg[6]  ( .D(n254), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[6])
         );
  DFFSR \width_reg[5]  ( .D(n256), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[5])
         );
  DFFSR \width_reg[4]  ( .D(n258), .CLK(HCLK), .R(n66), .S(1'b1), .Q(width[4])
         );
  DFFSR \width_reg[3]  ( .D(n260), .CLK(HCLK), .R(n64), .S(1'b1), .Q(width[3])
         );
  DFFSR \width_reg[2]  ( .D(n325), .CLK(HCLK), .R(n64), .S(1'b1), .Q(width[2])
         );
  DFFSR \width_reg[1]  ( .D(n326), .CLK(HCLK), .R(n64), .S(1'b1), .Q(width[1])
         );
  DFFSR \width_reg[0]  ( .D(n327), .CLK(HCLK), .R(n64), .S(1'b1), .Q(width[0])
         );
  DFFSR \source_addr_reg[31]  ( .D(n196), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[31]) );
  DFFSR \source_addr_reg[30]  ( .D(n194), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[30]) );
  DFFSR \source_addr_reg[29]  ( .D(n192), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[29]) );
  DFFSR \source_addr_reg[28]  ( .D(n190), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[28]) );
  DFFSR \source_addr_reg[27]  ( .D(n188), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[27]) );
  DFFSR \source_addr_reg[26]  ( .D(n186), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[26]) );
  DFFSR \source_addr_reg[25]  ( .D(n184), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[25]) );
  DFFSR \source_addr_reg[24]  ( .D(n182), .CLK(HCLK), .R(n64), .S(1'b1), .Q(
        source_addr[24]) );
  DFFSR \source_addr_reg[23]  ( .D(n180), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[23]) );
  DFFSR \source_addr_reg[22]  ( .D(n178), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[22]) );
  DFFSR \source_addr_reg[21]  ( .D(n176), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[21]) );
  DFFSR \source_addr_reg[20]  ( .D(n174), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[20]) );
  DFFSR \source_addr_reg[19]  ( .D(n172), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[19]) );
  DFFSR \source_addr_reg[18]  ( .D(n170), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[18]) );
  DFFSR \source_addr_reg[17]  ( .D(n168), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[17]) );
  DFFSR \source_addr_reg[16]  ( .D(n166), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[16]) );
  DFFSR \source_addr_reg[15]  ( .D(n164), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[15]) );
  DFFSR \source_addr_reg[14]  ( .D(n162), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[14]) );
  DFFSR \source_addr_reg[13]  ( .D(n160), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[13]) );
  DFFSR \source_addr_reg[12]  ( .D(n158), .CLK(HCLK), .R(n62), .S(1'b1), .Q(
        source_addr[12]) );
  DFFSR \source_addr_reg[11]  ( .D(n156), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[11]) );
  DFFSR \source_addr_reg[10]  ( .D(n154), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[10]) );
  DFFSR \source_addr_reg[9]  ( .D(n152), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[9]) );
  DFFSR \source_addr_reg[8]  ( .D(n150), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[8]) );
  DFFSR \source_addr_reg[7]  ( .D(n148), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[7]) );
  DFFSR \source_addr_reg[6]  ( .D(n146), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[6]) );
  DFFSR \source_addr_reg[5]  ( .D(n144), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[5]) );
  DFFSR \source_addr_reg[4]  ( .D(n142), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[4]) );
  DFFSR \source_addr_reg[3]  ( .D(n140), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[3]) );
  DFFSR \source_addr_reg[2]  ( .D(n138), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[2]) );
  DFFSR \source_addr_reg[1]  ( .D(n136), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[1]) );
  DFFSR \source_addr_reg[0]  ( .D(n134), .CLK(HCLK), .R(n60), .S(1'b1), .Q(
        source_addr[0]) );
  OAI21X1 U2 ( .A(n34), .B(n360), .C(n3), .Y(n134) );
  NAND2X1 U3 ( .A(source_addr[0]), .B(n40), .Y(n3) );
  OAI21X1 U4 ( .A(n32), .B(n359), .C(n5), .Y(n136) );
  NAND2X1 U5 ( .A(source_addr[1]), .B(n40), .Y(n5) );
  OAI21X1 U6 ( .A(n32), .B(n358), .C(n7), .Y(n138) );
  NAND2X1 U7 ( .A(source_addr[2]), .B(n40), .Y(n7) );
  OAI21X1 U8 ( .A(n32), .B(n357), .C(n9), .Y(n140) );
  NAND2X1 U9 ( .A(source_addr[3]), .B(n38), .Y(n9) );
  OAI21X1 U10 ( .A(n32), .B(n356), .C(n11), .Y(n142) );
  NAND2X1 U11 ( .A(source_addr[4]), .B(n38), .Y(n11) );
  OAI21X1 U12 ( .A(n32), .B(n355), .C(n13), .Y(n144) );
  NAND2X1 U13 ( .A(source_addr[5]), .B(n38), .Y(n13) );
  OAI21X1 U14 ( .A(n32), .B(n354), .C(n15), .Y(n146) );
  NAND2X1 U15 ( .A(source_addr[6]), .B(n38), .Y(n15) );
  OAI21X1 U16 ( .A(n32), .B(n353), .C(n17), .Y(n148) );
  NAND2X1 U17 ( .A(source_addr[7]), .B(n38), .Y(n17) );
  OAI21X1 U18 ( .A(n32), .B(n352), .C(n19), .Y(n150) );
  NAND2X1 U19 ( .A(source_addr[8]), .B(n38), .Y(n19) );
  OAI21X1 U20 ( .A(n32), .B(n351), .C(n21), .Y(n152) );
  NAND2X1 U21 ( .A(source_addr[9]), .B(n38), .Y(n21) );
  OAI21X1 U22 ( .A(n32), .B(n350), .C(n23), .Y(n154) );
  NAND2X1 U23 ( .A(source_addr[10]), .B(n38), .Y(n23) );
  OAI21X1 U24 ( .A(n32), .B(n349), .C(n25), .Y(n156) );
  NAND2X1 U25 ( .A(source_addr[11]), .B(n38), .Y(n25) );
  OAI21X1 U26 ( .A(n32), .B(n348), .C(n27), .Y(n158) );
  NAND2X1 U27 ( .A(source_addr[12]), .B(n38), .Y(n27) );
  OAI21X1 U28 ( .A(n32), .B(n347), .C(n29), .Y(n160) );
  NAND2X1 U29 ( .A(source_addr[13]), .B(n38), .Y(n29) );
  OAI21X1 U30 ( .A(n34), .B(n346), .C(n31), .Y(n162) );
  NAND2X1 U31 ( .A(source_addr[14]), .B(n36), .Y(n31) );
  OAI21X1 U32 ( .A(n34), .B(n345), .C(n33), .Y(n164) );
  NAND2X1 U33 ( .A(source_addr[15]), .B(n36), .Y(n33) );
  OAI21X1 U34 ( .A(n34), .B(n344), .C(n35), .Y(n166) );
  NAND2X1 U35 ( .A(source_addr[16]), .B(n38), .Y(n35) );
  OAI21X1 U36 ( .A(n34), .B(n343), .C(n37), .Y(n168) );
  NAND2X1 U37 ( .A(source_addr[17]), .B(n36), .Y(n37) );
  OAI21X1 U38 ( .A(n34), .B(n342), .C(n39), .Y(n170) );
  NAND2X1 U39 ( .A(source_addr[18]), .B(n36), .Y(n39) );
  OAI21X1 U40 ( .A(n34), .B(n341), .C(n41), .Y(n172) );
  NAND2X1 U41 ( .A(source_addr[19]), .B(n36), .Y(n41) );
  OAI21X1 U42 ( .A(n34), .B(n340), .C(n43), .Y(n174) );
  NAND2X1 U43 ( .A(source_addr[20]), .B(n36), .Y(n43) );
  OAI21X1 U44 ( .A(n34), .B(n339), .C(n45), .Y(n176) );
  NAND2X1 U45 ( .A(source_addr[21]), .B(n36), .Y(n45) );
  OAI21X1 U46 ( .A(n34), .B(n338), .C(n47), .Y(n178) );
  NAND2X1 U47 ( .A(source_addr[22]), .B(n38), .Y(n47) );
  OAI21X1 U48 ( .A(n34), .B(n337), .C(n49), .Y(n180) );
  NAND2X1 U49 ( .A(source_addr[23]), .B(n36), .Y(n49) );
  OAI21X1 U50 ( .A(n34), .B(n336), .C(n51), .Y(n182) );
  NAND2X1 U51 ( .A(source_addr[24]), .B(n36), .Y(n51) );
  OAI21X1 U52 ( .A(n36), .B(n335), .C(n53), .Y(n184) );
  NAND2X1 U53 ( .A(source_addr[25]), .B(n38), .Y(n53) );
  OAI21X1 U54 ( .A(n36), .B(n334), .C(n55), .Y(n186) );
  NAND2X1 U55 ( .A(source_addr[26]), .B(n38), .Y(n55) );
  OAI21X1 U56 ( .A(n34), .B(n333), .C(n57), .Y(n188) );
  NAND2X1 U57 ( .A(source_addr[27]), .B(n38), .Y(n57) );
  OAI21X1 U58 ( .A(n36), .B(n332), .C(n59), .Y(n190) );
  NAND2X1 U59 ( .A(source_addr[28]), .B(n38), .Y(n59) );
  OAI21X1 U60 ( .A(n36), .B(n331), .C(n61), .Y(n192) );
  NAND2X1 U61 ( .A(source_addr[29]), .B(n38), .Y(n61) );
  OAI21X1 U62 ( .A(n36), .B(n330), .C(n63), .Y(n194) );
  NAND2X1 U63 ( .A(source_addr[30]), .B(n40), .Y(n63) );
  OAI21X1 U64 ( .A(n36), .B(n329), .C(n65), .Y(n196) );
  NAND2X1 U65 ( .A(source_addr[31]), .B(n40), .Y(n65) );
  NAND2X1 U66 ( .A(decode_source_enable), .B(n44), .Y(n1) );
  AOI22X1 U68 ( .A(n58), .B(HWDATA[0]), .C(width[0]), .D(n42), .Y(n67) );
  AOI22X1 U70 ( .A(HWDATA[1]), .B(n58), .C(width[1]), .D(n42), .Y(n68) );
  AOI22X1 U72 ( .A(HWDATA[2]), .B(n56), .C(width[2]), .D(n42), .Y(n69) );
  AOI22X1 U74 ( .A(HWDATA[3]), .B(n56), .C(width[3]), .D(n42), .Y(n70) );
  AOI22X1 U76 ( .A(HWDATA[4]), .B(n56), .C(width[4]), .D(n42), .Y(n71) );
  AOI22X1 U78 ( .A(HWDATA[5]), .B(n56), .C(width[5]), .D(n42), .Y(n72) );
  AOI22X1 U80 ( .A(HWDATA[6]), .B(n56), .C(width[6]), .D(n42), .Y(n73) );
  AOI22X1 U82 ( .A(HWDATA[7]), .B(n56), .C(width[7]), .D(n42), .Y(n74) );
  AOI22X1 U84 ( .A(HWDATA[8]), .B(n56), .C(width[8]), .D(n42), .Y(n75) );
  AOI22X1 U86 ( .A(HWDATA[9]), .B(n54), .C(width[9]), .D(n42), .Y(n76) );
  AOI22X1 U88 ( .A(HWDATA[10]), .B(n54), .C(width[10]), .D(n42), .Y(n77) );
  AOI22X1 U90 ( .A(HWDATA[11]), .B(n54), .C(width[11]), .D(n42), .Y(n78) );
  AOI22X1 U92 ( .A(HWDATA[12]), .B(n54), .C(width[12]), .D(n42), .Y(n79) );
  AOI22X1 U94 ( .A(HWDATA[13]), .B(n54), .C(width[13]), .D(n42), .Y(n80) );
  AOI22X1 U96 ( .A(HWDATA[14]), .B(n54), .C(width[14]), .D(n42), .Y(n81) );
  AOI22X1 U98 ( .A(HWDATA[15]), .B(n54), .C(width[15]), .D(n42), .Y(n82) );
  AOI22X1 U100 ( .A(HWDATA[16]), .B(n52), .C(length[0]), .D(n42), .Y(n83) );
  AOI22X1 U102 ( .A(HWDATA[17]), .B(n52), .C(length[1]), .D(n42), .Y(n84) );
  AOI22X1 U104 ( .A(HWDATA[18]), .B(n52), .C(length[2]), .D(n42), .Y(n85) );
  AOI22X1 U106 ( .A(HWDATA[19]), .B(n52), .C(length[3]), .D(n42), .Y(n86) );
  AOI22X1 U108 ( .A(HWDATA[20]), .B(n52), .C(length[4]), .D(n42), .Y(n87) );
  AOI22X1 U110 ( .A(HWDATA[21]), .B(n52), .C(length[5]), .D(n42), .Y(n88) );
  AOI22X1 U112 ( .A(HWDATA[22]), .B(n50), .C(length[6]), .D(n42), .Y(n89) );
  AOI22X1 U114 ( .A(HWDATA[23]), .B(n50), .C(length[7]), .D(n42), .Y(n90) );
  AOI22X1 U116 ( .A(HWDATA[24]), .B(n50), .C(length[8]), .D(n42), .Y(n91) );
  AOI22X1 U118 ( .A(HWDATA[25]), .B(n48), .C(length[9]), .D(n42), .Y(n92) );
  AOI22X1 U120 ( .A(HWDATA[26]), .B(n48), .C(length[10]), .D(n44), .Y(n93) );
  AOI22X1 U122 ( .A(HWDATA[27]), .B(n48), .C(length[11]), .D(n44), .Y(n94) );
  AOI22X1 U124 ( .A(HWDATA[28]), .B(n46), .C(length[12]), .D(n44), .Y(n95) );
  AOI22X1 U126 ( .A(HWDATA[29]), .B(n46), .C(length[13]), .D(n44), .Y(n96) );
  AOI22X1 U128 ( .A(HWDATA[30]), .B(n46), .C(length[14]), .D(n44), .Y(n97) );
  AOI22X1 U130 ( .A(HWDATA[31]), .B(n52), .C(length[15]), .D(n44), .Y(n98) );
  OAI21X1 U131 ( .A(n360), .B(n24), .C(n100), .Y(n262) );
  NAND2X1 U132 ( .A(dest_addr[0]), .B(n30), .Y(n100) );
  OAI21X1 U134 ( .A(n359), .B(n22), .C(n101), .Y(n264) );
  NAND2X1 U135 ( .A(dest_addr[1]), .B(n30), .Y(n101) );
  OAI21X1 U137 ( .A(n358), .B(n22), .C(n102), .Y(n266) );
  NAND2X1 U138 ( .A(dest_addr[2]), .B(n30), .Y(n102) );
  OAI21X1 U140 ( .A(n357), .B(n22), .C(n103), .Y(n268) );
  NAND2X1 U141 ( .A(dest_addr[3]), .B(n28), .Y(n103) );
  OAI21X1 U143 ( .A(n356), .B(n22), .C(n104), .Y(n270) );
  NAND2X1 U144 ( .A(dest_addr[4]), .B(n30), .Y(n104) );
  OAI21X1 U146 ( .A(n355), .B(n22), .C(n105), .Y(n272) );
  NAND2X1 U147 ( .A(dest_addr[5]), .B(n28), .Y(n105) );
  OAI21X1 U149 ( .A(n354), .B(n22), .C(n106), .Y(n274) );
  NAND2X1 U150 ( .A(dest_addr[6]), .B(n28), .Y(n106) );
  OAI21X1 U152 ( .A(n353), .B(n22), .C(n107), .Y(n276) );
  NAND2X1 U153 ( .A(dest_addr[7]), .B(n28), .Y(n107) );
  OAI21X1 U155 ( .A(n352), .B(n22), .C(n108), .Y(n278) );
  NAND2X1 U156 ( .A(dest_addr[8]), .B(n28), .Y(n108) );
  OAI21X1 U158 ( .A(n351), .B(n22), .C(n109), .Y(n280) );
  NAND2X1 U159 ( .A(dest_addr[9]), .B(n28), .Y(n109) );
  OAI21X1 U161 ( .A(n350), .B(n22), .C(n110), .Y(n282) );
  NAND2X1 U162 ( .A(dest_addr[10]), .B(n28), .Y(n110) );
  OAI21X1 U164 ( .A(n349), .B(n22), .C(n111), .Y(n284) );
  NAND2X1 U165 ( .A(dest_addr[11]), .B(n28), .Y(n111) );
  OAI21X1 U167 ( .A(n348), .B(n22), .C(n112), .Y(n286) );
  NAND2X1 U168 ( .A(dest_addr[12]), .B(n28), .Y(n112) );
  OAI21X1 U170 ( .A(n347), .B(n24), .C(n113), .Y(n288) );
  NAND2X1 U171 ( .A(dest_addr[13]), .B(n28), .Y(n113) );
  OAI21X1 U173 ( .A(n346), .B(n24), .C(n114), .Y(n290) );
  NAND2X1 U174 ( .A(dest_addr[14]), .B(n28), .Y(n114) );
  OAI21X1 U176 ( .A(n345), .B(n24), .C(n115), .Y(n292) );
  NAND2X1 U177 ( .A(dest_addr[15]), .B(n26), .Y(n115) );
  OAI21X1 U179 ( .A(n344), .B(n24), .C(n116), .Y(n294) );
  NAND2X1 U180 ( .A(dest_addr[16]), .B(n28), .Y(n116) );
  OAI21X1 U182 ( .A(n343), .B(n24), .C(n117), .Y(n296) );
  NAND2X1 U183 ( .A(dest_addr[17]), .B(n26), .Y(n117) );
  OAI21X1 U185 ( .A(n342), .B(n24), .C(n118), .Y(n298) );
  NAND2X1 U186 ( .A(dest_addr[18]), .B(n26), .Y(n118) );
  OAI21X1 U188 ( .A(n341), .B(n24), .C(n119), .Y(n300) );
  NAND2X1 U189 ( .A(dest_addr[19]), .B(n26), .Y(n119) );
  OAI21X1 U191 ( .A(n340), .B(n24), .C(n120), .Y(n302) );
  NAND2X1 U192 ( .A(dest_addr[20]), .B(n26), .Y(n120) );
  OAI21X1 U194 ( .A(n339), .B(n24), .C(n121), .Y(n304) );
  NAND2X1 U195 ( .A(dest_addr[21]), .B(n26), .Y(n121) );
  OAI21X1 U197 ( .A(n338), .B(n24), .C(n122), .Y(n306) );
  NAND2X1 U198 ( .A(dest_addr[22]), .B(n28), .Y(n122) );
  OAI21X1 U200 ( .A(n337), .B(n26), .C(n123), .Y(n308) );
  NAND2X1 U201 ( .A(dest_addr[23]), .B(n26), .Y(n123) );
  OAI21X1 U203 ( .A(n336), .B(n24), .C(n124), .Y(n310) );
  NAND2X1 U204 ( .A(dest_addr[24]), .B(n28), .Y(n124) );
  OAI21X1 U206 ( .A(n335), .B(n26), .C(n125), .Y(n312) );
  NAND2X1 U207 ( .A(dest_addr[25]), .B(n28), .Y(n125) );
  OAI21X1 U209 ( .A(n334), .B(n26), .C(n126), .Y(n314) );
  NAND2X1 U210 ( .A(dest_addr[26]), .B(n28), .Y(n126) );
  OAI21X1 U212 ( .A(n333), .B(n26), .C(n127), .Y(n316) );
  NAND2X1 U213 ( .A(dest_addr[27]), .B(n28), .Y(n127) );
  OAI21X1 U215 ( .A(n332), .B(n26), .C(n128), .Y(n318) );
  NAND2X1 U216 ( .A(dest_addr[28]), .B(n28), .Y(n128) );
  OAI21X1 U218 ( .A(n331), .B(n26), .C(n129), .Y(n320) );
  NAND2X1 U219 ( .A(dest_addr[29]), .B(n28), .Y(n129) );
  OAI21X1 U221 ( .A(n330), .B(n26), .C(n130), .Y(n322) );
  NAND2X1 U222 ( .A(dest_addr[30]), .B(n30), .Y(n130) );
  OAI21X1 U224 ( .A(n329), .B(n26), .C(n131), .Y(n324) );
  NAND2X1 U225 ( .A(dest_addr[31]), .B(n30), .Y(n131) );
  NAND3X1 U226 ( .A(n44), .B(n328), .C(decode_dest_enable), .Y(n99) );
  BUFX2 U67 ( .A(n370), .Y(length[0]) );
  BUFX2 U69 ( .A(n362), .Y(length[12]) );
  BUFX2 U71 ( .A(n363), .Y(length[10]) );
  BUFX2 U73 ( .A(n366), .Y(length[6]) );
  BUFX2 U75 ( .A(n367), .Y(length[4]) );
  BUFX2 U77 ( .A(n361), .Y(length[13]) );
  BUFX2 U79 ( .A(n364), .Y(length[9]) );
  BUFX2 U81 ( .A(n365), .Y(length[7]) );
  BUFX2 U83 ( .A(n368), .Y(length[3]) );
  BUFX2 U85 ( .A(n369), .Y(length[1]) );
  INVX2 U87 ( .A(n46), .Y(n44) );
  INVX2 U89 ( .A(n48), .Y(n42) );
  BUFX2 U91 ( .A(n1), .Y(n32) );
  BUFX2 U93 ( .A(n1), .Y(n34) );
  BUFX2 U95 ( .A(n99), .Y(n26) );
  BUFX2 U97 ( .A(n99), .Y(n28) );
  BUFX2 U99 ( .A(n99), .Y(n22) );
  BUFX2 U101 ( .A(n99), .Y(n24) );
  BUFX2 U103 ( .A(n1), .Y(n38) );
  BUFX2 U105 ( .A(n1), .Y(n36) );
  BUFX2 U107 ( .A(decode_size_enable), .Y(n46) );
  BUFX2 U109 ( .A(decode_size_enable), .Y(n50) );
  BUFX2 U111 ( .A(decode_size_enable), .Y(n48) );
  BUFX2 U113 ( .A(decode_size_enable), .Y(n56) );
  BUFX2 U115 ( .A(decode_size_enable), .Y(n54) );
  BUFX2 U117 ( .A(decode_size_enable), .Y(n52) );
  BUFX2 U119 ( .A(n99), .Y(n30) );
  BUFX2 U121 ( .A(n1), .Y(n40) );
  BUFX2 U123 ( .A(decode_size_enable), .Y(n58) );
  BUFX2 U125 ( .A(HRESETn), .Y(n60) );
  BUFX2 U127 ( .A(HRESETn), .Y(n62) );
  BUFX2 U129 ( .A(HRESETn), .Y(n64) );
  BUFX2 U133 ( .A(HRESETn), .Y(n66) );
  BUFX2 U136 ( .A(HRESETn), .Y(n132) );
  BUFX2 U139 ( .A(HRESETn), .Y(n198) );
  BUFX2 U142 ( .A(HRESETn), .Y(n200) );
  BUFX2 U145 ( .A(HRESETn), .Y(n202) );
  INVX2 U148 ( .A(n98), .Y(n204) );
  INVX2 U151 ( .A(n97), .Y(n206) );
  INVX2 U154 ( .A(n96), .Y(n208) );
  INVX2 U157 ( .A(n95), .Y(n210) );
  INVX2 U160 ( .A(n94), .Y(n212) );
  INVX2 U163 ( .A(n93), .Y(n214) );
  INVX2 U166 ( .A(n92), .Y(n216) );
  INVX2 U169 ( .A(n91), .Y(n218) );
  INVX2 U172 ( .A(n90), .Y(n220) );
  INVX2 U175 ( .A(n89), .Y(n222) );
  INVX2 U178 ( .A(n88), .Y(n224) );
  INVX2 U181 ( .A(n87), .Y(n226) );
  INVX2 U184 ( .A(n86), .Y(n228) );
  INVX2 U187 ( .A(n85), .Y(n230) );
  INVX2 U190 ( .A(n84), .Y(n232) );
  INVX2 U193 ( .A(n83), .Y(n234) );
  INVX2 U196 ( .A(n82), .Y(n236) );
  INVX2 U199 ( .A(n81), .Y(n238) );
  INVX2 U202 ( .A(n80), .Y(n240) );
  INVX2 U205 ( .A(n79), .Y(n242) );
  INVX2 U208 ( .A(n78), .Y(n244) );
  INVX2 U211 ( .A(n77), .Y(n246) );
  INVX2 U214 ( .A(n76), .Y(n248) );
  INVX2 U217 ( .A(n75), .Y(n250) );
  INVX2 U220 ( .A(n74), .Y(n252) );
  INVX2 U223 ( .A(n73), .Y(n254) );
  INVX2 U227 ( .A(n72), .Y(n256) );
  INVX2 U228 ( .A(n71), .Y(n258) );
  INVX2 U229 ( .A(n70), .Y(n260) );
  INVX2 U326 ( .A(n69), .Y(n325) );
  INVX2 U327 ( .A(n68), .Y(n326) );
  INVX2 U328 ( .A(n67), .Y(n327) );
  INVX2 U329 ( .A(decode_source_enable), .Y(n328) );
  INVX2 U330 ( .A(HADDR[31]), .Y(n329) );
  INVX2 U331 ( .A(HADDR[30]), .Y(n330) );
  INVX2 U332 ( .A(HADDR[29]), .Y(n331) );
  INVX2 U333 ( .A(HADDR[28]), .Y(n332) );
  INVX2 U334 ( .A(HADDR[27]), .Y(n333) );
  INVX2 U335 ( .A(HADDR[26]), .Y(n334) );
  INVX2 U336 ( .A(HADDR[25]), .Y(n335) );
  INVX2 U337 ( .A(HADDR[24]), .Y(n336) );
  INVX2 U338 ( .A(HADDR[23]), .Y(n337) );
  INVX2 U339 ( .A(HADDR[22]), .Y(n338) );
  INVX2 U340 ( .A(HADDR[21]), .Y(n339) );
  INVX2 U341 ( .A(HADDR[20]), .Y(n340) );
  INVX2 U342 ( .A(HADDR[19]), .Y(n341) );
  INVX2 U343 ( .A(HADDR[18]), .Y(n342) );
  INVX2 U344 ( .A(HADDR[17]), .Y(n343) );
  INVX2 U345 ( .A(HADDR[16]), .Y(n344) );
  INVX2 U346 ( .A(HADDR[15]), .Y(n345) );
  INVX2 U347 ( .A(HADDR[14]), .Y(n346) );
  INVX2 U348 ( .A(HADDR[13]), .Y(n347) );
  INVX2 U349 ( .A(HADDR[12]), .Y(n348) );
  INVX2 U350 ( .A(HADDR[11]), .Y(n349) );
  INVX2 U351 ( .A(HADDR[10]), .Y(n350) );
  INVX2 U352 ( .A(HADDR[9]), .Y(n351) );
  INVX2 U353 ( .A(HADDR[8]), .Y(n352) );
  INVX2 U354 ( .A(HADDR[7]), .Y(n353) );
  INVX2 U355 ( .A(HADDR[6]), .Y(n354) );
  INVX2 U356 ( .A(HADDR[5]), .Y(n355) );
  INVX2 U357 ( .A(HADDR[4]), .Y(n356) );
  INVX2 U358 ( .A(HADDR[3]), .Y(n357) );
  INVX2 U359 ( .A(HADDR[2]), .Y(n358) );
  INVX2 U360 ( .A(HADDR[1]), .Y(n359) );
  INVX2 U361 ( .A(HADDR[0]), .Y(n360) );
endmodule


module ahb_slave ( HCLK, HRESETn, HREADY, HWRITE, HWDATA, HADDR, status, 
        length, width, source_addr, dest_addr, read_enable, write_enable );
  input [31:0] HWDATA;
  input [31:0] HADDR;
  output [2:0] status;
  output [15:0] length;
  output [15:0] width;
  output [31:0] source_addr;
  output [31:0] dest_addr;
  input HCLK, HRESETn, HREADY, HWRITE;
  output read_enable, write_enable;
  wire   decode_size_enable, decode_source_enable, decode_dest_enable;

  controller_ahb_slave AHB_SLAVE_CONTROLLER ( .HCLK(HCLK), .HRESETn(HRESETn), 
        .HREADY(HREADY), .HWRITE(HWRITE), .status(status), 
        .decode_size_enable(decode_size_enable), .decode_source_enable(
        decode_source_enable), .decode_dest_enable(decode_dest_enable), 
        .read_enable(read_enable), .write_enable(write_enable) );
  decoder_ahb AHB_SLAVE_DECODER ( .HCLK(HCLK), .HRESETn(HRESETn), 
        .decode_size_enable(decode_size_enable), .decode_source_enable(
        decode_source_enable), .decode_dest_enable(decode_dest_enable), 
        .HWDATA(HWDATA), .HADDR(HADDR), .length(length), .width(width), 
        .source_addr(source_addr), .dest_addr(dest_addr) );
endmodule


module controller_ahb ( HCLK, HRESETn, HREADY, read_enable, write_enable, 
        transfer_addr_complete_r, transfer_data_complete_r, 
        transfer_addr_complete_w, transfer_data_complete_w, end_of_image, 
        addr_enable_r, load_enable_r, shift_enable_r, addr_update_enable_r, 
        addr_enable_w, shift_enable_w, addr_update_enable_w );
  input HCLK, HRESETn, HREADY, read_enable, write_enable,
         transfer_addr_complete_r, transfer_data_complete_r,
         transfer_addr_complete_w, transfer_data_complete_w, end_of_image;
  output addr_enable_r, load_enable_r, shift_enable_r, addr_update_enable_r,
         addr_enable_w, shift_enable_w, addr_update_enable_w;
  wire   n81, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n7, n8,
         n9, n10, n11, n12, n13, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n80;
  wire   [4:0] state;
  wire   [4:0] next_state;

  DFFSR \state_reg[0]  ( .D(next_state[0]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[0]) );
  DFFSR \state_reg[2]  ( .D(next_state[2]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[2]) );
  DFFSR \state_reg[3]  ( .D(next_state[3]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[3]) );
  DFFSR \state_reg[1]  ( .D(next_state[1]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[1]) );
  DFFSR \state_reg[4]  ( .D(next_state[4]), .CLK(HCLK), .R(HRESETn), .S(1'b1), 
        .Q(state[4]) );
  AND2X2 U8 ( .A(n30), .B(n31), .Y(n40) );
  AND2X2 U9 ( .A(n46), .B(n47), .Y(n39) );
  AND2X2 U10 ( .A(n9), .B(n47), .Y(n51) );
  AND2X2 U11 ( .A(n65), .B(n25), .Y(n62) );
  AND2X2 U12 ( .A(n12), .B(n65), .Y(addr_update_enable_r) );
  NOR2X1 U34 ( .A(n27), .B(n18), .Y(shift_enable_r) );
  OR2X1 U35 ( .A(n28), .B(n29), .Y(next_state[4]) );
  OAI22X1 U36 ( .A(n30), .B(n8), .C(write_enable), .D(n31), .Y(n29) );
  OAI21X1 U37 ( .A(n26), .B(n32), .C(n33), .Y(n28) );
  NAND3X1 U38 ( .A(n34), .B(n9), .C(n35), .Y(next_state[3]) );
  AOI21X1 U39 ( .A(n11), .B(state[3]), .C(n36), .Y(n35) );
  NAND2X1 U40 ( .A(n37), .B(n38), .Y(n36) );
  NAND3X1 U41 ( .A(n39), .B(n40), .C(n41), .Y(next_state[2]) );
  NOR2X1 U42 ( .A(n42), .B(n43), .Y(n41) );
  OAI22X1 U43 ( .A(n8), .B(n44), .C(n80), .D(n45), .Y(n43) );
  OAI21X1 U44 ( .A(n22), .B(n32), .C(n37), .Y(n42) );
  NAND2X1 U45 ( .A(n48), .B(n49), .Y(next_state[1]) );
  AOI21X1 U46 ( .A(n11), .B(state[1]), .C(n50), .Y(n49) );
  OAI21X1 U47 ( .A(n51), .B(n10), .C(n52), .Y(n50) );
  AOI22X1 U48 ( .A(read_enable), .B(n19), .C(shift_enable_w), .D(n8), .Y(n48)
         );
  NAND3X1 U49 ( .A(n53), .B(n34), .C(n54), .Y(next_state[0]) );
  NOR2X1 U50 ( .A(n55), .B(n56), .Y(n54) );
  OAI21X1 U51 ( .A(transfer_data_complete_r), .B(n51), .C(n57), .Y(n56) );
  NAND3X1 U52 ( .A(n20), .B(n18), .C(HREADY), .Y(n57) );
  OAI21X1 U53 ( .A(end_of_image), .B(n30), .C(n59), .Y(n58) );
  OAI21X1 U54 ( .A(n60), .B(n61), .C(n33), .Y(n55) );
  AOI21X1 U55 ( .A(n13), .B(n62), .C(n63), .Y(n34) );
  OAI21X1 U56 ( .A(n64), .B(state[0]), .C(n52), .Y(n63) );
  OAI21X1 U57 ( .A(n19), .B(n17), .C(write_enable), .Y(n52) );
  AOI22X1 U58 ( .A(n11), .B(state[0]), .C(n19), .D(n7), .Y(n53) );
  NAND3X1 U59 ( .A(n66), .B(n67), .C(n68), .Y(n32) );
  NOR2X1 U60 ( .A(n69), .B(n70), .Y(n68) );
  NAND3X1 U61 ( .A(n47), .B(n46), .C(n38), .Y(n70) );
  NAND3X1 U62 ( .A(state[2]), .B(n24), .C(n12), .Y(n38) );
  NAND2X1 U63 ( .A(n12), .B(n21), .Y(n46) );
  NAND2X1 U64 ( .A(n23), .B(n71), .Y(n47) );
  NAND3X1 U65 ( .A(n31), .B(n30), .C(n45), .Y(n69) );
  NAND2X1 U66 ( .A(n20), .B(state[0]), .Y(n45) );
  NAND3X1 U67 ( .A(n25), .B(n26), .C(n21), .Y(n72) );
  NAND3X1 U68 ( .A(n71), .B(n25), .C(n65), .Y(n30) );
  NAND3X1 U69 ( .A(n23), .B(n18), .C(state[4]), .Y(n31) );
  NAND3X1 U70 ( .A(n25), .B(n24), .C(state[2]), .Y(n60) );
  NOR2X1 U71 ( .A(addr_update_enable_r), .B(n73), .Y(n67) );
  NAND2X1 U72 ( .A(n37), .B(n59), .Y(n73) );
  OR2X1 U73 ( .A(n64), .B(n18), .Y(n59) );
  NAND3X1 U74 ( .A(n22), .B(n26), .C(n74), .Y(n64) );
  NOR2X1 U75 ( .A(state[1]), .B(n24), .Y(n74) );
  NAND3X1 U76 ( .A(state[3]), .B(n22), .C(n12), .Y(n37) );
  NOR2X1 U77 ( .A(addr_update_enable_w), .B(addr_enable_w), .Y(n66) );
  NAND3X1 U78 ( .A(n21), .B(state[4]), .C(n76), .Y(n75) );
  NOR2X1 U79 ( .A(n18), .B(n25), .Y(n76) );
  NAND3X1 U80 ( .A(n21), .B(state[4]), .C(n77), .Y(n44) );
  NOR2X1 U81 ( .A(state[1]), .B(n18), .Y(n77) );
  NAND3X1 U82 ( .A(n65), .B(n71), .C(state[1]), .Y(n33) );
  NOR2X1 U83 ( .A(n18), .B(state[4]), .Y(n71) );
  NOR2X1 U84 ( .A(state[0]), .B(n27), .Y(n81) );
  NAND3X1 U85 ( .A(n25), .B(n26), .C(n78), .Y(n27) );
  NAND2X1 U86 ( .A(n24), .B(n22), .Y(n78) );
  NOR2X1 U87 ( .A(n65), .B(n79), .Y(addr_enable_r) );
  NAND2X1 U88 ( .A(n13), .B(state[1]), .Y(n79) );
  NAND2X1 U89 ( .A(n26), .B(n18), .Y(n61) );
  NOR2X1 U90 ( .A(n24), .B(n22), .Y(n65) );
  INVX2 U13 ( .A(read_enable), .Y(n7) );
  BUFX2 U14 ( .A(n81), .Y(load_enable_r) );
  INVX2 U15 ( .A(end_of_image), .Y(n8) );
  INVX2 U16 ( .A(n58), .Y(n9) );
  INVX2 U17 ( .A(transfer_data_complete_r), .Y(n10) );
  INVX2 U18 ( .A(n32), .Y(n11) );
  INVX2 U19 ( .A(n79), .Y(n12) );
  INVX2 U20 ( .A(n61), .Y(n13) );
  INVX2 U21 ( .A(n33), .Y(addr_enable_w) );
  INVX2 U22 ( .A(n44), .Y(shift_enable_w) );
  INVX2 U23 ( .A(n75), .Y(addr_update_enable_w) );
  INVX2 U24 ( .A(n31), .Y(n17) );
  INVX2 U25 ( .A(state[0]), .Y(n18) );
  INVX2 U26 ( .A(n45), .Y(n19) );
  INVX2 U27 ( .A(n72), .Y(n20) );
  INVX2 U28 ( .A(n78), .Y(n21) );
  INVX2 U29 ( .A(state[2]), .Y(n22) );
  INVX2 U30 ( .A(n60), .Y(n23) );
  INVX2 U31 ( .A(state[3]), .Y(n24) );
  INVX2 U32 ( .A(state[1]), .Y(n25) );
  INVX2 U33 ( .A(state[4]), .Y(n26) );
  INVX2 U91 ( .A(write_enable), .Y(n80) );
endmodule


module address_update_w_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module address_update_w_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   \A[0] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28;
  assign SUM[1] = A[1];
  assign SUM[0] = \A[0] ;
  assign \A[0]  = A[0];

  AND2X2 U1 ( .A(n15), .B(A[27]), .Y(n1) );
  AND2X2 U2 ( .A(n16), .B(A[25]), .Y(n2) );
  AND2X2 U3 ( .A(n17), .B(A[19]), .Y(n3) );
  AND2X2 U4 ( .A(n18), .B(A[17]), .Y(n4) );
  AND2X2 U5 ( .A(n19), .B(A[11]), .Y(n5) );
  AND2X2 U6 ( .A(n20), .B(A[9]), .Y(n6) );
  AND2X2 U7 ( .A(n21), .B(A[29]), .Y(n7) );
  AND2X2 U8 ( .A(n22), .B(A[23]), .Y(n8) );
  AND2X2 U9 ( .A(n23), .B(A[21]), .Y(n9) );
  AND2X2 U10 ( .A(n24), .B(A[15]), .Y(n10) );
  AND2X2 U11 ( .A(n25), .B(A[13]), .Y(n11) );
  AND2X2 U12 ( .A(n26), .B(A[7]), .Y(n12) );
  AND2X2 U13 ( .A(n27), .B(A[5]), .Y(n13) );
  AND2X2 U14 ( .A(A[2]), .B(A[3]), .Y(n14) );
  AND2X2 U15 ( .A(n2), .B(A[26]), .Y(n15) );
  AND2X2 U16 ( .A(n8), .B(A[24]), .Y(n16) );
  AND2X2 U17 ( .A(n4), .B(A[18]), .Y(n17) );
  AND2X2 U18 ( .A(n10), .B(A[16]), .Y(n18) );
  AND2X2 U19 ( .A(n6), .B(A[10]), .Y(n19) );
  AND2X2 U20 ( .A(n12), .B(A[8]), .Y(n20) );
  AND2X2 U21 ( .A(n1), .B(A[28]), .Y(n21) );
  AND2X2 U22 ( .A(n9), .B(A[22]), .Y(n22) );
  AND2X2 U23 ( .A(n3), .B(A[20]), .Y(n23) );
  AND2X2 U24 ( .A(n11), .B(A[14]), .Y(n24) );
  AND2X2 U25 ( .A(n5), .B(A[12]), .Y(n25) );
  AND2X2 U26 ( .A(n13), .B(A[6]), .Y(n26) );
  AND2X2 U27 ( .A(n14), .B(A[4]), .Y(n27) );
  AND2X2 U28 ( .A(n7), .B(A[30]), .Y(n28) );
  XOR2X1 U29 ( .A(A[31]), .B(n28), .Y(SUM[31]) );
  XOR2X1 U30 ( .A(n7), .B(A[30]), .Y(SUM[30]) );
  XOR2X1 U31 ( .A(n21), .B(A[29]), .Y(SUM[29]) );
  XOR2X1 U32 ( .A(n1), .B(A[28]), .Y(SUM[28]) );
  XOR2X1 U33 ( .A(n15), .B(A[27]), .Y(SUM[27]) );
  XOR2X1 U34 ( .A(n2), .B(A[26]), .Y(SUM[26]) );
  XOR2X1 U35 ( .A(n16), .B(A[25]), .Y(SUM[25]) );
  XOR2X1 U36 ( .A(n8), .B(A[24]), .Y(SUM[24]) );
  XOR2X1 U37 ( .A(n22), .B(A[23]), .Y(SUM[23]) );
  XOR2X1 U38 ( .A(n9), .B(A[22]), .Y(SUM[22]) );
  XOR2X1 U39 ( .A(n23), .B(A[21]), .Y(SUM[21]) );
  XOR2X1 U40 ( .A(n3), .B(A[20]), .Y(SUM[20]) );
  XOR2X1 U41 ( .A(n17), .B(A[19]), .Y(SUM[19]) );
  XOR2X1 U42 ( .A(n4), .B(A[18]), .Y(SUM[18]) );
  XOR2X1 U43 ( .A(n18), .B(A[17]), .Y(SUM[17]) );
  XOR2X1 U44 ( .A(n10), .B(A[16]), .Y(SUM[16]) );
  XOR2X1 U45 ( .A(n24), .B(A[15]), .Y(SUM[15]) );
  XOR2X1 U46 ( .A(n11), .B(A[14]), .Y(SUM[14]) );
  XOR2X1 U47 ( .A(n25), .B(A[13]), .Y(SUM[13]) );
  XOR2X1 U48 ( .A(n5), .B(A[12]), .Y(SUM[12]) );
  XOR2X1 U49 ( .A(n19), .B(A[11]), .Y(SUM[11]) );
  XOR2X1 U50 ( .A(n6), .B(A[10]), .Y(SUM[10]) );
  XOR2X1 U51 ( .A(n20), .B(A[9]), .Y(SUM[9]) );
  XOR2X1 U52 ( .A(n12), .B(A[8]), .Y(SUM[8]) );
  XOR2X1 U53 ( .A(n26), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U54 ( .A(n13), .B(A[6]), .Y(SUM[6]) );
  XOR2X1 U55 ( .A(n27), .B(A[5]), .Y(SUM[5]) );
  XOR2X1 U56 ( .A(n14), .B(A[4]), .Y(SUM[4]) );
  XOR2X1 U57 ( .A(A[2]), .B(A[3]), .Y(SUM[3]) );
  INVX2 U58 ( .A(A[2]), .Y(SUM[2]) );
endmodule


module address_update_w_DW01_add_1 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FAX1 U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .YS(SUM[31]) );
  FAX1 U1_30 ( .A(A[30]), .B(B[30]), .C(carry[30]), .YC(carry[31]), .YS(
        SUM[30]) );
  FAX1 U1_29 ( .A(A[29]), .B(B[29]), .C(carry[29]), .YC(carry[30]), .YS(
        SUM[29]) );
  FAX1 U1_28 ( .A(A[28]), .B(B[28]), .C(carry[28]), .YC(carry[29]), .YS(
        SUM[28]) );
  FAX1 U1_27 ( .A(A[27]), .B(B[27]), .C(carry[27]), .YC(carry[28]), .YS(
        SUM[27]) );
  FAX1 U1_26 ( .A(A[26]), .B(B[26]), .C(carry[26]), .YC(carry[27]), .YS(
        SUM[26]) );
  FAX1 U1_25 ( .A(A[25]), .B(B[25]), .C(carry[25]), .YC(carry[26]), .YS(
        SUM[25]) );
  FAX1 U1_24 ( .A(A[24]), .B(B[24]), .C(carry[24]), .YC(carry[25]), .YS(
        SUM[24]) );
  FAX1 U1_23 ( .A(A[23]), .B(B[23]), .C(carry[23]), .YC(carry[24]), .YS(
        SUM[23]) );
  FAX1 U1_22 ( .A(A[22]), .B(B[22]), .C(carry[22]), .YC(carry[23]), .YS(
        SUM[22]) );
  FAX1 U1_21 ( .A(A[21]), .B(B[21]), .C(carry[21]), .YC(carry[22]), .YS(
        SUM[21]) );
  FAX1 U1_20 ( .A(A[20]), .B(B[20]), .C(carry[20]), .YC(carry[21]), .YS(
        SUM[20]) );
  FAX1 U1_19 ( .A(A[19]), .B(B[19]), .C(carry[19]), .YC(carry[20]), .YS(
        SUM[19]) );
  FAX1 U1_18 ( .A(A[18]), .B(B[18]), .C(carry[18]), .YC(carry[19]), .YS(
        SUM[18]) );
  FAX1 U1_17 ( .A(A[17]), .B(B[17]), .C(carry[17]), .YC(carry[18]), .YS(
        SUM[17]) );
  FAX1 U1_16 ( .A(A[16]), .B(B[16]), .C(carry[16]), .YC(carry[17]), .YS(
        SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module address_update_w_DW_mult_uns_0 ( a, b, product );
  input [15:0] a;
  input [15:0] b;
  output [31:0] product;
  wire   n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n84, n85, n87, n88, n89, n90, n91, n92, n93, n94, n95, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n177, n178, n179,
         n180, n181, n182, n183, n184, n185, n186, n187, n188, n189, n190,
         n191, n192, n193, n194, n195, n196, n197, n198, n199, n200, n201,
         n202, n203, n204, n205, n206, n207, n208, n209, n210, n211, n212,
         n213, n214, n215, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n354, n357,
         n358, n359, n360, n361, n362, n363, n364, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n376, n377, n378, n379, n380, n381,
         n382, n383, n384, n385, n386, n387, n388, n389, n390, n391, n392,
         n393, n394, n395, n396, n397, n398, n399, n400, n401, n402, n403,
         n404, n405, n406, n407, n408, n409, n410, n411, n412, n413, n414,
         n415, n416, n417, n418, n419, n420, n421, n422, n423, n424, n425,
         n426, n427, n428, n429, n430, n431, n432, n433, n434, n435, n436,
         n437, n438, n439, n440, n441, n442, n443, n444, n445, n446, n447,
         n448, n449, n450, n451, n452, n453, n454, n455, n456, n457, n458,
         n459, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469,
         n470, n471, n472, n473, n474, n475, n476, n477, n478, n479, n480,
         n481, n482, n483, n484, n485, n486, n487, n488, n489, n490, n491,
         n492, n493, n494, n495, n496, n497, n498, n499, n500, n502, n503,
         n504, n505, n506, n507, n508, n509, n510, n511, n512, n513, n514,
         n515, n516, n517, n786, n787, n788, n789, n790, n791, n792, n793,
         n794, n795, n796, n797, n798, n799, n800, n801, n802, n803, n804,
         n805, n806, n807, n808, n809, n810, n811, n812, n813, n814, n815,
         n816, n817, n818, n819, n820, n821, n822, n823, n824, n825, n826,
         n827, n828, n829, n830, n831, n832, n833, n834, n835, n836, n837,
         n838, n839, n840, n841, n842, n843, n844, n845, n846, n847, n848,
         n849, n850, n851, n852, n853, n854, n855, n856, n857, n858, n859,
         n860, n861, n862, n863, n864, n865, n866, n867, n868, n869, n870,
         n871, n872, n873, n874, n875, n876, n877, n878, n879, n880, n881,
         n882, n883, n884, n885, n886, n887, n888, n889, n890, n891, n892,
         n893, n894, n895, n896, n897, n898, n899, n900, n901, n902, n903,
         n904, n905, n906, n907, n908, n909, n910, n911, n912, n913, n914,
         n915, n916, n917, n918, n919, n920, n921, n922, n923, n924, n925,
         n926, n927, n928, n929, n930, n931, n932, n933, n934, n935, n936,
         n937, n938, n939, n940, n941, n942, n943, n944, n945, n946, n947,
         n948, n949, n950, n951, n952, n953, n954, n955, n956, n957, n958,
         n959, n960, n961, n962, n963, n964, n965, n966, n967, n968, n969,
         n970, n971, n972, n973, n974, n975, n976, n977, n978, n979, n980,
         n981, n982, n983, n984, n985, n986, n987, n988, n989, n990, n991,
         n992, n993, n994, n995, n996, n997, n998, n999, n1000, n1001, n1002,
         n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012,
         n1013, n1014, n1015, n1016, n1017, n1018, n1019;
  assign n354 = a[1];

  FAX1 U53 ( .A(n85), .B(n88), .C(n53), .YC(n52), .YS(product[30]) );
  FAX1 U54 ( .A(n89), .B(n92), .C(n54), .YC(n53), .YS(product[29]) );
  FAX1 U55 ( .A(n93), .B(n98), .C(n55), .YC(n54), .YS(product[28]) );
  FAX1 U56 ( .A(n99), .B(n104), .C(n56), .YC(n55), .YS(product[27]) );
  FAX1 U57 ( .A(n105), .B(n112), .C(n57), .YC(n56), .YS(product[26]) );
  FAX1 U58 ( .A(n113), .B(n120), .C(n58), .YC(n57), .YS(product[25]) );
  FAX1 U59 ( .A(n130), .B(n121), .C(n59), .YC(n58), .YS(product[24]) );
  FAX1 U60 ( .A(n131), .B(n140), .C(n60), .YC(n59), .YS(product[23]) );
  FAX1 U61 ( .A(n141), .B(n152), .C(n61), .YC(n60), .YS(product[22]) );
  FAX1 U62 ( .A(n164), .B(n153), .C(n62), .YC(n61), .YS(product[21]) );
  FAX1 U63 ( .A(n178), .B(n165), .C(n63), .YC(n62), .YS(product[20]) );
  FAX1 U64 ( .A(n192), .B(n179), .C(n64), .YC(n63), .YS(product[19]) );
  FAX1 U65 ( .A(n206), .B(n193), .C(n65), .YC(n64), .YS(product[18]) );
  FAX1 U66 ( .A(n220), .B(n207), .C(n66), .YC(n65), .YS(product[17]) );
  FAX1 U67 ( .A(n234), .B(n221), .C(n67), .YC(n66), .YS(product[16]) );
  FAX1 U68 ( .A(n248), .B(n235), .C(n68), .YC(n67), .YS(product[15]) );
  FAX1 U69 ( .A(n260), .B(n249), .C(n69), .YC(n68), .YS(product[14]) );
  FAX1 U70 ( .A(n272), .B(n261), .C(n70), .YC(n69), .YS(product[13]) );
  FAX1 U71 ( .A(n282), .B(n273), .C(n71), .YC(n70), .YS(product[12]) );
  FAX1 U72 ( .A(n292), .B(n283), .C(n72), .YC(n71), .YS(product[11]) );
  FAX1 U73 ( .A(n300), .B(n293), .C(n73), .YC(n72), .YS(product[10]) );
  FAX1 U74 ( .A(n308), .B(n301), .C(n74), .YC(n73), .YS(product[9]) );
  FAX1 U75 ( .A(n314), .B(n309), .C(n75), .YC(n74), .YS(product[8]) );
  FAX1 U76 ( .A(n320), .B(n315), .C(n76), .YC(n75), .YS(product[7]) );
  FAX1 U77 ( .A(n324), .B(n321), .C(n77), .YC(n76), .YS(product[6]) );
  FAX1 U78 ( .A(n328), .B(n325), .C(n78), .YC(n77), .YS(product[5]) );
  FAX1 U79 ( .A(n330), .B(n329), .C(n79), .YC(n78), .YS(product[4]) );
  FAX1 U80 ( .A(n363), .B(n331), .C(n80), .YC(n79), .YS(product[3]) );
  FAX1 U81 ( .A(n516), .B(n500), .C(n81), .YC(n80), .YS(product[2]) );
  HAX1 U82 ( .A(n364), .B(n517), .YC(n81), .YS(product[1]) );
  FAX1 U85 ( .A(n87), .B(n376), .C(n90), .YC(n84), .YS(n85) );
  FAX1 U87 ( .A(n393), .B(n91), .C(n94), .YC(n88), .YS(n89) );
  FAX1 U88 ( .A(n853), .B(n366), .C(n377), .YC(n90), .YS(n91) );
  FAX1 U89 ( .A(n102), .B(n95), .C(n100), .YC(n92), .YS(n93) );
  FAX1 U90 ( .A(n97), .B(n394), .C(n378), .YC(n94), .YS(n95) );
  FAX1 U92 ( .A(n108), .B(n106), .C(n101), .YC(n98), .YS(n99) );
  FAX1 U93 ( .A(n379), .B(n411), .C(n103), .YC(n100), .YS(n101) );
  FAX1 U94 ( .A(n857), .B(n367), .C(n395), .YC(n102), .YS(n103) );
  FAX1 U95 ( .A(n109), .B(n107), .C(n114), .YC(n104), .YS(n105) );
  FAX1 U96 ( .A(n380), .B(n118), .C(n116), .YC(n106), .YS(n107) );
  FAX1 U97 ( .A(n111), .B(n412), .C(n396), .YC(n108), .YS(n109) );
  FAX1 U99 ( .A(n124), .B(n115), .C(n122), .YC(n112), .YS(n113) );
  FAX1 U100 ( .A(n119), .B(n126), .C(n117), .YC(n114), .YS(n115) );
  FAX1 U101 ( .A(n381), .B(n397), .C(n429), .YC(n116), .YS(n117) );
  FAX1 U102 ( .A(n856), .B(n368), .C(n413), .YC(n118), .YS(n119) );
  FAX1 U103 ( .A(n134), .B(n123), .C(n132), .YC(n120), .YS(n121) );
  FAX1 U104 ( .A(n136), .B(n127), .C(n125), .YC(n122), .YS(n123) );
  FAX1 U105 ( .A(n398), .B(n382), .C(n138), .YC(n124), .YS(n125) );
  FAX1 U106 ( .A(n129), .B(n430), .C(n414), .YC(n126), .YS(n127) );
  FAX1 U108 ( .A(n135), .B(n142), .C(n133), .YC(n130), .YS(n131) );
  FAX1 U109 ( .A(n146), .B(n137), .C(n144), .YC(n132), .YS(n133) );
  FAX1 U110 ( .A(n383), .B(n139), .C(n148), .YC(n134), .YS(n135) );
  FAX1 U111 ( .A(n399), .B(n431), .C(n447), .YC(n136), .YS(n137) );
  FAX1 U112 ( .A(n855), .B(n369), .C(n415), .YC(n138), .YS(n139) );
  FAX1 U113 ( .A(n145), .B(n143), .C(n154), .YC(n140), .YS(n141) );
  FAX1 U114 ( .A(n147), .B(n158), .C(n156), .YC(n142), .YS(n143) );
  FAX1 U115 ( .A(n162), .B(n160), .C(n149), .YC(n144), .YS(n145) );
  FAX1 U116 ( .A(n384), .B(n400), .C(n416), .YC(n146), .YS(n147) );
  FAX1 U117 ( .A(n151), .B(n448), .C(n432), .YC(n148), .YS(n149) );
  FAX1 U119 ( .A(n157), .B(n166), .C(n155), .YC(n152), .YS(n153) );
  FAX1 U120 ( .A(n159), .B(n170), .C(n168), .YC(n154), .YS(n155) );
  FAX1 U121 ( .A(n174), .B(n172), .C(n161), .YC(n156), .YS(n157) );
  FAX1 U122 ( .A(n449), .B(n417), .C(n163), .YC(n158), .YS(n159) );
  FAX1 U123 ( .A(n401), .B(n385), .C(n465), .YC(n160), .YS(n161) );
  FAX1 U124 ( .A(n854), .B(n370), .C(n433), .YC(n162), .YS(n163) );
  FAX1 U125 ( .A(n169), .B(n180), .C(n167), .YC(n164), .YS(n165) );
  FAX1 U126 ( .A(n184), .B(n171), .C(n182), .YC(n166), .YS(n167) );
  FAX1 U127 ( .A(n186), .B(n175), .C(n173), .YC(n168), .YS(n169) );
  FAX1 U128 ( .A(n402), .B(n190), .C(n188), .YC(n170), .YS(n171) );
  FAX1 U129 ( .A(n434), .B(n386), .C(n418), .YC(n172), .YS(n173) );
  FAX1 U130 ( .A(n177), .B(n466), .C(n450), .YC(n174), .YS(n175) );
  FAX1 U132 ( .A(n183), .B(n194), .C(n181), .YC(n178), .YS(n179) );
  FAX1 U133 ( .A(n198), .B(n185), .C(n196), .YC(n180), .YS(n181) );
  FAX1 U134 ( .A(n191), .B(n189), .C(n187), .YC(n182), .YS(n183) );
  FAX1 U135 ( .A(n204), .B(n202), .C(n200), .YC(n184), .YS(n185) );
  FAX1 U136 ( .A(n467), .B(n451), .C(n799), .YC(n186), .YS(n187) );
  FAX1 U137 ( .A(n419), .B(n403), .C(n483), .YC(n188), .YS(n189) );
  FAX1 U138 ( .A(n371), .B(n387), .C(n435), .YC(n190), .YS(n191) );
  FAX1 U139 ( .A(n197), .B(n208), .C(n195), .YC(n192), .YS(n193) );
  FAX1 U140 ( .A(n212), .B(n199), .C(n210), .YC(n194), .YS(n195) );
  FAX1 U141 ( .A(n214), .B(n201), .C(n203), .YC(n196), .YS(n197) );
  FAX1 U142 ( .A(n218), .B(n205), .C(n216), .YC(n198), .YS(n199) );
  FAX1 U143 ( .A(n452), .B(n404), .C(n436), .YC(n200), .YS(n201) );
  FAX1 U144 ( .A(n420), .B(n468), .C(n388), .YC(n202), .YS(n203) );
  FAX1 U145 ( .A(n354), .B(n372), .C(n484), .YC(n204), .YS(n205) );
  FAX1 U146 ( .A(n211), .B(n222), .C(n209), .YC(n206), .YS(n207) );
  FAX1 U147 ( .A(n226), .B(n213), .C(n224), .YC(n208), .YS(n209) );
  FAX1 U148 ( .A(n230), .B(n215), .C(n217), .YC(n210), .YS(n211) );
  FAX1 U149 ( .A(n219), .B(n232), .C(n228), .YC(n212), .YS(n213) );
  FAX1 U150 ( .A(n453), .B(n405), .C(n437), .YC(n214), .YS(n215) );
  FAX1 U151 ( .A(n421), .B(n469), .C(n389), .YC(n216), .YS(n217) );
  FAX1 U152 ( .A(n354), .B(n373), .C(n485), .YC(n218), .YS(n219) );
  FAX1 U153 ( .A(n225), .B(n236), .C(n223), .YC(n220), .YS(n221) );
  FAX1 U154 ( .A(n240), .B(n227), .C(n238), .YC(n222), .YS(n223) );
  FAX1 U155 ( .A(n233), .B(n229), .C(n231), .YC(n224), .YS(n225) );
  FAX1 U156 ( .A(n246), .B(n244), .C(n242), .YC(n226), .YS(n227) );
  FAX1 U157 ( .A(n454), .B(n422), .C(n438), .YC(n228), .YS(n229) );
  FAX1 U158 ( .A(n470), .B(n390), .C(n406), .YC(n230), .YS(n231) );
  FAX1 U159 ( .A(n374), .B(n502), .C(n486), .YC(n232), .YS(n233) );
  FAX1 U160 ( .A(n239), .B(n250), .C(n237), .YC(n234), .YS(n235) );
  FAX1 U161 ( .A(n254), .B(n241), .C(n252), .YC(n236), .YS(n237) );
  FAX1 U162 ( .A(n256), .B(n243), .C(n245), .YC(n238), .YS(n239) );
  FAX1 U163 ( .A(n471), .B(n247), .C(n258), .YC(n240), .YS(n241) );
  FAX1 U164 ( .A(n487), .B(n423), .C(n455), .YC(n242), .YS(n243) );
  FAX1 U165 ( .A(n439), .B(n391), .C(n407), .YC(n244), .YS(n245) );
  HAX1 U166 ( .A(n503), .B(n357), .YC(n246), .YS(n247) );
  FAX1 U167 ( .A(n253), .B(n262), .C(n251), .YC(n248), .YS(n249) );
  FAX1 U168 ( .A(n259), .B(n255), .C(n264), .YC(n250), .YS(n251) );
  FAX1 U169 ( .A(n268), .B(n266), .C(n257), .YC(n252), .YS(n253) );
  FAX1 U170 ( .A(n472), .B(n456), .C(n270), .YC(n254), .YS(n255) );
  FAX1 U171 ( .A(n488), .B(n424), .C(n440), .YC(n256), .YS(n257) );
  FAX1 U172 ( .A(n504), .B(n408), .C(n392), .YC(n258), .YS(n259) );
  FAX1 U173 ( .A(n265), .B(n274), .C(n263), .YC(n260), .YS(n261) );
  FAX1 U174 ( .A(n267), .B(n269), .C(n276), .YC(n262), .YS(n263) );
  FAX1 U175 ( .A(n271), .B(n280), .C(n278), .YC(n264), .YS(n265) );
  FAX1 U176 ( .A(n457), .B(n409), .C(n425), .YC(n266), .YS(n267) );
  FAX1 U177 ( .A(n441), .B(n489), .C(n473), .YC(n268), .YS(n269) );
  HAX1 U178 ( .A(n505), .B(n358), .YC(n270), .YS(n271) );
  FAX1 U179 ( .A(n277), .B(n284), .C(n275), .YC(n272), .YS(n273) );
  FAX1 U180 ( .A(n281), .B(n279), .C(n286), .YC(n274), .YS(n275) );
  FAX1 U181 ( .A(n474), .B(n290), .C(n288), .YC(n276), .YS(n277) );
  FAX1 U182 ( .A(n490), .B(n442), .C(n458), .YC(n278), .YS(n279) );
  FAX1 U183 ( .A(n506), .B(n426), .C(n410), .YC(n280), .YS(n281) );
  FAX1 U184 ( .A(n287), .B(n294), .C(n285), .YC(n282), .YS(n283) );
  FAX1 U185 ( .A(n298), .B(n296), .C(n289), .YC(n284), .YS(n285) );
  FAX1 U186 ( .A(n475), .B(n443), .C(n291), .YC(n286), .YS(n287) );
  FAX1 U187 ( .A(n459), .B(n427), .C(n491), .YC(n288), .YS(n289) );
  HAX1 U188 ( .A(n507), .B(n359), .YC(n290), .YS(n291) );
  FAX1 U189 ( .A(n297), .B(n302), .C(n295), .YC(n292), .YS(n293) );
  FAX1 U190 ( .A(n306), .B(n304), .C(n299), .YC(n294), .YS(n295) );
  FAX1 U191 ( .A(n492), .B(n460), .C(n476), .YC(n296), .YS(n297) );
  FAX1 U192 ( .A(n508), .B(n444), .C(n428), .YC(n298), .YS(n299) );
  FAX1 U193 ( .A(n305), .B(n310), .C(n303), .YC(n300), .YS(n301) );
  FAX1 U194 ( .A(n493), .B(n307), .C(n312), .YC(n302), .YS(n303) );
  FAX1 U195 ( .A(n461), .B(n445), .C(n477), .YC(n304), .YS(n305) );
  HAX1 U196 ( .A(n509), .B(n360), .YC(n306), .YS(n307) );
  FAX1 U197 ( .A(n316), .B(n313), .C(n311), .YC(n308), .YS(n309) );
  FAX1 U198 ( .A(n494), .B(n478), .C(n318), .YC(n310), .YS(n311) );
  FAX1 U199 ( .A(n510), .B(n462), .C(n446), .YC(n312), .YS(n313) );
  FAX1 U200 ( .A(n319), .B(n322), .C(n317), .YC(n314), .YS(n315) );
  FAX1 U201 ( .A(n495), .B(n463), .C(n479), .YC(n316), .YS(n317) );
  HAX1 U202 ( .A(n511), .B(n361), .YC(n318), .YS(n319) );
  FAX1 U203 ( .A(n496), .B(n326), .C(n323), .YC(n320), .YS(n321) );
  FAX1 U204 ( .A(n512), .B(n480), .C(n464), .YC(n322), .YS(n323) );
  FAX1 U205 ( .A(n497), .B(n481), .C(n327), .YC(n324), .YS(n325) );
  HAX1 U206 ( .A(n513), .B(n362), .YC(n326), .YS(n327) );
  FAX1 U207 ( .A(n514), .B(n498), .C(n482), .YC(n328), .YS(n329) );
  HAX1 U208 ( .A(n515), .B(n499), .YC(n330), .YS(n331) );
  INVX2 U604 ( .A(a[0]), .Y(n866) );
  AND2X2 U605 ( .A(n354), .B(n866), .Y(n786) );
  INVX2 U606 ( .A(n787), .Y(n807) );
  INVX2 U607 ( .A(n841), .Y(n842) );
  INVX2 U608 ( .A(n840), .Y(n843) );
  AND2X2 U609 ( .A(n858), .B(n1019), .Y(n787) );
  INVX2 U610 ( .A(n844), .Y(n847) );
  INVX2 U611 ( .A(n845), .Y(n846) );
  INVX2 U612 ( .A(n849), .Y(n852) );
  INVX2 U613 ( .A(n848), .Y(n851) );
  INVX2 U614 ( .A(n903), .Y(n864) );
  INVX2 U615 ( .A(n920), .Y(n863) );
  INVX2 U616 ( .A(n788), .Y(n801) );
  INVX2 U617 ( .A(n789), .Y(n802) );
  INVX2 U618 ( .A(n954), .Y(n861) );
  INVX2 U619 ( .A(n790), .Y(n804) );
  INVX2 U620 ( .A(n971), .Y(n860) );
  INVX2 U621 ( .A(n937), .Y(n862) );
  BUFX2 U622 ( .A(a[5]), .Y(n840) );
  INVX2 U623 ( .A(n792), .Y(n805) );
  INVX2 U624 ( .A(n791), .Y(n803) );
  BUFX2 U625 ( .A(a[5]), .Y(n841) );
  INVX2 U626 ( .A(n988), .Y(n859) );
  INVX2 U627 ( .A(n1018), .Y(n858) );
  BUFX2 U628 ( .A(a[11]), .Y(n844) );
  INVX2 U629 ( .A(n793), .Y(n806) );
  BUFX2 U630 ( .A(a[15]), .Y(n848) );
  BUFX2 U631 ( .A(a[11]), .Y(n845) );
  BUFX2 U632 ( .A(a[15]), .Y(n849) );
  BUFX2 U633 ( .A(a[15]), .Y(n850) );
  INVX2 U634 ( .A(n786), .Y(n800) );
  INVX4 U635 ( .A(n798), .Y(n799) );
  INVX2 U636 ( .A(n865), .Y(n798) );
  INVX1 U637 ( .A(n354), .Y(n865) );
  INVX4 U638 ( .A(a[3]), .Y(n797) );
  AND2X2 U639 ( .A(n864), .B(n1006), .Y(n788) );
  AND2X2 U640 ( .A(n863), .B(n1008), .Y(n789) );
  INVX4 U641 ( .A(a[7]), .Y(n796) );
  AND2X2 U642 ( .A(n861), .B(n1012), .Y(n790) );
  AND2X2 U643 ( .A(n862), .B(n1010), .Y(n791) );
  INVX4 U644 ( .A(a[9]), .Y(n795) );
  INVX2 U645 ( .A(n812), .Y(n813) );
  INVX2 U646 ( .A(b[2]), .Y(n812) );
  INVX2 U647 ( .A(n808), .Y(n809) );
  INVX2 U648 ( .A(b[0]), .Y(n808) );
  INVX2 U649 ( .A(n810), .Y(n811) );
  INVX2 U650 ( .A(b[1]), .Y(n810) );
  INVX2 U651 ( .A(n818), .Y(n819) );
  INVX2 U652 ( .A(b[5]), .Y(n818) );
  INVX2 U653 ( .A(n814), .Y(n815) );
  INVX2 U654 ( .A(b[3]), .Y(n814) );
  INVX2 U655 ( .A(n816), .Y(n817) );
  INVX2 U656 ( .A(b[4]), .Y(n816) );
  AND2X2 U657 ( .A(n860), .B(n1014), .Y(n792) );
  INVX4 U658 ( .A(a[13]), .Y(n794) );
  INVX2 U659 ( .A(n822), .Y(n823) );
  INVX2 U660 ( .A(b[7]), .Y(n822) );
  INVX2 U661 ( .A(n820), .Y(n821) );
  INVX2 U662 ( .A(b[6]), .Y(n820) );
  INVX2 U663 ( .A(n824), .Y(n825) );
  INVX2 U664 ( .A(b[8]), .Y(n824) );
  AND2X2 U665 ( .A(n859), .B(n1016), .Y(n793) );
  INVX2 U666 ( .A(n826), .Y(n827) );
  INVX2 U667 ( .A(b[9]), .Y(n826) );
  INVX2 U668 ( .A(n830), .Y(n831) );
  INVX2 U669 ( .A(b[11]), .Y(n830) );
  INVX2 U670 ( .A(n828), .Y(n829) );
  INVX2 U671 ( .A(b[10]), .Y(n828) );
  INVX2 U672 ( .A(n834), .Y(n835) );
  INVX2 U673 ( .A(b[13]), .Y(n834) );
  INVX2 U674 ( .A(n832), .Y(n833) );
  INVX2 U675 ( .A(b[12]), .Y(n832) );
  INVX2 U676 ( .A(n838), .Y(n839) );
  INVX2 U677 ( .A(b[15]), .Y(n838) );
  INVX2 U678 ( .A(n836), .Y(n837) );
  INVX2 U679 ( .A(b[14]), .Y(n836) );
  INVX2 U680 ( .A(n97), .Y(n853) );
  INVX2 U681 ( .A(n177), .Y(n854) );
  INVX2 U682 ( .A(n151), .Y(n855) );
  INVX2 U683 ( .A(n129), .Y(n856) );
  INVX2 U684 ( .A(n111), .Y(n857) );
  XOR2X1 U685 ( .A(n867), .B(n868), .Y(product[31]) );
  XNOR2X1 U686 ( .A(n869), .B(n870), .Y(n868) );
  OAI22X1 U687 ( .A(n807), .B(n852), .C(n852), .D(n858), .Y(n870) );
  AND2X1 U688 ( .A(n850), .B(n839), .Y(n869) );
  XOR2X1 U689 ( .A(n87), .B(n871), .Y(n867) );
  XNOR2X1 U690 ( .A(n84), .B(n52), .Y(n871) );
  NOR2X1 U691 ( .A(n866), .B(n808), .Y(product[0]) );
  NAND2X1 U692 ( .A(n833), .B(n849), .Y(n97) );
  NAND2X1 U693 ( .A(n837), .B(n849), .Y(n87) );
  OAI22X1 U694 ( .A(n872), .B(n866), .C(n809), .D(n800), .Y(n517) );
  OAI22X1 U695 ( .A(n873), .B(n866), .C(n872), .D(n800), .Y(n516) );
  XOR2X1 U696 ( .A(n811), .B(n799), .Y(n872) );
  OAI22X1 U697 ( .A(n874), .B(n866), .C(n873), .D(n800), .Y(n515) );
  XOR2X1 U698 ( .A(n813), .B(n799), .Y(n873) );
  OAI22X1 U699 ( .A(n875), .B(n866), .C(n874), .D(n800), .Y(n514) );
  XOR2X1 U700 ( .A(n815), .B(n799), .Y(n874) );
  OAI22X1 U701 ( .A(n876), .B(n866), .C(n875), .D(n800), .Y(n513) );
  XOR2X1 U702 ( .A(n817), .B(n799), .Y(n875) );
  OAI22X1 U703 ( .A(n877), .B(n866), .C(n876), .D(n800), .Y(n512) );
  XOR2X1 U704 ( .A(n819), .B(n799), .Y(n876) );
  OAI22X1 U705 ( .A(n878), .B(n866), .C(n877), .D(n800), .Y(n511) );
  XOR2X1 U706 ( .A(n821), .B(n799), .Y(n877) );
  OAI22X1 U707 ( .A(n879), .B(n866), .C(n878), .D(n800), .Y(n510) );
  XOR2X1 U708 ( .A(n823), .B(n799), .Y(n878) );
  OAI22X1 U709 ( .A(n880), .B(n866), .C(n879), .D(n800), .Y(n509) );
  XOR2X1 U710 ( .A(n825), .B(n799), .Y(n879) );
  OAI22X1 U711 ( .A(n881), .B(n866), .C(n880), .D(n800), .Y(n508) );
  XOR2X1 U712 ( .A(n827), .B(n799), .Y(n880) );
  OAI22X1 U713 ( .A(n882), .B(n866), .C(n881), .D(n800), .Y(n507) );
  XOR2X1 U714 ( .A(n829), .B(n799), .Y(n881) );
  OAI22X1 U715 ( .A(n883), .B(n866), .C(n882), .D(n800), .Y(n506) );
  XOR2X1 U716 ( .A(n831), .B(n799), .Y(n882) );
  OAI22X1 U717 ( .A(n884), .B(n866), .C(n883), .D(n800), .Y(n505) );
  XOR2X1 U718 ( .A(n833), .B(n799), .Y(n883) );
  OAI22X1 U719 ( .A(n885), .B(n866), .C(n884), .D(n800), .Y(n504) );
  XOR2X1 U720 ( .A(n835), .B(n799), .Y(n884) );
  OAI22X1 U721 ( .A(n886), .B(n866), .C(n885), .D(n800), .Y(n503) );
  XOR2X1 U722 ( .A(n837), .B(n799), .Y(n885) );
  OAI22X1 U723 ( .A(n799), .B(n866), .C(n886), .D(n800), .Y(n502) );
  XOR2X1 U724 ( .A(n839), .B(n799), .Y(n886) );
  NOR2X1 U725 ( .A(n864), .B(n808), .Y(n500) );
  OAI22X1 U726 ( .A(n864), .B(n887), .C(n888), .D(n801), .Y(n499) );
  XOR2X1 U727 ( .A(n797), .B(n809), .Y(n888) );
  OAI22X1 U728 ( .A(n864), .B(n889), .C(n887), .D(n801), .Y(n498) );
  XOR2X1 U729 ( .A(n811), .B(n797), .Y(n887) );
  OAI22X1 U730 ( .A(n864), .B(n890), .C(n889), .D(n801), .Y(n497) );
  XOR2X1 U731 ( .A(n813), .B(n797), .Y(n889) );
  OAI22X1 U732 ( .A(n864), .B(n891), .C(n890), .D(n801), .Y(n496) );
  XOR2X1 U733 ( .A(n815), .B(n797), .Y(n890) );
  OAI22X1 U734 ( .A(n864), .B(n892), .C(n891), .D(n801), .Y(n495) );
  XOR2X1 U735 ( .A(n817), .B(n797), .Y(n891) );
  OAI22X1 U736 ( .A(n864), .B(n893), .C(n892), .D(n801), .Y(n494) );
  XOR2X1 U737 ( .A(n819), .B(n797), .Y(n892) );
  OAI22X1 U738 ( .A(n864), .B(n894), .C(n893), .D(n801), .Y(n493) );
  XOR2X1 U739 ( .A(n821), .B(n797), .Y(n893) );
  OAI22X1 U740 ( .A(n864), .B(n895), .C(n894), .D(n801), .Y(n492) );
  XOR2X1 U741 ( .A(n823), .B(n797), .Y(n894) );
  OAI22X1 U742 ( .A(n864), .B(n896), .C(n895), .D(n801), .Y(n491) );
  XOR2X1 U743 ( .A(n825), .B(n797), .Y(n895) );
  OAI22X1 U744 ( .A(n864), .B(n897), .C(n896), .D(n801), .Y(n490) );
  XOR2X1 U745 ( .A(n827), .B(n797), .Y(n896) );
  OAI22X1 U746 ( .A(n864), .B(n898), .C(n897), .D(n801), .Y(n489) );
  XOR2X1 U747 ( .A(n829), .B(n797), .Y(n897) );
  OAI22X1 U748 ( .A(n864), .B(n899), .C(n898), .D(n801), .Y(n488) );
  XOR2X1 U749 ( .A(n831), .B(n797), .Y(n898) );
  OAI22X1 U750 ( .A(n864), .B(n900), .C(n899), .D(n801), .Y(n487) );
  XOR2X1 U751 ( .A(n833), .B(n797), .Y(n899) );
  OAI22X1 U752 ( .A(n864), .B(n901), .C(n900), .D(n801), .Y(n486) );
  XOR2X1 U753 ( .A(n835), .B(n797), .Y(n900) );
  OAI22X1 U754 ( .A(n864), .B(n902), .C(n901), .D(n801), .Y(n485) );
  XOR2X1 U755 ( .A(n837), .B(n797), .Y(n901) );
  OAI22X1 U756 ( .A(n864), .B(n797), .C(n902), .D(n801), .Y(n484) );
  XOR2X1 U757 ( .A(n839), .B(n797), .Y(n902) );
  AOI22X1 U758 ( .A(n788), .B(a[3]), .C(a[3]), .D(n903), .Y(n483) );
  NOR2X1 U759 ( .A(n863), .B(n808), .Y(n482) );
  OAI22X1 U760 ( .A(n863), .B(n904), .C(n905), .D(n802), .Y(n481) );
  XOR2X1 U761 ( .A(n843), .B(n809), .Y(n905) );
  OAI22X1 U762 ( .A(n863), .B(n906), .C(n904), .D(n802), .Y(n480) );
  XOR2X1 U763 ( .A(n811), .B(n843), .Y(n904) );
  OAI22X1 U764 ( .A(n863), .B(n907), .C(n906), .D(n802), .Y(n479) );
  XOR2X1 U765 ( .A(n813), .B(n843), .Y(n906) );
  OAI22X1 U766 ( .A(n863), .B(n908), .C(n907), .D(n802), .Y(n478) );
  XOR2X1 U767 ( .A(n815), .B(n842), .Y(n907) );
  OAI22X1 U768 ( .A(n863), .B(n909), .C(n908), .D(n802), .Y(n477) );
  XOR2X1 U769 ( .A(n817), .B(n842), .Y(n908) );
  OAI22X1 U770 ( .A(n863), .B(n910), .C(n909), .D(n802), .Y(n476) );
  XOR2X1 U771 ( .A(n819), .B(n842), .Y(n909) );
  OAI22X1 U772 ( .A(n863), .B(n911), .C(n910), .D(n802), .Y(n475) );
  XOR2X1 U773 ( .A(n821), .B(n842), .Y(n910) );
  OAI22X1 U774 ( .A(n863), .B(n912), .C(n911), .D(n802), .Y(n474) );
  XOR2X1 U775 ( .A(n823), .B(n842), .Y(n911) );
  OAI22X1 U776 ( .A(n863), .B(n913), .C(n912), .D(n802), .Y(n473) );
  XOR2X1 U777 ( .A(n825), .B(n842), .Y(n912) );
  OAI22X1 U778 ( .A(n863), .B(n914), .C(n913), .D(n802), .Y(n472) );
  XOR2X1 U779 ( .A(n827), .B(n842), .Y(n913) );
  OAI22X1 U780 ( .A(n863), .B(n915), .C(n914), .D(n802), .Y(n471) );
  XOR2X1 U781 ( .A(n829), .B(n842), .Y(n914) );
  OAI22X1 U782 ( .A(n863), .B(n916), .C(n915), .D(n802), .Y(n470) );
  XOR2X1 U783 ( .A(n831), .B(n842), .Y(n915) );
  OAI22X1 U784 ( .A(n863), .B(n917), .C(n916), .D(n802), .Y(n469) );
  XOR2X1 U785 ( .A(n833), .B(n842), .Y(n916) );
  OAI22X1 U786 ( .A(n863), .B(n918), .C(n917), .D(n802), .Y(n468) );
  XOR2X1 U787 ( .A(n835), .B(n842), .Y(n917) );
  OAI22X1 U788 ( .A(n863), .B(n919), .C(n918), .D(n802), .Y(n467) );
  XOR2X1 U789 ( .A(n837), .B(n842), .Y(n918) );
  OAI22X1 U790 ( .A(n863), .B(n843), .C(n919), .D(n802), .Y(n466) );
  XOR2X1 U791 ( .A(n839), .B(n842), .Y(n919) );
  AOI22X1 U792 ( .A(n789), .B(n841), .C(n841), .D(n920), .Y(n465) );
  NOR2X1 U793 ( .A(n862), .B(n808), .Y(n464) );
  OAI22X1 U794 ( .A(n862), .B(n921), .C(n922), .D(n803), .Y(n463) );
  XOR2X1 U795 ( .A(n796), .B(n809), .Y(n922) );
  OAI22X1 U796 ( .A(n862), .B(n923), .C(n921), .D(n803), .Y(n462) );
  XOR2X1 U797 ( .A(n811), .B(n796), .Y(n921) );
  OAI22X1 U798 ( .A(n862), .B(n924), .C(n923), .D(n803), .Y(n461) );
  XOR2X1 U799 ( .A(n813), .B(n796), .Y(n923) );
  OAI22X1 U800 ( .A(n862), .B(n925), .C(n924), .D(n803), .Y(n460) );
  XOR2X1 U801 ( .A(n815), .B(n796), .Y(n924) );
  OAI22X1 U802 ( .A(n862), .B(n926), .C(n925), .D(n803), .Y(n459) );
  XOR2X1 U803 ( .A(n817), .B(n796), .Y(n925) );
  OAI22X1 U804 ( .A(n862), .B(n927), .C(n926), .D(n803), .Y(n458) );
  XOR2X1 U805 ( .A(n819), .B(n796), .Y(n926) );
  OAI22X1 U806 ( .A(n862), .B(n928), .C(n927), .D(n803), .Y(n457) );
  XOR2X1 U807 ( .A(n821), .B(n796), .Y(n927) );
  OAI22X1 U808 ( .A(n862), .B(n929), .C(n928), .D(n803), .Y(n456) );
  XOR2X1 U809 ( .A(n823), .B(n796), .Y(n928) );
  OAI22X1 U810 ( .A(n862), .B(n930), .C(n929), .D(n803), .Y(n455) );
  XOR2X1 U811 ( .A(n825), .B(n796), .Y(n929) );
  OAI22X1 U812 ( .A(n862), .B(n931), .C(n930), .D(n803), .Y(n454) );
  XOR2X1 U813 ( .A(n827), .B(n796), .Y(n930) );
  OAI22X1 U814 ( .A(n862), .B(n932), .C(n931), .D(n803), .Y(n453) );
  XOR2X1 U815 ( .A(n829), .B(n796), .Y(n931) );
  OAI22X1 U816 ( .A(n862), .B(n933), .C(n932), .D(n803), .Y(n452) );
  XOR2X1 U817 ( .A(n831), .B(n796), .Y(n932) );
  OAI22X1 U818 ( .A(n862), .B(n934), .C(n933), .D(n803), .Y(n451) );
  XOR2X1 U819 ( .A(n833), .B(n796), .Y(n933) );
  OAI22X1 U820 ( .A(n862), .B(n935), .C(n934), .D(n803), .Y(n450) );
  XOR2X1 U821 ( .A(n835), .B(n796), .Y(n934) );
  OAI22X1 U822 ( .A(n862), .B(n936), .C(n935), .D(n803), .Y(n449) );
  XOR2X1 U823 ( .A(n837), .B(n796), .Y(n935) );
  OAI22X1 U824 ( .A(n862), .B(n796), .C(n936), .D(n803), .Y(n448) );
  XOR2X1 U825 ( .A(n839), .B(n796), .Y(n936) );
  AOI22X1 U826 ( .A(n791), .B(a[7]), .C(a[7]), .D(n937), .Y(n447) );
  NOR2X1 U827 ( .A(n861), .B(n808), .Y(n446) );
  OAI22X1 U828 ( .A(n861), .B(n938), .C(n939), .D(n804), .Y(n445) );
  XOR2X1 U829 ( .A(n795), .B(n809), .Y(n939) );
  OAI22X1 U830 ( .A(n861), .B(n940), .C(n938), .D(n804), .Y(n444) );
  XOR2X1 U831 ( .A(n811), .B(n795), .Y(n938) );
  OAI22X1 U832 ( .A(n861), .B(n941), .C(n940), .D(n804), .Y(n443) );
  XOR2X1 U833 ( .A(n813), .B(n795), .Y(n940) );
  OAI22X1 U834 ( .A(n861), .B(n942), .C(n941), .D(n804), .Y(n442) );
  XOR2X1 U835 ( .A(n815), .B(n795), .Y(n941) );
  OAI22X1 U836 ( .A(n861), .B(n943), .C(n942), .D(n804), .Y(n441) );
  XOR2X1 U837 ( .A(n817), .B(n795), .Y(n942) );
  OAI22X1 U838 ( .A(n861), .B(n944), .C(n943), .D(n804), .Y(n440) );
  XOR2X1 U839 ( .A(n819), .B(n795), .Y(n943) );
  OAI22X1 U840 ( .A(n861), .B(n945), .C(n944), .D(n804), .Y(n439) );
  XOR2X1 U841 ( .A(n821), .B(n795), .Y(n944) );
  OAI22X1 U842 ( .A(n861), .B(n946), .C(n945), .D(n804), .Y(n438) );
  XOR2X1 U843 ( .A(n823), .B(n795), .Y(n945) );
  OAI22X1 U844 ( .A(n861), .B(n947), .C(n946), .D(n804), .Y(n437) );
  XOR2X1 U845 ( .A(n825), .B(n795), .Y(n946) );
  OAI22X1 U846 ( .A(n861), .B(n948), .C(n947), .D(n804), .Y(n436) );
  XOR2X1 U847 ( .A(n827), .B(n795), .Y(n947) );
  OAI22X1 U848 ( .A(n861), .B(n949), .C(n948), .D(n804), .Y(n435) );
  XOR2X1 U849 ( .A(n829), .B(n795), .Y(n948) );
  OAI22X1 U850 ( .A(n861), .B(n950), .C(n949), .D(n804), .Y(n434) );
  XOR2X1 U851 ( .A(n831), .B(n795), .Y(n949) );
  OAI22X1 U852 ( .A(n861), .B(n951), .C(n950), .D(n804), .Y(n433) );
  XOR2X1 U853 ( .A(n833), .B(n795), .Y(n950) );
  OAI22X1 U854 ( .A(n861), .B(n952), .C(n951), .D(n804), .Y(n432) );
  XOR2X1 U855 ( .A(n835), .B(n795), .Y(n951) );
  OAI22X1 U856 ( .A(n861), .B(n953), .C(n952), .D(n804), .Y(n431) );
  XOR2X1 U857 ( .A(n837), .B(n795), .Y(n952) );
  OAI22X1 U858 ( .A(n861), .B(n795), .C(n953), .D(n804), .Y(n430) );
  XOR2X1 U859 ( .A(n839), .B(n795), .Y(n953) );
  AOI22X1 U860 ( .A(n790), .B(a[9]), .C(a[9]), .D(n954), .Y(n429) );
  NOR2X1 U861 ( .A(n860), .B(n808), .Y(n428) );
  OAI22X1 U862 ( .A(n860), .B(n955), .C(n956), .D(n805), .Y(n427) );
  XOR2X1 U863 ( .A(n847), .B(n809), .Y(n956) );
  OAI22X1 U864 ( .A(n860), .B(n957), .C(n955), .D(n805), .Y(n426) );
  XOR2X1 U865 ( .A(n811), .B(n847), .Y(n955) );
  OAI22X1 U866 ( .A(n860), .B(n958), .C(n957), .D(n805), .Y(n425) );
  XOR2X1 U867 ( .A(n813), .B(n847), .Y(n957) );
  OAI22X1 U868 ( .A(n860), .B(n959), .C(n958), .D(n805), .Y(n424) );
  XOR2X1 U869 ( .A(n815), .B(n846), .Y(n958) );
  OAI22X1 U870 ( .A(n860), .B(n960), .C(n959), .D(n805), .Y(n423) );
  XOR2X1 U871 ( .A(n817), .B(n846), .Y(n959) );
  OAI22X1 U872 ( .A(n860), .B(n961), .C(n960), .D(n805), .Y(n422) );
  XOR2X1 U873 ( .A(n819), .B(n846), .Y(n960) );
  OAI22X1 U874 ( .A(n860), .B(n962), .C(n961), .D(n805), .Y(n421) );
  XOR2X1 U875 ( .A(n821), .B(n846), .Y(n961) );
  OAI22X1 U876 ( .A(n860), .B(n963), .C(n962), .D(n805), .Y(n420) );
  XOR2X1 U877 ( .A(n823), .B(n846), .Y(n962) );
  OAI22X1 U878 ( .A(n860), .B(n964), .C(n963), .D(n805), .Y(n419) );
  XOR2X1 U879 ( .A(n825), .B(n846), .Y(n963) );
  OAI22X1 U880 ( .A(n860), .B(n965), .C(n964), .D(n805), .Y(n418) );
  XOR2X1 U881 ( .A(n827), .B(n846), .Y(n964) );
  OAI22X1 U882 ( .A(n860), .B(n966), .C(n965), .D(n805), .Y(n417) );
  XOR2X1 U883 ( .A(n829), .B(n846), .Y(n965) );
  OAI22X1 U884 ( .A(n860), .B(n967), .C(n966), .D(n805), .Y(n416) );
  XOR2X1 U885 ( .A(n831), .B(n846), .Y(n966) );
  OAI22X1 U886 ( .A(n860), .B(n968), .C(n967), .D(n805), .Y(n415) );
  XOR2X1 U887 ( .A(n833), .B(n846), .Y(n967) );
  OAI22X1 U888 ( .A(n860), .B(n969), .C(n968), .D(n805), .Y(n414) );
  XOR2X1 U889 ( .A(n835), .B(n846), .Y(n968) );
  OAI22X1 U890 ( .A(n860), .B(n970), .C(n969), .D(n805), .Y(n413) );
  XOR2X1 U891 ( .A(n837), .B(n846), .Y(n969) );
  OAI22X1 U892 ( .A(n860), .B(n847), .C(n970), .D(n805), .Y(n412) );
  XOR2X1 U893 ( .A(n839), .B(n846), .Y(n970) );
  AOI22X1 U894 ( .A(n792), .B(n845), .C(n845), .D(n971), .Y(n411) );
  NOR2X1 U895 ( .A(n859), .B(n808), .Y(n410) );
  OAI22X1 U896 ( .A(n859), .B(n972), .C(n973), .D(n806), .Y(n409) );
  XOR2X1 U897 ( .A(n794), .B(n809), .Y(n973) );
  OAI22X1 U898 ( .A(n859), .B(n974), .C(n972), .D(n806), .Y(n408) );
  XOR2X1 U899 ( .A(n811), .B(n794), .Y(n972) );
  OAI22X1 U900 ( .A(n859), .B(n975), .C(n974), .D(n806), .Y(n407) );
  XOR2X1 U901 ( .A(n813), .B(n794), .Y(n974) );
  OAI22X1 U902 ( .A(n859), .B(n976), .C(n975), .D(n806), .Y(n406) );
  XOR2X1 U903 ( .A(n815), .B(n794), .Y(n975) );
  OAI22X1 U904 ( .A(n859), .B(n977), .C(n976), .D(n806), .Y(n405) );
  XOR2X1 U905 ( .A(n817), .B(n794), .Y(n976) );
  OAI22X1 U906 ( .A(n859), .B(n978), .C(n977), .D(n806), .Y(n404) );
  XOR2X1 U907 ( .A(n819), .B(n794), .Y(n977) );
  OAI22X1 U908 ( .A(n859), .B(n979), .C(n978), .D(n806), .Y(n403) );
  XOR2X1 U909 ( .A(n821), .B(n794), .Y(n978) );
  OAI22X1 U910 ( .A(n859), .B(n980), .C(n979), .D(n806), .Y(n402) );
  XOR2X1 U911 ( .A(n823), .B(n794), .Y(n979) );
  OAI22X1 U912 ( .A(n859), .B(n981), .C(n980), .D(n806), .Y(n401) );
  XOR2X1 U913 ( .A(n825), .B(n794), .Y(n980) );
  OAI22X1 U914 ( .A(n859), .B(n982), .C(n981), .D(n806), .Y(n400) );
  XOR2X1 U915 ( .A(n827), .B(n794), .Y(n981) );
  OAI22X1 U916 ( .A(n859), .B(n983), .C(n982), .D(n806), .Y(n399) );
  XOR2X1 U917 ( .A(n829), .B(n794), .Y(n982) );
  OAI22X1 U918 ( .A(n859), .B(n984), .C(n983), .D(n806), .Y(n398) );
  XOR2X1 U919 ( .A(n831), .B(n794), .Y(n983) );
  OAI22X1 U920 ( .A(n859), .B(n985), .C(n984), .D(n806), .Y(n397) );
  XOR2X1 U921 ( .A(n833), .B(n794), .Y(n984) );
  OAI22X1 U922 ( .A(n859), .B(n986), .C(n985), .D(n806), .Y(n396) );
  XOR2X1 U923 ( .A(n835), .B(n794), .Y(n985) );
  OAI22X1 U924 ( .A(n859), .B(n987), .C(n986), .D(n806), .Y(n395) );
  XOR2X1 U925 ( .A(n837), .B(n794), .Y(n986) );
  OAI22X1 U926 ( .A(n859), .B(n794), .C(n987), .D(n806), .Y(n394) );
  XOR2X1 U927 ( .A(n839), .B(n794), .Y(n987) );
  AOI22X1 U928 ( .A(n793), .B(a[13]), .C(a[13]), .D(n988), .Y(n393) );
  NOR2X1 U929 ( .A(n858), .B(n808), .Y(n392) );
  OAI22X1 U930 ( .A(n858), .B(n989), .C(n990), .D(n807), .Y(n391) );
  XOR2X1 U931 ( .A(n808), .B(n848), .Y(n990) );
  OAI22X1 U932 ( .A(n858), .B(n991), .C(n989), .D(n807), .Y(n390) );
  XOR2X1 U933 ( .A(n811), .B(n852), .Y(n989) );
  OAI22X1 U934 ( .A(n858), .B(n992), .C(n991), .D(n807), .Y(n389) );
  XOR2X1 U935 ( .A(n813), .B(n852), .Y(n991) );
  OAI22X1 U936 ( .A(n858), .B(n993), .C(n992), .D(n807), .Y(n388) );
  XOR2X1 U937 ( .A(n815), .B(n851), .Y(n992) );
  OAI22X1 U938 ( .A(n858), .B(n994), .C(n993), .D(n807), .Y(n387) );
  XOR2X1 U939 ( .A(n817), .B(n851), .Y(n993) );
  OAI22X1 U940 ( .A(n858), .B(n995), .C(n994), .D(n807), .Y(n386) );
  XOR2X1 U941 ( .A(n819), .B(n851), .Y(n994) );
  OAI22X1 U942 ( .A(n858), .B(n996), .C(n995), .D(n807), .Y(n385) );
  XOR2X1 U943 ( .A(n821), .B(n851), .Y(n995) );
  OAI22X1 U944 ( .A(n858), .B(n997), .C(n996), .D(n807), .Y(n384) );
  XOR2X1 U945 ( .A(n823), .B(n851), .Y(n996) );
  OAI22X1 U946 ( .A(n858), .B(n998), .C(n997), .D(n807), .Y(n383) );
  XOR2X1 U947 ( .A(n825), .B(n851), .Y(n997) );
  OAI22X1 U948 ( .A(n858), .B(n999), .C(n998), .D(n807), .Y(n382) );
  XOR2X1 U949 ( .A(n827), .B(n851), .Y(n998) );
  OAI22X1 U950 ( .A(n858), .B(n1000), .C(n999), .D(n807), .Y(n381) );
  XOR2X1 U951 ( .A(n829), .B(n851), .Y(n999) );
  OAI22X1 U952 ( .A(n858), .B(n1001), .C(n1000), .D(n807), .Y(n380) );
  XOR2X1 U953 ( .A(n831), .B(n851), .Y(n1000) );
  OAI22X1 U954 ( .A(n858), .B(n1002), .C(n1001), .D(n807), .Y(n379) );
  XOR2X1 U955 ( .A(n833), .B(n851), .Y(n1001) );
  OAI22X1 U956 ( .A(n858), .B(n1003), .C(n1002), .D(n807), .Y(n378) );
  XOR2X1 U957 ( .A(n835), .B(n851), .Y(n1002) );
  OAI22X1 U958 ( .A(n858), .B(n1004), .C(n1003), .D(n807), .Y(n377) );
  XOR2X1 U959 ( .A(n837), .B(n851), .Y(n1003) );
  OAI22X1 U960 ( .A(n858), .B(n852), .C(n1004), .D(n807), .Y(n376) );
  XOR2X1 U961 ( .A(n839), .B(n851), .Y(n1004) );
  NOR2X1 U962 ( .A(n852), .B(n808), .Y(n374) );
  AND2X1 U963 ( .A(n850), .B(n811), .Y(n373) );
  AND2X1 U964 ( .A(n850), .B(n813), .Y(n372) );
  AND2X1 U965 ( .A(n850), .B(n815), .Y(n371) );
  AND2X1 U966 ( .A(n850), .B(n819), .Y(n370) );
  AND2X1 U967 ( .A(n850), .B(n823), .Y(n369) );
  AND2X1 U968 ( .A(n850), .B(n827), .Y(n368) );
  AND2X1 U969 ( .A(n850), .B(n831), .Y(n367) );
  AND2X1 U970 ( .A(n850), .B(n835), .Y(n366) );
  OAI21X1 U971 ( .A(n809), .B(n799), .C(n800), .Y(n364) );
  OAI21X1 U972 ( .A(n797), .B(n801), .C(n1005), .Y(n363) );
  NAND3X1 U973 ( .A(n903), .B(n808), .C(a[3]), .Y(n1005) );
  XOR2X1 U974 ( .A(a[3]), .B(a[2]), .Y(n1006) );
  XOR2X1 U975 ( .A(a[2]), .B(n354), .Y(n903) );
  OAI21X1 U976 ( .A(n843), .B(n802), .C(n1007), .Y(n362) );
  NAND3X1 U977 ( .A(n920), .B(n808), .C(n841), .Y(n1007) );
  XOR2X1 U978 ( .A(n840), .B(a[4]), .Y(n1008) );
  XOR2X1 U979 ( .A(a[4]), .B(a[3]), .Y(n920) );
  OAI21X1 U980 ( .A(n796), .B(n803), .C(n1009), .Y(n361) );
  NAND3X1 U981 ( .A(n937), .B(n808), .C(a[7]), .Y(n1009) );
  XOR2X1 U982 ( .A(a[7]), .B(a[6]), .Y(n1010) );
  XOR2X1 U983 ( .A(a[6]), .B(n840), .Y(n937) );
  OAI21X1 U984 ( .A(n795), .B(n804), .C(n1011), .Y(n360) );
  NAND3X1 U985 ( .A(n954), .B(n808), .C(a[9]), .Y(n1011) );
  XOR2X1 U986 ( .A(a[9]), .B(a[8]), .Y(n1012) );
  XOR2X1 U987 ( .A(a[8]), .B(a[7]), .Y(n954) );
  OAI21X1 U988 ( .A(n847), .B(n805), .C(n1013), .Y(n359) );
  NAND3X1 U989 ( .A(n971), .B(n808), .C(n845), .Y(n1013) );
  XOR2X1 U990 ( .A(n844), .B(a[10]), .Y(n1014) );
  XOR2X1 U991 ( .A(a[10]), .B(a[9]), .Y(n971) );
  OAI21X1 U992 ( .A(n794), .B(n806), .C(n1015), .Y(n358) );
  NAND3X1 U993 ( .A(n988), .B(n808), .C(a[13]), .Y(n1015) );
  XOR2X1 U994 ( .A(a[13]), .B(a[12]), .Y(n1016) );
  XOR2X1 U995 ( .A(a[12]), .B(n844), .Y(n988) );
  OAI21X1 U996 ( .A(n852), .B(n807), .C(n1017), .Y(n357) );
  NAND3X1 U997 ( .A(n1018), .B(n808), .C(n849), .Y(n1017) );
  XOR2X1 U998 ( .A(n848), .B(a[14]), .Y(n1019) );
  XOR2X1 U999 ( .A(a[14]), .B(a[13]), .Y(n1018) );
  NAND2X1 U1000 ( .A(n817), .B(n850), .Y(n177) );
  NAND2X1 U1001 ( .A(n821), .B(n850), .Y(n151) );
  NAND2X1 U1002 ( .A(n825), .B(n849), .Y(n129) );
  NAND2X1 U1003 ( .A(n829), .B(n849), .Y(n111) );
endmodule


module address_update_w_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] DIFF;
  input CI;
  output CO;
  wire   \A[0] ;
  wire   [32:0] carry;
  assign DIFF[0] = \A[0] ;
  assign \A[0]  = A[0];

  OR2X1 U1 ( .A(A[10]), .B(carry[10]), .Y(carry[11]) );
  XNOR2X1 U2 ( .A(carry[10]), .B(A[10]), .Y(DIFF[10]) );
  OR2X1 U3 ( .A(A[11]), .B(carry[11]), .Y(carry[12]) );
  XNOR2X1 U4 ( .A(carry[11]), .B(A[11]), .Y(DIFF[11]) );
  OR2X1 U5 ( .A(A[12]), .B(carry[12]), .Y(carry[13]) );
  XNOR2X1 U6 ( .A(carry[12]), .B(A[12]), .Y(DIFF[12]) );
  OR2X1 U7 ( .A(A[13]), .B(carry[13]), .Y(carry[14]) );
  XNOR2X1 U8 ( .A(carry[13]), .B(A[13]), .Y(DIFF[13]) );
  OR2X1 U9 ( .A(A[14]), .B(carry[14]), .Y(carry[15]) );
  XNOR2X1 U10 ( .A(carry[14]), .B(A[14]), .Y(DIFF[14]) );
  OR2X1 U11 ( .A(A[15]), .B(carry[15]), .Y(carry[16]) );
  XNOR2X1 U12 ( .A(carry[15]), .B(A[15]), .Y(DIFF[15]) );
  OR2X1 U13 ( .A(A[16]), .B(carry[16]), .Y(carry[17]) );
  XNOR2X1 U14 ( .A(carry[16]), .B(A[16]), .Y(DIFF[16]) );
  OR2X1 U15 ( .A(A[17]), .B(carry[17]), .Y(carry[18]) );
  XNOR2X1 U16 ( .A(carry[17]), .B(A[17]), .Y(DIFF[17]) );
  OR2X1 U17 ( .A(A[18]), .B(carry[18]), .Y(carry[19]) );
  XNOR2X1 U18 ( .A(carry[18]), .B(A[18]), .Y(DIFF[18]) );
  OR2X1 U19 ( .A(A[19]), .B(carry[19]), .Y(carry[20]) );
  XNOR2X1 U20 ( .A(carry[19]), .B(A[19]), .Y(DIFF[19]) );
  OR2X1 U21 ( .A(A[20]), .B(carry[20]), .Y(carry[21]) );
  XNOR2X1 U22 ( .A(carry[20]), .B(A[20]), .Y(DIFF[20]) );
  OR2X1 U23 ( .A(A[21]), .B(carry[21]), .Y(carry[22]) );
  XNOR2X1 U24 ( .A(carry[21]), .B(A[21]), .Y(DIFF[21]) );
  OR2X1 U25 ( .A(A[22]), .B(carry[22]), .Y(carry[23]) );
  XNOR2X1 U26 ( .A(carry[22]), .B(A[22]), .Y(DIFF[22]) );
  OR2X1 U27 ( .A(A[23]), .B(carry[23]), .Y(carry[24]) );
  XNOR2X1 U28 ( .A(carry[23]), .B(A[23]), .Y(DIFF[23]) );
  OR2X1 U29 ( .A(A[24]), .B(carry[24]), .Y(carry[25]) );
  XNOR2X1 U30 ( .A(carry[24]), .B(A[24]), .Y(DIFF[24]) );
  OR2X1 U31 ( .A(A[25]), .B(carry[25]), .Y(carry[26]) );
  XNOR2X1 U32 ( .A(carry[25]), .B(A[25]), .Y(DIFF[25]) );
  OR2X1 U33 ( .A(A[26]), .B(carry[26]), .Y(carry[27]) );
  XNOR2X1 U34 ( .A(carry[26]), .B(A[26]), .Y(DIFF[26]) );
  OR2X1 U35 ( .A(A[27]), .B(carry[27]), .Y(carry[28]) );
  XNOR2X1 U36 ( .A(carry[27]), .B(A[27]), .Y(DIFF[27]) );
  OR2X1 U37 ( .A(A[28]), .B(carry[28]), .Y(carry[29]) );
  XNOR2X1 U38 ( .A(carry[28]), .B(A[28]), .Y(DIFF[28]) );
  OR2X1 U39 ( .A(A[29]), .B(carry[29]), .Y(carry[30]) );
  XNOR2X1 U40 ( .A(carry[29]), .B(A[29]), .Y(DIFF[29]) );
  OR2X1 U41 ( .A(A[2]), .B(A[1]), .Y(carry[3]) );
  XNOR2X1 U42 ( .A(A[1]), .B(A[2]), .Y(DIFF[2]) );
  OR2X1 U43 ( .A(A[30]), .B(carry[30]), .Y(carry[31]) );
  XNOR2X1 U44 ( .A(carry[30]), .B(A[30]), .Y(DIFF[30]) );
  XNOR2X1 U45 ( .A(A[31]), .B(carry[31]), .Y(DIFF[31]) );
  OR2X1 U46 ( .A(A[3]), .B(carry[3]), .Y(carry[4]) );
  XNOR2X1 U47 ( .A(carry[3]), .B(A[3]), .Y(DIFF[3]) );
  OR2X1 U48 ( .A(A[4]), .B(carry[4]), .Y(carry[5]) );
  XNOR2X1 U49 ( .A(carry[4]), .B(A[4]), .Y(DIFF[4]) );
  OR2X1 U50 ( .A(A[5]), .B(carry[5]), .Y(carry[6]) );
  XNOR2X1 U51 ( .A(carry[5]), .B(A[5]), .Y(DIFF[5]) );
  OR2X1 U52 ( .A(A[6]), .B(carry[6]), .Y(carry[7]) );
  XNOR2X1 U53 ( .A(carry[6]), .B(A[6]), .Y(DIFF[6]) );
  OR2X1 U54 ( .A(A[7]), .B(carry[7]), .Y(carry[8]) );
  XNOR2X1 U55 ( .A(carry[7]), .B(A[7]), .Y(DIFF[7]) );
  OR2X1 U56 ( .A(A[8]), .B(carry[8]), .Y(carry[9]) );
  XNOR2X1 U57 ( .A(carry[8]), .B(A[8]), .Y(DIFF[8]) );
  OR2X1 U58 ( .A(A[9]), .B(carry[9]), .Y(carry[10]) );
  XNOR2X1 U59 ( .A(carry[9]), .B(A[9]), .Y(DIFF[9]) );
  INVX2 U60 ( .A(A[1]), .Y(DIFF[1]) );
endmodule


module address_update_w ( HCLK, HRESETn, length, width, addr, 
        addr_update_enable_w, plus4_r, curr_addr );
  input [15:0] length;
  input [15:0] width;
  input [31:0] addr;
  output [31:0] curr_addr;
  input HCLK, HRESETn, addr_update_enable_w, plus4_r;
  wire   N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46, N47, N48,
         N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62,
         N63, N64, N65, N66, N105, N106, N107, N108, N109, N110, N111, N112,
         N113, N114, N115, N116, N117, N118, N119, N120, N121, N122, N123,
         N124, N125, N126, N127, N128, N129, N130, N131, N132, N133, N134,
         N135, N136, N169, N170, N171, N172, N173, N174, N175, N176, N177,
         N178, N179, N180, N181, N182, N183, N184, N185, N186, N187, N188,
         N189, N190, N191, N192, N193, N194, N195, N196, N197, N198, N199,
         N200, n78, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92,
         n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, N9, N8, N7, N6, N5, N4, N34, N33, N32,
         N31, N30, N3, N29, N28, N27, N26, N25, N24, N23, N22, N21, N20, N19,
         N18, N17, N16, N15, N14, N13, N12, N11, N10, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77;
  wire   [31:0] offset_w;

  DFFSR \offset_w_reg[0]  ( .D(n198), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[0]) );
  DFFSR \offset_w_reg[1]  ( .D(n197), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[1]) );
  DFFSR \offset_w_reg[31]  ( .D(n167), .CLK(HCLK), .R(HRESETn), .S(1'b1), .Q(
        offset_w[31]) );
  DFFSR \offset_w_reg[2]  ( .D(n196), .CLK(HCLK), .R(HRESETn), .S(1'b1), .Q(
        offset_w[2]) );
  DFFSR \offset_w_reg[3]  ( .D(n195), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[3]) );
  DFFSR \offset_w_reg[4]  ( .D(n194), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[4]) );
  DFFSR \offset_w_reg[5]  ( .D(n193), .CLK(HCLK), .R(HRESETn), .S(1'b1), .Q(
        offset_w[5]) );
  DFFSR \offset_w_reg[6]  ( .D(n192), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[6]) );
  DFFSR \offset_w_reg[7]  ( .D(n191), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[7]) );
  DFFSR \offset_w_reg[8]  ( .D(n190), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[8]) );
  DFFSR \offset_w_reg[9]  ( .D(n189), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[9]) );
  DFFSR \offset_w_reg[10]  ( .D(n188), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[10]) );
  DFFSR \offset_w_reg[11]  ( .D(n187), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[11]) );
  DFFSR \offset_w_reg[12]  ( .D(n186), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[12]) );
  DFFSR \offset_w_reg[13]  ( .D(n185), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[13]) );
  DFFSR \offset_w_reg[14]  ( .D(n184), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[14]) );
  DFFSR \offset_w_reg[15]  ( .D(n183), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[15]) );
  DFFSR \offset_w_reg[16]  ( .D(n182), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[16]) );
  DFFSR \offset_w_reg[17]  ( .D(n181), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[17]) );
  DFFSR \offset_w_reg[18]  ( .D(n180), .CLK(HCLK), .R(n11), .S(1'b1), .Q(
        offset_w[18]) );
  DFFSR \offset_w_reg[19]  ( .D(n179), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[19]) );
  DFFSR \offset_w_reg[20]  ( .D(n178), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[20]) );
  DFFSR \offset_w_reg[21]  ( .D(n177), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[21]) );
  DFFSR \offset_w_reg[22]  ( .D(n176), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[22]) );
  DFFSR \offset_w_reg[23]  ( .D(n175), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[23]) );
  DFFSR \offset_w_reg[24]  ( .D(n174), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[24]) );
  DFFSR \offset_w_reg[25]  ( .D(n173), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[25]) );
  DFFSR \offset_w_reg[26]  ( .D(n172), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[26]) );
  DFFSR \offset_w_reg[27]  ( .D(n171), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[27]) );
  DFFSR \offset_w_reg[28]  ( .D(n170), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[28]) );
  DFFSR \offset_w_reg[29]  ( .D(n169), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[29]) );
  DFFSR \offset_w_reg[30]  ( .D(n168), .CLK(HCLK), .R(n10), .S(1'b1), .Q(
        offset_w[30]) );
  OAI21X1 U71 ( .A(n5), .B(n48), .C(n78), .Y(n167) );
  AOI22X1 U72 ( .A(N200), .B(n8), .C(N136), .D(n7), .Y(n78) );
  OAI21X1 U73 ( .A(n5), .B(n77), .C(n81), .Y(n168) );
  AOI22X1 U74 ( .A(N199), .B(n9), .C(N135), .D(n7), .Y(n81) );
  OAI21X1 U75 ( .A(n5), .B(n76), .C(n82), .Y(n169) );
  AOI22X1 U76 ( .A(N198), .B(n8), .C(N134), .D(n7), .Y(n82) );
  OAI21X1 U77 ( .A(n5), .B(n75), .C(n83), .Y(n170) );
  AOI22X1 U78 ( .A(N197), .B(n9), .C(N133), .D(n7), .Y(n83) );
  OAI21X1 U79 ( .A(n5), .B(n74), .C(n84), .Y(n171) );
  AOI22X1 U80 ( .A(N196), .B(n8), .C(N132), .D(n7), .Y(n84) );
  OAI21X1 U81 ( .A(n5), .B(n73), .C(n85), .Y(n172) );
  AOI22X1 U82 ( .A(N195), .B(n9), .C(N131), .D(n7), .Y(n85) );
  OAI21X1 U83 ( .A(n5), .B(n72), .C(n86), .Y(n173) );
  AOI22X1 U84 ( .A(N194), .B(n9), .C(N130), .D(n7), .Y(n86) );
  OAI21X1 U85 ( .A(n45), .B(n71), .C(n87), .Y(n174) );
  AOI22X1 U86 ( .A(N193), .B(n9), .C(N129), .D(n7), .Y(n87) );
  OAI21X1 U87 ( .A(n45), .B(n70), .C(n88), .Y(n175) );
  AOI22X1 U88 ( .A(N192), .B(n9), .C(N128), .D(n7), .Y(n88) );
  OAI21X1 U89 ( .A(n45), .B(n69), .C(n89), .Y(n176) );
  AOI22X1 U90 ( .A(N191), .B(n9), .C(N127), .D(n7), .Y(n89) );
  OAI21X1 U91 ( .A(n45), .B(n68), .C(n90), .Y(n177) );
  AOI22X1 U92 ( .A(N190), .B(n9), .C(N126), .D(n7), .Y(n90) );
  OAI21X1 U93 ( .A(n45), .B(n67), .C(n91), .Y(n178) );
  AOI22X1 U94 ( .A(N189), .B(n9), .C(N125), .D(n7), .Y(n91) );
  OAI21X1 U95 ( .A(n45), .B(n66), .C(n92), .Y(n179) );
  AOI22X1 U96 ( .A(N188), .B(n9), .C(N124), .D(n7), .Y(n92) );
  OAI21X1 U97 ( .A(n45), .B(n65), .C(n93), .Y(n180) );
  AOI22X1 U98 ( .A(N187), .B(n9), .C(N123), .D(n6), .Y(n93) );
  OAI21X1 U99 ( .A(n45), .B(n64), .C(n94), .Y(n181) );
  AOI22X1 U100 ( .A(N186), .B(n9), .C(N122), .D(n7), .Y(n94) );
  OAI21X1 U101 ( .A(n45), .B(n63), .C(n95), .Y(n182) );
  AOI22X1 U102 ( .A(N185), .B(n9), .C(N121), .D(n6), .Y(n95) );
  OAI21X1 U103 ( .A(n45), .B(n62), .C(n96), .Y(n183) );
  AOI22X1 U104 ( .A(N184), .B(n9), .C(N120), .D(n7), .Y(n96) );
  OAI21X1 U105 ( .A(n45), .B(n61), .C(n97), .Y(n184) );
  AOI22X1 U106 ( .A(N183), .B(n9), .C(N119), .D(n6), .Y(n97) );
  OAI21X1 U107 ( .A(n45), .B(n60), .C(n98), .Y(n185) );
  AOI22X1 U108 ( .A(N182), .B(n9), .C(N118), .D(n7), .Y(n98) );
  OAI21X1 U109 ( .A(n45), .B(n59), .C(n99), .Y(n186) );
  AOI22X1 U110 ( .A(N181), .B(n8), .C(N117), .D(n6), .Y(n99) );
  OAI21X1 U111 ( .A(n45), .B(n58), .C(n100), .Y(n187) );
  AOI22X1 U112 ( .A(N180), .B(n8), .C(N116), .D(n6), .Y(n100) );
  OAI21X1 U113 ( .A(n45), .B(n57), .C(n101), .Y(n188) );
  AOI22X1 U114 ( .A(N179), .B(n8), .C(N115), .D(n6), .Y(n101) );
  OAI21X1 U115 ( .A(n45), .B(n56), .C(n102), .Y(n189) );
  AOI22X1 U116 ( .A(N178), .B(n8), .C(N114), .D(n6), .Y(n102) );
  OAI21X1 U117 ( .A(n45), .B(n55), .C(n103), .Y(n190) );
  AOI22X1 U118 ( .A(N177), .B(n8), .C(N113), .D(n6), .Y(n103) );
  OAI21X1 U119 ( .A(n45), .B(n54), .C(n104), .Y(n191) );
  AOI22X1 U120 ( .A(N176), .B(n8), .C(N112), .D(n6), .Y(n104) );
  OAI21X1 U121 ( .A(n45), .B(n53), .C(n105), .Y(n192) );
  AOI22X1 U122 ( .A(N175), .B(n8), .C(N111), .D(n6), .Y(n105) );
  OAI21X1 U123 ( .A(n45), .B(n52), .C(n106), .Y(n193) );
  AOI22X1 U124 ( .A(N174), .B(n8), .C(N110), .D(n6), .Y(n106) );
  OAI21X1 U125 ( .A(n45), .B(n51), .C(n107), .Y(n194) );
  AOI22X1 U126 ( .A(N173), .B(n8), .C(N109), .D(n6), .Y(n107) );
  OAI21X1 U127 ( .A(n45), .B(n50), .C(n108), .Y(n195) );
  AOI22X1 U128 ( .A(N172), .B(n8), .C(N108), .D(n6), .Y(n108) );
  OAI21X1 U129 ( .A(n45), .B(n49), .C(n109), .Y(n196) );
  AOI22X1 U130 ( .A(N171), .B(n8), .C(N107), .D(n6), .Y(n109) );
  OAI21X1 U131 ( .A(n45), .B(n47), .C(n110), .Y(n197) );
  AOI22X1 U132 ( .A(N170), .B(n8), .C(N106), .D(n6), .Y(n110) );
  OAI21X1 U133 ( .A(n45), .B(n46), .C(n111), .Y(n198) );
  AOI22X1 U134 ( .A(N169), .B(n8), .C(N105), .D(n6), .Y(n111) );
  OAI21X1 U136 ( .A(n113), .B(n114), .C(addr_update_enable_w), .Y(n112) );
  NAND2X1 U137 ( .A(n115), .B(n116), .Y(n114) );
  NOR2X1 U138 ( .A(n117), .B(n118), .Y(n116) );
  NAND3X1 U139 ( .A(n119), .B(n120), .C(n121), .Y(n118) );
  NOR2X1 U140 ( .A(n122), .B(n123), .Y(n121) );
  XNOR2X1 U141 ( .A(n77), .B(N65), .Y(n123) );
  XNOR2X1 U142 ( .A(n48), .B(N66), .Y(n122) );
  XNOR2X1 U143 ( .A(offset_w[27]), .B(N62), .Y(n120) );
  XNOR2X1 U144 ( .A(offset_w[26]), .B(N61), .Y(n119) );
  NAND3X1 U145 ( .A(n124), .B(n125), .C(n126), .Y(n117) );
  NOR2X1 U146 ( .A(n127), .B(n128), .Y(n126) );
  XNOR2X1 U147 ( .A(n69), .B(N57), .Y(n128) );
  XNOR2X1 U148 ( .A(n70), .B(N58), .Y(n127) );
  XNOR2X1 U149 ( .A(offset_w[19]), .B(N54), .Y(n125) );
  XNOR2X1 U150 ( .A(offset_w[18]), .B(N53), .Y(n124) );
  NOR2X1 U151 ( .A(n129), .B(n130), .Y(n115) );
  NAND3X1 U152 ( .A(n131), .B(n132), .C(n133), .Y(n130) );
  NOR2X1 U153 ( .A(n134), .B(n135), .Y(n133) );
  XNOR2X1 U154 ( .A(n61), .B(N49), .Y(n135) );
  XNOR2X1 U155 ( .A(n62), .B(N50), .Y(n134) );
  XNOR2X1 U156 ( .A(offset_w[11]), .B(N46), .Y(n132) );
  XNOR2X1 U157 ( .A(offset_w[10]), .B(N45), .Y(n131) );
  NAND3X1 U158 ( .A(n136), .B(n137), .C(n138), .Y(n129) );
  NOR2X1 U159 ( .A(n139), .B(n140), .Y(n138) );
  XNOR2X1 U160 ( .A(n53), .B(N41), .Y(n140) );
  XNOR2X1 U161 ( .A(n54), .B(N42), .Y(n139) );
  XNOR2X1 U162 ( .A(offset_w[3]), .B(N38), .Y(n137) );
  XNOR2X1 U163 ( .A(offset_w[2]), .B(N37), .Y(n136) );
  NAND2X1 U164 ( .A(n141), .B(n142), .Y(n113) );
  NOR2X1 U165 ( .A(n143), .B(n144), .Y(n142) );
  NAND3X1 U166 ( .A(n145), .B(n146), .C(n147), .Y(n144) );
  NOR2X1 U167 ( .A(n148), .B(n149), .Y(n147) );
  XNOR2X1 U168 ( .A(n76), .B(N64), .Y(n149) );
  XNOR2X1 U169 ( .A(n75), .B(N63), .Y(n148) );
  XNOR2X1 U170 ( .A(offset_w[24]), .B(N59), .Y(n146) );
  XNOR2X1 U171 ( .A(offset_w[25]), .B(N60), .Y(n145) );
  NAND3X1 U172 ( .A(n150), .B(n151), .C(n152), .Y(n143) );
  NOR2X1 U173 ( .A(n153), .B(n154), .Y(n152) );
  XNOR2X1 U174 ( .A(n68), .B(N56), .Y(n154) );
  XNOR2X1 U175 ( .A(n67), .B(N55), .Y(n153) );
  XNOR2X1 U176 ( .A(offset_w[16]), .B(N51), .Y(n151) );
  XNOR2X1 U177 ( .A(offset_w[17]), .B(N52), .Y(n150) );
  NOR2X1 U178 ( .A(n155), .B(n156), .Y(n141) );
  NAND3X1 U179 ( .A(n157), .B(n158), .C(n159), .Y(n156) );
  NOR2X1 U180 ( .A(n160), .B(n161), .Y(n159) );
  XNOR2X1 U181 ( .A(n60), .B(N48), .Y(n161) );
  XNOR2X1 U182 ( .A(n59), .B(N47), .Y(n160) );
  XNOR2X1 U183 ( .A(offset_w[8]), .B(N43), .Y(n158) );
  XNOR2X1 U184 ( .A(offset_w[9]), .B(N44), .Y(n157) );
  NAND3X1 U185 ( .A(n162), .B(n163), .C(n164), .Y(n155) );
  NOR2X1 U186 ( .A(n165), .B(n166), .Y(n164) );
  XNOR2X1 U187 ( .A(n52), .B(N40), .Y(n166) );
  XNOR2X1 U188 ( .A(n51), .B(N39), .Y(n165) );
  XNOR2X1 U189 ( .A(offset_w[0]), .B(N35), .Y(n163) );
  XNOR2X1 U190 ( .A(offset_w[1]), .B(N36), .Y(n162) );
  address_update_w_DW01_inc_0 add_42 ( .A(offset_w), .SUM({N200, N199, N198, 
        N197, N196, N195, N194, N193, N192, N191, N190, N189, N188, N187, N186, 
        N185, N184, N183, N182, N181, N180, N179, N178, N177, N176, N175, N174, 
        N173, N172, N171, N170, N169}) );
  address_update_w_DW01_add_0 add_38 ( .A(offset_w), .B({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b0, 1'b0}), .CI(1'b0), .SUM({N136, N135, N134, 
        N133, N132, N131, N130, N129, N128, N127, N126, N125, N124, N123, N122, 
        N121, N120, N119, N118, N117, N116, N115, N114, N113, N112, N111, N110, 
        N109, N108, N107, N106, N105}) );
  address_update_w_DW01_add_1 r312 ( .A(addr), .B(offset_w), .CI(1'b0), .SUM(
        curr_addr) );
  address_update_w_DW_mult_uns_0 mult_32 ( .a(length), .b(width), .product({
        N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, 
        N20, N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5, N4, N3}) );
  address_update_w_DW01_sub_0 sub_32 ( .A({N34, N33, N32, N31, N30, N29, N28, 
        N27, N26, N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, 
        N13, N12, N11, N10, N9, N8, N7, N6, N5, N4, N3}), .B({1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b1, 1'b0}), .CI(1'b0), .DIFF({N66, N65, N64, N63, 
        N62, N61, N60, N59, N58, N57, N56, N55, N54, N53, N52, N51, N50, N49, 
        N48, N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, N35})
         );
  INVX2 U37 ( .A(n112), .Y(n5) );
  INVX2 U38 ( .A(n12), .Y(n10) );
  INVX2 U39 ( .A(n12), .Y(n11) );
  INVX2 U40 ( .A(n3), .Y(n6) );
  INVX2 U41 ( .A(n3), .Y(n7) );
  INVX2 U42 ( .A(n4), .Y(n9) );
  INVX2 U43 ( .A(n4), .Y(n8) );
  INVX2 U44 ( .A(HRESETn), .Y(n12) );
  NAND2X1 U45 ( .A(plus4_r), .B(n5), .Y(n3) );
  OR2X1 U46 ( .A(n112), .B(plus4_r), .Y(n4) );
  INVX2 U47 ( .A(n112), .Y(n45) );
  INVX2 U48 ( .A(offset_w[0]), .Y(n46) );
  INVX2 U49 ( .A(offset_w[1]), .Y(n47) );
  INVX2 U50 ( .A(offset_w[31]), .Y(n48) );
  INVX2 U51 ( .A(offset_w[2]), .Y(n49) );
  INVX2 U52 ( .A(offset_w[3]), .Y(n50) );
  INVX2 U53 ( .A(offset_w[4]), .Y(n51) );
  INVX2 U54 ( .A(offset_w[5]), .Y(n52) );
  INVX2 U55 ( .A(offset_w[6]), .Y(n53) );
  INVX2 U56 ( .A(offset_w[7]), .Y(n54) );
  INVX2 U57 ( .A(offset_w[8]), .Y(n55) );
  INVX2 U58 ( .A(offset_w[9]), .Y(n56) );
  INVX2 U59 ( .A(offset_w[10]), .Y(n57) );
  INVX2 U60 ( .A(offset_w[11]), .Y(n58) );
  INVX2 U61 ( .A(offset_w[12]), .Y(n59) );
  INVX2 U62 ( .A(offset_w[13]), .Y(n60) );
  INVX2 U63 ( .A(offset_w[14]), .Y(n61) );
  INVX2 U64 ( .A(offset_w[15]), .Y(n62) );
  INVX2 U65 ( .A(offset_w[16]), .Y(n63) );
  INVX2 U66 ( .A(offset_w[17]), .Y(n64) );
  INVX2 U67 ( .A(offset_w[18]), .Y(n65) );
  INVX2 U68 ( .A(offset_w[19]), .Y(n66) );
  INVX2 U69 ( .A(offset_w[20]), .Y(n67) );
  INVX2 U70 ( .A(offset_w[21]), .Y(n68) );
  INVX2 U135 ( .A(offset_w[22]), .Y(n69) );
  INVX2 U191 ( .A(offset_w[23]), .Y(n70) );
  INVX2 U192 ( .A(offset_w[24]), .Y(n71) );
  INVX2 U193 ( .A(offset_w[25]), .Y(n72) );
  INVX2 U194 ( .A(offset_w[26]), .Y(n73) );
  INVX2 U195 ( .A(offset_w[27]), .Y(n74) );
  INVX2 U196 ( .A(offset_w[28]), .Y(n75) );
  INVX2 U197 ( .A(offset_w[29]), .Y(n76) );
  INVX2 U198 ( .A(offset_w[30]), .Y(n77) );
endmodule


module fifo_w ( HCLK, HRESETn, shift_enable, data_out_1, data_out_2, HWDATA );
  input [7:0] data_out_1;
  input [7:0] data_out_2;
  output [31:0] HWDATA;
  input HCLK, HRESETn, shift_enable;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n2, n19, n21, n23, n25, n27, n29, n31, n33, n35, n37, n39, n41,
         n43, n45, n47, n49, n50, n51;
  assign HWDATA[31] = 1'b1;
  assign HWDATA[30] = 1'b1;
  assign HWDATA[29] = 1'b1;
  assign HWDATA[28] = 1'b1;
  assign HWDATA[27] = 1'b1;
  assign HWDATA[26] = 1'b1;
  assign HWDATA[25] = 1'b1;
  assign HWDATA[24] = 1'b1;
  assign HWDATA[23] = 1'b1;
  assign HWDATA[22] = 1'b1;
  assign HWDATA[21] = 1'b1;
  assign HWDATA[20] = 1'b1;
  assign HWDATA[19] = 1'b1;
  assign HWDATA[18] = 1'b1;
  assign HWDATA[17] = 1'b1;
  assign HWDATA[16] = 1'b1;

  DFFSR \HWDATA_reg[15]  ( .D(n21), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[15]) );
  DFFSR \HWDATA_reg[14]  ( .D(n23), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[14]) );
  DFFSR \HWDATA_reg[13]  ( .D(n25), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[13]) );
  DFFSR \HWDATA_reg[12]  ( .D(n27), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[12]) );
  DFFSR \HWDATA_reg[11]  ( .D(n29), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[11]) );
  DFFSR \HWDATA_reg[10]  ( .D(n31), .CLK(HCLK), .R(1'b1), .S(n2), .Q(
        HWDATA[10]) );
  DFFSR \HWDATA_reg[9]  ( .D(n33), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[9])
         );
  DFFSR \HWDATA_reg[8]  ( .D(n35), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[8])
         );
  DFFSR \HWDATA_reg[7]  ( .D(n37), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[7])
         );
  DFFSR \HWDATA_reg[6]  ( .D(n39), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[6])
         );
  DFFSR \HWDATA_reg[5]  ( .D(n41), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[5])
         );
  DFFSR \HWDATA_reg[4]  ( .D(n43), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[4])
         );
  DFFSR \HWDATA_reg[3]  ( .D(n45), .CLK(HCLK), .R(1'b1), .S(HRESETn), .Q(
        HWDATA[3]) );
  DFFSR \HWDATA_reg[2]  ( .D(n47), .CLK(HCLK), .R(1'b1), .S(HRESETn), .Q(
        HWDATA[2]) );
  DFFSR \HWDATA_reg[1]  ( .D(n49), .CLK(HCLK), .R(1'b1), .S(HRESETn), .Q(
        HWDATA[1]) );
  DFFSR \HWDATA_reg[0]  ( .D(n50), .CLK(HCLK), .R(1'b1), .S(n2), .Q(HWDATA[0])
         );
  AOI22X1 U5 ( .A(HWDATA[0]), .B(n51), .C(shift_enable), .D(data_out_2[0]), 
        .Y(n1) );
  AOI22X1 U7 ( .A(HWDATA[1]), .B(n51), .C(data_out_2[1]), .D(shift_enable), 
        .Y(n3) );
  AOI22X1 U9 ( .A(HWDATA[2]), .B(n51), .C(data_out_2[2]), .D(shift_enable), 
        .Y(n4) );
  AOI22X1 U11 ( .A(HWDATA[3]), .B(n51), .C(data_out_2[3]), .D(shift_enable), 
        .Y(n5) );
  AOI22X1 U13 ( .A(HWDATA[4]), .B(n51), .C(data_out_2[4]), .D(shift_enable), 
        .Y(n6) );
  AOI22X1 U15 ( .A(HWDATA[5]), .B(n51), .C(data_out_2[5]), .D(shift_enable), 
        .Y(n7) );
  AOI22X1 U17 ( .A(HWDATA[6]), .B(n51), .C(data_out_2[6]), .D(shift_enable), 
        .Y(n8) );
  AOI22X1 U19 ( .A(HWDATA[7]), .B(n51), .C(data_out_2[7]), .D(shift_enable), 
        .Y(n9) );
  AOI22X1 U21 ( .A(HWDATA[8]), .B(n51), .C(data_out_1[0]), .D(shift_enable), 
        .Y(n10) );
  AOI22X1 U23 ( .A(HWDATA[9]), .B(n51), .C(data_out_1[1]), .D(shift_enable), 
        .Y(n11) );
  AOI22X1 U25 ( .A(HWDATA[10]), .B(n51), .C(data_out_1[2]), .D(shift_enable), 
        .Y(n12) );
  AOI22X1 U27 ( .A(HWDATA[11]), .B(n51), .C(data_out_1[3]), .D(shift_enable), 
        .Y(n13) );
  AOI22X1 U29 ( .A(HWDATA[12]), .B(n51), .C(data_out_1[4]), .D(shift_enable), 
        .Y(n14) );
  AOI22X1 U31 ( .A(HWDATA[13]), .B(n51), .C(data_out_1[5]), .D(shift_enable), 
        .Y(n15) );
  AOI22X1 U33 ( .A(HWDATA[14]), .B(n51), .C(data_out_1[6]), .D(shift_enable), 
        .Y(n16) );
  AOI22X1 U35 ( .A(HWDATA[15]), .B(n51), .C(data_out_1[7]), .D(shift_enable), 
        .Y(n17) );
  INVX2 U4 ( .A(shift_enable), .Y(n51) );
  INVX2 U6 ( .A(n19), .Y(n2) );
  INVX2 U8 ( .A(HRESETn), .Y(n19) );
  INVX2 U10 ( .A(n17), .Y(n21) );
  INVX2 U12 ( .A(n16), .Y(n23) );
  INVX2 U14 ( .A(n15), .Y(n25) );
  INVX2 U16 ( .A(n14), .Y(n27) );
  INVX2 U18 ( .A(n13), .Y(n29) );
  INVX2 U20 ( .A(n12), .Y(n31) );
  INVX2 U22 ( .A(n11), .Y(n33) );
  INVX2 U24 ( .A(n10), .Y(n35) );
  INVX2 U26 ( .A(n9), .Y(n37) );
  INVX2 U28 ( .A(n8), .Y(n39) );
  INVX2 U30 ( .A(n7), .Y(n41) );
  INVX2 U32 ( .A(n6), .Y(n43) );
  INVX2 U34 ( .A(n5), .Y(n45) );
  INVX2 U36 ( .A(n4), .Y(n47) );
  INVX2 U69 ( .A(n3), .Y(n49) );
  INVX2 U70 ( .A(n1), .Y(n50) );
endmodule


module flex_counter_NUM_CNT_BITS32_2_DW01_dec_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n20, n25, n26, n27, n28, n29, n30,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75;

  INVX1 U1 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U2 ( .A(A[20]), .Y(n3) );
  INVX2 U3 ( .A(A[21]), .Y(n4) );
  INVX2 U4 ( .A(A[18]), .Y(n2) );
  INVX2 U5 ( .A(A[16]), .Y(n1) );
  INVX2 U6 ( .A(A[23]), .Y(n5) );
  INVX2 U7 ( .A(A[2]), .Y(n9) );
  INVX2 U8 ( .A(A[27]), .Y(n7) );
  INVX2 U9 ( .A(A[25]), .Y(n6) );
  INVX2 U10 ( .A(A[29]), .Y(n8) );
  INVX2 U11 ( .A(n61), .Y(SUM[1]) );
  INVX2 U12 ( .A(n74), .Y(SUM[11]) );
  INVX2 U13 ( .A(n71), .Y(SUM[13]) );
  INVX2 U14 ( .A(n68), .Y(SUM[15]) );
  INVX2 U15 ( .A(n65), .Y(SUM[17]) );
  INVX2 U16 ( .A(n62), .Y(SUM[19]) );
  INVX2 U17 ( .A(n57), .Y(SUM[22]) );
  INVX2 U18 ( .A(n54), .Y(SUM[24]) );
  INVX2 U19 ( .A(n51), .Y(SUM[26]) );
  INVX2 U20 ( .A(n48), .Y(SUM[28]) );
  INVX2 U21 ( .A(n59), .Y(n20) );
  INVX2 U22 ( .A(n32), .Y(SUM[9]) );
  INVX2 U23 ( .A(n36), .Y(SUM[7]) );
  INVX2 U24 ( .A(n39), .Y(SUM[5]) );
  INVX2 U25 ( .A(n42), .Y(SUM[3]) );
  INVX2 U26 ( .A(A[14]), .Y(n25) );
  INVX2 U27 ( .A(A[12]), .Y(n26) );
  INVX2 U28 ( .A(A[10]), .Y(n27) );
  INVX2 U29 ( .A(A[8]), .Y(n28) );
  INVX2 U30 ( .A(A[6]), .Y(n29) );
  INVX2 U31 ( .A(A[4]), .Y(n30) );
  AOI21X1 U32 ( .A(n33), .B(A[9]), .C(n34), .Y(n32) );
  OAI21X1 U33 ( .A(n35), .B(n28), .C(n33), .Y(SUM[8]) );
  AOI21X1 U34 ( .A(n37), .B(A[7]), .C(n35), .Y(n36) );
  OAI21X1 U35 ( .A(n38), .B(n29), .C(n37), .Y(SUM[6]) );
  AOI21X1 U36 ( .A(n40), .B(A[5]), .C(n38), .Y(n39) );
  OAI21X1 U37 ( .A(n41), .B(n30), .C(n40), .Y(SUM[4]) );
  AOI21X1 U38 ( .A(n43), .B(A[3]), .C(n41), .Y(n42) );
  XOR2X1 U39 ( .A(A[31]), .B(n44), .Y(SUM[31]) );
  NOR2X1 U40 ( .A(A[30]), .B(n45), .Y(n44) );
  XNOR2X1 U41 ( .A(A[30]), .B(n45), .Y(SUM[30]) );
  OAI21X1 U42 ( .A(n46), .B(n9), .C(n43), .Y(SUM[2]) );
  OAI21X1 U43 ( .A(n47), .B(n8), .C(n45), .Y(SUM[29]) );
  NAND2X1 U44 ( .A(n47), .B(n8), .Y(n45) );
  AOI21X1 U45 ( .A(n49), .B(A[28]), .C(n47), .Y(n48) );
  NOR2X1 U46 ( .A(n49), .B(A[28]), .Y(n47) );
  OAI21X1 U47 ( .A(n50), .B(n7), .C(n49), .Y(SUM[27]) );
  NAND2X1 U48 ( .A(n50), .B(n7), .Y(n49) );
  AOI21X1 U49 ( .A(n52), .B(A[26]), .C(n50), .Y(n51) );
  NOR2X1 U50 ( .A(n52), .B(A[26]), .Y(n50) );
  OAI21X1 U51 ( .A(n53), .B(n6), .C(n52), .Y(SUM[25]) );
  NAND2X1 U52 ( .A(n53), .B(n6), .Y(n52) );
  AOI21X1 U53 ( .A(n55), .B(A[24]), .C(n53), .Y(n54) );
  NOR2X1 U54 ( .A(n55), .B(A[24]), .Y(n53) );
  OAI21X1 U55 ( .A(n56), .B(n5), .C(n55), .Y(SUM[23]) );
  NAND2X1 U56 ( .A(n56), .B(n5), .Y(n55) );
  AOI21X1 U57 ( .A(n58), .B(A[22]), .C(n56), .Y(n57) );
  NOR2X1 U58 ( .A(n58), .B(A[22]), .Y(n56) );
  OAI21X1 U59 ( .A(n20), .B(n4), .C(n58), .Y(SUM[21]) );
  NAND2X1 U60 ( .A(n20), .B(n4), .Y(n58) );
  OAI21X1 U61 ( .A(n60), .B(n3), .C(n59), .Y(SUM[20]) );
  NAND2X1 U62 ( .A(n60), .B(n3), .Y(n59) );
  AOI21X1 U63 ( .A(A[0]), .B(A[1]), .C(n46), .Y(n61) );
  AOI21X1 U64 ( .A(n63), .B(A[19]), .C(n60), .Y(n62) );
  NOR2X1 U65 ( .A(n63), .B(A[19]), .Y(n60) );
  OAI21X1 U66 ( .A(n64), .B(n2), .C(n63), .Y(SUM[18]) );
  NAND2X1 U67 ( .A(n64), .B(n2), .Y(n63) );
  AOI21X1 U68 ( .A(n66), .B(A[17]), .C(n64), .Y(n65) );
  NOR2X1 U69 ( .A(n66), .B(A[17]), .Y(n64) );
  OAI21X1 U70 ( .A(n67), .B(n1), .C(n66), .Y(SUM[16]) );
  NAND2X1 U71 ( .A(n67), .B(n1), .Y(n66) );
  AOI21X1 U72 ( .A(n69), .B(A[15]), .C(n67), .Y(n68) );
  NOR2X1 U73 ( .A(n69), .B(A[15]), .Y(n67) );
  OAI21X1 U74 ( .A(n70), .B(n25), .C(n69), .Y(SUM[14]) );
  NAND2X1 U75 ( .A(n70), .B(n25), .Y(n69) );
  AOI21X1 U76 ( .A(n72), .B(A[13]), .C(n70), .Y(n71) );
  NOR2X1 U77 ( .A(n72), .B(A[13]), .Y(n70) );
  OAI21X1 U78 ( .A(n73), .B(n26), .C(n72), .Y(SUM[12]) );
  NAND2X1 U79 ( .A(n73), .B(n26), .Y(n72) );
  AOI21X1 U80 ( .A(n75), .B(A[11]), .C(n73), .Y(n74) );
  NOR2X1 U81 ( .A(n75), .B(A[11]), .Y(n73) );
  OAI21X1 U82 ( .A(n34), .B(n27), .C(n75), .Y(SUM[10]) );
  NAND2X1 U83 ( .A(n34), .B(n27), .Y(n75) );
  NOR2X1 U84 ( .A(n33), .B(A[9]), .Y(n34) );
  NAND2X1 U85 ( .A(n35), .B(n28), .Y(n33) );
  NOR2X1 U86 ( .A(n37), .B(A[7]), .Y(n35) );
  NAND2X1 U87 ( .A(n38), .B(n29), .Y(n37) );
  NOR2X1 U88 ( .A(n40), .B(A[5]), .Y(n38) );
  NAND2X1 U89 ( .A(n41), .B(n30), .Y(n40) );
  NOR2X1 U90 ( .A(n43), .B(A[3]), .Y(n41) );
  NAND2X1 U91 ( .A(n46), .B(n9), .Y(n43) );
  NOR2X1 U92 ( .A(A[1]), .B(A[0]), .Y(n46) );
endmodule


module flex_counter_NUM_CNT_BITS32_2_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module flex_counter_NUM_CNT_BITS32_2 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [31:0] rollover_val;
  output [31:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32,
         N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46,
         N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60,
         N61, N62, N63, N64, N65, N66, N67, n1, n2, n3, n4, n5, n6, n7, n8,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n135, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424;

  DFFSR \count_out_reg[0]  ( .D(n73), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n75), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n135), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n251), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n252), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n253), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(n254), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(n255), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(n256), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[10]  ( .D(n257), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[11]  ( .D(n258), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[12]  ( .D(n259), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[13]  ( .D(n260), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[14]  ( .D(n261), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[14]) );
  DFFSR \count_out_reg[15]  ( .D(n262), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[15]) );
  DFFSR \count_out_reg[16]  ( .D(n263), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[16]) );
  DFFSR \count_out_reg[17]  ( .D(n264), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[17]) );
  DFFSR \count_out_reg[18]  ( .D(n265), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[18]) );
  DFFSR \count_out_reg[19]  ( .D(n266), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[19]) );
  DFFSR \count_out_reg[20]  ( .D(n267), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[20]) );
  DFFSR \count_out_reg[21]  ( .D(n268), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[21]) );
  DFFSR \count_out_reg[22]  ( .D(n269), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[22]) );
  DFFSR \count_out_reg[23]  ( .D(n270), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[23]) );
  DFFSR \count_out_reg[24]  ( .D(n271), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[24]) );
  DFFSR \count_out_reg[25]  ( .D(n272), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[25]) );
  DFFSR \count_out_reg[26]  ( .D(n273), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[26]) );
  DFFSR \count_out_reg[27]  ( .D(n274), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[27]) );
  DFFSR \count_out_reg[28]  ( .D(n275), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[28]) );
  DFFSR \count_out_reg[29]  ( .D(n276), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[29]) );
  DFFSR \count_out_reg[30]  ( .D(n277), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[30]) );
  DFFSR \count_out_reg[31]  ( .D(n278), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[31]) );
  DFFSR rollover_flag_reg ( .D(n279), .CLK(clk), .R(n5), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U70 ( .A(n424), .B(n423), .C(n422), .Y(n279) );
  NAND2X1 U71 ( .A(rollover_flag), .B(n421), .Y(n422) );
  NAND2X1 U72 ( .A(n420), .B(n419), .Y(n423) );
  NOR2X1 U73 ( .A(n418), .B(n417), .Y(n419) );
  NAND3X1 U74 ( .A(n416), .B(n415), .C(n414), .Y(n417) );
  NOR2X1 U75 ( .A(n413), .B(n412), .Y(n414) );
  XNOR2X1 U76 ( .A(n70), .B(N66), .Y(n412) );
  XNOR2X1 U77 ( .A(n71), .B(N67), .Y(n413) );
  XNOR2X1 U78 ( .A(count_out[27]), .B(N63), .Y(n415) );
  XNOR2X1 U79 ( .A(count_out[26]), .B(N62), .Y(n416) );
  NAND3X1 U80 ( .A(n411), .B(n410), .C(n409), .Y(n418) );
  NOR2X1 U81 ( .A(n408), .B(n407), .Y(n409) );
  XNOR2X1 U82 ( .A(n58), .B(N54), .Y(n407) );
  XNOR2X1 U83 ( .A(n59), .B(N55), .Y(n408) );
  XNOR2X1 U84 ( .A(count_out[23]), .B(N59), .Y(n410) );
  NOR2X1 U85 ( .A(n406), .B(n405), .Y(n411) );
  XNOR2X1 U86 ( .A(n49), .B(N45), .Y(n405) );
  XNOR2X1 U87 ( .A(n62), .B(N58), .Y(n406) );
  NOR2X1 U88 ( .A(n404), .B(n403), .Y(n420) );
  NAND3X1 U89 ( .A(n402), .B(n401), .C(n400), .Y(n403) );
  NOR2X1 U90 ( .A(n399), .B(n398), .Y(n400) );
  XNOR2X1 U91 ( .A(n54), .B(N50), .Y(n398) );
  XNOR2X1 U92 ( .A(n55), .B(N51), .Y(n399) );
  XNOR2X1 U93 ( .A(count_out[11]), .B(N47), .Y(n401) );
  XNOR2X1 U94 ( .A(count_out[10]), .B(N46), .Y(n402) );
  NAND3X1 U95 ( .A(n397), .B(n396), .C(n395), .Y(n404) );
  NOR2X1 U96 ( .A(n394), .B(n393), .Y(n395) );
  XNOR2X1 U97 ( .A(n46), .B(N42), .Y(n393) );
  XNOR2X1 U98 ( .A(n47), .B(N43), .Y(n394) );
  XNOR2X1 U99 ( .A(count_out[3]), .B(N39), .Y(n396) );
  XNOR2X1 U100 ( .A(count_out[2]), .B(N38), .Y(n397) );
  NAND2X1 U101 ( .A(n392), .B(n391), .Y(n424) );
  NOR2X1 U102 ( .A(n390), .B(n389), .Y(n391) );
  NAND3X1 U103 ( .A(n388), .B(n387), .C(n386), .Y(n389) );
  NOR2X1 U104 ( .A(n385), .B(n384), .Y(n386) );
  XNOR2X1 U105 ( .A(n68), .B(N64), .Y(n384) );
  XNOR2X1 U106 ( .A(n57), .B(N53), .Y(n385) );
  XNOR2X1 U107 ( .A(count_out[29]), .B(N65), .Y(n387) );
  XNOR2X1 U108 ( .A(count_out[24]), .B(N60), .Y(n388) );
  NAND3X1 U109 ( .A(n383), .B(n382), .C(n381), .Y(n390) );
  NOR2X1 U110 ( .A(n380), .B(n379), .Y(n381) );
  XNOR2X1 U111 ( .A(n56), .B(N52), .Y(n379) );
  XNOR2X1 U112 ( .A(n61), .B(N57), .Y(n380) );
  XNOR2X1 U113 ( .A(count_out[20]), .B(N56), .Y(n382) );
  NOR2X1 U114 ( .A(clear), .B(n421), .Y(n383) );
  NOR2X1 U115 ( .A(n378), .B(n377), .Y(n392) );
  NAND3X1 U116 ( .A(n376), .B(n375), .C(n374), .Y(n377) );
  NOR2X1 U117 ( .A(n373), .B(n372), .Y(n374) );
  XNOR2X1 U118 ( .A(n52), .B(N48), .Y(n372) );
  XNOR2X1 U119 ( .A(n8), .B(N37), .Y(n373) );
  XNOR2X1 U120 ( .A(count_out[13]), .B(N49), .Y(n375) );
  XNOR2X1 U121 ( .A(count_out[8]), .B(N44), .Y(n376) );
  NAND3X1 U122 ( .A(n371), .B(n370), .C(n369), .Y(n378) );
  NOR2X1 U123 ( .A(n368), .B(n367), .Y(n369) );
  XNOR2X1 U124 ( .A(n44), .B(N40), .Y(n367) );
  XNOR2X1 U125 ( .A(n65), .B(N61), .Y(n368) );
  XNOR2X1 U126 ( .A(count_out[5]), .B(N41), .Y(n370) );
  XNOR2X1 U127 ( .A(count_out[0]), .B(N36), .Y(n371) );
  OAI21X1 U128 ( .A(n71), .B(n2), .C(n366), .Y(n278) );
  NAND2X1 U129 ( .A(N35), .B(n4), .Y(n366) );
  OAI21X1 U130 ( .A(n70), .B(n2), .C(n365), .Y(n277) );
  NAND2X1 U131 ( .A(N34), .B(n4), .Y(n365) );
  OAI21X1 U132 ( .A(n69), .B(n2), .C(n364), .Y(n276) );
  NAND2X1 U133 ( .A(N33), .B(n4), .Y(n364) );
  OAI21X1 U134 ( .A(n68), .B(n2), .C(n363), .Y(n275) );
  NAND2X1 U135 ( .A(N32), .B(n4), .Y(n363) );
  OAI21X1 U136 ( .A(n67), .B(n2), .C(n362), .Y(n274) );
  NAND2X1 U137 ( .A(N31), .B(n4), .Y(n362) );
  OAI21X1 U138 ( .A(n66), .B(n2), .C(n361), .Y(n273) );
  NAND2X1 U139 ( .A(N30), .B(n4), .Y(n361) );
  OAI21X1 U140 ( .A(n65), .B(n2), .C(n360), .Y(n272) );
  NAND2X1 U141 ( .A(N29), .B(n4), .Y(n360) );
  OAI21X1 U142 ( .A(n64), .B(n2), .C(n359), .Y(n271) );
  NAND2X1 U143 ( .A(N28), .B(n4), .Y(n359) );
  OAI21X1 U144 ( .A(n63), .B(n2), .C(n358), .Y(n270) );
  NAND2X1 U145 ( .A(N27), .B(n4), .Y(n358) );
  OAI21X1 U146 ( .A(n62), .B(n2), .C(n357), .Y(n269) );
  NAND2X1 U147 ( .A(N26), .B(n4), .Y(n357) );
  OAI21X1 U148 ( .A(n61), .B(n2), .C(n356), .Y(n268) );
  NAND2X1 U149 ( .A(N25), .B(n4), .Y(n356) );
  OAI21X1 U150 ( .A(n60), .B(n2), .C(n355), .Y(n267) );
  NAND2X1 U151 ( .A(N24), .B(n4), .Y(n355) );
  OAI21X1 U152 ( .A(n59), .B(n3), .C(n354), .Y(n266) );
  NAND2X1 U153 ( .A(N23), .B(n4), .Y(n354) );
  OAI21X1 U154 ( .A(n58), .B(n3), .C(n353), .Y(n265) );
  NAND2X1 U155 ( .A(N22), .B(n4), .Y(n353) );
  OAI21X1 U156 ( .A(n57), .B(n3), .C(n352), .Y(n264) );
  NAND2X1 U157 ( .A(N21), .B(n4), .Y(n352) );
  OAI21X1 U158 ( .A(n56), .B(n3), .C(n351), .Y(n263) );
  NAND2X1 U159 ( .A(N20), .B(n4), .Y(n351) );
  OAI21X1 U160 ( .A(n55), .B(n3), .C(n350), .Y(n262) );
  NAND2X1 U161 ( .A(N19), .B(n4), .Y(n350) );
  OAI21X1 U162 ( .A(n54), .B(n3), .C(n349), .Y(n261) );
  NAND2X1 U163 ( .A(N18), .B(n4), .Y(n349) );
  OAI21X1 U164 ( .A(n53), .B(n3), .C(n348), .Y(n260) );
  NAND2X1 U165 ( .A(N17), .B(n4), .Y(n348) );
  OAI21X1 U166 ( .A(n52), .B(n3), .C(n347), .Y(n259) );
  NAND2X1 U167 ( .A(N16), .B(n4), .Y(n347) );
  OAI21X1 U168 ( .A(n51), .B(n3), .C(n346), .Y(n258) );
  NAND2X1 U169 ( .A(N15), .B(n4), .Y(n346) );
  OAI21X1 U170 ( .A(n50), .B(n3), .C(n345), .Y(n257) );
  NAND2X1 U171 ( .A(N14), .B(n4), .Y(n345) );
  OAI21X1 U172 ( .A(n49), .B(n3), .C(n344), .Y(n256) );
  NAND2X1 U173 ( .A(N13), .B(n4), .Y(n344) );
  OAI21X1 U174 ( .A(n48), .B(n3), .C(n343), .Y(n255) );
  NAND2X1 U175 ( .A(N12), .B(n4), .Y(n343) );
  OAI21X1 U176 ( .A(n47), .B(n3), .C(n342), .Y(n254) );
  NAND2X1 U177 ( .A(N11), .B(n4), .Y(n342) );
  OAI21X1 U178 ( .A(n46), .B(n2), .C(n341), .Y(n253) );
  NAND2X1 U179 ( .A(N10), .B(n4), .Y(n341) );
  OAI21X1 U180 ( .A(n45), .B(n3), .C(n340), .Y(n252) );
  NAND2X1 U181 ( .A(N9), .B(n4), .Y(n340) );
  OAI21X1 U182 ( .A(n44), .B(n2), .C(n339), .Y(n251) );
  NAND2X1 U183 ( .A(N8), .B(n4), .Y(n339) );
  OAI21X1 U184 ( .A(n43), .B(n3), .C(n338), .Y(n135) );
  NAND2X1 U185 ( .A(N7), .B(n4), .Y(n338) );
  OAI21X1 U186 ( .A(n42), .B(n2), .C(n337), .Y(n75) );
  NAND2X1 U187 ( .A(N6), .B(n4), .Y(n337) );
  OAI21X1 U188 ( .A(n8), .B(n3), .C(n336), .Y(n74) );
  NAND2X1 U189 ( .A(N5), .B(n4), .Y(n336) );
  OAI21X1 U190 ( .A(n7), .B(n2), .C(n335), .Y(n73) );
  NAND2X1 U191 ( .A(N4), .B(n4), .Y(n335) );
  OAI21X1 U193 ( .A(n333), .B(n332), .C(n72), .Y(n334) );
  NAND2X1 U194 ( .A(n331), .B(n330), .Y(n332) );
  NOR2X1 U195 ( .A(n329), .B(n328), .Y(n330) );
  NAND3X1 U196 ( .A(n327), .B(n326), .C(n325), .Y(n328) );
  NOR2X1 U197 ( .A(n324), .B(n323), .Y(n325) );
  XNOR2X1 U198 ( .A(rollover_val[30]), .B(n70), .Y(n323) );
  XNOR2X1 U199 ( .A(rollover_val[31]), .B(n71), .Y(n324) );
  XNOR2X1 U200 ( .A(count_out[27]), .B(rollover_val[27]), .Y(n326) );
  XNOR2X1 U201 ( .A(count_out[26]), .B(rollover_val[26]), .Y(n327) );
  NAND3X1 U202 ( .A(n322), .B(n321), .C(n320), .Y(n329) );
  NOR2X1 U203 ( .A(n319), .B(n318), .Y(n320) );
  XNOR2X1 U204 ( .A(rollover_val[22]), .B(n62), .Y(n318) );
  XNOR2X1 U205 ( .A(rollover_val[23]), .B(n63), .Y(n319) );
  XNOR2X1 U206 ( .A(count_out[19]), .B(rollover_val[19]), .Y(n321) );
  XNOR2X1 U207 ( .A(count_out[18]), .B(rollover_val[18]), .Y(n322) );
  NOR2X1 U208 ( .A(n317), .B(n316), .Y(n331) );
  NAND3X1 U209 ( .A(n315), .B(n314), .C(n313), .Y(n316) );
  NOR2X1 U210 ( .A(n312), .B(n311), .Y(n313) );
  XNOR2X1 U211 ( .A(rollover_val[14]), .B(n54), .Y(n311) );
  XNOR2X1 U212 ( .A(rollover_val[15]), .B(n55), .Y(n312) );
  XNOR2X1 U213 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n314) );
  XNOR2X1 U214 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n315) );
  NAND3X1 U215 ( .A(n310), .B(n309), .C(n308), .Y(n317) );
  NOR2X1 U216 ( .A(n307), .B(n306), .Y(n308) );
  XNOR2X1 U217 ( .A(rollover_val[6]), .B(n46), .Y(n306) );
  XNOR2X1 U218 ( .A(rollover_val[7]), .B(n47), .Y(n307) );
  XNOR2X1 U219 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n309) );
  XNOR2X1 U220 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n310) );
  NAND2X1 U221 ( .A(n305), .B(n304), .Y(n333) );
  NOR2X1 U222 ( .A(n303), .B(n302), .Y(n304) );
  NAND3X1 U223 ( .A(n301), .B(n300), .C(n299), .Y(n302) );
  NOR2X1 U224 ( .A(n298), .B(n297), .Y(n299) );
  XNOR2X1 U225 ( .A(rollover_val[29]), .B(n69), .Y(n297) );
  XNOR2X1 U226 ( .A(rollover_val[28]), .B(n68), .Y(n298) );
  XNOR2X1 U227 ( .A(count_out[24]), .B(rollover_val[24]), .Y(n300) );
  XNOR2X1 U228 ( .A(count_out[25]), .B(rollover_val[25]), .Y(n301) );
  NAND3X1 U229 ( .A(n296), .B(n295), .C(n294), .Y(n303) );
  NOR2X1 U230 ( .A(n293), .B(n292), .Y(n294) );
  XNOR2X1 U231 ( .A(rollover_val[21]), .B(n61), .Y(n292) );
  XNOR2X1 U232 ( .A(rollover_val[20]), .B(n60), .Y(n293) );
  XNOR2X1 U233 ( .A(count_out[16]), .B(rollover_val[16]), .Y(n295) );
  XNOR2X1 U234 ( .A(count_out[17]), .B(rollover_val[17]), .Y(n296) );
  NOR2X1 U235 ( .A(n291), .B(n290), .Y(n305) );
  NAND3X1 U236 ( .A(n289), .B(n288), .C(n287), .Y(n290) );
  NOR2X1 U237 ( .A(n286), .B(n285), .Y(n287) );
  XNOR2X1 U238 ( .A(rollover_val[13]), .B(n53), .Y(n285) );
  XNOR2X1 U239 ( .A(rollover_val[12]), .B(n52), .Y(n286) );
  XNOR2X1 U240 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n288) );
  XNOR2X1 U241 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n289) );
  NAND3X1 U242 ( .A(n284), .B(n283), .C(n282), .Y(n291) );
  NOR2X1 U243 ( .A(n281), .B(n280), .Y(n282) );
  XNOR2X1 U244 ( .A(rollover_val[5]), .B(n45), .Y(n280) );
  XNOR2X1 U245 ( .A(rollover_val[4]), .B(n44), .Y(n281) );
  XNOR2X1 U246 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n283) );
  XNOR2X1 U247 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n284) );
  NOR2X1 U248 ( .A(clear), .B(count_enable), .Y(n421) );
  flex_counter_NUM_CNT_BITS32_2_DW01_dec_0 sub_56 ( .A(rollover_val), .SUM({
        N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55, N54, 
        N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  flex_counter_NUM_CNT_BITS32_2_DW01_inc_0 add_54 ( .A(count_out), .SUM({N35, 
        N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, 
        N20, N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5, N4}) );
  INVX1 U36 ( .A(n_rst), .Y(n6) );
  INVX2 U37 ( .A(n6), .Y(n5) );
  INVX2 U38 ( .A(n421), .Y(n2) );
  INVX2 U39 ( .A(n421), .Y(n3) );
  INVX2 U40 ( .A(n1), .Y(n4) );
  OR2X1 U41 ( .A(n421), .B(n334), .Y(n1) );
  INVX2 U42 ( .A(count_out[0]), .Y(n7) );
  INVX2 U43 ( .A(count_out[1]), .Y(n8) );
  INVX2 U44 ( .A(count_out[2]), .Y(n42) );
  INVX2 U45 ( .A(count_out[3]), .Y(n43) );
  INVX2 U46 ( .A(count_out[4]), .Y(n44) );
  INVX2 U47 ( .A(count_out[5]), .Y(n45) );
  INVX2 U48 ( .A(count_out[6]), .Y(n46) );
  INVX2 U49 ( .A(count_out[7]), .Y(n47) );
  INVX2 U50 ( .A(count_out[8]), .Y(n48) );
  INVX2 U51 ( .A(count_out[9]), .Y(n49) );
  INVX2 U52 ( .A(count_out[10]), .Y(n50) );
  INVX2 U53 ( .A(count_out[11]), .Y(n51) );
  INVX2 U54 ( .A(count_out[12]), .Y(n52) );
  INVX2 U55 ( .A(count_out[13]), .Y(n53) );
  INVX2 U56 ( .A(count_out[14]), .Y(n54) );
  INVX2 U57 ( .A(count_out[15]), .Y(n55) );
  INVX2 U58 ( .A(count_out[16]), .Y(n56) );
  INVX2 U59 ( .A(count_out[17]), .Y(n57) );
  INVX2 U60 ( .A(count_out[18]), .Y(n58) );
  INVX2 U61 ( .A(count_out[19]), .Y(n59) );
  INVX2 U62 ( .A(count_out[20]), .Y(n60) );
  INVX2 U63 ( .A(count_out[21]), .Y(n61) );
  INVX2 U64 ( .A(count_out[22]), .Y(n62) );
  INVX2 U65 ( .A(count_out[23]), .Y(n63) );
  INVX2 U66 ( .A(count_out[24]), .Y(n64) );
  INVX2 U67 ( .A(count_out[25]), .Y(n65) );
  INVX2 U68 ( .A(count_out[26]), .Y(n66) );
  INVX2 U69 ( .A(count_out[27]), .Y(n67) );
  INVX2 U192 ( .A(count_out[28]), .Y(n68) );
  INVX2 U249 ( .A(count_out[29]), .Y(n69) );
  INVX2 U250 ( .A(count_out[30]), .Y(n70) );
  INVX2 U251 ( .A(count_out[31]), .Y(n71) );
  INVX2 U252 ( .A(clear), .Y(n72) );
endmodule


module address_update_r_DW_cmp_0 ( A, B, TC, GE_LT, GE_GT_EQ, GE_LT_GT_LE, 
        EQ_NE );
  input [31:0] A;
  input [31:0] B;
  input TC, GE_LT, GE_GT_EQ;
  output GE_LT_GT_LE, EQ_NE;
  wire   n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284,
         n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295,
         n296, n297, n298, n299, n300, n301, n302, n303, n304, n305, n306,
         n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317,
         n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328,
         n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339,
         n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350,
         n351, n352, n353, n354, n355, n356, n357, n358, n359;

  INVX2 U161 ( .A(n302), .Y(n230) );
  INVX2 U162 ( .A(B[30]), .Y(n231) );
  INVX2 U163 ( .A(B[28]), .Y(n232) );
  INVX2 U164 ( .A(n309), .Y(n233) );
  INVX2 U165 ( .A(B[26]), .Y(n234) );
  INVX2 U166 ( .A(B[24]), .Y(n235) );
  INVX2 U167 ( .A(n296), .Y(n236) );
  INVX2 U168 ( .A(n285), .Y(n237) );
  INVX2 U169 ( .A(B[22]), .Y(n238) );
  INVX2 U170 ( .A(B[20]), .Y(n239) );
  INVX2 U171 ( .A(n317), .Y(n240) );
  INVX2 U172 ( .A(B[18]), .Y(n241) );
  INVX2 U173 ( .A(B[16]), .Y(n242) );
  INVX2 U174 ( .A(n320), .Y(n243) );
  INVX2 U175 ( .A(n325), .Y(n244) );
  INVX2 U176 ( .A(n348), .Y(n245) );
  INVX2 U177 ( .A(B[14]), .Y(n246) );
  INVX2 U178 ( .A(B[12]), .Y(n247) );
  INVX2 U179 ( .A(n355), .Y(n248) );
  INVX2 U180 ( .A(B[10]), .Y(n249) );
  INVX2 U181 ( .A(B[8]), .Y(n250) );
  INVX2 U182 ( .A(n337), .Y(n251) );
  INVX2 U183 ( .A(B[6]), .Y(n252) );
  INVX2 U184 ( .A(n341), .Y(n253) );
  INVX2 U185 ( .A(B[4]), .Y(n254) );
  INVX2 U186 ( .A(n338), .Y(n255) );
  INVX2 U187 ( .A(B[2]), .Y(n256) );
  INVX2 U188 ( .A(B[1]), .Y(n257) );
  INVX2 U189 ( .A(B[0]), .Y(n258) );
  INVX2 U190 ( .A(A[31]), .Y(n259) );
  INVX2 U191 ( .A(A[1]), .Y(n260) );
  INVX2 U192 ( .A(A[3]), .Y(n261) );
  INVX2 U193 ( .A(A[5]), .Y(n262) );
  INVX2 U194 ( .A(A[7]), .Y(n263) );
  INVX2 U195 ( .A(A[9]), .Y(n264) );
  INVX2 U196 ( .A(A[11]), .Y(n265) );
  INVX2 U197 ( .A(A[13]), .Y(n266) );
  INVX2 U198 ( .A(A[15]), .Y(n267) );
  INVX2 U199 ( .A(A[17]), .Y(n268) );
  INVX2 U200 ( .A(A[19]), .Y(n269) );
  INVX2 U201 ( .A(A[21]), .Y(n270) );
  INVX2 U202 ( .A(A[23]), .Y(n271) );
  INVX2 U203 ( .A(A[25]), .Y(n272) );
  INVX2 U204 ( .A(A[27]), .Y(n273) );
  INVX2 U205 ( .A(A[29]), .Y(n274) );
  OAI21X1 U206 ( .A(n275), .B(n276), .C(n277), .Y(GE_LT_GT_LE) );
  OAI22X1 U207 ( .A(n278), .B(n279), .C(n280), .D(n278), .Y(n277) );
  OAI21X1 U208 ( .A(n236), .B(n281), .C(n282), .Y(n279) );
  OAI22X1 U209 ( .A(n283), .B(n284), .C(n237), .D(n283), .Y(n282) );
  OAI21X1 U210 ( .A(B[21]), .B(n270), .C(n286), .Y(n284) );
  NAND3X1 U211 ( .A(n287), .B(n239), .C(A[20]), .Y(n286) );
  OAI21X1 U212 ( .A(B[23]), .B(n271), .C(n288), .Y(n283) );
  NAND3X1 U213 ( .A(n289), .B(n238), .C(A[22]), .Y(n288) );
  OAI22X1 U214 ( .A(n290), .B(n291), .C(n240), .D(n290), .Y(n281) );
  OAI21X1 U215 ( .A(B[17]), .B(n268), .C(n292), .Y(n291) );
  NAND3X1 U216 ( .A(n293), .B(n242), .C(A[16]), .Y(n292) );
  OAI21X1 U217 ( .A(B[19]), .B(n269), .C(n294), .Y(n290) );
  NAND3X1 U218 ( .A(n295), .B(n241), .C(A[18]), .Y(n294) );
  OAI21X1 U219 ( .A(n297), .B(n298), .C(n299), .Y(n278) );
  OAI22X1 U220 ( .A(n300), .B(n301), .C(n230), .D(n300), .Y(n299) );
  OAI21X1 U221 ( .A(B[29]), .B(n274), .C(n303), .Y(n301) );
  NAND3X1 U222 ( .A(n304), .B(n232), .C(A[28]), .Y(n303) );
  OAI21X1 U223 ( .A(B[31]), .B(n259), .C(n305), .Y(n300) );
  NAND3X1 U224 ( .A(n306), .B(n231), .C(A[30]), .Y(n305) );
  OAI22X1 U225 ( .A(n307), .B(n308), .C(n233), .D(n307), .Y(n298) );
  OAI21X1 U226 ( .A(B[25]), .B(n272), .C(n310), .Y(n308) );
  NAND3X1 U227 ( .A(n311), .B(n235), .C(A[24]), .Y(n310) );
  OAI21X1 U228 ( .A(B[27]), .B(n273), .C(n312), .Y(n307) );
  NAND3X1 U229 ( .A(n313), .B(n234), .C(A[26]), .Y(n312) );
  NAND3X1 U230 ( .A(n240), .B(n296), .C(n280), .Y(n276) );
  NOR3X1 U231 ( .A(n309), .B(n297), .C(n314), .Y(n280) );
  OAI21X1 U232 ( .A(n235), .B(A[24]), .C(n311), .Y(n314) );
  NAND2X1 U233 ( .A(B[25]), .B(n272), .Y(n311) );
  OR2X1 U234 ( .A(n302), .B(n315), .Y(n297) );
  OAI21X1 U235 ( .A(A[28]), .B(n232), .C(n304), .Y(n315) );
  NAND2X1 U236 ( .A(B[29]), .B(n274), .Y(n304) );
  OAI21X1 U237 ( .A(A[30]), .B(n231), .C(n306), .Y(n302) );
  NAND2X1 U238 ( .A(B[31]), .B(n259), .Y(n306) );
  OAI21X1 U239 ( .A(A[26]), .B(n234), .C(n313), .Y(n309) );
  NAND2X1 U240 ( .A(B[27]), .B(n273), .Y(n313) );
  NOR2X1 U241 ( .A(n285), .B(n316), .Y(n296) );
  OAI21X1 U242 ( .A(A[20]), .B(n239), .C(n287), .Y(n316) );
  NAND2X1 U243 ( .A(B[21]), .B(n270), .Y(n287) );
  OAI21X1 U244 ( .A(A[22]), .B(n238), .C(n289), .Y(n285) );
  NAND2X1 U245 ( .A(B[23]), .B(n271), .Y(n289) );
  OAI21X1 U246 ( .A(A[18]), .B(n241), .C(n295), .Y(n317) );
  NAND2X1 U247 ( .A(B[19]), .B(n269), .Y(n295) );
  OR2X1 U248 ( .A(n318), .B(n319), .Y(n275) );
  OAI21X1 U249 ( .A(n320), .B(n321), .C(n322), .Y(n319) );
  OAI21X1 U250 ( .A(n323), .B(n324), .C(n243), .Y(n322) );
  NAND2X1 U251 ( .A(n248), .B(n325), .Y(n324) );
  OAI21X1 U252 ( .A(A[8]), .B(n250), .C(n326), .Y(n323) );
  OAI21X1 U253 ( .A(n327), .B(n328), .C(n329), .Y(n321) );
  OAI22X1 U254 ( .A(n330), .B(n331), .C(n251), .D(n330), .Y(n329) );
  OAI21X1 U255 ( .A(B[5]), .B(n262), .C(n332), .Y(n331) );
  NAND3X1 U256 ( .A(n333), .B(n254), .C(A[4]), .Y(n332) );
  OAI21X1 U257 ( .A(B[7]), .B(n263), .C(n334), .Y(n330) );
  NAND3X1 U258 ( .A(n335), .B(n252), .C(A[6]), .Y(n334) );
  OAI21X1 U259 ( .A(n255), .B(n336), .C(n251), .Y(n328) );
  OAI21X1 U260 ( .A(A[6]), .B(n252), .C(n335), .Y(n337) );
  NAND2X1 U261 ( .A(B[7]), .B(n263), .Y(n335) );
  OAI21X1 U262 ( .A(n256), .B(A[2]), .C(n339), .Y(n338) );
  OAI21X1 U263 ( .A(n336), .B(n340), .C(n253), .Y(n327) );
  OAI21X1 U264 ( .A(n254), .B(A[4]), .C(n333), .Y(n341) );
  NAND2X1 U265 ( .A(B[5]), .B(n262), .Y(n333) );
  OAI21X1 U266 ( .A(B[1]), .B(n260), .C(n342), .Y(n340) );
  OAI22X1 U267 ( .A(A[1]), .B(n257), .C(A[0]), .D(n258), .Y(n342) );
  OAI21X1 U268 ( .A(B[3]), .B(n261), .C(n343), .Y(n336) );
  NAND3X1 U269 ( .A(n339), .B(n256), .C(A[2]), .Y(n343) );
  NAND2X1 U270 ( .A(B[3]), .B(n261), .Y(n339) );
  OAI21X1 U271 ( .A(n244), .B(n344), .C(n345), .Y(n320) );
  OAI22X1 U272 ( .A(n346), .B(n347), .C(n245), .D(n346), .Y(n345) );
  OAI21X1 U273 ( .A(B[13]), .B(n266), .C(n349), .Y(n347) );
  NAND3X1 U274 ( .A(n350), .B(n247), .C(A[12]), .Y(n349) );
  OAI21X1 U275 ( .A(B[15]), .B(n267), .C(n351), .Y(n346) );
  NAND3X1 U276 ( .A(n352), .B(n246), .C(A[14]), .Y(n351) );
  OAI22X1 U277 ( .A(n353), .B(n354), .C(n248), .D(n353), .Y(n344) );
  OAI21X1 U278 ( .A(A[10]), .B(n249), .C(n356), .Y(n355) );
  OAI21X1 U279 ( .A(B[9]), .B(n264), .C(n357), .Y(n354) );
  NAND3X1 U280 ( .A(n326), .B(n250), .C(A[8]), .Y(n357) );
  NAND2X1 U281 ( .A(B[9]), .B(n264), .Y(n326) );
  OAI21X1 U282 ( .A(B[11]), .B(n265), .C(n358), .Y(n353) );
  NAND3X1 U283 ( .A(n356), .B(n249), .C(A[10]), .Y(n358) );
  NAND2X1 U284 ( .A(B[11]), .B(n265), .Y(n356) );
  NOR2X1 U285 ( .A(n348), .B(n359), .Y(n325) );
  OAI21X1 U286 ( .A(A[12]), .B(n247), .C(n350), .Y(n359) );
  NAND2X1 U287 ( .A(B[13]), .B(n266), .Y(n350) );
  OAI21X1 U288 ( .A(A[14]), .B(n246), .C(n352), .Y(n348) );
  NAND2X1 U289 ( .A(B[15]), .B(n267), .Y(n352) );
  OAI21X1 U290 ( .A(A[16]), .B(n242), .C(n293), .Y(n318) );
  NAND2X1 U291 ( .A(B[17]), .B(n268), .Y(n293) );
endmodule


module address_update_r_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FAX1 U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .YS(SUM[31]) );
  FAX1 U1_30 ( .A(A[30]), .B(B[30]), .C(carry[30]), .YC(carry[31]), .YS(
        SUM[30]) );
  FAX1 U1_29 ( .A(A[29]), .B(B[29]), .C(carry[29]), .YC(carry[30]), .YS(
        SUM[29]) );
  FAX1 U1_28 ( .A(A[28]), .B(B[28]), .C(carry[28]), .YC(carry[29]), .YS(
        SUM[28]) );
  FAX1 U1_27 ( .A(A[27]), .B(B[27]), .C(carry[27]), .YC(carry[28]), .YS(
        SUM[27]) );
  FAX1 U1_26 ( .A(A[26]), .B(B[26]), .C(carry[26]), .YC(carry[27]), .YS(
        SUM[26]) );
  FAX1 U1_25 ( .A(A[25]), .B(B[25]), .C(carry[25]), .YC(carry[26]), .YS(
        SUM[25]) );
  FAX1 U1_24 ( .A(A[24]), .B(B[24]), .C(carry[24]), .YC(carry[25]), .YS(
        SUM[24]) );
  FAX1 U1_23 ( .A(A[23]), .B(B[23]), .C(carry[23]), .YC(carry[24]), .YS(
        SUM[23]) );
  FAX1 U1_22 ( .A(A[22]), .B(B[22]), .C(carry[22]), .YC(carry[23]), .YS(
        SUM[22]) );
  FAX1 U1_21 ( .A(A[21]), .B(B[21]), .C(carry[21]), .YC(carry[22]), .YS(
        SUM[21]) );
  FAX1 U1_20 ( .A(A[20]), .B(B[20]), .C(carry[20]), .YC(carry[21]), .YS(
        SUM[20]) );
  FAX1 U1_19 ( .A(A[19]), .B(B[19]), .C(carry[19]), .YC(carry[20]), .YS(
        SUM[19]) );
  FAX1 U1_18 ( .A(A[18]), .B(B[18]), .C(carry[18]), .YC(carry[19]), .YS(
        SUM[18]) );
  FAX1 U1_17 ( .A(A[17]), .B(B[17]), .C(carry[17]), .YC(carry[18]), .YS(
        SUM[17]) );
  FAX1 U1_16 ( .A(A[16]), .B(B[16]), .C(carry[16]), .YC(carry[17]), .YS(
        SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module address_update_r_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module address_update_r_DW01_add_1 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28;

  AND2X2 U1 ( .A(n17), .B(A[24]), .Y(n1) );
  AND2X2 U2 ( .A(n27), .B(A[4]), .Y(n2) );
  AND2X2 U3 ( .A(n15), .B(A[28]), .Y(n3) );
  AND2X2 U4 ( .A(n16), .B(A[26]), .Y(n4) );
  AND2X2 U5 ( .A(n18), .B(A[22]), .Y(n5) );
  AND2X2 U6 ( .A(n19), .B(A[20]), .Y(n6) );
  AND2X2 U7 ( .A(n20), .B(A[18]), .Y(n7) );
  AND2X2 U8 ( .A(n21), .B(A[16]), .Y(n8) );
  AND2X2 U9 ( .A(n22), .B(A[14]), .Y(n9) );
  AND2X2 U10 ( .A(n23), .B(A[12]), .Y(n10) );
  AND2X2 U11 ( .A(n24), .B(A[10]), .Y(n11) );
  AND2X2 U12 ( .A(n25), .B(A[8]), .Y(n12) );
  AND2X2 U13 ( .A(n26), .B(A[6]), .Y(n13) );
  AND2X2 U14 ( .A(n3), .B(A[29]), .Y(n14) );
  AND2X2 U15 ( .A(n4), .B(A[27]), .Y(n15) );
  AND2X2 U16 ( .A(n1), .B(A[25]), .Y(n16) );
  AND2X2 U17 ( .A(n5), .B(A[23]), .Y(n17) );
  AND2X2 U18 ( .A(n6), .B(A[21]), .Y(n18) );
  AND2X2 U19 ( .A(n7), .B(A[19]), .Y(n19) );
  AND2X2 U20 ( .A(n8), .B(A[17]), .Y(n20) );
  AND2X2 U21 ( .A(n9), .B(A[15]), .Y(n21) );
  AND2X2 U22 ( .A(n10), .B(A[13]), .Y(n22) );
  AND2X2 U23 ( .A(n11), .B(A[11]), .Y(n23) );
  AND2X2 U24 ( .A(n12), .B(A[9]), .Y(n24) );
  AND2X2 U25 ( .A(n13), .B(A[7]), .Y(n25) );
  AND2X2 U26 ( .A(n2), .B(A[5]), .Y(n26) );
  AND2X2 U27 ( .A(A[2]), .B(A[3]), .Y(n27) );
  AND2X2 U28 ( .A(n14), .B(A[30]), .Y(n28) );
  XOR2X1 U29 ( .A(A[31]), .B(n28), .Y(SUM[31]) );
  XOR2X1 U30 ( .A(n14), .B(A[30]), .Y(SUM[30]) );
  XOR2X1 U31 ( .A(n3), .B(A[29]), .Y(SUM[29]) );
  XOR2X1 U32 ( .A(n15), .B(A[28]), .Y(SUM[28]) );
  XOR2X1 U33 ( .A(n4), .B(A[27]), .Y(SUM[27]) );
  XOR2X1 U34 ( .A(n16), .B(A[26]), .Y(SUM[26]) );
  XOR2X1 U35 ( .A(n1), .B(A[25]), .Y(SUM[25]) );
  XOR2X1 U36 ( .A(n17), .B(A[24]), .Y(SUM[24]) );
  XOR2X1 U37 ( .A(n5), .B(A[23]), .Y(SUM[23]) );
  XOR2X1 U38 ( .A(n18), .B(A[22]), .Y(SUM[22]) );
  XOR2X1 U39 ( .A(n6), .B(A[21]), .Y(SUM[21]) );
  XOR2X1 U40 ( .A(n19), .B(A[20]), .Y(SUM[20]) );
  XOR2X1 U41 ( .A(n7), .B(A[19]), .Y(SUM[19]) );
  XOR2X1 U42 ( .A(n20), .B(A[18]), .Y(SUM[18]) );
  XOR2X1 U43 ( .A(n8), .B(A[17]), .Y(SUM[17]) );
  XOR2X1 U44 ( .A(n21), .B(A[16]), .Y(SUM[16]) );
  XOR2X1 U45 ( .A(n9), .B(A[15]), .Y(SUM[15]) );
  XOR2X1 U46 ( .A(n22), .B(A[14]), .Y(SUM[14]) );
  XOR2X1 U47 ( .A(n10), .B(A[13]), .Y(SUM[13]) );
  XOR2X1 U48 ( .A(n23), .B(A[12]), .Y(SUM[12]) );
  XOR2X1 U49 ( .A(n11), .B(A[11]), .Y(SUM[11]) );
  XOR2X1 U50 ( .A(n24), .B(A[10]), .Y(SUM[10]) );
  XOR2X1 U51 ( .A(n12), .B(A[9]), .Y(SUM[9]) );
  XOR2X1 U52 ( .A(n25), .B(A[8]), .Y(SUM[8]) );
  XOR2X1 U53 ( .A(n13), .B(A[7]), .Y(SUM[7]) );
  XOR2X1 U54 ( .A(n26), .B(A[6]), .Y(SUM[6]) );
  XOR2X1 U55 ( .A(n2), .B(A[5]), .Y(SUM[5]) );
  XOR2X1 U56 ( .A(n27), .B(A[4]), .Y(SUM[4]) );
  XOR2X1 U57 ( .A(A[2]), .B(A[3]), .Y(SUM[3]) );
endmodule


module address_update_r_DW_cmp_1 ( A, B, TC, GE_LT, GE_GT_EQ, GE_LT_GT_LE, 
        EQ_NE );
  input [31:0] A;
  input [31:0] B;
  input TC, GE_LT, GE_GT_EQ;
  output GE_LT_GT_LE, EQ_NE;
  wire   n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n282, n283, n284,
         n285, n286, n287, n288, n289, n290, n291, n292, n293, n294, n295,
         n296, n297, n298, n299, n300, n301, n302, n303, n304, n305, n306,
         n307, n308, n309, n310, n311, n312, n313, n314, n315, n316, n317,
         n318, n319, n320, n321, n322, n323, n324, n325, n326, n327, n328,
         n329, n330, n331, n332, n333, n334, n335, n336, n337, n338, n339,
         n340, n341, n342, n343, n344, n345, n346, n347, n348, n349, n350,
         n351, n352, n353, n354, n355, n356, n357, n358, n359;

  INVX2 U161 ( .A(n302), .Y(n230) );
  INVX2 U162 ( .A(B[30]), .Y(n231) );
  INVX2 U163 ( .A(B[28]), .Y(n232) );
  INVX2 U164 ( .A(n309), .Y(n233) );
  INVX2 U165 ( .A(B[26]), .Y(n234) );
  INVX2 U166 ( .A(B[24]), .Y(n235) );
  INVX2 U167 ( .A(n296), .Y(n236) );
  INVX2 U168 ( .A(n285), .Y(n237) );
  INVX2 U169 ( .A(B[22]), .Y(n238) );
  INVX2 U170 ( .A(B[20]), .Y(n239) );
  INVX2 U171 ( .A(n317), .Y(n240) );
  INVX2 U172 ( .A(B[18]), .Y(n241) );
  INVX2 U173 ( .A(B[16]), .Y(n242) );
  INVX2 U174 ( .A(n320), .Y(n243) );
  INVX2 U175 ( .A(n325), .Y(n244) );
  INVX2 U176 ( .A(n348), .Y(n245) );
  INVX2 U177 ( .A(B[14]), .Y(n246) );
  INVX2 U178 ( .A(B[12]), .Y(n247) );
  INVX2 U179 ( .A(n355), .Y(n248) );
  INVX2 U180 ( .A(B[10]), .Y(n249) );
  INVX2 U181 ( .A(B[8]), .Y(n250) );
  INVX2 U182 ( .A(n337), .Y(n251) );
  INVX2 U183 ( .A(B[6]), .Y(n252) );
  INVX2 U184 ( .A(n341), .Y(n253) );
  INVX2 U185 ( .A(B[4]), .Y(n254) );
  INVX2 U186 ( .A(n338), .Y(n255) );
  INVX2 U187 ( .A(B[2]), .Y(n256) );
  INVX2 U188 ( .A(B[1]), .Y(n257) );
  INVX2 U189 ( .A(B[0]), .Y(n258) );
  INVX2 U190 ( .A(A[31]), .Y(n259) );
  INVX2 U191 ( .A(A[1]), .Y(n260) );
  INVX2 U192 ( .A(A[3]), .Y(n261) );
  INVX2 U193 ( .A(A[5]), .Y(n262) );
  INVX2 U194 ( .A(A[7]), .Y(n263) );
  INVX2 U195 ( .A(A[9]), .Y(n264) );
  INVX2 U196 ( .A(A[11]), .Y(n265) );
  INVX2 U197 ( .A(A[13]), .Y(n266) );
  INVX2 U198 ( .A(A[15]), .Y(n267) );
  INVX2 U199 ( .A(A[17]), .Y(n268) );
  INVX2 U200 ( .A(A[19]), .Y(n269) );
  INVX2 U201 ( .A(A[21]), .Y(n270) );
  INVX2 U202 ( .A(A[23]), .Y(n271) );
  INVX2 U203 ( .A(A[25]), .Y(n272) );
  INVX2 U204 ( .A(A[27]), .Y(n273) );
  INVX2 U205 ( .A(A[29]), .Y(n274) );
  OAI21X1 U206 ( .A(n275), .B(n276), .C(n277), .Y(GE_LT_GT_LE) );
  OAI22X1 U207 ( .A(n278), .B(n279), .C(n280), .D(n278), .Y(n277) );
  OAI21X1 U208 ( .A(n236), .B(n281), .C(n282), .Y(n279) );
  OAI22X1 U209 ( .A(n283), .B(n284), .C(n237), .D(n283), .Y(n282) );
  OAI21X1 U210 ( .A(B[21]), .B(n270), .C(n286), .Y(n284) );
  NAND3X1 U211 ( .A(n287), .B(n239), .C(A[20]), .Y(n286) );
  OAI21X1 U212 ( .A(B[23]), .B(n271), .C(n288), .Y(n283) );
  NAND3X1 U213 ( .A(n289), .B(n238), .C(A[22]), .Y(n288) );
  OAI22X1 U214 ( .A(n290), .B(n291), .C(n240), .D(n290), .Y(n281) );
  OAI21X1 U215 ( .A(B[17]), .B(n268), .C(n292), .Y(n291) );
  NAND3X1 U216 ( .A(n293), .B(n242), .C(A[16]), .Y(n292) );
  OAI21X1 U217 ( .A(B[19]), .B(n269), .C(n294), .Y(n290) );
  NAND3X1 U218 ( .A(n295), .B(n241), .C(A[18]), .Y(n294) );
  OAI21X1 U219 ( .A(n297), .B(n298), .C(n299), .Y(n278) );
  OAI22X1 U220 ( .A(n300), .B(n301), .C(n230), .D(n300), .Y(n299) );
  OAI21X1 U221 ( .A(B[29]), .B(n274), .C(n303), .Y(n301) );
  NAND3X1 U222 ( .A(n304), .B(n232), .C(A[28]), .Y(n303) );
  OAI21X1 U223 ( .A(B[31]), .B(n259), .C(n305), .Y(n300) );
  NAND3X1 U224 ( .A(n306), .B(n231), .C(A[30]), .Y(n305) );
  OAI22X1 U225 ( .A(n307), .B(n308), .C(n233), .D(n307), .Y(n298) );
  OAI21X1 U226 ( .A(B[25]), .B(n272), .C(n310), .Y(n308) );
  NAND3X1 U227 ( .A(n311), .B(n235), .C(A[24]), .Y(n310) );
  OAI21X1 U228 ( .A(B[27]), .B(n273), .C(n312), .Y(n307) );
  NAND3X1 U229 ( .A(n313), .B(n234), .C(A[26]), .Y(n312) );
  NAND3X1 U230 ( .A(n240), .B(n296), .C(n280), .Y(n276) );
  NOR3X1 U231 ( .A(n309), .B(n297), .C(n314), .Y(n280) );
  OAI21X1 U232 ( .A(n235), .B(A[24]), .C(n311), .Y(n314) );
  NAND2X1 U233 ( .A(B[25]), .B(n272), .Y(n311) );
  OR2X1 U234 ( .A(n302), .B(n315), .Y(n297) );
  OAI21X1 U235 ( .A(A[28]), .B(n232), .C(n304), .Y(n315) );
  NAND2X1 U236 ( .A(B[29]), .B(n274), .Y(n304) );
  OAI21X1 U237 ( .A(A[30]), .B(n231), .C(n306), .Y(n302) );
  NAND2X1 U238 ( .A(B[31]), .B(n259), .Y(n306) );
  OAI21X1 U239 ( .A(A[26]), .B(n234), .C(n313), .Y(n309) );
  NAND2X1 U240 ( .A(B[27]), .B(n273), .Y(n313) );
  NOR2X1 U241 ( .A(n285), .B(n316), .Y(n296) );
  OAI21X1 U242 ( .A(A[20]), .B(n239), .C(n287), .Y(n316) );
  NAND2X1 U243 ( .A(B[21]), .B(n270), .Y(n287) );
  OAI21X1 U244 ( .A(A[22]), .B(n238), .C(n289), .Y(n285) );
  NAND2X1 U245 ( .A(B[23]), .B(n271), .Y(n289) );
  OAI21X1 U246 ( .A(A[18]), .B(n241), .C(n295), .Y(n317) );
  NAND2X1 U247 ( .A(B[19]), .B(n269), .Y(n295) );
  OR2X1 U248 ( .A(n318), .B(n319), .Y(n275) );
  OAI21X1 U249 ( .A(n320), .B(n321), .C(n322), .Y(n319) );
  OAI21X1 U250 ( .A(n323), .B(n324), .C(n243), .Y(n322) );
  NAND2X1 U251 ( .A(n248), .B(n325), .Y(n324) );
  OAI21X1 U252 ( .A(A[8]), .B(n250), .C(n326), .Y(n323) );
  OAI21X1 U253 ( .A(n327), .B(n328), .C(n329), .Y(n321) );
  OAI22X1 U254 ( .A(n330), .B(n331), .C(n251), .D(n330), .Y(n329) );
  OAI21X1 U255 ( .A(B[5]), .B(n262), .C(n332), .Y(n331) );
  NAND3X1 U256 ( .A(n333), .B(n254), .C(A[4]), .Y(n332) );
  OAI21X1 U257 ( .A(B[7]), .B(n263), .C(n334), .Y(n330) );
  NAND3X1 U258 ( .A(n335), .B(n252), .C(A[6]), .Y(n334) );
  OAI21X1 U259 ( .A(n255), .B(n336), .C(n251), .Y(n328) );
  OAI21X1 U260 ( .A(A[6]), .B(n252), .C(n335), .Y(n337) );
  NAND2X1 U261 ( .A(B[7]), .B(n263), .Y(n335) );
  OAI21X1 U262 ( .A(n256), .B(A[2]), .C(n339), .Y(n338) );
  OAI21X1 U263 ( .A(n336), .B(n340), .C(n253), .Y(n327) );
  OAI21X1 U264 ( .A(n254), .B(A[4]), .C(n333), .Y(n341) );
  NAND2X1 U265 ( .A(B[5]), .B(n262), .Y(n333) );
  OAI21X1 U266 ( .A(B[1]), .B(n260), .C(n342), .Y(n340) );
  OAI22X1 U267 ( .A(A[1]), .B(n257), .C(A[0]), .D(n258), .Y(n342) );
  OAI21X1 U268 ( .A(B[3]), .B(n261), .C(n343), .Y(n336) );
  NAND3X1 U269 ( .A(n339), .B(n256), .C(A[2]), .Y(n343) );
  NAND2X1 U270 ( .A(B[3]), .B(n261), .Y(n339) );
  OAI21X1 U271 ( .A(n244), .B(n344), .C(n345), .Y(n320) );
  OAI22X1 U272 ( .A(n346), .B(n347), .C(n245), .D(n346), .Y(n345) );
  OAI21X1 U273 ( .A(B[13]), .B(n266), .C(n349), .Y(n347) );
  NAND3X1 U274 ( .A(n350), .B(n247), .C(A[12]), .Y(n349) );
  OAI21X1 U275 ( .A(B[15]), .B(n267), .C(n351), .Y(n346) );
  NAND3X1 U276 ( .A(n352), .B(n246), .C(A[14]), .Y(n351) );
  OAI22X1 U277 ( .A(n353), .B(n354), .C(n248), .D(n353), .Y(n344) );
  OAI21X1 U278 ( .A(A[10]), .B(n249), .C(n356), .Y(n355) );
  OAI21X1 U279 ( .A(B[9]), .B(n264), .C(n357), .Y(n354) );
  NAND3X1 U280 ( .A(n326), .B(n250), .C(A[8]), .Y(n357) );
  NAND2X1 U281 ( .A(B[9]), .B(n264), .Y(n326) );
  OAI21X1 U282 ( .A(B[11]), .B(n265), .C(n358), .Y(n353) );
  NAND3X1 U283 ( .A(n356), .B(n249), .C(A[10]), .Y(n358) );
  NAND2X1 U284 ( .A(B[11]), .B(n265), .Y(n356) );
  NOR2X1 U285 ( .A(n348), .B(n359), .Y(n325) );
  OAI21X1 U286 ( .A(A[12]), .B(n247), .C(n350), .Y(n359) );
  NAND2X1 U287 ( .A(B[13]), .B(n266), .Y(n350) );
  OAI21X1 U288 ( .A(A[14]), .B(n246), .C(n352), .Y(n348) );
  NAND2X1 U289 ( .A(B[15]), .B(n267), .Y(n352) );
  OAI21X1 U290 ( .A(A[16]), .B(n242), .C(n293), .Y(n318) );
  NAND2X1 U291 ( .A(B[17]), .B(n268), .Y(n293) );
endmodule


module address_update_r_DW01_inc_1 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module address_update_r_DW_mult_uns_1 ( a, b, product );
  input [15:0] a;
  input [31:0] b;
  output [47:0] product;
  wire   n5, n15, n25, n35, n45, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n126, n127, n129, n130, n131, n132, n133, n134,
         n135, n136, n138, n139, n140, n141, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n156, n157, n158, n159,
         n160, n161, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n180, n181, n182, n183,
         n184, n185, n186, n187, n189, n190, n191, n192, n193, n194, n195,
         n196, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n284, n286, n288,
         n290, n292, n294, n296, n298, n300, n302, n304, n306, n308, n310,
         n312, n313, n509, n510, n511, n512, n513, n514, n515, n516, n517,
         n518, n519, n520, n521, n522, n523, n524, n525, n526, n527, n528,
         n529, n530, n531, n532, n533, n534, n535, n536, n537, n538, n539,
         n540, n541, n542, n543, n544, n545, n546, n547, n548, n549, n550,
         n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561,
         n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n950, n951, n952,
         n953, n954, n955, n956, n957, n958, n959, n960, n961, n962, n963,
         n964, n965, n966, n967, n968, n969, n970, n971, n972, n973, n974,
         n975, n976, n977, n978, n979, n980, n981, n982, n983, n984, n985,
         n986, n987, n988, n989, n990, n991, n992, n993, n994, n995, n996,
         n997, n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006,
         n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016,
         n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026,
         n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036,
         n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046,
         n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056,
         n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066,
         n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076,
         n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086,
         n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096,
         n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106,
         n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116,
         n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126,
         n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136,
         n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146,
         n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156,
         n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166,
         n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176,
         n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186,
         n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196,
         n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204, n1205, n1206,
         n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214, n1215, n1216,
         n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226,
         n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234, n1235, n1236,
         n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244, n1245, n1246,
         n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254, n1255, n1256,
         n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264, n1265, n1266,
         n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274, n1275, n1276,
         n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284, n1285, n1286,
         n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294, n1295, n1296,
         n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304, n1305, n1306,
         n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314, n1315, n1316,
         n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324, n1325, n1326,
         n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334, n1335, n1336,
         n1337, n1338, n1339, n1340, n1341;
  assign n5 = a[2];
  assign n15 = a[5];
  assign n25 = a[8];
  assign n35 = a[11];
  assign n45 = a[14];

  FAX1 U91 ( .A(n122), .B(n123), .C(n91), .YC(n90), .YS(product[30]) );
  FAX1 U92 ( .A(n126), .B(n124), .C(n92), .YC(n91), .YS(product[29]) );
  FAX1 U93 ( .A(n129), .B(n127), .C(n93), .YC(n92), .YS(product[28]) );
  FAX1 U94 ( .A(n130), .B(n133), .C(n94), .YC(n93), .YS(product[27]) );
  FAX1 U95 ( .A(n138), .B(n134), .C(n95), .YC(n94), .YS(product[26]) );
  FAX1 U96 ( .A(n143), .B(n139), .C(n96), .YC(n95), .YS(product[25]) );
  FAX1 U97 ( .A(n144), .B(n149), .C(n97), .YC(n96), .YS(product[24]) );
  FAX1 U98 ( .A(n156), .B(n150), .C(n98), .YC(n97), .YS(product[23]) );
  FAX1 U99 ( .A(n163), .B(n157), .C(n99), .YC(n98), .YS(product[22]) );
  FAX1 U100 ( .A(n164), .B(n171), .C(n100), .YC(n99), .YS(product[21]) );
  FAX1 U101 ( .A(n180), .B(n172), .C(n101), .YC(n100), .YS(product[20]) );
  FAX1 U102 ( .A(n189), .B(n181), .C(n102), .YC(n101), .YS(product[19]) );
  FAX1 U103 ( .A(n198), .B(n190), .C(n103), .YC(n102), .YS(product[18]) );
  FAX1 U104 ( .A(n199), .B(n618), .C(n104), .YC(n103), .YS(product[17]) );
  FAX1 U105 ( .A(n207), .B(n619), .C(n105), .YC(n104), .YS(product[16]) );
  FAX1 U106 ( .A(n215), .B(n620), .C(n106), .YC(n105), .YS(product[15]) );
  FAX1 U107 ( .A(n223), .B(n621), .C(n107), .YC(n106), .YS(product[14]) );
  FAX1 U108 ( .A(n231), .B(n622), .C(n108), .YC(n107), .YS(product[13]) );
  FAX1 U109 ( .A(n239), .B(n623), .C(n109), .YC(n108), .YS(product[12]) );
  FAX1 U110 ( .A(n247), .B(n624), .C(n110), .YC(n109), .YS(product[11]) );
  FAX1 U111 ( .A(n253), .B(n625), .C(n111), .YC(n110), .YS(product[10]) );
  FAX1 U112 ( .A(n259), .B(n626), .C(n112), .YC(n111), .YS(product[9]) );
  FAX1 U113 ( .A(n265), .B(n627), .C(n113), .YC(n112), .YS(product[8]) );
  FAX1 U114 ( .A(n269), .B(n628), .C(n114), .YC(n113), .YS(product[7]) );
  FAX1 U115 ( .A(n273), .B(n629), .C(n115), .YC(n114), .YS(product[6]) );
  FAX1 U116 ( .A(n277), .B(n630), .C(n116), .YC(n115), .YS(product[5]) );
  FAX1 U117 ( .A(n279), .B(n631), .C(n117), .YC(n116), .YS(product[4]) );
  FAX1 U118 ( .A(n281), .B(n632), .C(n118), .YC(n117), .YS(product[3]) );
  HAX1 U119 ( .A(n633), .B(n119), .YC(n118), .YS(product[2]) );
  HAX1 U120 ( .A(n634), .B(n120), .YC(n119), .YS(product[1]) );
  HAX1 U121 ( .A(n5), .B(n635), .YC(n120), .YS(product[0]) );
  FAX1 U122 ( .A(n288), .B(n284), .C(n541), .YC(n121), .YS(n122) );
  FAX1 U123 ( .A(n286), .B(n990), .C(n542), .YC(n123), .YS(n124) );
  FAX1 U125 ( .A(n990), .B(n131), .C(n543), .YC(n126), .YS(n127) );
  FAX1 U127 ( .A(n132), .B(n544), .C(n135), .YC(n129), .YS(n130) );
  FAX1 U128 ( .A(n292), .B(n290), .C(n560), .YC(n131), .YS(n132) );
  FAX1 U129 ( .A(n545), .B(n136), .C(n561), .YC(n133), .YS(n134) );
  FAX1 U130 ( .A(n294), .B(n995), .C(n140), .YC(n135), .YS(n136) );
  FAX1 U132 ( .A(n145), .B(n141), .C(n562), .YC(n138), .YS(n139) );
  FAX1 U133 ( .A(n998), .B(n147), .C(n546), .YC(n140), .YS(n141) );
  FAX1 U135 ( .A(n146), .B(n563), .C(n151), .YC(n143), .YS(n144) );
  FAX1 U136 ( .A(n148), .B(n153), .C(n547), .YC(n145), .YS(n146) );
  FAX1 U137 ( .A(n300), .B(n296), .C(n579), .YC(n147), .YS(n148) );
  FAX1 U138 ( .A(n564), .B(n152), .C(n580), .YC(n149), .YS(n150) );
  FAX1 U139 ( .A(n160), .B(n154), .C(n158), .YC(n151), .YS(n152) );
  FAX1 U140 ( .A(n298), .B(n1005), .C(n548), .YC(n153), .YS(n154) );
  FAX1 U142 ( .A(n165), .B(n159), .C(n581), .YC(n156), .YS(n157) );
  FAX1 U143 ( .A(n167), .B(n161), .C(n565), .YC(n158), .YS(n159) );
  FAX1 U144 ( .A(n1005), .B(n169), .C(n549), .YC(n160), .YS(n161) );
  FAX1 U146 ( .A(n166), .B(n582), .C(n173), .YC(n163), .YS(n164) );
  FAX1 U147 ( .A(n168), .B(n175), .C(n566), .YC(n165), .YS(n166) );
  FAX1 U148 ( .A(n170), .B(n177), .C(n550), .YC(n167), .YS(n168) );
  FAX1 U149 ( .A(n302), .B(n304), .C(n598), .YC(n169), .YS(n170) );
  FAX1 U150 ( .A(n583), .B(n174), .C(n599), .YC(n171), .YS(n172) );
  FAX1 U151 ( .A(n184), .B(n176), .C(n182), .YC(n173), .YS(n174) );
  FAX1 U152 ( .A(n551), .B(n178), .C(n567), .YC(n175), .YS(n176) );
  FAX1 U153 ( .A(n306), .B(n1010), .C(n186), .YC(n177), .YS(n178) );
  FAX1 U155 ( .A(n584), .B(n183), .C(n600), .YC(n180), .YS(n181) );
  FAX1 U156 ( .A(n193), .B(n185), .C(n191), .YC(n182), .YS(n183) );
  FAX1 U157 ( .A(n552), .B(n187), .C(n568), .YC(n184), .YS(n185) );
  FAX1 U158 ( .A(n308), .B(n1013), .C(n195), .YC(n186), .YS(n187) );
  FAX1 U160 ( .A(n200), .B(n192), .C(n601), .YC(n189), .YS(n190) );
  FAX1 U161 ( .A(n202), .B(n194), .C(n585), .YC(n191), .YS(n192) );
  FAX1 U162 ( .A(n204), .B(n196), .C(n569), .YC(n193), .YS(n194) );
  FAX1 U163 ( .A(n1016), .B(n617), .C(n553), .YC(n195), .YS(n196) );
  FAX1 U165 ( .A(n201), .B(n602), .C(n206), .YC(n198), .YS(n199) );
  FAX1 U166 ( .A(n203), .B(n586), .C(n208), .YC(n200), .YS(n201) );
  FAX1 U167 ( .A(n205), .B(n570), .C(n210), .YC(n202), .YS(n203) );
  FAX1 U168 ( .A(n310), .B(n554), .C(n212), .YC(n204), .YS(n205) );
  FAX1 U169 ( .A(n209), .B(n603), .C(n214), .YC(n206), .YS(n207) );
  FAX1 U170 ( .A(n211), .B(n587), .C(n216), .YC(n208), .YS(n209) );
  FAX1 U171 ( .A(n213), .B(n571), .C(n218), .YC(n210), .YS(n211) );
  FAX1 U172 ( .A(n312), .B(n555), .C(n220), .YC(n212), .YS(n213) );
  FAX1 U173 ( .A(n217), .B(n604), .C(n222), .YC(n214), .YS(n215) );
  FAX1 U174 ( .A(n219), .B(n588), .C(n224), .YC(n216), .YS(n217) );
  FAX1 U175 ( .A(n221), .B(n572), .C(n226), .YC(n218), .YS(n219) );
  FAX1 U176 ( .A(n313), .B(n556), .C(n228), .YC(n220), .YS(n221) );
  FAX1 U177 ( .A(n225), .B(n605), .C(n230), .YC(n222), .YS(n223) );
  FAX1 U178 ( .A(n227), .B(n589), .C(n232), .YC(n224), .YS(n225) );
  FAX1 U179 ( .A(n229), .B(n573), .C(n234), .YC(n226), .YS(n227) );
  HAX1 U180 ( .A(n557), .B(n236), .YC(n228), .YS(n229) );
  FAX1 U181 ( .A(n233), .B(n606), .C(n238), .YC(n230), .YS(n231) );
  FAX1 U182 ( .A(n235), .B(n590), .C(n240), .YC(n232), .YS(n233) );
  FAX1 U183 ( .A(n237), .B(n574), .C(n242), .YC(n234), .YS(n235) );
  HAX1 U184 ( .A(n558), .B(n244), .YC(n236), .YS(n237) );
  FAX1 U185 ( .A(n241), .B(n607), .C(n246), .YC(n238), .YS(n239) );
  FAX1 U186 ( .A(n243), .B(n591), .C(n248), .YC(n240), .YS(n241) );
  FAX1 U187 ( .A(n245), .B(n575), .C(n250), .YC(n242), .YS(n243) );
  HAX1 U188 ( .A(n45), .B(n559), .YC(n244), .YS(n245) );
  FAX1 U189 ( .A(n249), .B(n608), .C(n252), .YC(n246), .YS(n247) );
  FAX1 U190 ( .A(n251), .B(n592), .C(n254), .YC(n248), .YS(n249) );
  HAX1 U191 ( .A(n576), .B(n256), .YC(n250), .YS(n251) );
  FAX1 U192 ( .A(n255), .B(n609), .C(n258), .YC(n252), .YS(n253) );
  FAX1 U193 ( .A(n257), .B(n593), .C(n260), .YC(n254), .YS(n255) );
  HAX1 U194 ( .A(n577), .B(n262), .YC(n256), .YS(n257) );
  FAX1 U195 ( .A(n261), .B(n610), .C(n264), .YC(n258), .YS(n259) );
  FAX1 U196 ( .A(n263), .B(n594), .C(n266), .YC(n260), .YS(n261) );
  HAX1 U197 ( .A(n979), .B(n578), .YC(n262), .YS(n263) );
  FAX1 U198 ( .A(n267), .B(n611), .C(n268), .YC(n264), .YS(n265) );
  HAX1 U199 ( .A(n595), .B(n270), .YC(n266), .YS(n267) );
  FAX1 U200 ( .A(n271), .B(n612), .C(n272), .YC(n268), .YS(n269) );
  HAX1 U201 ( .A(n596), .B(n274), .YC(n270), .YS(n271) );
  FAX1 U202 ( .A(n275), .B(n613), .C(n276), .YC(n272), .YS(n273) );
  HAX1 U203 ( .A(n976), .B(n597), .YC(n274), .YS(n275) );
  HAX1 U204 ( .A(n614), .B(n278), .YC(n276), .YS(n277) );
  HAX1 U205 ( .A(n615), .B(n280), .YC(n278), .YS(n279) );
  HAX1 U206 ( .A(n973), .B(n616), .YC(n280), .YS(n281) );
  FAX1 U774 ( .A(b[16]), .B(b[15]), .C(n509), .YC(n524), .YS(n525) );
  FAX1 U775 ( .A(b[15]), .B(b[14]), .C(n510), .YC(n509), .YS(n526) );
  FAX1 U776 ( .A(b[14]), .B(b[13]), .C(n511), .YC(n510), .YS(n527) );
  FAX1 U777 ( .A(b[13]), .B(b[12]), .C(n512), .YC(n511), .YS(n528) );
  FAX1 U778 ( .A(b[12]), .B(b[11]), .C(n513), .YC(n512), .YS(n529) );
  FAX1 U779 ( .A(b[11]), .B(b[10]), .C(n514), .YC(n513), .YS(n530) );
  FAX1 U780 ( .A(b[10]), .B(b[9]), .C(n515), .YC(n514), .YS(n531) );
  FAX1 U781 ( .A(b[9]), .B(b[8]), .C(n516), .YC(n515), .YS(n532) );
  FAX1 U782 ( .A(b[8]), .B(b[7]), .C(n517), .YC(n516), .YS(n533) );
  FAX1 U783 ( .A(b[7]), .B(b[6]), .C(n518), .YC(n517), .YS(n534) );
  FAX1 U784 ( .A(b[6]), .B(b[5]), .C(n519), .YC(n518), .YS(n535) );
  FAX1 U785 ( .A(b[5]), .B(b[4]), .C(n520), .YC(n519), .YS(n536) );
  FAX1 U786 ( .A(b[4]), .B(b[3]), .C(n521), .YC(n520), .YS(n537) );
  FAX1 U787 ( .A(b[3]), .B(b[2]), .C(n522), .YC(n521), .YS(n538) );
  FAX1 U788 ( .A(b[2]), .B(n969), .C(n523), .YC(n522), .YS(n539) );
  HAX1 U789 ( .A(n969), .B(n967), .YC(n523), .YS(n540) );
  INVX1 U792 ( .A(n45), .Y(n982) );
  AND2X2 U793 ( .A(a[1]), .B(n1041), .Y(n950) );
  AND2X2 U794 ( .A(a[0]), .B(n1101), .Y(n951) );
  INVX1 U795 ( .A(a[0]), .Y(n1041) );
  INVX1 U796 ( .A(a[1]), .Y(n1040) );
  INVX2 U797 ( .A(n971), .Y(n970) );
  INVX2 U798 ( .A(n977), .Y(n975) );
  INVX2 U799 ( .A(n977), .Y(n976) );
  INVX2 U800 ( .A(n982), .Y(n981) );
  INVX2 U801 ( .A(n5), .Y(n971) );
  INVX2 U802 ( .A(n974), .Y(n972) );
  INVX2 U803 ( .A(n25), .Y(n977) );
  INVX2 U804 ( .A(n980), .Y(n978) );
  INVX2 U805 ( .A(n974), .Y(n973) );
  INVX2 U806 ( .A(n980), .Y(n979) );
  INVX2 U807 ( .A(n1048), .Y(n1038) );
  INVX2 U808 ( .A(n1105), .Y(n1034) );
  INVX2 U809 ( .A(n1097), .Y(n1039) );
  INVX2 U810 ( .A(n952), .Y(n960) );
  INVX2 U811 ( .A(n1165), .Y(n1030) );
  INVX2 U812 ( .A(n1106), .Y(n1036) );
  INVX2 U813 ( .A(n1155), .Y(n1035) );
  INVX2 U814 ( .A(b[0]), .Y(n1042) );
  INVX2 U815 ( .A(n953), .Y(n961) );
  INVX2 U816 ( .A(n1225), .Y(n1026) );
  INVX2 U817 ( .A(n1166), .Y(n1032) );
  INVX2 U818 ( .A(n1215), .Y(n1031) );
  INVX2 U819 ( .A(n15), .Y(n974) );
  INVX2 U820 ( .A(n1285), .Y(n1022) );
  INVX2 U821 ( .A(n1226), .Y(n1028) );
  INVX2 U822 ( .A(n1286), .Y(n1024) );
  INVX2 U823 ( .A(n1275), .Y(n1027) );
  INVX2 U824 ( .A(n1335), .Y(n1023) );
  INVX2 U825 ( .A(n954), .Y(n962) );
  INVX2 U826 ( .A(n955), .Y(n963) );
  INVX2 U827 ( .A(n35), .Y(n980) );
  INVX2 U828 ( .A(n956), .Y(n965) );
  INVX2 U829 ( .A(n957), .Y(n964) );
  INVX2 U830 ( .A(n951), .Y(n959) );
  AND2X2 U831 ( .A(n1161), .B(n1159), .Y(n952) );
  INVX2 U832 ( .A(b[7]), .Y(n1006) );
  INVX2 U833 ( .A(b[2]), .Y(n1019) );
  INVX2 U834 ( .A(b[3]), .Y(n1017) );
  INVX2 U835 ( .A(b[4]), .Y(n1014) );
  INVX2 U836 ( .A(b[5]), .Y(n1011) );
  INVX2 U837 ( .A(b[6]), .Y(n1008) );
  INVX2 U838 ( .A(b[9]), .Y(n1001) );
  INVX2 U839 ( .A(b[10]), .Y(n999) );
  INVX2 U840 ( .A(b[11]), .Y(n996) );
  INVX2 U841 ( .A(b[12]), .Y(n993) );
  INVX2 U842 ( .A(b[8]), .Y(n1003) );
  AND2X2 U843 ( .A(n1221), .B(n1219), .Y(n953) );
  INVX2 U844 ( .A(n968), .Y(n969) );
  INVX2 U845 ( .A(n966), .Y(n967) );
  INVX2 U846 ( .A(b[13]), .Y(n991) );
  INVX2 U847 ( .A(b[15]), .Y(n986) );
  INVX2 U848 ( .A(b[14]), .Y(n988) );
  INVX2 U849 ( .A(b[16]), .Y(n983) );
  AND2X2 U850 ( .A(n1281), .B(n1279), .Y(n954) );
  AND2X2 U851 ( .A(n1341), .B(n1339), .Y(n955) );
  XNOR2X1 U852 ( .A(a[15]), .B(n982), .Y(n956) );
  AND2X2 U853 ( .A(n965), .B(a[15]), .Y(n957) );
  INVX2 U854 ( .A(n950), .Y(n958) );
  INVX2 U855 ( .A(b[1]), .Y(n968) );
  INVX2 U856 ( .A(b[0]), .Y(n966) );
  INVX2 U857 ( .A(n524), .Y(n984) );
  INVX2 U858 ( .A(n525), .Y(n985) );
  INVX2 U859 ( .A(n526), .Y(n987) );
  INVX2 U860 ( .A(n527), .Y(n989) );
  INVX2 U861 ( .A(n288), .Y(n990) );
  INVX2 U862 ( .A(n528), .Y(n992) );
  INVX2 U863 ( .A(n529), .Y(n994) );
  INVX2 U864 ( .A(n292), .Y(n995) );
  INVX2 U865 ( .A(n530), .Y(n997) );
  INVX2 U866 ( .A(n294), .Y(n998) );
  INVX2 U867 ( .A(n531), .Y(n1000) );
  INVX2 U868 ( .A(n532), .Y(n1002) );
  INVX2 U869 ( .A(n533), .Y(n1004) );
  INVX2 U870 ( .A(n300), .Y(n1005) );
  INVX2 U871 ( .A(n534), .Y(n1007) );
  INVX2 U872 ( .A(n535), .Y(n1009) );
  INVX2 U873 ( .A(n304), .Y(n1010) );
  INVX2 U874 ( .A(n536), .Y(n1012) );
  INVX2 U875 ( .A(n306), .Y(n1013) );
  INVX2 U876 ( .A(n537), .Y(n1015) );
  INVX2 U877 ( .A(n308), .Y(n1016) );
  INVX2 U878 ( .A(n538), .Y(n1018) );
  INVX2 U879 ( .A(n539), .Y(n1020) );
  INVX2 U880 ( .A(n540), .Y(n1021) );
  INVX2 U881 ( .A(n1341), .Y(n1025) );
  INVX2 U882 ( .A(n1281), .Y(n1029) );
  INVX2 U883 ( .A(n1221), .Y(n1033) );
  INVX2 U884 ( .A(n1161), .Y(n1037) );
  XOR2X1 U885 ( .A(n1043), .B(n1044), .Y(product[31]) );
  XNOR2X1 U886 ( .A(n90), .B(n121), .Y(n1044) );
  OAI22X1 U887 ( .A(n964), .B(n986), .C(n965), .D(n983), .Y(n1043) );
  XOR2X1 U888 ( .A(n1045), .B(n970), .Y(n635) );
  OAI22X1 U889 ( .A(n1042), .B(n1038), .C(n959), .D(n1042), .Y(n1045) );
  XOR2X1 U890 ( .A(n1046), .B(n5), .Y(n634) );
  OAI21X1 U891 ( .A(n959), .B(n1021), .C(n1047), .Y(n1046) );
  AOI22X1 U892 ( .A(n969), .B(n1048), .C(n950), .D(n967), .Y(n1047) );
  XOR2X1 U893 ( .A(n1049), .B(n5), .Y(n633) );
  OAI21X1 U894 ( .A(n959), .B(n1020), .C(n1050), .Y(n1049) );
  OAI22X1 U895 ( .A(b[0]), .B(n1051), .C(n1039), .D(n1051), .Y(n1050) );
  OAI22X1 U896 ( .A(n968), .B(n958), .C(n1038), .D(n1019), .Y(n1051) );
  XOR2X1 U897 ( .A(n1052), .B(n5), .Y(n632) );
  OAI21X1 U898 ( .A(n959), .B(n1018), .C(n1053), .Y(n1052) );
  OAI22X1 U899 ( .A(b[1]), .B(n1054), .C(n1039), .D(n1054), .Y(n1053) );
  OAI22X1 U900 ( .A(n958), .B(n1019), .C(n1038), .D(n1017), .Y(n1054) );
  XOR2X1 U901 ( .A(n1055), .B(n5), .Y(n631) );
  OAI21X1 U902 ( .A(n959), .B(n1015), .C(n1056), .Y(n1055) );
  OAI22X1 U903 ( .A(b[2]), .B(n1057), .C(n1039), .D(n1057), .Y(n1056) );
  OAI22X1 U904 ( .A(n958), .B(n1017), .C(n1038), .D(n1014), .Y(n1057) );
  XOR2X1 U905 ( .A(n1058), .B(n5), .Y(n630) );
  OAI21X1 U906 ( .A(n959), .B(n1012), .C(n1059), .Y(n1058) );
  OAI22X1 U907 ( .A(b[3]), .B(n1060), .C(n1039), .D(n1060), .Y(n1059) );
  OAI22X1 U908 ( .A(n958), .B(n1014), .C(n1038), .D(n1011), .Y(n1060) );
  XOR2X1 U909 ( .A(n1061), .B(n970), .Y(n629) );
  OAI21X1 U910 ( .A(n959), .B(n1009), .C(n1062), .Y(n1061) );
  OAI22X1 U911 ( .A(b[4]), .B(n1063), .C(n1039), .D(n1063), .Y(n1062) );
  OAI22X1 U912 ( .A(n958), .B(n1011), .C(n1038), .D(n1008), .Y(n1063) );
  XOR2X1 U913 ( .A(n1064), .B(n970), .Y(n628) );
  OAI21X1 U914 ( .A(n959), .B(n1007), .C(n1065), .Y(n1064) );
  OAI22X1 U915 ( .A(b[5]), .B(n1066), .C(n1039), .D(n1066), .Y(n1065) );
  OAI22X1 U916 ( .A(n958), .B(n1008), .C(n1038), .D(n1006), .Y(n1066) );
  XOR2X1 U917 ( .A(n1067), .B(n970), .Y(n627) );
  OAI21X1 U918 ( .A(n959), .B(n1004), .C(n1068), .Y(n1067) );
  OAI22X1 U919 ( .A(b[6]), .B(n1069), .C(n1039), .D(n1069), .Y(n1068) );
  OAI22X1 U920 ( .A(n1038), .B(n1003), .C(n958), .D(n1006), .Y(n1069) );
  XOR2X1 U921 ( .A(n1070), .B(n970), .Y(n626) );
  OAI21X1 U922 ( .A(n959), .B(n1002), .C(n1071), .Y(n1070) );
  OAI22X1 U923 ( .A(b[7]), .B(n1072), .C(n1039), .D(n1072), .Y(n1071) );
  OAI22X1 U924 ( .A(n958), .B(n1003), .C(n1038), .D(n1001), .Y(n1072) );
  XOR2X1 U925 ( .A(n1073), .B(n970), .Y(n625) );
  OAI21X1 U926 ( .A(n959), .B(n1000), .C(n1074), .Y(n1073) );
  OAI22X1 U927 ( .A(b[8]), .B(n1075), .C(n1039), .D(n1075), .Y(n1074) );
  OAI22X1 U928 ( .A(n958), .B(n1001), .C(n1038), .D(n999), .Y(n1075) );
  XOR2X1 U929 ( .A(n1076), .B(n970), .Y(n624) );
  OAI21X1 U930 ( .A(n959), .B(n997), .C(n1077), .Y(n1076) );
  OAI22X1 U931 ( .A(b[9]), .B(n1078), .C(n1039), .D(n1078), .Y(n1077) );
  OAI22X1 U932 ( .A(n958), .B(n999), .C(n1038), .D(n996), .Y(n1078) );
  XOR2X1 U933 ( .A(n1079), .B(n970), .Y(n623) );
  OAI21X1 U934 ( .A(n959), .B(n994), .C(n1080), .Y(n1079) );
  OAI22X1 U935 ( .A(b[10]), .B(n1081), .C(n1039), .D(n1081), .Y(n1080) );
  OAI22X1 U936 ( .A(n958), .B(n996), .C(n1038), .D(n993), .Y(n1081) );
  XOR2X1 U937 ( .A(n1082), .B(n970), .Y(n622) );
  OAI21X1 U938 ( .A(n959), .B(n992), .C(n1083), .Y(n1082) );
  OAI22X1 U939 ( .A(b[11]), .B(n1084), .C(n1039), .D(n1084), .Y(n1083) );
  OAI22X1 U940 ( .A(n958), .B(n993), .C(n1038), .D(n991), .Y(n1084) );
  XOR2X1 U941 ( .A(n1085), .B(n970), .Y(n621) );
  OAI21X1 U942 ( .A(n959), .B(n989), .C(n1086), .Y(n1085) );
  OAI22X1 U943 ( .A(b[12]), .B(n1087), .C(n1039), .D(n1087), .Y(n1086) );
  OAI22X1 U944 ( .A(n1038), .B(n988), .C(n958), .D(n991), .Y(n1087) );
  XOR2X1 U945 ( .A(n1088), .B(n970), .Y(n620) );
  OAI21X1 U946 ( .A(n959), .B(n987), .C(n1089), .Y(n1088) );
  OAI22X1 U947 ( .A(b[13]), .B(n1090), .C(n1039), .D(n1090), .Y(n1089) );
  OAI22X1 U948 ( .A(n958), .B(n988), .C(n986), .D(n1038), .Y(n1090) );
  XOR2X1 U949 ( .A(n1091), .B(n970), .Y(n619) );
  OAI21X1 U950 ( .A(n959), .B(n985), .C(n1092), .Y(n1091) );
  OAI22X1 U951 ( .A(b[14]), .B(n1093), .C(n1039), .D(n1093), .Y(n1092) );
  OAI22X1 U952 ( .A(n983), .B(n1038), .C(n986), .D(n958), .Y(n1093) );
  XOR2X1 U953 ( .A(n1094), .B(n970), .Y(n618) );
  OAI21X1 U954 ( .A(n959), .B(n984), .C(n1095), .Y(n1094) );
  OAI22X1 U955 ( .A(b[15]), .B(n1096), .C(n1039), .D(n1096), .Y(n1095) );
  OAI22X1 U956 ( .A(n983), .B(n958), .C(n983), .D(n1038), .Y(n1096) );
  XOR2X1 U957 ( .A(n971), .B(n1098), .Y(n617) );
  OAI21X1 U958 ( .A(n983), .B(n959), .C(n1099), .Y(n1098) );
  OAI21X1 U959 ( .A(n950), .B(n1100), .C(b[16]), .Y(n1099) );
  NAND2X1 U960 ( .A(n1038), .B(n1097), .Y(n1100) );
  NAND3X1 U961 ( .A(n1041), .B(n1040), .C(n1101), .Y(n1097) );
  NOR2X1 U962 ( .A(n1101), .B(n1041), .Y(n1048) );
  XOR2X1 U963 ( .A(n1040), .B(n971), .Y(n1101) );
  XOR2X1 U964 ( .A(n1102), .B(n973), .Y(n616) );
  OAI22X1 U965 ( .A(n1042), .B(n1034), .C(n1042), .D(n960), .Y(n1102) );
  XOR2X1 U966 ( .A(n1103), .B(n973), .Y(n615) );
  OAI21X1 U967 ( .A(n1021), .B(n960), .C(n1104), .Y(n1103) );
  AOI22X1 U968 ( .A(n1105), .B(n969), .C(n1106), .D(b[0]), .Y(n1104) );
  XOR2X1 U969 ( .A(n1107), .B(n973), .Y(n614) );
  OAI21X1 U970 ( .A(n1020), .B(n960), .C(n1108), .Y(n1107) );
  OAI22X1 U971 ( .A(n967), .B(n1109), .C(n1035), .D(n1109), .Y(n1108) );
  OAI22X1 U972 ( .A(n968), .B(n1036), .C(n1019), .D(n1034), .Y(n1109) );
  XOR2X1 U973 ( .A(n1110), .B(n973), .Y(n613) );
  OAI21X1 U974 ( .A(n1018), .B(n960), .C(n1111), .Y(n1110) );
  OAI22X1 U975 ( .A(b[1]), .B(n1112), .C(n1035), .D(n1112), .Y(n1111) );
  OAI22X1 U976 ( .A(n1019), .B(n1036), .C(n1017), .D(n1034), .Y(n1112) );
  XOR2X1 U977 ( .A(n1113), .B(n973), .Y(n612) );
  OAI21X1 U978 ( .A(n1015), .B(n960), .C(n1114), .Y(n1113) );
  OAI22X1 U979 ( .A(b[2]), .B(n1115), .C(n1035), .D(n1115), .Y(n1114) );
  OAI22X1 U980 ( .A(n1017), .B(n1036), .C(n1014), .D(n1034), .Y(n1115) );
  XOR2X1 U981 ( .A(n1116), .B(n973), .Y(n611) );
  OAI21X1 U982 ( .A(n1012), .B(n960), .C(n1117), .Y(n1116) );
  OAI22X1 U983 ( .A(b[3]), .B(n1118), .C(n1035), .D(n1118), .Y(n1117) );
  OAI22X1 U984 ( .A(n1014), .B(n1036), .C(n1011), .D(n1034), .Y(n1118) );
  XOR2X1 U985 ( .A(n1119), .B(n973), .Y(n610) );
  OAI21X1 U986 ( .A(n1009), .B(n960), .C(n1120), .Y(n1119) );
  OAI22X1 U987 ( .A(b[4]), .B(n1121), .C(n1035), .D(n1121), .Y(n1120) );
  OAI22X1 U988 ( .A(n1011), .B(n1036), .C(n1008), .D(n1034), .Y(n1121) );
  XOR2X1 U989 ( .A(n1122), .B(n972), .Y(n609) );
  OAI21X1 U990 ( .A(n1007), .B(n960), .C(n1123), .Y(n1122) );
  OAI22X1 U991 ( .A(b[5]), .B(n1124), .C(n1035), .D(n1124), .Y(n1123) );
  OAI22X1 U992 ( .A(n1008), .B(n1036), .C(n1006), .D(n1034), .Y(n1124) );
  XOR2X1 U993 ( .A(n1125), .B(n972), .Y(n608) );
  OAI21X1 U994 ( .A(n1004), .B(n960), .C(n1126), .Y(n1125) );
  OAI22X1 U995 ( .A(b[6]), .B(n1127), .C(n1035), .D(n1127), .Y(n1126) );
  OAI22X1 U996 ( .A(n1003), .B(n1034), .C(n1006), .D(n1036), .Y(n1127) );
  XOR2X1 U997 ( .A(n1128), .B(n972), .Y(n607) );
  OAI21X1 U998 ( .A(n1002), .B(n960), .C(n1129), .Y(n1128) );
  OAI22X1 U999 ( .A(b[7]), .B(n1130), .C(n1035), .D(n1130), .Y(n1129) );
  OAI22X1 U1000 ( .A(n1003), .B(n1036), .C(n1001), .D(n1034), .Y(n1130) );
  XOR2X1 U1001 ( .A(n1131), .B(n972), .Y(n606) );
  OAI21X1 U1002 ( .A(n1000), .B(n960), .C(n1132), .Y(n1131) );
  OAI22X1 U1003 ( .A(b[8]), .B(n1133), .C(n1035), .D(n1133), .Y(n1132) );
  OAI22X1 U1004 ( .A(n1001), .B(n1036), .C(n999), .D(n1034), .Y(n1133) );
  XOR2X1 U1005 ( .A(n1134), .B(n972), .Y(n605) );
  OAI21X1 U1006 ( .A(n997), .B(n960), .C(n1135), .Y(n1134) );
  OAI22X1 U1007 ( .A(b[9]), .B(n1136), .C(n1035), .D(n1136), .Y(n1135) );
  OAI22X1 U1008 ( .A(n999), .B(n1036), .C(n996), .D(n1034), .Y(n1136) );
  XOR2X1 U1009 ( .A(n1137), .B(n972), .Y(n604) );
  OAI21X1 U1010 ( .A(n994), .B(n960), .C(n1138), .Y(n1137) );
  OAI22X1 U1011 ( .A(b[10]), .B(n1139), .C(n1035), .D(n1139), .Y(n1138) );
  OAI22X1 U1012 ( .A(n996), .B(n1036), .C(n993), .D(n1034), .Y(n1139) );
  XOR2X1 U1013 ( .A(n1140), .B(n972), .Y(n603) );
  OAI21X1 U1014 ( .A(n992), .B(n960), .C(n1141), .Y(n1140) );
  OAI22X1 U1015 ( .A(b[11]), .B(n1142), .C(n1035), .D(n1142), .Y(n1141) );
  OAI22X1 U1016 ( .A(n993), .B(n1036), .C(n991), .D(n1034), .Y(n1142) );
  XOR2X1 U1017 ( .A(n1143), .B(n972), .Y(n602) );
  OAI21X1 U1018 ( .A(n989), .B(n960), .C(n1144), .Y(n1143) );
  OAI22X1 U1019 ( .A(b[12]), .B(n1145), .C(n1035), .D(n1145), .Y(n1144) );
  OAI22X1 U1020 ( .A(n988), .B(n1034), .C(n991), .D(n1036), .Y(n1145) );
  XOR2X1 U1021 ( .A(n1146), .B(n972), .Y(n601) );
  OAI21X1 U1022 ( .A(n987), .B(n960), .C(n1147), .Y(n1146) );
  OAI22X1 U1023 ( .A(b[13]), .B(n1148), .C(n1035), .D(n1148), .Y(n1147) );
  OAI22X1 U1024 ( .A(n988), .B(n1036), .C(n986), .D(n1034), .Y(n1148) );
  XOR2X1 U1025 ( .A(n1149), .B(n972), .Y(n600) );
  OAI21X1 U1026 ( .A(n985), .B(n960), .C(n1150), .Y(n1149) );
  OAI22X1 U1027 ( .A(b[14]), .B(n1151), .C(n1035), .D(n1151), .Y(n1150) );
  OAI22X1 U1028 ( .A(n983), .B(n1034), .C(n986), .D(n1036), .Y(n1151) );
  XOR2X1 U1029 ( .A(n1152), .B(n972), .Y(n599) );
  OAI21X1 U1030 ( .A(n984), .B(n960), .C(n1153), .Y(n1152) );
  OAI22X1 U1031 ( .A(b[15]), .B(n1154), .C(n1035), .D(n1154), .Y(n1153) );
  OAI22X1 U1032 ( .A(n983), .B(n1036), .C(n983), .D(n1034), .Y(n1154) );
  XOR2X1 U1033 ( .A(n974), .B(n1156), .Y(n598) );
  OAI21X1 U1034 ( .A(n983), .B(n960), .C(n1157), .Y(n1156) );
  OAI21X1 U1035 ( .A(n1106), .B(n1158), .C(b[16]), .Y(n1157) );
  NAND2X1 U1036 ( .A(n1034), .B(n1155), .Y(n1158) );
  NAND3X1 U1037 ( .A(n1037), .B(n1159), .C(n1160), .Y(n1155) );
  NOR2X1 U1038 ( .A(n1159), .B(n1037), .Y(n1105) );
  NOR2X1 U1039 ( .A(n1161), .B(n1160), .Y(n1106) );
  XNOR2X1 U1040 ( .A(a[3]), .B(a[4]), .Y(n1160) );
  XOR2X1 U1041 ( .A(a[4]), .B(n972), .Y(n1159) );
  XOR2X1 U1042 ( .A(a[3]), .B(n970), .Y(n1161) );
  XOR2X1 U1043 ( .A(n1162), .B(n976), .Y(n597) );
  OAI22X1 U1044 ( .A(n1042), .B(n1030), .C(n1042), .D(n961), .Y(n1162) );
  XOR2X1 U1045 ( .A(n1163), .B(n976), .Y(n596) );
  OAI21X1 U1046 ( .A(n1021), .B(n961), .C(n1164), .Y(n1163) );
  AOI22X1 U1047 ( .A(n1165), .B(n969), .C(n1166), .D(n967), .Y(n1164) );
  XOR2X1 U1048 ( .A(n1167), .B(n976), .Y(n595) );
  OAI21X1 U1049 ( .A(n1020), .B(n961), .C(n1168), .Y(n1167) );
  OAI22X1 U1050 ( .A(b[0]), .B(n1169), .C(n1031), .D(n1169), .Y(n1168) );
  OAI22X1 U1051 ( .A(n968), .B(n1032), .C(n1019), .D(n1030), .Y(n1169) );
  XOR2X1 U1052 ( .A(n1170), .B(n976), .Y(n594) );
  OAI21X1 U1053 ( .A(n1018), .B(n961), .C(n1171), .Y(n1170) );
  OAI22X1 U1054 ( .A(b[1]), .B(n1172), .C(n1031), .D(n1172), .Y(n1171) );
  OAI22X1 U1055 ( .A(n1019), .B(n1032), .C(n1017), .D(n1030), .Y(n1172) );
  XOR2X1 U1056 ( .A(n1173), .B(n976), .Y(n593) );
  OAI21X1 U1057 ( .A(n1015), .B(n961), .C(n1174), .Y(n1173) );
  OAI22X1 U1058 ( .A(b[2]), .B(n1175), .C(n1031), .D(n1175), .Y(n1174) );
  OAI22X1 U1059 ( .A(n1017), .B(n1032), .C(n1014), .D(n1030), .Y(n1175) );
  XOR2X1 U1060 ( .A(n1176), .B(n976), .Y(n592) );
  OAI21X1 U1061 ( .A(n1012), .B(n961), .C(n1177), .Y(n1176) );
  OAI22X1 U1062 ( .A(b[3]), .B(n1178), .C(n1031), .D(n1178), .Y(n1177) );
  OAI22X1 U1063 ( .A(n1014), .B(n1032), .C(n1011), .D(n1030), .Y(n1178) );
  XOR2X1 U1064 ( .A(n1179), .B(n976), .Y(n591) );
  OAI21X1 U1065 ( .A(n1009), .B(n961), .C(n1180), .Y(n1179) );
  OAI22X1 U1066 ( .A(b[4]), .B(n1181), .C(n1031), .D(n1181), .Y(n1180) );
  OAI22X1 U1067 ( .A(n1011), .B(n1032), .C(n1008), .D(n1030), .Y(n1181) );
  XOR2X1 U1068 ( .A(n1182), .B(n975), .Y(n590) );
  OAI21X1 U1069 ( .A(n1007), .B(n961), .C(n1183), .Y(n1182) );
  OAI22X1 U1070 ( .A(b[5]), .B(n1184), .C(n1031), .D(n1184), .Y(n1183) );
  OAI22X1 U1071 ( .A(n1008), .B(n1032), .C(n1006), .D(n1030), .Y(n1184) );
  XOR2X1 U1072 ( .A(n1185), .B(n975), .Y(n589) );
  OAI21X1 U1073 ( .A(n1004), .B(n961), .C(n1186), .Y(n1185) );
  OAI22X1 U1074 ( .A(b[6]), .B(n1187), .C(n1031), .D(n1187), .Y(n1186) );
  OAI22X1 U1075 ( .A(n1003), .B(n1030), .C(n1006), .D(n1032), .Y(n1187) );
  XOR2X1 U1076 ( .A(n1188), .B(n975), .Y(n588) );
  OAI21X1 U1077 ( .A(n1002), .B(n961), .C(n1189), .Y(n1188) );
  OAI22X1 U1078 ( .A(b[7]), .B(n1190), .C(n1031), .D(n1190), .Y(n1189) );
  OAI22X1 U1079 ( .A(n1003), .B(n1032), .C(n1001), .D(n1030), .Y(n1190) );
  XOR2X1 U1080 ( .A(n1191), .B(n975), .Y(n587) );
  OAI21X1 U1081 ( .A(n1000), .B(n961), .C(n1192), .Y(n1191) );
  OAI22X1 U1082 ( .A(b[8]), .B(n1193), .C(n1031), .D(n1193), .Y(n1192) );
  OAI22X1 U1083 ( .A(n1001), .B(n1032), .C(n999), .D(n1030), .Y(n1193) );
  XOR2X1 U1084 ( .A(n1194), .B(n975), .Y(n586) );
  OAI21X1 U1085 ( .A(n997), .B(n961), .C(n1195), .Y(n1194) );
  OAI22X1 U1086 ( .A(b[9]), .B(n1196), .C(n1031), .D(n1196), .Y(n1195) );
  OAI22X1 U1087 ( .A(n999), .B(n1032), .C(n996), .D(n1030), .Y(n1196) );
  XOR2X1 U1088 ( .A(n1197), .B(n975), .Y(n585) );
  OAI21X1 U1089 ( .A(n994), .B(n961), .C(n1198), .Y(n1197) );
  OAI22X1 U1090 ( .A(b[10]), .B(n1199), .C(n1031), .D(n1199), .Y(n1198) );
  OAI22X1 U1091 ( .A(n996), .B(n1032), .C(n993), .D(n1030), .Y(n1199) );
  XOR2X1 U1092 ( .A(n1200), .B(n975), .Y(n584) );
  OAI21X1 U1093 ( .A(n992), .B(n961), .C(n1201), .Y(n1200) );
  OAI22X1 U1094 ( .A(b[11]), .B(n1202), .C(n1031), .D(n1202), .Y(n1201) );
  OAI22X1 U1095 ( .A(n993), .B(n1032), .C(n991), .D(n1030), .Y(n1202) );
  XOR2X1 U1096 ( .A(n1203), .B(n975), .Y(n583) );
  OAI21X1 U1097 ( .A(n989), .B(n961), .C(n1204), .Y(n1203) );
  OAI22X1 U1098 ( .A(b[12]), .B(n1205), .C(n1031), .D(n1205), .Y(n1204) );
  OAI22X1 U1099 ( .A(n988), .B(n1030), .C(n991), .D(n1032), .Y(n1205) );
  XOR2X1 U1100 ( .A(n1206), .B(n975), .Y(n582) );
  OAI21X1 U1101 ( .A(n987), .B(n961), .C(n1207), .Y(n1206) );
  OAI22X1 U1102 ( .A(b[13]), .B(n1208), .C(n1031), .D(n1208), .Y(n1207) );
  OAI22X1 U1103 ( .A(n988), .B(n1032), .C(n986), .D(n1030), .Y(n1208) );
  XOR2X1 U1104 ( .A(n1209), .B(n975), .Y(n581) );
  OAI21X1 U1105 ( .A(n985), .B(n961), .C(n1210), .Y(n1209) );
  OAI22X1 U1106 ( .A(b[14]), .B(n1211), .C(n1031), .D(n1211), .Y(n1210) );
  OAI22X1 U1107 ( .A(n983), .B(n1030), .C(n986), .D(n1032), .Y(n1211) );
  XOR2X1 U1108 ( .A(n1212), .B(n975), .Y(n580) );
  OAI21X1 U1109 ( .A(n984), .B(n961), .C(n1213), .Y(n1212) );
  OAI22X1 U1110 ( .A(b[15]), .B(n1214), .C(n1031), .D(n1214), .Y(n1213) );
  OAI22X1 U1111 ( .A(n983), .B(n1032), .C(n983), .D(n1030), .Y(n1214) );
  XOR2X1 U1112 ( .A(n977), .B(n1216), .Y(n579) );
  OAI21X1 U1113 ( .A(n983), .B(n961), .C(n1217), .Y(n1216) );
  OAI21X1 U1114 ( .A(n1166), .B(n1218), .C(b[16]), .Y(n1217) );
  NAND2X1 U1115 ( .A(n1030), .B(n1215), .Y(n1218) );
  NAND3X1 U1116 ( .A(n1033), .B(n1219), .C(n1220), .Y(n1215) );
  NOR2X1 U1117 ( .A(n1219), .B(n1033), .Y(n1165) );
  NOR2X1 U1118 ( .A(n1221), .B(n1220), .Y(n1166) );
  XNOR2X1 U1119 ( .A(a[6]), .B(a[7]), .Y(n1220) );
  XOR2X1 U1120 ( .A(a[7]), .B(n975), .Y(n1219) );
  XOR2X1 U1121 ( .A(a[6]), .B(n972), .Y(n1221) );
  XOR2X1 U1122 ( .A(n1222), .B(n979), .Y(n578) );
  OAI22X1 U1123 ( .A(n1042), .B(n1026), .C(n1042), .D(n962), .Y(n1222) );
  XOR2X1 U1124 ( .A(n1223), .B(n979), .Y(n577) );
  OAI21X1 U1125 ( .A(n1021), .B(n962), .C(n1224), .Y(n1223) );
  AOI22X1 U1126 ( .A(n1225), .B(b[1]), .C(n1226), .D(b[0]), .Y(n1224) );
  XOR2X1 U1127 ( .A(n1227), .B(n979), .Y(n576) );
  OAI21X1 U1128 ( .A(n1020), .B(n962), .C(n1228), .Y(n1227) );
  OAI22X1 U1129 ( .A(n967), .B(n1229), .C(n1027), .D(n1229), .Y(n1228) );
  OAI22X1 U1130 ( .A(n968), .B(n1028), .C(n1019), .D(n1026), .Y(n1229) );
  XOR2X1 U1131 ( .A(n1230), .B(n979), .Y(n575) );
  OAI21X1 U1132 ( .A(n1018), .B(n962), .C(n1231), .Y(n1230) );
  OAI22X1 U1133 ( .A(b[1]), .B(n1232), .C(n1027), .D(n1232), .Y(n1231) );
  OAI22X1 U1134 ( .A(n1019), .B(n1028), .C(n1017), .D(n1026), .Y(n1232) );
  XOR2X1 U1135 ( .A(n1233), .B(n979), .Y(n574) );
  OAI21X1 U1136 ( .A(n1015), .B(n962), .C(n1234), .Y(n1233) );
  OAI22X1 U1137 ( .A(b[2]), .B(n1235), .C(n1027), .D(n1235), .Y(n1234) );
  OAI22X1 U1138 ( .A(n1017), .B(n1028), .C(n1014), .D(n1026), .Y(n1235) );
  XOR2X1 U1139 ( .A(n1236), .B(n979), .Y(n573) );
  OAI21X1 U1140 ( .A(n1012), .B(n962), .C(n1237), .Y(n1236) );
  OAI22X1 U1141 ( .A(b[3]), .B(n1238), .C(n1027), .D(n1238), .Y(n1237) );
  OAI22X1 U1142 ( .A(n1014), .B(n1028), .C(n1011), .D(n1026), .Y(n1238) );
  XOR2X1 U1143 ( .A(n1239), .B(n979), .Y(n572) );
  OAI21X1 U1144 ( .A(n1009), .B(n962), .C(n1240), .Y(n1239) );
  OAI22X1 U1145 ( .A(b[4]), .B(n1241), .C(n1027), .D(n1241), .Y(n1240) );
  OAI22X1 U1146 ( .A(n1011), .B(n1028), .C(n1008), .D(n1026), .Y(n1241) );
  XOR2X1 U1147 ( .A(n1242), .B(n978), .Y(n571) );
  OAI21X1 U1148 ( .A(n1007), .B(n962), .C(n1243), .Y(n1242) );
  OAI22X1 U1149 ( .A(b[5]), .B(n1244), .C(n1027), .D(n1244), .Y(n1243) );
  OAI22X1 U1150 ( .A(n1008), .B(n1028), .C(n1006), .D(n1026), .Y(n1244) );
  XOR2X1 U1151 ( .A(n1245), .B(n978), .Y(n570) );
  OAI21X1 U1152 ( .A(n1004), .B(n962), .C(n1246), .Y(n1245) );
  OAI22X1 U1153 ( .A(b[6]), .B(n1247), .C(n1027), .D(n1247), .Y(n1246) );
  OAI22X1 U1154 ( .A(n1003), .B(n1026), .C(n1006), .D(n1028), .Y(n1247) );
  XOR2X1 U1155 ( .A(n1248), .B(n978), .Y(n569) );
  OAI21X1 U1156 ( .A(n1002), .B(n962), .C(n1249), .Y(n1248) );
  OAI22X1 U1157 ( .A(b[7]), .B(n1250), .C(n1027), .D(n1250), .Y(n1249) );
  OAI22X1 U1158 ( .A(n1003), .B(n1028), .C(n1001), .D(n1026), .Y(n1250) );
  XOR2X1 U1159 ( .A(n1251), .B(n978), .Y(n568) );
  OAI21X1 U1160 ( .A(n1000), .B(n962), .C(n1252), .Y(n1251) );
  OAI22X1 U1161 ( .A(b[8]), .B(n1253), .C(n1027), .D(n1253), .Y(n1252) );
  OAI22X1 U1162 ( .A(n1001), .B(n1028), .C(n999), .D(n1026), .Y(n1253) );
  XOR2X1 U1163 ( .A(n1254), .B(n978), .Y(n567) );
  OAI21X1 U1164 ( .A(n997), .B(n962), .C(n1255), .Y(n1254) );
  OAI22X1 U1165 ( .A(b[9]), .B(n1256), .C(n1027), .D(n1256), .Y(n1255) );
  OAI22X1 U1166 ( .A(n999), .B(n1028), .C(n996), .D(n1026), .Y(n1256) );
  XOR2X1 U1167 ( .A(n1257), .B(n978), .Y(n566) );
  OAI21X1 U1168 ( .A(n994), .B(n962), .C(n1258), .Y(n1257) );
  OAI22X1 U1169 ( .A(b[10]), .B(n1259), .C(n1027), .D(n1259), .Y(n1258) );
  OAI22X1 U1170 ( .A(n996), .B(n1028), .C(n993), .D(n1026), .Y(n1259) );
  XOR2X1 U1171 ( .A(n1260), .B(n978), .Y(n565) );
  OAI21X1 U1172 ( .A(n992), .B(n962), .C(n1261), .Y(n1260) );
  OAI22X1 U1173 ( .A(b[11]), .B(n1262), .C(n1027), .D(n1262), .Y(n1261) );
  OAI22X1 U1174 ( .A(n993), .B(n1028), .C(n991), .D(n1026), .Y(n1262) );
  XOR2X1 U1175 ( .A(n1263), .B(n978), .Y(n564) );
  OAI21X1 U1176 ( .A(n989), .B(n962), .C(n1264), .Y(n1263) );
  OAI22X1 U1177 ( .A(b[12]), .B(n1265), .C(n1027), .D(n1265), .Y(n1264) );
  OAI22X1 U1178 ( .A(n988), .B(n1026), .C(n991), .D(n1028), .Y(n1265) );
  XOR2X1 U1179 ( .A(n1266), .B(n978), .Y(n563) );
  OAI21X1 U1180 ( .A(n987), .B(n962), .C(n1267), .Y(n1266) );
  OAI22X1 U1181 ( .A(b[13]), .B(n1268), .C(n1027), .D(n1268), .Y(n1267) );
  OAI22X1 U1182 ( .A(n988), .B(n1028), .C(n986), .D(n1026), .Y(n1268) );
  XOR2X1 U1183 ( .A(n1269), .B(n978), .Y(n562) );
  OAI21X1 U1184 ( .A(n985), .B(n962), .C(n1270), .Y(n1269) );
  OAI22X1 U1185 ( .A(b[14]), .B(n1271), .C(n1027), .D(n1271), .Y(n1270) );
  OAI22X1 U1186 ( .A(n983), .B(n1026), .C(n986), .D(n1028), .Y(n1271) );
  XOR2X1 U1187 ( .A(n1272), .B(n978), .Y(n561) );
  OAI21X1 U1188 ( .A(n984), .B(n962), .C(n1273), .Y(n1272) );
  OAI22X1 U1189 ( .A(b[15]), .B(n1274), .C(n1027), .D(n1274), .Y(n1273) );
  OAI22X1 U1190 ( .A(n983), .B(n1028), .C(n983), .D(n1026), .Y(n1274) );
  XOR2X1 U1191 ( .A(n980), .B(n1276), .Y(n560) );
  OAI21X1 U1192 ( .A(n983), .B(n962), .C(n1277), .Y(n1276) );
  OAI21X1 U1193 ( .A(n1226), .B(n1278), .C(b[16]), .Y(n1277) );
  NAND2X1 U1194 ( .A(n1026), .B(n1275), .Y(n1278) );
  NAND3X1 U1195 ( .A(n1029), .B(n1279), .C(n1280), .Y(n1275) );
  NOR2X1 U1196 ( .A(n1279), .B(n1029), .Y(n1225) );
  NOR2X1 U1197 ( .A(n1281), .B(n1280), .Y(n1226) );
  XNOR2X1 U1198 ( .A(a[10]), .B(a[9]), .Y(n1280) );
  XOR2X1 U1199 ( .A(a[10]), .B(n978), .Y(n1279) );
  XOR2X1 U1200 ( .A(a[9]), .B(n975), .Y(n1281) );
  XOR2X1 U1201 ( .A(n1282), .B(n981), .Y(n559) );
  OAI22X1 U1202 ( .A(n1042), .B(n1022), .C(n1042), .D(n963), .Y(n1282) );
  XOR2X1 U1203 ( .A(n1283), .B(n45), .Y(n558) );
  OAI21X1 U1204 ( .A(n1021), .B(n963), .C(n1284), .Y(n1283) );
  AOI22X1 U1205 ( .A(n1285), .B(b[1]), .C(n1286), .D(n967), .Y(n1284) );
  XOR2X1 U1206 ( .A(n1287), .B(n45), .Y(n557) );
  OAI21X1 U1207 ( .A(n1020), .B(n963), .C(n1288), .Y(n1287) );
  OAI22X1 U1208 ( .A(b[0]), .B(n1289), .C(n1023), .D(n1289), .Y(n1288) );
  OAI22X1 U1209 ( .A(n968), .B(n1024), .C(n1019), .D(n1022), .Y(n1289) );
  XOR2X1 U1210 ( .A(n1290), .B(n45), .Y(n556) );
  OAI21X1 U1211 ( .A(n1018), .B(n963), .C(n1291), .Y(n1290) );
  OAI22X1 U1212 ( .A(b[1]), .B(n1292), .C(n1023), .D(n1292), .Y(n1291) );
  OAI22X1 U1213 ( .A(n1019), .B(n1024), .C(n1017), .D(n1022), .Y(n1292) );
  XOR2X1 U1214 ( .A(n1293), .B(n45), .Y(n555) );
  OAI21X1 U1215 ( .A(n1015), .B(n963), .C(n1294), .Y(n1293) );
  OAI22X1 U1216 ( .A(b[2]), .B(n1295), .C(n1023), .D(n1295), .Y(n1294) );
  OAI22X1 U1217 ( .A(n1017), .B(n1024), .C(n1014), .D(n1022), .Y(n1295) );
  XOR2X1 U1218 ( .A(n1296), .B(n45), .Y(n554) );
  OAI21X1 U1219 ( .A(n1012), .B(n963), .C(n1297), .Y(n1296) );
  OAI22X1 U1220 ( .A(b[3]), .B(n1298), .C(n1023), .D(n1298), .Y(n1297) );
  OAI22X1 U1221 ( .A(n1014), .B(n1024), .C(n1011), .D(n1022), .Y(n1298) );
  XOR2X1 U1222 ( .A(n1299), .B(n981), .Y(n553) );
  OAI21X1 U1223 ( .A(n1009), .B(n963), .C(n1300), .Y(n1299) );
  OAI22X1 U1224 ( .A(b[4]), .B(n1301), .C(n1023), .D(n1301), .Y(n1300) );
  OAI22X1 U1225 ( .A(n1011), .B(n1024), .C(n1008), .D(n1022), .Y(n1301) );
  XOR2X1 U1226 ( .A(n1302), .B(n981), .Y(n552) );
  OAI21X1 U1227 ( .A(n1007), .B(n963), .C(n1303), .Y(n1302) );
  OAI22X1 U1228 ( .A(b[5]), .B(n1304), .C(n1023), .D(n1304), .Y(n1303) );
  OAI22X1 U1229 ( .A(n1008), .B(n1024), .C(n1006), .D(n1022), .Y(n1304) );
  XOR2X1 U1230 ( .A(n1305), .B(n981), .Y(n551) );
  OAI21X1 U1231 ( .A(n1004), .B(n963), .C(n1306), .Y(n1305) );
  OAI22X1 U1232 ( .A(b[6]), .B(n1307), .C(n1023), .D(n1307), .Y(n1306) );
  OAI22X1 U1233 ( .A(n1003), .B(n1022), .C(n1006), .D(n1024), .Y(n1307) );
  XOR2X1 U1234 ( .A(n1308), .B(n981), .Y(n550) );
  OAI21X1 U1235 ( .A(n1002), .B(n963), .C(n1309), .Y(n1308) );
  OAI22X1 U1236 ( .A(b[7]), .B(n1310), .C(n1023), .D(n1310), .Y(n1309) );
  OAI22X1 U1237 ( .A(n1003), .B(n1024), .C(n1001), .D(n1022), .Y(n1310) );
  XOR2X1 U1238 ( .A(n1311), .B(n981), .Y(n549) );
  OAI21X1 U1239 ( .A(n1000), .B(n963), .C(n1312), .Y(n1311) );
  OAI22X1 U1240 ( .A(b[8]), .B(n1313), .C(n1023), .D(n1313), .Y(n1312) );
  OAI22X1 U1241 ( .A(n1001), .B(n1024), .C(n999), .D(n1022), .Y(n1313) );
  XOR2X1 U1242 ( .A(n1314), .B(n981), .Y(n548) );
  OAI21X1 U1243 ( .A(n997), .B(n963), .C(n1315), .Y(n1314) );
  OAI22X1 U1244 ( .A(b[9]), .B(n1316), .C(n1023), .D(n1316), .Y(n1315) );
  OAI22X1 U1245 ( .A(n999), .B(n1024), .C(n996), .D(n1022), .Y(n1316) );
  XOR2X1 U1246 ( .A(n1317), .B(n981), .Y(n547) );
  OAI21X1 U1247 ( .A(n994), .B(n963), .C(n1318), .Y(n1317) );
  OAI22X1 U1248 ( .A(b[10]), .B(n1319), .C(n1023), .D(n1319), .Y(n1318) );
  OAI22X1 U1249 ( .A(n996), .B(n1024), .C(n993), .D(n1022), .Y(n1319) );
  XOR2X1 U1250 ( .A(n1320), .B(n981), .Y(n546) );
  OAI21X1 U1251 ( .A(n992), .B(n963), .C(n1321), .Y(n1320) );
  OAI22X1 U1252 ( .A(b[11]), .B(n1322), .C(n1023), .D(n1322), .Y(n1321) );
  OAI22X1 U1253 ( .A(n993), .B(n1024), .C(n991), .D(n1022), .Y(n1322) );
  XOR2X1 U1254 ( .A(n1323), .B(n981), .Y(n545) );
  OAI21X1 U1255 ( .A(n989), .B(n963), .C(n1324), .Y(n1323) );
  OAI22X1 U1256 ( .A(b[12]), .B(n1325), .C(n1023), .D(n1325), .Y(n1324) );
  OAI22X1 U1257 ( .A(n988), .B(n1022), .C(n991), .D(n1024), .Y(n1325) );
  XOR2X1 U1258 ( .A(n1326), .B(n981), .Y(n544) );
  OAI21X1 U1259 ( .A(n987), .B(n963), .C(n1327), .Y(n1326) );
  OAI22X1 U1260 ( .A(b[13]), .B(n1328), .C(n1023), .D(n1328), .Y(n1327) );
  OAI22X1 U1261 ( .A(n988), .B(n1024), .C(n986), .D(n1022), .Y(n1328) );
  XOR2X1 U1262 ( .A(n1329), .B(n981), .Y(n543) );
  OAI21X1 U1263 ( .A(n985), .B(n963), .C(n1330), .Y(n1329) );
  OAI22X1 U1264 ( .A(b[14]), .B(n1331), .C(n1023), .D(n1331), .Y(n1330) );
  OAI22X1 U1265 ( .A(n983), .B(n1022), .C(n986), .D(n1024), .Y(n1331) );
  XOR2X1 U1266 ( .A(n1332), .B(n981), .Y(n542) );
  OAI21X1 U1267 ( .A(n984), .B(n963), .C(n1333), .Y(n1332) );
  OAI22X1 U1268 ( .A(b[15]), .B(n1334), .C(n1023), .D(n1334), .Y(n1333) );
  OAI22X1 U1269 ( .A(n983), .B(n1024), .C(n983), .D(n1022), .Y(n1334) );
  XOR2X1 U1270 ( .A(n982), .B(n1336), .Y(n541) );
  OAI21X1 U1271 ( .A(n983), .B(n963), .C(n1337), .Y(n1336) );
  OAI21X1 U1272 ( .A(n1286), .B(n1338), .C(b[16]), .Y(n1337) );
  NAND2X1 U1273 ( .A(n1022), .B(n1335), .Y(n1338) );
  NAND3X1 U1274 ( .A(n1025), .B(n1339), .C(n1340), .Y(n1335) );
  NOR2X1 U1275 ( .A(n1339), .B(n1025), .Y(n1285) );
  NOR2X1 U1276 ( .A(n1341), .B(n1340), .Y(n1286) );
  XNOR2X1 U1277 ( .A(a[12]), .B(a[13]), .Y(n1340) );
  XOR2X1 U1278 ( .A(a[13]), .B(n981), .Y(n1339) );
  XOR2X1 U1279 ( .A(a[12]), .B(n978), .Y(n1341) );
  NOR2X1 U1280 ( .A(n965), .B(n1042), .Y(n313) );
  OAI22X1 U1281 ( .A(n964), .B(n1042), .C(n965), .D(n968), .Y(n312) );
  OAI22X1 U1282 ( .A(n964), .B(n968), .C(n965), .D(n1019), .Y(n310) );
  OAI22X1 U1283 ( .A(n964), .B(n1011), .C(n965), .D(n1008), .Y(n302) );
  OAI22X1 U1284 ( .A(n964), .B(n1006), .C(n965), .D(n1003), .Y(n298) );
  OAI22X1 U1285 ( .A(n964), .B(n1003), .C(n965), .D(n1001), .Y(n296) );
  OAI22X1 U1286 ( .A(n964), .B(n996), .C(n965), .D(n993), .Y(n290) );
  OAI22X1 U1287 ( .A(n964), .B(n991), .C(n965), .D(n988), .Y(n286) );
  OAI22X1 U1288 ( .A(n964), .B(n988), .C(n965), .D(n986), .Y(n284) );
  OAI22X1 U1289 ( .A(n964), .B(n1019), .C(n965), .D(n1017), .Y(n308) );
  OAI22X1 U1290 ( .A(n964), .B(n1017), .C(n965), .D(n1014), .Y(n306) );
  OAI22X1 U1291 ( .A(n964), .B(n1014), .C(n965), .D(n1011), .Y(n304) );
  OAI22X1 U1292 ( .A(n964), .B(n1008), .C(n965), .D(n1006), .Y(n300) );
  OAI22X1 U1293 ( .A(n964), .B(n1001), .C(n965), .D(n999), .Y(n294) );
  OAI22X1 U1294 ( .A(n964), .B(n999), .C(n965), .D(n996), .Y(n292) );
  OAI22X1 U1295 ( .A(n964), .B(n993), .C(n965), .D(n991), .Y(n288) );
endmodule


module address_update_r_DW01_add_3 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FAX1 U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .YS(SUM[31]) );
  FAX1 U1_30 ( .A(A[30]), .B(B[30]), .C(carry[30]), .YC(carry[31]), .YS(
        SUM[30]) );
  FAX1 U1_29 ( .A(A[29]), .B(B[29]), .C(carry[29]), .YC(carry[30]), .YS(
        SUM[29]) );
  FAX1 U1_28 ( .A(A[28]), .B(B[28]), .C(carry[28]), .YC(carry[29]), .YS(
        SUM[28]) );
  FAX1 U1_27 ( .A(A[27]), .B(B[27]), .C(carry[27]), .YC(carry[28]), .YS(
        SUM[27]) );
  FAX1 U1_26 ( .A(A[26]), .B(B[26]), .C(carry[26]), .YC(carry[27]), .YS(
        SUM[26]) );
  FAX1 U1_25 ( .A(A[25]), .B(B[25]), .C(carry[25]), .YC(carry[26]), .YS(
        SUM[25]) );
  FAX1 U1_24 ( .A(A[24]), .B(B[24]), .C(carry[24]), .YC(carry[25]), .YS(
        SUM[24]) );
  FAX1 U1_23 ( .A(A[23]), .B(B[23]), .C(carry[23]), .YC(carry[24]), .YS(
        SUM[23]) );
  FAX1 U1_22 ( .A(A[22]), .B(B[22]), .C(carry[22]), .YC(carry[23]), .YS(
        SUM[22]) );
  FAX1 U1_21 ( .A(A[21]), .B(B[21]), .C(carry[21]), .YC(carry[22]), .YS(
        SUM[21]) );
  FAX1 U1_20 ( .A(A[20]), .B(B[20]), .C(carry[20]), .YC(carry[21]), .YS(
        SUM[20]) );
  FAX1 U1_19 ( .A(A[19]), .B(B[19]), .C(carry[19]), .YC(carry[20]), .YS(
        SUM[19]) );
  FAX1 U1_18 ( .A(A[18]), .B(B[18]), .C(carry[18]), .YC(carry[19]), .YS(
        SUM[18]) );
  FAX1 U1_17 ( .A(A[17]), .B(B[17]), .C(carry[17]), .YC(carry[18]), .YS(
        SUM[17]) );
  FAX1 U1_16 ( .A(A[16]), .B(B[16]), .C(carry[16]), .YC(carry[17]), .YS(
        SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module address_update_r_DW_mult_uns_0 ( a, b, product );
  input [15:0] a;
  input [31:0] b;
  output [47:0] product;
  wire   n5, n15, n25, n35, n45, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n126, n127, n129, n130, n131, n132, n133, n134,
         n135, n136, n138, n139, n140, n141, n143, n144, n145, n146, n147,
         n148, n149, n150, n151, n152, n153, n154, n156, n157, n158, n159,
         n160, n161, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n180, n181, n182, n183,
         n184, n185, n186, n187, n189, n190, n191, n192, n193, n194, n195,
         n196, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274, n275, n276, n277, n278, n279, n280, n281, n284, n286, n288,
         n290, n292, n294, n296, n298, n300, n302, n304, n306, n308, n310,
         n312, n313, n509, n510, n511, n512, n513, n514, n515, n516, n517,
         n518, n519, n520, n521, n522, n523, n524, n525, n526, n527, n528,
         n529, n530, n531, n532, n533, n534, n535, n536, n537, n538, n539,
         n540, n541, n542, n543, n544, n545, n546, n547, n548, n549, n550,
         n551, n552, n553, n554, n555, n556, n557, n558, n559, n560, n561,
         n562, n563, n564, n565, n566, n567, n568, n569, n570, n571, n572,
         n573, n574, n575, n576, n577, n578, n579, n580, n581, n582, n583,
         n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n950, n951, n952,
         n953, n954, n955, n956, n957, n958, n959, n960, n961, n962, n963,
         n964, n965, n966, n967, n968, n969, n970, n971, n972, n973, n974,
         n975, n976, n977, n978, n979, n980, n981, n982, n983, n984, n985,
         n986, n987, n988, n989, n990, n991, n992, n993, n994, n995, n996,
         n997, n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006,
         n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016,
         n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026,
         n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036,
         n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046,
         n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056,
         n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066,
         n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076,
         n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086,
         n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096,
         n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106,
         n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116,
         n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126,
         n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136,
         n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146,
         n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156,
         n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166,
         n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176,
         n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186,
         n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196,
         n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204, n1205, n1206,
         n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214, n1215, n1216,
         n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226,
         n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234, n1235, n1236,
         n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244, n1245, n1246,
         n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254, n1255, n1256,
         n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264, n1265, n1266,
         n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274, n1275, n1276,
         n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284, n1285, n1286,
         n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294, n1295, n1296,
         n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304, n1305, n1306,
         n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314, n1315, n1316,
         n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324, n1325, n1326,
         n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334, n1335, n1336;
  assign n5 = a[2];
  assign n15 = a[5];
  assign n25 = a[8];
  assign n35 = a[11];
  assign n45 = a[14];

  FAX1 U91 ( .A(n122), .B(n123), .C(n91), .YC(n90), .YS(product[30]) );
  FAX1 U92 ( .A(n126), .B(n124), .C(n92), .YC(n91), .YS(product[29]) );
  FAX1 U93 ( .A(n129), .B(n127), .C(n93), .YC(n92), .YS(product[28]) );
  FAX1 U94 ( .A(n130), .B(n133), .C(n94), .YC(n93), .YS(product[27]) );
  FAX1 U95 ( .A(n138), .B(n134), .C(n95), .YC(n94), .YS(product[26]) );
  FAX1 U96 ( .A(n143), .B(n139), .C(n96), .YC(n95), .YS(product[25]) );
  FAX1 U97 ( .A(n144), .B(n149), .C(n97), .YC(n96), .YS(product[24]) );
  FAX1 U98 ( .A(n156), .B(n150), .C(n98), .YC(n97), .YS(product[23]) );
  FAX1 U99 ( .A(n163), .B(n157), .C(n99), .YC(n98), .YS(product[22]) );
  FAX1 U100 ( .A(n164), .B(n171), .C(n100), .YC(n99), .YS(product[21]) );
  FAX1 U101 ( .A(n180), .B(n172), .C(n101), .YC(n100), .YS(product[20]) );
  FAX1 U102 ( .A(n189), .B(n181), .C(n102), .YC(n101), .YS(product[19]) );
  FAX1 U103 ( .A(n198), .B(n190), .C(n103), .YC(n102), .YS(product[18]) );
  FAX1 U104 ( .A(n199), .B(n618), .C(n104), .YC(n103), .YS(product[17]) );
  FAX1 U105 ( .A(n207), .B(n619), .C(n105), .YC(n104), .YS(product[16]) );
  FAX1 U106 ( .A(n215), .B(n620), .C(n106), .YC(n105), .YS(product[15]) );
  FAX1 U107 ( .A(n223), .B(n621), .C(n107), .YC(n106), .YS(product[14]) );
  FAX1 U108 ( .A(n231), .B(n622), .C(n108), .YC(n107), .YS(product[13]) );
  FAX1 U109 ( .A(n239), .B(n623), .C(n109), .YC(n108), .YS(product[12]) );
  FAX1 U110 ( .A(n247), .B(n624), .C(n110), .YC(n109), .YS(product[11]) );
  FAX1 U111 ( .A(n253), .B(n625), .C(n111), .YC(n110), .YS(product[10]) );
  FAX1 U112 ( .A(n259), .B(n626), .C(n112), .YC(n111), .YS(product[9]) );
  FAX1 U113 ( .A(n265), .B(n627), .C(n113), .YC(n112), .YS(product[8]) );
  FAX1 U114 ( .A(n269), .B(n628), .C(n114), .YC(n113), .YS(product[7]) );
  FAX1 U115 ( .A(n273), .B(n629), .C(n115), .YC(n114), .YS(product[6]) );
  FAX1 U116 ( .A(n277), .B(n630), .C(n116), .YC(n115), .YS(product[5]) );
  FAX1 U117 ( .A(n279), .B(n631), .C(n117), .YC(n116), .YS(product[4]) );
  FAX1 U118 ( .A(n281), .B(n632), .C(n118), .YC(n117), .YS(product[3]) );
  HAX1 U119 ( .A(n633), .B(n119), .YC(n118), .YS(product[2]) );
  HAX1 U120 ( .A(n634), .B(n120), .YC(n119), .YS(product[1]) );
  HAX1 U121 ( .A(n5), .B(n635), .YC(n120), .YS(product[0]) );
  FAX1 U122 ( .A(n288), .B(n284), .C(n541), .YC(n121), .YS(n122) );
  FAX1 U123 ( .A(n286), .B(n986), .C(n542), .YC(n123), .YS(n124) );
  FAX1 U125 ( .A(n986), .B(n131), .C(n543), .YC(n126), .YS(n127) );
  FAX1 U127 ( .A(n132), .B(n544), .C(n135), .YC(n129), .YS(n130) );
  FAX1 U128 ( .A(n292), .B(n290), .C(n560), .YC(n131), .YS(n132) );
  FAX1 U129 ( .A(n545), .B(n136), .C(n561), .YC(n133), .YS(n134) );
  FAX1 U130 ( .A(n294), .B(n991), .C(n140), .YC(n135), .YS(n136) );
  FAX1 U132 ( .A(n145), .B(n141), .C(n562), .YC(n138), .YS(n139) );
  FAX1 U133 ( .A(n994), .B(n147), .C(n546), .YC(n140), .YS(n141) );
  FAX1 U135 ( .A(n146), .B(n563), .C(n151), .YC(n143), .YS(n144) );
  FAX1 U136 ( .A(n148), .B(n153), .C(n547), .YC(n145), .YS(n146) );
  FAX1 U137 ( .A(n300), .B(n296), .C(n579), .YC(n147), .YS(n148) );
  FAX1 U138 ( .A(n564), .B(n152), .C(n580), .YC(n149), .YS(n150) );
  FAX1 U139 ( .A(n160), .B(n154), .C(n158), .YC(n151), .YS(n152) );
  FAX1 U140 ( .A(n298), .B(n1001), .C(n548), .YC(n153), .YS(n154) );
  FAX1 U142 ( .A(n165), .B(n159), .C(n581), .YC(n156), .YS(n157) );
  FAX1 U143 ( .A(n167), .B(n161), .C(n565), .YC(n158), .YS(n159) );
  FAX1 U144 ( .A(n1001), .B(n169), .C(n549), .YC(n160), .YS(n161) );
  FAX1 U146 ( .A(n166), .B(n582), .C(n173), .YC(n163), .YS(n164) );
  FAX1 U147 ( .A(n168), .B(n175), .C(n566), .YC(n165), .YS(n166) );
  FAX1 U148 ( .A(n170), .B(n177), .C(n550), .YC(n167), .YS(n168) );
  FAX1 U149 ( .A(n302), .B(n304), .C(n598), .YC(n169), .YS(n170) );
  FAX1 U150 ( .A(n583), .B(n174), .C(n599), .YC(n171), .YS(n172) );
  FAX1 U151 ( .A(n184), .B(n176), .C(n182), .YC(n173), .YS(n174) );
  FAX1 U152 ( .A(n551), .B(n178), .C(n567), .YC(n175), .YS(n176) );
  FAX1 U153 ( .A(n306), .B(n1006), .C(n186), .YC(n177), .YS(n178) );
  FAX1 U155 ( .A(n584), .B(n183), .C(n600), .YC(n180), .YS(n181) );
  FAX1 U156 ( .A(n193), .B(n185), .C(n191), .YC(n182), .YS(n183) );
  FAX1 U157 ( .A(n552), .B(n187), .C(n568), .YC(n184), .YS(n185) );
  FAX1 U158 ( .A(n308), .B(n1009), .C(n195), .YC(n186), .YS(n187) );
  FAX1 U160 ( .A(n200), .B(n192), .C(n601), .YC(n189), .YS(n190) );
  FAX1 U161 ( .A(n202), .B(n194), .C(n585), .YC(n191), .YS(n192) );
  FAX1 U162 ( .A(n204), .B(n196), .C(n569), .YC(n193), .YS(n194) );
  FAX1 U163 ( .A(n1012), .B(n617), .C(n553), .YC(n195), .YS(n196) );
  FAX1 U165 ( .A(n201), .B(n602), .C(n206), .YC(n198), .YS(n199) );
  FAX1 U166 ( .A(n203), .B(n586), .C(n208), .YC(n200), .YS(n201) );
  FAX1 U167 ( .A(n205), .B(n570), .C(n210), .YC(n202), .YS(n203) );
  FAX1 U168 ( .A(n310), .B(n554), .C(n212), .YC(n204), .YS(n205) );
  FAX1 U169 ( .A(n209), .B(n603), .C(n214), .YC(n206), .YS(n207) );
  FAX1 U170 ( .A(n211), .B(n587), .C(n216), .YC(n208), .YS(n209) );
  FAX1 U171 ( .A(n213), .B(n571), .C(n218), .YC(n210), .YS(n211) );
  FAX1 U172 ( .A(n312), .B(n555), .C(n220), .YC(n212), .YS(n213) );
  FAX1 U173 ( .A(n217), .B(n604), .C(n222), .YC(n214), .YS(n215) );
  FAX1 U174 ( .A(n219), .B(n588), .C(n224), .YC(n216), .YS(n217) );
  FAX1 U175 ( .A(n221), .B(n572), .C(n226), .YC(n218), .YS(n219) );
  FAX1 U176 ( .A(n313), .B(n556), .C(n228), .YC(n220), .YS(n221) );
  FAX1 U177 ( .A(n225), .B(n605), .C(n230), .YC(n222), .YS(n223) );
  FAX1 U178 ( .A(n227), .B(n589), .C(n232), .YC(n224), .YS(n225) );
  FAX1 U179 ( .A(n229), .B(n573), .C(n234), .YC(n226), .YS(n227) );
  HAX1 U180 ( .A(n557), .B(n236), .YC(n228), .YS(n229) );
  FAX1 U181 ( .A(n233), .B(n606), .C(n238), .YC(n230), .YS(n231) );
  FAX1 U182 ( .A(n235), .B(n590), .C(n240), .YC(n232), .YS(n233) );
  FAX1 U183 ( .A(n237), .B(n574), .C(n242), .YC(n234), .YS(n235) );
  HAX1 U184 ( .A(n558), .B(n244), .YC(n236), .YS(n237) );
  FAX1 U185 ( .A(n241), .B(n607), .C(n246), .YC(n238), .YS(n239) );
  FAX1 U186 ( .A(n243), .B(n591), .C(n248), .YC(n240), .YS(n241) );
  FAX1 U187 ( .A(n245), .B(n575), .C(n250), .YC(n242), .YS(n243) );
  HAX1 U188 ( .A(n45), .B(n559), .YC(n244), .YS(n245) );
  FAX1 U189 ( .A(n249), .B(n608), .C(n252), .YC(n246), .YS(n247) );
  FAX1 U190 ( .A(n251), .B(n592), .C(n254), .YC(n248), .YS(n249) );
  HAX1 U191 ( .A(n576), .B(n256), .YC(n250), .YS(n251) );
  FAX1 U192 ( .A(n255), .B(n609), .C(n258), .YC(n252), .YS(n253) );
  FAX1 U193 ( .A(n257), .B(n593), .C(n260), .YC(n254), .YS(n255) );
  HAX1 U194 ( .A(n577), .B(n262), .YC(n256), .YS(n257) );
  FAX1 U195 ( .A(n261), .B(n610), .C(n264), .YC(n258), .YS(n259) );
  FAX1 U196 ( .A(n263), .B(n594), .C(n266), .YC(n260), .YS(n261) );
  HAX1 U197 ( .A(n35), .B(n578), .YC(n262), .YS(n263) );
  FAX1 U198 ( .A(n267), .B(n611), .C(n268), .YC(n264), .YS(n265) );
  HAX1 U199 ( .A(n595), .B(n270), .YC(n266), .YS(n267) );
  FAX1 U200 ( .A(n271), .B(n612), .C(n272), .YC(n268), .YS(n269) );
  HAX1 U201 ( .A(n596), .B(n274), .YC(n270), .YS(n271) );
  FAX1 U202 ( .A(n275), .B(n613), .C(n276), .YC(n272), .YS(n273) );
  HAX1 U203 ( .A(n25), .B(n597), .YC(n274), .YS(n275) );
  HAX1 U204 ( .A(n614), .B(n278), .YC(n276), .YS(n277) );
  HAX1 U205 ( .A(n615), .B(n280), .YC(n278), .YS(n279) );
  HAX1 U206 ( .A(n15), .B(n616), .YC(n280), .YS(n281) );
  FAX1 U774 ( .A(b[16]), .B(b[15]), .C(n509), .YC(n524), .YS(n525) );
  FAX1 U775 ( .A(b[15]), .B(b[14]), .C(n510), .YC(n509), .YS(n526) );
  FAX1 U776 ( .A(b[14]), .B(b[13]), .C(n511), .YC(n510), .YS(n527) );
  FAX1 U777 ( .A(b[13]), .B(b[12]), .C(n512), .YC(n511), .YS(n528) );
  FAX1 U778 ( .A(b[12]), .B(b[11]), .C(n513), .YC(n512), .YS(n529) );
  FAX1 U779 ( .A(b[11]), .B(b[10]), .C(n514), .YC(n513), .YS(n530) );
  FAX1 U780 ( .A(b[10]), .B(b[9]), .C(n515), .YC(n514), .YS(n531) );
  FAX1 U781 ( .A(b[9]), .B(b[8]), .C(n516), .YC(n515), .YS(n532) );
  FAX1 U782 ( .A(b[8]), .B(b[7]), .C(n517), .YC(n516), .YS(n533) );
  FAX1 U783 ( .A(b[7]), .B(b[6]), .C(n518), .YC(n517), .YS(n534) );
  FAX1 U784 ( .A(b[6]), .B(b[5]), .C(n519), .YC(n518), .YS(n535) );
  FAX1 U785 ( .A(b[5]), .B(b[4]), .C(n520), .YC(n519), .YS(n536) );
  FAX1 U786 ( .A(b[4]), .B(b[3]), .C(n521), .YC(n520), .YS(n537) );
  FAX1 U787 ( .A(b[3]), .B(b[2]), .C(n522), .YC(n521), .YS(n538) );
  FAX1 U788 ( .A(b[2]), .B(n968), .C(n523), .YC(n522), .YS(n539) );
  HAX1 U789 ( .A(n968), .B(b[0]), .YC(n523), .YS(n540) );
  AND2X2 U792 ( .A(a[1]), .B(n1037), .Y(n950) );
  AND2X2 U793 ( .A(a[0]), .B(n1096), .Y(n951) );
  INVX1 U794 ( .A(a[0]), .Y(n1037) );
  INVX1 U795 ( .A(a[1]), .Y(n1036) );
  INVX2 U796 ( .A(n974), .Y(n973) );
  INVX2 U797 ( .A(n978), .Y(n977) );
  INVX2 U798 ( .A(n970), .Y(n969) );
  INVX2 U799 ( .A(n972), .Y(n971) );
  INVX2 U800 ( .A(n25), .Y(n974) );
  INVX2 U801 ( .A(n976), .Y(n975) );
  INVX2 U802 ( .A(n45), .Y(n978) );
  INVX2 U803 ( .A(n1043), .Y(n1034) );
  INVX2 U804 ( .A(n1100), .Y(n1030) );
  INVX2 U805 ( .A(n1092), .Y(n1035) );
  INVX2 U806 ( .A(n1160), .Y(n1026) );
  INVX2 U807 ( .A(n1101), .Y(n1032) );
  INVX2 U808 ( .A(n1150), .Y(n1031) );
  INVX2 U809 ( .A(n5), .Y(n970) );
  INVX2 U810 ( .A(n952), .Y(n960) );
  INVX2 U811 ( .A(n953), .Y(n961) );
  INVX2 U812 ( .A(n967), .Y(n968) );
  INVX2 U813 ( .A(n1220), .Y(n1022) );
  INVX2 U814 ( .A(n1161), .Y(n1028) );
  INVX2 U815 ( .A(n1210), .Y(n1027) );
  INVX2 U816 ( .A(b[16]), .Y(n979) );
  INVX2 U817 ( .A(n954), .Y(n962) );
  INVX2 U818 ( .A(n15), .Y(n972) );
  INVX2 U819 ( .A(n1280), .Y(n1018) );
  INVX2 U820 ( .A(n1221), .Y(n1024) );
  INVX2 U821 ( .A(n1281), .Y(n1020) );
  INVX2 U822 ( .A(n1270), .Y(n1023) );
  INVX2 U823 ( .A(n955), .Y(n963) );
  INVX2 U824 ( .A(n35), .Y(n976) );
  INVX2 U825 ( .A(n1330), .Y(n1019) );
  INVX2 U826 ( .A(n956), .Y(n965) );
  INVX2 U827 ( .A(n957), .Y(n964) );
  INVX2 U828 ( .A(n951), .Y(n959) );
  INVX1 U829 ( .A(b[7]), .Y(n1002) );
  INVX1 U830 ( .A(b[2]), .Y(n1015) );
  INVX1 U831 ( .A(b[3]), .Y(n1013) );
  INVX1 U832 ( .A(b[4]), .Y(n1010) );
  INVX1 U833 ( .A(b[5]), .Y(n1007) );
  INVX1 U834 ( .A(b[6]), .Y(n1004) );
  INVX1 U835 ( .A(b[9]), .Y(n997) );
  INVX1 U836 ( .A(b[10]), .Y(n995) );
  INVX1 U837 ( .A(b[11]), .Y(n992) );
  INVX1 U838 ( .A(b[12]), .Y(n989) );
  INVX1 U839 ( .A(b[8]), .Y(n999) );
  INVX2 U840 ( .A(b[1]), .Y(n967) );
  INVX2 U841 ( .A(b[0]), .Y(n966) );
  AND2X2 U842 ( .A(n1156), .B(n1154), .Y(n952) );
  AND2X2 U843 ( .A(n1216), .B(n1214), .Y(n953) );
  INVX1 U844 ( .A(b[13]), .Y(n987) );
  INVX1 U845 ( .A(b[15]), .Y(n982) );
  INVX1 U846 ( .A(b[14]), .Y(n984) );
  AND2X2 U847 ( .A(n1276), .B(n1274), .Y(n954) );
  AND2X2 U848 ( .A(n1336), .B(n1334), .Y(n955) );
  XNOR2X1 U849 ( .A(a[15]), .B(n978), .Y(n956) );
  AND2X2 U850 ( .A(n965), .B(a[15]), .Y(n957) );
  INVX2 U851 ( .A(n950), .Y(n958) );
  INVX2 U852 ( .A(n524), .Y(n980) );
  INVX2 U853 ( .A(n525), .Y(n981) );
  INVX2 U854 ( .A(n526), .Y(n983) );
  INVX2 U855 ( .A(n527), .Y(n985) );
  INVX2 U856 ( .A(n288), .Y(n986) );
  INVX2 U857 ( .A(n528), .Y(n988) );
  INVX2 U858 ( .A(n529), .Y(n990) );
  INVX2 U859 ( .A(n292), .Y(n991) );
  INVX2 U860 ( .A(n530), .Y(n993) );
  INVX2 U861 ( .A(n294), .Y(n994) );
  INVX2 U862 ( .A(n531), .Y(n996) );
  INVX2 U863 ( .A(n532), .Y(n998) );
  INVX2 U864 ( .A(n533), .Y(n1000) );
  INVX2 U865 ( .A(n300), .Y(n1001) );
  INVX2 U866 ( .A(n534), .Y(n1003) );
  INVX2 U867 ( .A(n535), .Y(n1005) );
  INVX2 U868 ( .A(n304), .Y(n1006) );
  INVX2 U869 ( .A(n536), .Y(n1008) );
  INVX2 U870 ( .A(n306), .Y(n1009) );
  INVX2 U871 ( .A(n537), .Y(n1011) );
  INVX2 U872 ( .A(n308), .Y(n1012) );
  INVX2 U873 ( .A(n538), .Y(n1014) );
  INVX2 U874 ( .A(n539), .Y(n1016) );
  INVX2 U875 ( .A(n540), .Y(n1017) );
  INVX2 U876 ( .A(n1336), .Y(n1021) );
  INVX2 U877 ( .A(n1276), .Y(n1025) );
  INVX2 U878 ( .A(n1216), .Y(n1029) );
  INVX2 U879 ( .A(n1156), .Y(n1033) );
  XOR2X1 U880 ( .A(n1038), .B(n1039), .Y(product[31]) );
  XNOR2X1 U881 ( .A(n90), .B(n121), .Y(n1039) );
  OAI22X1 U882 ( .A(n964), .B(n982), .C(n965), .D(n979), .Y(n1038) );
  XOR2X1 U883 ( .A(n1040), .B(n969), .Y(n635) );
  OAI22X1 U884 ( .A(n966), .B(n1034), .C(n959), .D(n966), .Y(n1040) );
  XOR2X1 U885 ( .A(n1041), .B(n5), .Y(n634) );
  OAI21X1 U886 ( .A(n959), .B(n1017), .C(n1042), .Y(n1041) );
  AOI22X1 U887 ( .A(n968), .B(n1043), .C(n950), .D(b[0]), .Y(n1042) );
  XOR2X1 U888 ( .A(n1044), .B(n5), .Y(n633) );
  OAI21X1 U889 ( .A(n959), .B(n1016), .C(n1045), .Y(n1044) );
  OAI22X1 U890 ( .A(b[0]), .B(n1046), .C(n1035), .D(n1046), .Y(n1045) );
  OAI22X1 U891 ( .A(n967), .B(n958), .C(n1034), .D(n1015), .Y(n1046) );
  XOR2X1 U892 ( .A(n1047), .B(n5), .Y(n632) );
  OAI21X1 U893 ( .A(n959), .B(n1014), .C(n1048), .Y(n1047) );
  OAI22X1 U894 ( .A(b[1]), .B(n1049), .C(n1035), .D(n1049), .Y(n1048) );
  OAI22X1 U895 ( .A(n958), .B(n1015), .C(n1034), .D(n1013), .Y(n1049) );
  XOR2X1 U896 ( .A(n1050), .B(n5), .Y(n631) );
  OAI21X1 U897 ( .A(n959), .B(n1011), .C(n1051), .Y(n1050) );
  OAI22X1 U898 ( .A(b[2]), .B(n1052), .C(n1035), .D(n1052), .Y(n1051) );
  OAI22X1 U899 ( .A(n958), .B(n1013), .C(n1034), .D(n1010), .Y(n1052) );
  XOR2X1 U900 ( .A(n1053), .B(n5), .Y(n630) );
  OAI21X1 U901 ( .A(n959), .B(n1008), .C(n1054), .Y(n1053) );
  OAI22X1 U902 ( .A(b[3]), .B(n1055), .C(n1035), .D(n1055), .Y(n1054) );
  OAI22X1 U903 ( .A(n958), .B(n1010), .C(n1034), .D(n1007), .Y(n1055) );
  XOR2X1 U904 ( .A(n1056), .B(n969), .Y(n629) );
  OAI21X1 U905 ( .A(n959), .B(n1005), .C(n1057), .Y(n1056) );
  OAI22X1 U906 ( .A(b[4]), .B(n1058), .C(n1035), .D(n1058), .Y(n1057) );
  OAI22X1 U907 ( .A(n958), .B(n1007), .C(n1034), .D(n1004), .Y(n1058) );
  XOR2X1 U908 ( .A(n1059), .B(n969), .Y(n628) );
  OAI21X1 U909 ( .A(n959), .B(n1003), .C(n1060), .Y(n1059) );
  OAI22X1 U910 ( .A(b[5]), .B(n1061), .C(n1035), .D(n1061), .Y(n1060) );
  OAI22X1 U911 ( .A(n958), .B(n1004), .C(n1034), .D(n1002), .Y(n1061) );
  XOR2X1 U912 ( .A(n1062), .B(n969), .Y(n627) );
  OAI21X1 U913 ( .A(n959), .B(n1000), .C(n1063), .Y(n1062) );
  OAI22X1 U914 ( .A(b[6]), .B(n1064), .C(n1035), .D(n1064), .Y(n1063) );
  OAI22X1 U915 ( .A(n1034), .B(n999), .C(n958), .D(n1002), .Y(n1064) );
  XOR2X1 U916 ( .A(n1065), .B(n969), .Y(n626) );
  OAI21X1 U917 ( .A(n959), .B(n998), .C(n1066), .Y(n1065) );
  OAI22X1 U918 ( .A(b[7]), .B(n1067), .C(n1035), .D(n1067), .Y(n1066) );
  OAI22X1 U919 ( .A(n958), .B(n999), .C(n1034), .D(n997), .Y(n1067) );
  XOR2X1 U920 ( .A(n1068), .B(n969), .Y(n625) );
  OAI21X1 U921 ( .A(n959), .B(n996), .C(n1069), .Y(n1068) );
  OAI22X1 U922 ( .A(b[8]), .B(n1070), .C(n1035), .D(n1070), .Y(n1069) );
  OAI22X1 U923 ( .A(n958), .B(n997), .C(n1034), .D(n995), .Y(n1070) );
  XOR2X1 U924 ( .A(n1071), .B(n969), .Y(n624) );
  OAI21X1 U925 ( .A(n959), .B(n993), .C(n1072), .Y(n1071) );
  OAI22X1 U926 ( .A(b[9]), .B(n1073), .C(n1035), .D(n1073), .Y(n1072) );
  OAI22X1 U927 ( .A(n958), .B(n995), .C(n1034), .D(n992), .Y(n1073) );
  XOR2X1 U928 ( .A(n1074), .B(n969), .Y(n623) );
  OAI21X1 U929 ( .A(n959), .B(n990), .C(n1075), .Y(n1074) );
  OAI22X1 U930 ( .A(b[10]), .B(n1076), .C(n1035), .D(n1076), .Y(n1075) );
  OAI22X1 U931 ( .A(n958), .B(n992), .C(n1034), .D(n989), .Y(n1076) );
  XOR2X1 U932 ( .A(n1077), .B(n969), .Y(n622) );
  OAI21X1 U933 ( .A(n959), .B(n988), .C(n1078), .Y(n1077) );
  OAI22X1 U934 ( .A(b[11]), .B(n1079), .C(n1035), .D(n1079), .Y(n1078) );
  OAI22X1 U935 ( .A(n958), .B(n989), .C(n1034), .D(n987), .Y(n1079) );
  XOR2X1 U936 ( .A(n1080), .B(n969), .Y(n621) );
  OAI21X1 U937 ( .A(n959), .B(n985), .C(n1081), .Y(n1080) );
  OAI22X1 U938 ( .A(b[12]), .B(n1082), .C(n1035), .D(n1082), .Y(n1081) );
  OAI22X1 U939 ( .A(n1034), .B(n984), .C(n958), .D(n987), .Y(n1082) );
  XOR2X1 U940 ( .A(n1083), .B(n969), .Y(n620) );
  OAI21X1 U941 ( .A(n959), .B(n983), .C(n1084), .Y(n1083) );
  OAI22X1 U942 ( .A(b[13]), .B(n1085), .C(n1035), .D(n1085), .Y(n1084) );
  OAI22X1 U943 ( .A(n958), .B(n984), .C(n982), .D(n1034), .Y(n1085) );
  XOR2X1 U944 ( .A(n1086), .B(n969), .Y(n619) );
  OAI21X1 U945 ( .A(n959), .B(n981), .C(n1087), .Y(n1086) );
  OAI22X1 U946 ( .A(b[14]), .B(n1088), .C(n1035), .D(n1088), .Y(n1087) );
  OAI22X1 U947 ( .A(n979), .B(n1034), .C(n982), .D(n958), .Y(n1088) );
  XOR2X1 U948 ( .A(n1089), .B(n969), .Y(n618) );
  OAI21X1 U949 ( .A(n959), .B(n980), .C(n1090), .Y(n1089) );
  OAI22X1 U950 ( .A(b[15]), .B(n1091), .C(n1035), .D(n1091), .Y(n1090) );
  OAI22X1 U951 ( .A(n979), .B(n958), .C(n979), .D(n1034), .Y(n1091) );
  XOR2X1 U952 ( .A(n970), .B(n1093), .Y(n617) );
  OAI21X1 U953 ( .A(n979), .B(n959), .C(n1094), .Y(n1093) );
  OAI21X1 U954 ( .A(n950), .B(n1095), .C(b[17]), .Y(n1094) );
  NAND2X1 U955 ( .A(n1034), .B(n1092), .Y(n1095) );
  NAND3X1 U956 ( .A(n1037), .B(n1036), .C(n1096), .Y(n1092) );
  NOR2X1 U957 ( .A(n1096), .B(n1037), .Y(n1043) );
  XOR2X1 U958 ( .A(n1036), .B(n970), .Y(n1096) );
  XOR2X1 U959 ( .A(n1097), .B(n15), .Y(n616) );
  OAI22X1 U960 ( .A(n966), .B(n1030), .C(n966), .D(n960), .Y(n1097) );
  XOR2X1 U961 ( .A(n1098), .B(n15), .Y(n615) );
  OAI21X1 U962 ( .A(n1017), .B(n960), .C(n1099), .Y(n1098) );
  AOI22X1 U963 ( .A(n1100), .B(n968), .C(n1101), .D(b[0]), .Y(n1099) );
  XOR2X1 U964 ( .A(n1102), .B(n15), .Y(n614) );
  OAI21X1 U965 ( .A(n1016), .B(n960), .C(n1103), .Y(n1102) );
  OAI22X1 U966 ( .A(b[0]), .B(n1104), .C(n1031), .D(n1104), .Y(n1103) );
  OAI22X1 U967 ( .A(n967), .B(n1032), .C(n1015), .D(n1030), .Y(n1104) );
  XOR2X1 U968 ( .A(n1105), .B(n15), .Y(n613) );
  OAI21X1 U969 ( .A(n1014), .B(n960), .C(n1106), .Y(n1105) );
  OAI22X1 U970 ( .A(b[1]), .B(n1107), .C(n1031), .D(n1107), .Y(n1106) );
  OAI22X1 U971 ( .A(n1015), .B(n1032), .C(n1013), .D(n1030), .Y(n1107) );
  XOR2X1 U972 ( .A(n1108), .B(n15), .Y(n612) );
  OAI21X1 U973 ( .A(n1011), .B(n960), .C(n1109), .Y(n1108) );
  OAI22X1 U974 ( .A(b[2]), .B(n1110), .C(n1031), .D(n1110), .Y(n1109) );
  OAI22X1 U975 ( .A(n1013), .B(n1032), .C(n1010), .D(n1030), .Y(n1110) );
  XOR2X1 U976 ( .A(n1111), .B(n15), .Y(n611) );
  OAI21X1 U977 ( .A(n1008), .B(n960), .C(n1112), .Y(n1111) );
  OAI22X1 U978 ( .A(b[3]), .B(n1113), .C(n1031), .D(n1113), .Y(n1112) );
  OAI22X1 U979 ( .A(n1010), .B(n1032), .C(n1007), .D(n1030), .Y(n1113) );
  XOR2X1 U980 ( .A(n1114), .B(n15), .Y(n610) );
  OAI21X1 U981 ( .A(n1005), .B(n960), .C(n1115), .Y(n1114) );
  OAI22X1 U982 ( .A(b[4]), .B(n1116), .C(n1031), .D(n1116), .Y(n1115) );
  OAI22X1 U983 ( .A(n1007), .B(n1032), .C(n1004), .D(n1030), .Y(n1116) );
  XOR2X1 U984 ( .A(n1117), .B(n971), .Y(n609) );
  OAI21X1 U985 ( .A(n1003), .B(n960), .C(n1118), .Y(n1117) );
  OAI22X1 U986 ( .A(b[5]), .B(n1119), .C(n1031), .D(n1119), .Y(n1118) );
  OAI22X1 U987 ( .A(n1004), .B(n1032), .C(n1002), .D(n1030), .Y(n1119) );
  XOR2X1 U988 ( .A(n1120), .B(n971), .Y(n608) );
  OAI21X1 U989 ( .A(n1000), .B(n960), .C(n1121), .Y(n1120) );
  OAI22X1 U990 ( .A(b[6]), .B(n1122), .C(n1031), .D(n1122), .Y(n1121) );
  OAI22X1 U991 ( .A(n999), .B(n1030), .C(n1002), .D(n1032), .Y(n1122) );
  XOR2X1 U992 ( .A(n1123), .B(n971), .Y(n607) );
  OAI21X1 U993 ( .A(n998), .B(n960), .C(n1124), .Y(n1123) );
  OAI22X1 U994 ( .A(b[7]), .B(n1125), .C(n1031), .D(n1125), .Y(n1124) );
  OAI22X1 U995 ( .A(n999), .B(n1032), .C(n997), .D(n1030), .Y(n1125) );
  XOR2X1 U996 ( .A(n1126), .B(n971), .Y(n606) );
  OAI21X1 U997 ( .A(n996), .B(n960), .C(n1127), .Y(n1126) );
  OAI22X1 U998 ( .A(b[8]), .B(n1128), .C(n1031), .D(n1128), .Y(n1127) );
  OAI22X1 U999 ( .A(n997), .B(n1032), .C(n995), .D(n1030), .Y(n1128) );
  XOR2X1 U1000 ( .A(n1129), .B(n971), .Y(n605) );
  OAI21X1 U1001 ( .A(n993), .B(n960), .C(n1130), .Y(n1129) );
  OAI22X1 U1002 ( .A(b[9]), .B(n1131), .C(n1031), .D(n1131), .Y(n1130) );
  OAI22X1 U1003 ( .A(n995), .B(n1032), .C(n992), .D(n1030), .Y(n1131) );
  XOR2X1 U1004 ( .A(n1132), .B(n971), .Y(n604) );
  OAI21X1 U1005 ( .A(n990), .B(n960), .C(n1133), .Y(n1132) );
  OAI22X1 U1006 ( .A(b[10]), .B(n1134), .C(n1031), .D(n1134), .Y(n1133) );
  OAI22X1 U1007 ( .A(n992), .B(n1032), .C(n989), .D(n1030), .Y(n1134) );
  XOR2X1 U1008 ( .A(n1135), .B(n971), .Y(n603) );
  OAI21X1 U1009 ( .A(n988), .B(n960), .C(n1136), .Y(n1135) );
  OAI22X1 U1010 ( .A(b[11]), .B(n1137), .C(n1031), .D(n1137), .Y(n1136) );
  OAI22X1 U1011 ( .A(n989), .B(n1032), .C(n987), .D(n1030), .Y(n1137) );
  XOR2X1 U1012 ( .A(n1138), .B(n971), .Y(n602) );
  OAI21X1 U1013 ( .A(n985), .B(n960), .C(n1139), .Y(n1138) );
  OAI22X1 U1014 ( .A(b[12]), .B(n1140), .C(n1031), .D(n1140), .Y(n1139) );
  OAI22X1 U1015 ( .A(n984), .B(n1030), .C(n987), .D(n1032), .Y(n1140) );
  XOR2X1 U1016 ( .A(n1141), .B(n971), .Y(n601) );
  OAI21X1 U1017 ( .A(n983), .B(n960), .C(n1142), .Y(n1141) );
  OAI22X1 U1018 ( .A(b[13]), .B(n1143), .C(n1031), .D(n1143), .Y(n1142) );
  OAI22X1 U1019 ( .A(n984), .B(n1032), .C(n982), .D(n1030), .Y(n1143) );
  XOR2X1 U1020 ( .A(n1144), .B(n971), .Y(n600) );
  OAI21X1 U1021 ( .A(n981), .B(n960), .C(n1145), .Y(n1144) );
  OAI22X1 U1022 ( .A(b[14]), .B(n1146), .C(n1031), .D(n1146), .Y(n1145) );
  OAI22X1 U1023 ( .A(n979), .B(n1030), .C(n982), .D(n1032), .Y(n1146) );
  XOR2X1 U1024 ( .A(n1147), .B(n971), .Y(n599) );
  OAI21X1 U1025 ( .A(n980), .B(n960), .C(n1148), .Y(n1147) );
  OAI22X1 U1026 ( .A(b[15]), .B(n1149), .C(n1031), .D(n1149), .Y(n1148) );
  OAI22X1 U1027 ( .A(n979), .B(n1032), .C(n979), .D(n1030), .Y(n1149) );
  XOR2X1 U1028 ( .A(n972), .B(n1151), .Y(n598) );
  OAI21X1 U1029 ( .A(n979), .B(n960), .C(n1152), .Y(n1151) );
  OAI21X1 U1030 ( .A(n1101), .B(n1153), .C(b[17]), .Y(n1152) );
  NAND2X1 U1031 ( .A(n1030), .B(n1150), .Y(n1153) );
  NAND3X1 U1032 ( .A(n1033), .B(n1154), .C(n1155), .Y(n1150) );
  NOR2X1 U1033 ( .A(n1154), .B(n1033), .Y(n1100) );
  NOR2X1 U1034 ( .A(n1156), .B(n1155), .Y(n1101) );
  XNOR2X1 U1035 ( .A(a[3]), .B(a[4]), .Y(n1155) );
  XOR2X1 U1036 ( .A(a[4]), .B(n971), .Y(n1154) );
  XOR2X1 U1037 ( .A(a[3]), .B(n969), .Y(n1156) );
  XOR2X1 U1038 ( .A(n1157), .B(n25), .Y(n597) );
  OAI22X1 U1039 ( .A(n966), .B(n1026), .C(n966), .D(n961), .Y(n1157) );
  XOR2X1 U1040 ( .A(n1158), .B(n25), .Y(n596) );
  OAI21X1 U1041 ( .A(n1017), .B(n961), .C(n1159), .Y(n1158) );
  AOI22X1 U1042 ( .A(n1160), .B(n968), .C(n1161), .D(b[0]), .Y(n1159) );
  XOR2X1 U1043 ( .A(n1162), .B(n25), .Y(n595) );
  OAI21X1 U1044 ( .A(n1016), .B(n961), .C(n1163), .Y(n1162) );
  OAI22X1 U1045 ( .A(b[0]), .B(n1164), .C(n1027), .D(n1164), .Y(n1163) );
  OAI22X1 U1046 ( .A(n967), .B(n1028), .C(n1015), .D(n1026), .Y(n1164) );
  XOR2X1 U1047 ( .A(n1165), .B(n25), .Y(n594) );
  OAI21X1 U1048 ( .A(n1014), .B(n961), .C(n1166), .Y(n1165) );
  OAI22X1 U1049 ( .A(b[1]), .B(n1167), .C(n1027), .D(n1167), .Y(n1166) );
  OAI22X1 U1050 ( .A(n1015), .B(n1028), .C(n1013), .D(n1026), .Y(n1167) );
  XOR2X1 U1051 ( .A(n1168), .B(n25), .Y(n593) );
  OAI21X1 U1052 ( .A(n1011), .B(n961), .C(n1169), .Y(n1168) );
  OAI22X1 U1053 ( .A(b[2]), .B(n1170), .C(n1027), .D(n1170), .Y(n1169) );
  OAI22X1 U1054 ( .A(n1013), .B(n1028), .C(n1010), .D(n1026), .Y(n1170) );
  XOR2X1 U1055 ( .A(n1171), .B(n25), .Y(n592) );
  OAI21X1 U1056 ( .A(n1008), .B(n961), .C(n1172), .Y(n1171) );
  OAI22X1 U1057 ( .A(b[3]), .B(n1173), .C(n1027), .D(n1173), .Y(n1172) );
  OAI22X1 U1058 ( .A(n1010), .B(n1028), .C(n1007), .D(n1026), .Y(n1173) );
  XOR2X1 U1059 ( .A(n1174), .B(n25), .Y(n591) );
  OAI21X1 U1060 ( .A(n1005), .B(n961), .C(n1175), .Y(n1174) );
  OAI22X1 U1061 ( .A(b[4]), .B(n1176), .C(n1027), .D(n1176), .Y(n1175) );
  OAI22X1 U1062 ( .A(n1007), .B(n1028), .C(n1004), .D(n1026), .Y(n1176) );
  XOR2X1 U1063 ( .A(n1177), .B(n973), .Y(n590) );
  OAI21X1 U1064 ( .A(n1003), .B(n961), .C(n1178), .Y(n1177) );
  OAI22X1 U1065 ( .A(b[5]), .B(n1179), .C(n1027), .D(n1179), .Y(n1178) );
  OAI22X1 U1066 ( .A(n1004), .B(n1028), .C(n1002), .D(n1026), .Y(n1179) );
  XOR2X1 U1067 ( .A(n1180), .B(n973), .Y(n589) );
  OAI21X1 U1068 ( .A(n1000), .B(n961), .C(n1181), .Y(n1180) );
  OAI22X1 U1069 ( .A(b[6]), .B(n1182), .C(n1027), .D(n1182), .Y(n1181) );
  OAI22X1 U1070 ( .A(n999), .B(n1026), .C(n1002), .D(n1028), .Y(n1182) );
  XOR2X1 U1071 ( .A(n1183), .B(n973), .Y(n588) );
  OAI21X1 U1072 ( .A(n998), .B(n961), .C(n1184), .Y(n1183) );
  OAI22X1 U1073 ( .A(b[7]), .B(n1185), .C(n1027), .D(n1185), .Y(n1184) );
  OAI22X1 U1074 ( .A(n999), .B(n1028), .C(n997), .D(n1026), .Y(n1185) );
  XOR2X1 U1075 ( .A(n1186), .B(n973), .Y(n587) );
  OAI21X1 U1076 ( .A(n996), .B(n961), .C(n1187), .Y(n1186) );
  OAI22X1 U1077 ( .A(b[8]), .B(n1188), .C(n1027), .D(n1188), .Y(n1187) );
  OAI22X1 U1078 ( .A(n997), .B(n1028), .C(n995), .D(n1026), .Y(n1188) );
  XOR2X1 U1079 ( .A(n1189), .B(n973), .Y(n586) );
  OAI21X1 U1080 ( .A(n993), .B(n961), .C(n1190), .Y(n1189) );
  OAI22X1 U1081 ( .A(b[9]), .B(n1191), .C(n1027), .D(n1191), .Y(n1190) );
  OAI22X1 U1082 ( .A(n995), .B(n1028), .C(n992), .D(n1026), .Y(n1191) );
  XOR2X1 U1083 ( .A(n1192), .B(n973), .Y(n585) );
  OAI21X1 U1084 ( .A(n990), .B(n961), .C(n1193), .Y(n1192) );
  OAI22X1 U1085 ( .A(b[10]), .B(n1194), .C(n1027), .D(n1194), .Y(n1193) );
  OAI22X1 U1086 ( .A(n992), .B(n1028), .C(n989), .D(n1026), .Y(n1194) );
  XOR2X1 U1087 ( .A(n1195), .B(n973), .Y(n584) );
  OAI21X1 U1088 ( .A(n988), .B(n961), .C(n1196), .Y(n1195) );
  OAI22X1 U1089 ( .A(b[11]), .B(n1197), .C(n1027), .D(n1197), .Y(n1196) );
  OAI22X1 U1090 ( .A(n989), .B(n1028), .C(n987), .D(n1026), .Y(n1197) );
  XOR2X1 U1091 ( .A(n1198), .B(n973), .Y(n583) );
  OAI21X1 U1092 ( .A(n985), .B(n961), .C(n1199), .Y(n1198) );
  OAI22X1 U1093 ( .A(b[12]), .B(n1200), .C(n1027), .D(n1200), .Y(n1199) );
  OAI22X1 U1094 ( .A(n984), .B(n1026), .C(n987), .D(n1028), .Y(n1200) );
  XOR2X1 U1095 ( .A(n1201), .B(n973), .Y(n582) );
  OAI21X1 U1096 ( .A(n983), .B(n961), .C(n1202), .Y(n1201) );
  OAI22X1 U1097 ( .A(b[13]), .B(n1203), .C(n1027), .D(n1203), .Y(n1202) );
  OAI22X1 U1098 ( .A(n984), .B(n1028), .C(n982), .D(n1026), .Y(n1203) );
  XOR2X1 U1099 ( .A(n1204), .B(n973), .Y(n581) );
  OAI21X1 U1100 ( .A(n981), .B(n961), .C(n1205), .Y(n1204) );
  OAI22X1 U1101 ( .A(b[14]), .B(n1206), .C(n1027), .D(n1206), .Y(n1205) );
  OAI22X1 U1102 ( .A(n979), .B(n1026), .C(n982), .D(n1028), .Y(n1206) );
  XOR2X1 U1103 ( .A(n1207), .B(n973), .Y(n580) );
  OAI21X1 U1104 ( .A(n980), .B(n961), .C(n1208), .Y(n1207) );
  OAI22X1 U1105 ( .A(b[15]), .B(n1209), .C(n1027), .D(n1209), .Y(n1208) );
  OAI22X1 U1106 ( .A(n979), .B(n1028), .C(n979), .D(n1026), .Y(n1209) );
  XOR2X1 U1107 ( .A(n974), .B(n1211), .Y(n579) );
  OAI21X1 U1108 ( .A(n979), .B(n961), .C(n1212), .Y(n1211) );
  OAI21X1 U1109 ( .A(n1161), .B(n1213), .C(b[17]), .Y(n1212) );
  NAND2X1 U1110 ( .A(n1026), .B(n1210), .Y(n1213) );
  NAND3X1 U1111 ( .A(n1029), .B(n1214), .C(n1215), .Y(n1210) );
  NOR2X1 U1112 ( .A(n1214), .B(n1029), .Y(n1160) );
  NOR2X1 U1113 ( .A(n1216), .B(n1215), .Y(n1161) );
  XNOR2X1 U1114 ( .A(a[6]), .B(a[7]), .Y(n1215) );
  XOR2X1 U1115 ( .A(a[7]), .B(n973), .Y(n1214) );
  XOR2X1 U1116 ( .A(a[6]), .B(n971), .Y(n1216) );
  XOR2X1 U1117 ( .A(n1217), .B(n35), .Y(n578) );
  OAI22X1 U1118 ( .A(n966), .B(n1022), .C(n966), .D(n962), .Y(n1217) );
  XOR2X1 U1119 ( .A(n1218), .B(n35), .Y(n577) );
  OAI21X1 U1120 ( .A(n1017), .B(n962), .C(n1219), .Y(n1218) );
  AOI22X1 U1121 ( .A(n1220), .B(b[1]), .C(n1221), .D(b[0]), .Y(n1219) );
  XOR2X1 U1122 ( .A(n1222), .B(n35), .Y(n576) );
  OAI21X1 U1123 ( .A(n1016), .B(n962), .C(n1223), .Y(n1222) );
  OAI22X1 U1124 ( .A(b[0]), .B(n1224), .C(n1023), .D(n1224), .Y(n1223) );
  OAI22X1 U1125 ( .A(n967), .B(n1024), .C(n1015), .D(n1022), .Y(n1224) );
  XOR2X1 U1126 ( .A(n1225), .B(n35), .Y(n575) );
  OAI21X1 U1127 ( .A(n1014), .B(n962), .C(n1226), .Y(n1225) );
  OAI22X1 U1128 ( .A(b[1]), .B(n1227), .C(n1023), .D(n1227), .Y(n1226) );
  OAI22X1 U1129 ( .A(n1015), .B(n1024), .C(n1013), .D(n1022), .Y(n1227) );
  XOR2X1 U1130 ( .A(n1228), .B(n35), .Y(n574) );
  OAI21X1 U1131 ( .A(n1011), .B(n962), .C(n1229), .Y(n1228) );
  OAI22X1 U1132 ( .A(b[2]), .B(n1230), .C(n1023), .D(n1230), .Y(n1229) );
  OAI22X1 U1133 ( .A(n1013), .B(n1024), .C(n1010), .D(n1022), .Y(n1230) );
  XOR2X1 U1134 ( .A(n1231), .B(n35), .Y(n573) );
  OAI21X1 U1135 ( .A(n1008), .B(n962), .C(n1232), .Y(n1231) );
  OAI22X1 U1136 ( .A(b[3]), .B(n1233), .C(n1023), .D(n1233), .Y(n1232) );
  OAI22X1 U1137 ( .A(n1010), .B(n1024), .C(n1007), .D(n1022), .Y(n1233) );
  XOR2X1 U1138 ( .A(n1234), .B(n35), .Y(n572) );
  OAI21X1 U1139 ( .A(n1005), .B(n962), .C(n1235), .Y(n1234) );
  OAI22X1 U1140 ( .A(b[4]), .B(n1236), .C(n1023), .D(n1236), .Y(n1235) );
  OAI22X1 U1141 ( .A(n1007), .B(n1024), .C(n1004), .D(n1022), .Y(n1236) );
  XOR2X1 U1142 ( .A(n1237), .B(n975), .Y(n571) );
  OAI21X1 U1143 ( .A(n1003), .B(n962), .C(n1238), .Y(n1237) );
  OAI22X1 U1144 ( .A(b[5]), .B(n1239), .C(n1023), .D(n1239), .Y(n1238) );
  OAI22X1 U1145 ( .A(n1004), .B(n1024), .C(n1002), .D(n1022), .Y(n1239) );
  XOR2X1 U1146 ( .A(n1240), .B(n975), .Y(n570) );
  OAI21X1 U1147 ( .A(n1000), .B(n962), .C(n1241), .Y(n1240) );
  OAI22X1 U1148 ( .A(b[6]), .B(n1242), .C(n1023), .D(n1242), .Y(n1241) );
  OAI22X1 U1149 ( .A(n999), .B(n1022), .C(n1002), .D(n1024), .Y(n1242) );
  XOR2X1 U1150 ( .A(n1243), .B(n975), .Y(n569) );
  OAI21X1 U1151 ( .A(n998), .B(n962), .C(n1244), .Y(n1243) );
  OAI22X1 U1152 ( .A(b[7]), .B(n1245), .C(n1023), .D(n1245), .Y(n1244) );
  OAI22X1 U1153 ( .A(n999), .B(n1024), .C(n997), .D(n1022), .Y(n1245) );
  XOR2X1 U1154 ( .A(n1246), .B(n975), .Y(n568) );
  OAI21X1 U1155 ( .A(n996), .B(n962), .C(n1247), .Y(n1246) );
  OAI22X1 U1156 ( .A(b[8]), .B(n1248), .C(n1023), .D(n1248), .Y(n1247) );
  OAI22X1 U1157 ( .A(n997), .B(n1024), .C(n995), .D(n1022), .Y(n1248) );
  XOR2X1 U1158 ( .A(n1249), .B(n975), .Y(n567) );
  OAI21X1 U1159 ( .A(n993), .B(n962), .C(n1250), .Y(n1249) );
  OAI22X1 U1160 ( .A(b[9]), .B(n1251), .C(n1023), .D(n1251), .Y(n1250) );
  OAI22X1 U1161 ( .A(n995), .B(n1024), .C(n992), .D(n1022), .Y(n1251) );
  XOR2X1 U1162 ( .A(n1252), .B(n975), .Y(n566) );
  OAI21X1 U1163 ( .A(n990), .B(n962), .C(n1253), .Y(n1252) );
  OAI22X1 U1164 ( .A(b[10]), .B(n1254), .C(n1023), .D(n1254), .Y(n1253) );
  OAI22X1 U1165 ( .A(n992), .B(n1024), .C(n989), .D(n1022), .Y(n1254) );
  XOR2X1 U1166 ( .A(n1255), .B(n975), .Y(n565) );
  OAI21X1 U1167 ( .A(n988), .B(n962), .C(n1256), .Y(n1255) );
  OAI22X1 U1168 ( .A(b[11]), .B(n1257), .C(n1023), .D(n1257), .Y(n1256) );
  OAI22X1 U1169 ( .A(n989), .B(n1024), .C(n987), .D(n1022), .Y(n1257) );
  XOR2X1 U1170 ( .A(n1258), .B(n975), .Y(n564) );
  OAI21X1 U1171 ( .A(n985), .B(n962), .C(n1259), .Y(n1258) );
  OAI22X1 U1172 ( .A(b[12]), .B(n1260), .C(n1023), .D(n1260), .Y(n1259) );
  OAI22X1 U1173 ( .A(n984), .B(n1022), .C(n987), .D(n1024), .Y(n1260) );
  XOR2X1 U1174 ( .A(n1261), .B(n975), .Y(n563) );
  OAI21X1 U1175 ( .A(n983), .B(n962), .C(n1262), .Y(n1261) );
  OAI22X1 U1176 ( .A(b[13]), .B(n1263), .C(n1023), .D(n1263), .Y(n1262) );
  OAI22X1 U1177 ( .A(n984), .B(n1024), .C(n982), .D(n1022), .Y(n1263) );
  XOR2X1 U1178 ( .A(n1264), .B(n975), .Y(n562) );
  OAI21X1 U1179 ( .A(n981), .B(n962), .C(n1265), .Y(n1264) );
  OAI22X1 U1180 ( .A(b[14]), .B(n1266), .C(n1023), .D(n1266), .Y(n1265) );
  OAI22X1 U1181 ( .A(n979), .B(n1022), .C(n982), .D(n1024), .Y(n1266) );
  XOR2X1 U1182 ( .A(n1267), .B(n975), .Y(n561) );
  OAI21X1 U1183 ( .A(n980), .B(n962), .C(n1268), .Y(n1267) );
  OAI22X1 U1184 ( .A(b[15]), .B(n1269), .C(n1023), .D(n1269), .Y(n1268) );
  OAI22X1 U1185 ( .A(n979), .B(n1024), .C(n979), .D(n1022), .Y(n1269) );
  XOR2X1 U1186 ( .A(n976), .B(n1271), .Y(n560) );
  OAI21X1 U1187 ( .A(n979), .B(n962), .C(n1272), .Y(n1271) );
  OAI21X1 U1188 ( .A(n1221), .B(n1273), .C(b[17]), .Y(n1272) );
  NAND2X1 U1189 ( .A(n1022), .B(n1270), .Y(n1273) );
  NAND3X1 U1190 ( .A(n1025), .B(n1274), .C(n1275), .Y(n1270) );
  NOR2X1 U1191 ( .A(n1274), .B(n1025), .Y(n1220) );
  NOR2X1 U1192 ( .A(n1276), .B(n1275), .Y(n1221) );
  XNOR2X1 U1193 ( .A(a[10]), .B(a[9]), .Y(n1275) );
  XOR2X1 U1194 ( .A(a[10]), .B(n975), .Y(n1274) );
  XOR2X1 U1195 ( .A(a[9]), .B(n973), .Y(n1276) );
  XOR2X1 U1196 ( .A(n1277), .B(n45), .Y(n559) );
  OAI22X1 U1197 ( .A(n966), .B(n1018), .C(n966), .D(n963), .Y(n1277) );
  XOR2X1 U1198 ( .A(n1278), .B(n45), .Y(n558) );
  OAI21X1 U1199 ( .A(n1017), .B(n963), .C(n1279), .Y(n1278) );
  AOI22X1 U1200 ( .A(n1280), .B(b[1]), .C(n1281), .D(b[0]), .Y(n1279) );
  XOR2X1 U1201 ( .A(n1282), .B(n45), .Y(n557) );
  OAI21X1 U1202 ( .A(n1016), .B(n963), .C(n1283), .Y(n1282) );
  OAI22X1 U1203 ( .A(b[0]), .B(n1284), .C(n1019), .D(n1284), .Y(n1283) );
  OAI22X1 U1204 ( .A(n967), .B(n1020), .C(n1015), .D(n1018), .Y(n1284) );
  XOR2X1 U1205 ( .A(n1285), .B(n45), .Y(n556) );
  OAI21X1 U1206 ( .A(n1014), .B(n963), .C(n1286), .Y(n1285) );
  OAI22X1 U1207 ( .A(b[1]), .B(n1287), .C(n1019), .D(n1287), .Y(n1286) );
  OAI22X1 U1208 ( .A(n1015), .B(n1020), .C(n1013), .D(n1018), .Y(n1287) );
  XOR2X1 U1209 ( .A(n1288), .B(n45), .Y(n555) );
  OAI21X1 U1210 ( .A(n1011), .B(n963), .C(n1289), .Y(n1288) );
  OAI22X1 U1211 ( .A(b[2]), .B(n1290), .C(n1019), .D(n1290), .Y(n1289) );
  OAI22X1 U1212 ( .A(n1013), .B(n1020), .C(n1010), .D(n1018), .Y(n1290) );
  XOR2X1 U1213 ( .A(n1291), .B(n45), .Y(n554) );
  OAI21X1 U1214 ( .A(n1008), .B(n963), .C(n1292), .Y(n1291) );
  OAI22X1 U1215 ( .A(b[3]), .B(n1293), .C(n1019), .D(n1293), .Y(n1292) );
  OAI22X1 U1216 ( .A(n1010), .B(n1020), .C(n1007), .D(n1018), .Y(n1293) );
  XOR2X1 U1217 ( .A(n1294), .B(n977), .Y(n553) );
  OAI21X1 U1218 ( .A(n1005), .B(n963), .C(n1295), .Y(n1294) );
  OAI22X1 U1219 ( .A(b[4]), .B(n1296), .C(n1019), .D(n1296), .Y(n1295) );
  OAI22X1 U1220 ( .A(n1007), .B(n1020), .C(n1004), .D(n1018), .Y(n1296) );
  XOR2X1 U1221 ( .A(n1297), .B(n977), .Y(n552) );
  OAI21X1 U1222 ( .A(n1003), .B(n963), .C(n1298), .Y(n1297) );
  OAI22X1 U1223 ( .A(b[5]), .B(n1299), .C(n1019), .D(n1299), .Y(n1298) );
  OAI22X1 U1224 ( .A(n1004), .B(n1020), .C(n1002), .D(n1018), .Y(n1299) );
  XOR2X1 U1225 ( .A(n1300), .B(n977), .Y(n551) );
  OAI21X1 U1226 ( .A(n1000), .B(n963), .C(n1301), .Y(n1300) );
  OAI22X1 U1227 ( .A(b[6]), .B(n1302), .C(n1019), .D(n1302), .Y(n1301) );
  OAI22X1 U1228 ( .A(n999), .B(n1018), .C(n1002), .D(n1020), .Y(n1302) );
  XOR2X1 U1229 ( .A(n1303), .B(n977), .Y(n550) );
  OAI21X1 U1230 ( .A(n998), .B(n963), .C(n1304), .Y(n1303) );
  OAI22X1 U1231 ( .A(b[7]), .B(n1305), .C(n1019), .D(n1305), .Y(n1304) );
  OAI22X1 U1232 ( .A(n999), .B(n1020), .C(n997), .D(n1018), .Y(n1305) );
  XOR2X1 U1233 ( .A(n1306), .B(n977), .Y(n549) );
  OAI21X1 U1234 ( .A(n996), .B(n963), .C(n1307), .Y(n1306) );
  OAI22X1 U1235 ( .A(b[8]), .B(n1308), .C(n1019), .D(n1308), .Y(n1307) );
  OAI22X1 U1236 ( .A(n997), .B(n1020), .C(n995), .D(n1018), .Y(n1308) );
  XOR2X1 U1237 ( .A(n1309), .B(n977), .Y(n548) );
  OAI21X1 U1238 ( .A(n993), .B(n963), .C(n1310), .Y(n1309) );
  OAI22X1 U1239 ( .A(b[9]), .B(n1311), .C(n1019), .D(n1311), .Y(n1310) );
  OAI22X1 U1240 ( .A(n995), .B(n1020), .C(n992), .D(n1018), .Y(n1311) );
  XOR2X1 U1241 ( .A(n1312), .B(n977), .Y(n547) );
  OAI21X1 U1242 ( .A(n990), .B(n963), .C(n1313), .Y(n1312) );
  OAI22X1 U1243 ( .A(b[10]), .B(n1314), .C(n1019), .D(n1314), .Y(n1313) );
  OAI22X1 U1244 ( .A(n992), .B(n1020), .C(n989), .D(n1018), .Y(n1314) );
  XOR2X1 U1245 ( .A(n1315), .B(n977), .Y(n546) );
  OAI21X1 U1246 ( .A(n988), .B(n963), .C(n1316), .Y(n1315) );
  OAI22X1 U1247 ( .A(b[11]), .B(n1317), .C(n1019), .D(n1317), .Y(n1316) );
  OAI22X1 U1248 ( .A(n989), .B(n1020), .C(n987), .D(n1018), .Y(n1317) );
  XOR2X1 U1249 ( .A(n1318), .B(n977), .Y(n545) );
  OAI21X1 U1250 ( .A(n985), .B(n963), .C(n1319), .Y(n1318) );
  OAI22X1 U1251 ( .A(b[12]), .B(n1320), .C(n1019), .D(n1320), .Y(n1319) );
  OAI22X1 U1252 ( .A(n984), .B(n1018), .C(n987), .D(n1020), .Y(n1320) );
  XOR2X1 U1253 ( .A(n1321), .B(n977), .Y(n544) );
  OAI21X1 U1254 ( .A(n983), .B(n963), .C(n1322), .Y(n1321) );
  OAI22X1 U1255 ( .A(b[13]), .B(n1323), .C(n1019), .D(n1323), .Y(n1322) );
  OAI22X1 U1256 ( .A(n984), .B(n1020), .C(n982), .D(n1018), .Y(n1323) );
  XOR2X1 U1257 ( .A(n1324), .B(n977), .Y(n543) );
  OAI21X1 U1258 ( .A(n981), .B(n963), .C(n1325), .Y(n1324) );
  OAI22X1 U1259 ( .A(b[14]), .B(n1326), .C(n1019), .D(n1326), .Y(n1325) );
  OAI22X1 U1260 ( .A(n979), .B(n1018), .C(n982), .D(n1020), .Y(n1326) );
  XOR2X1 U1261 ( .A(n1327), .B(n977), .Y(n542) );
  OAI21X1 U1262 ( .A(n980), .B(n963), .C(n1328), .Y(n1327) );
  OAI22X1 U1263 ( .A(b[15]), .B(n1329), .C(n1019), .D(n1329), .Y(n1328) );
  OAI22X1 U1264 ( .A(n979), .B(n1020), .C(n979), .D(n1018), .Y(n1329) );
  XOR2X1 U1265 ( .A(n978), .B(n1331), .Y(n541) );
  OAI21X1 U1266 ( .A(n979), .B(n963), .C(n1332), .Y(n1331) );
  OAI21X1 U1267 ( .A(n1281), .B(n1333), .C(b[17]), .Y(n1332) );
  NAND2X1 U1268 ( .A(n1018), .B(n1330), .Y(n1333) );
  NAND3X1 U1269 ( .A(n1021), .B(n1334), .C(n1335), .Y(n1330) );
  NOR2X1 U1270 ( .A(n1334), .B(n1021), .Y(n1280) );
  NOR2X1 U1271 ( .A(n1336), .B(n1335), .Y(n1281) );
  XNOR2X1 U1272 ( .A(a[12]), .B(a[13]), .Y(n1335) );
  XOR2X1 U1273 ( .A(a[13]), .B(n977), .Y(n1334) );
  XOR2X1 U1274 ( .A(a[12]), .B(n975), .Y(n1336) );
  NOR2X1 U1275 ( .A(n965), .B(n966), .Y(n313) );
  OAI22X1 U1276 ( .A(n964), .B(n966), .C(n965), .D(n967), .Y(n312) );
  OAI22X1 U1277 ( .A(n964), .B(n967), .C(n965), .D(n1015), .Y(n310) );
  OAI22X1 U1278 ( .A(n964), .B(n1007), .C(n965), .D(n1004), .Y(n302) );
  OAI22X1 U1279 ( .A(n964), .B(n1002), .C(n965), .D(n999), .Y(n298) );
  OAI22X1 U1280 ( .A(n964), .B(n999), .C(n965), .D(n997), .Y(n296) );
  OAI22X1 U1281 ( .A(n964), .B(n992), .C(n965), .D(n989), .Y(n290) );
  OAI22X1 U1282 ( .A(n964), .B(n987), .C(n965), .D(n984), .Y(n286) );
  OAI22X1 U1283 ( .A(n964), .B(n984), .C(n965), .D(n982), .Y(n284) );
  OAI22X1 U1284 ( .A(n964), .B(n1015), .C(n965), .D(n1013), .Y(n308) );
  OAI22X1 U1285 ( .A(n964), .B(n1013), .C(n965), .D(n1010), .Y(n306) );
  OAI22X1 U1286 ( .A(n964), .B(n1010), .C(n965), .D(n1007), .Y(n304) );
  OAI22X1 U1287 ( .A(n964), .B(n1004), .C(n965), .D(n1002), .Y(n300) );
  OAI22X1 U1288 ( .A(n964), .B(n997), .C(n965), .D(n995), .Y(n294) );
  OAI22X1 U1289 ( .A(n964), .B(n995), .C(n965), .D(n992), .Y(n292) );
  OAI22X1 U1290 ( .A(n964), .B(n989), .C(n965), .D(n987), .Y(n288) );
endmodule


module address_update_r_DW01_add_2 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FAX1 U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .YS(SUM[31]) );
  FAX1 U1_30 ( .A(A[30]), .B(B[30]), .C(carry[30]), .YC(carry[31]), .YS(
        SUM[30]) );
  FAX1 U1_29 ( .A(A[29]), .B(B[29]), .C(carry[29]), .YC(carry[30]), .YS(
        SUM[29]) );
  FAX1 U1_28 ( .A(A[28]), .B(B[28]), .C(carry[28]), .YC(carry[29]), .YS(
        SUM[28]) );
  FAX1 U1_27 ( .A(A[27]), .B(B[27]), .C(carry[27]), .YC(carry[28]), .YS(
        SUM[27]) );
  FAX1 U1_26 ( .A(A[26]), .B(B[26]), .C(carry[26]), .YC(carry[27]), .YS(
        SUM[26]) );
  FAX1 U1_25 ( .A(A[25]), .B(B[25]), .C(carry[25]), .YC(carry[26]), .YS(
        SUM[25]) );
  FAX1 U1_24 ( .A(A[24]), .B(B[24]), .C(carry[24]), .YC(carry[25]), .YS(
        SUM[24]) );
  FAX1 U1_23 ( .A(A[23]), .B(B[23]), .C(carry[23]), .YC(carry[24]), .YS(
        SUM[23]) );
  FAX1 U1_22 ( .A(A[22]), .B(B[22]), .C(carry[22]), .YC(carry[23]), .YS(
        SUM[22]) );
  FAX1 U1_21 ( .A(A[21]), .B(B[21]), .C(carry[21]), .YC(carry[22]), .YS(
        SUM[21]) );
  FAX1 U1_20 ( .A(A[20]), .B(B[20]), .C(carry[20]), .YC(carry[21]), .YS(
        SUM[20]) );
  FAX1 U1_19 ( .A(A[19]), .B(B[19]), .C(carry[19]), .YC(carry[20]), .YS(
        SUM[19]) );
  FAX1 U1_18 ( .A(A[18]), .B(B[18]), .C(carry[18]), .YC(carry[19]), .YS(
        SUM[18]) );
  FAX1 U1_17 ( .A(A[17]), .B(B[17]), .C(carry[17]), .YC(carry[18]), .YS(
        SUM[17]) );
  FAX1 U1_16 ( .A(A[16]), .B(B[16]), .C(carry[16]), .YC(carry[17]), .YS(
        SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module address_update_r ( HCLK, HRESETn, length, width, addr, 
        addr_update_enable_r, curr_addr, plus4_r, end_of_image );
  input [15:0] length;
  input [15:0] width;
  input [31:0] addr;
  output [31:0] curr_addr;
  input HCLK, HRESETn, addr_update_enable_r;
  output plus4_r, end_of_image;
  wire   \_0_net_[31] , \_0_net_[15] , \_0_net_[14] , \_0_net_[13] ,
         \_0_net_[12] , \_0_net_[11] , \_0_net_[10] , \_0_net_[9] ,
         \_0_net_[8] , \_0_net_[7] , \_0_net_[6] , \_0_net_[5] , \_0_net_[4] ,
         \_0_net_[3] , \_0_net_[1] , \_0_net_[0] , N7, N8, N9, N10, N11, N12,
         N13, N14, N15, N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26,
         N27, N28, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N105,
         N106, N107, N108, N109, N110, N111, N112, N113, N114, N115, N116,
         N117, N118, N119, N120, N121, N122, N123, N124, N125, N126, N127,
         N128, N129, N130, N131, N132, N133, N134, N135, N136, N137, N175,
         N176, N177, N178, N179, N180, N181, N182, N183, N184, N185, N186,
         N187, N188, N189, N190, N191, N192, N193, N194, N195, N196, N197,
         N198, N199, N200, N201, N202, N203, N204, N205, N206, N207, N208,
         N209, N210, N211, N212, N213, N214, N215, N216, N217, N218, N219,
         N220, N221, N222, N223, N224, N225, N226, N227, N228, N229, N230,
         N231, N232, N233, N234, N235, N334, N335, N336, N337, N338, N339,
         N340, N341, N342, N343, N344, N345, N346, N347, N348, N349, N400,
         N401, N402, N403, N404, N405, N406, N407, N408, N409, N410, N411,
         N412, N413, N414, N415, N416, N417, N418, N419, N420, N421, N422,
         N423, N424, N425, N426, N427, N428, N429, N430, N431, N435, n26, n28,
         n30, n32, n34, n36, n38, n40, n42, n44, n46, n48, n50, n52, n54, n56,
         n58, n60, n62, n64, n66, n68, n70, n72, n74, n76, n78, n80, n82, n84,
         n86, n88, n90, n92, n93, n95, n99, n101, n103, n105, n107, n109, n111,
         n113, n115, n117, n119, n121, n123, n125, n127, n129, n131, n133,
         n135, n137, n139, n141, n143, n145, n147, n149, n151, n153, n155,
         n157, n159, n161, n162, n163, n164, n165, n166, n167, n168, n169,
         n170, n171, n172, n173, n174, n175, n176, n177, n178, n179, n180,
         n181, n182, n183, n184, n185, n186, n187, n188, n189, n190, n191,
         n192, n193, n194, n195, n196, n197, n198, n199, n200, n201, n202,
         n203, n204, n205, n206, n207, n208, n209, n210, n211, n212, n213,
         n214, n216, n218, n220, n222, n224, n226, n228, n230, n232, n234,
         n236, n238, n240, n242, n244, n246, n248, n250, n252, n254, n256,
         n258, n260, n262, n264, n266, n268, n270, n272, n274, n276, n278,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, N87, N86,
         N85, N84, N83, N82, N81, N80, N79, N78, N77, N76, N75, N74, N73, N72,
         N71, N70, N69, N68, N67, N66, N65, N64, N63, N62, N61, N60, N59, N58,
         N57, N56, N54, N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43,
         N42, N41, N40, N382, N381, N380, N379, N378, N377, N376, N375, N374,
         N373, N372, N371, N370, N369, N368, N367, N366, N365, N364, N363,
         N362, N361, N360, N359, N358, N357, N356, N355, N354, N353, N352,
         N351, \r325/carry[16] , \r325/carry[15] , \r325/carry[14] ,
         \r325/carry[13] , \r325/carry[12] , \r325/carry[11] ,
         \r325/carry[10] , \r325/carry[9] , \r325/carry[8] , \r325/carry[7] ,
         \r325/carry[6] , \r325/carry[5] , \r325/carry[4] , \sub_83/carry[2] ,
         \sub_83/carry[3] , \sub_83/carry[4] , \sub_83/carry[5] ,
         \sub_83/carry[6] , \sub_83/carry[7] , \sub_83/carry[8] ,
         \sub_83/carry[9] , \sub_83/carry[10] , \sub_83/carry[11] ,
         \sub_83/carry[12] , \sub_83/carry[13] , \sub_83/carry[14] ,
         \sub_83/carry[15] , \sub_69/carry[2] , \sub_69/carry[3] ,
         \sub_69/carry[4] , \sub_69/carry[5] , \sub_69/carry[6] ,
         \sub_69/carry[7] , \sub_69/carry[8] , \sub_69/carry[9] ,
         \sub_69/carry[10] , \sub_69/carry[11] , \sub_69/carry[12] ,
         \sub_69/carry[13] , \sub_69/carry[14] , \sub_69/carry[15] , n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n27, n29, n31, n33, n35, n37, n39, n41, n43, n45, n47,
         n49, n51, n53, n55, n57, n59, n61, n63, n65, n67, n69, n71, n73, n75,
         n77, n79, n81, n83, n85, n87, n89, n91, n94, n96, n97, n98, n100,
         n102, n104, n106, n108, n110, n112, n114, n116, n118, n120, n122,
         n124, n126, n128, n130, n132, n134, n136, n138, n140, n142, n144,
         n146, n148, n150, n152, n154, n156, n158, n160, n343, n344, n345,
         n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356,
         n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372;
  wire   [31:0] offset_r;
  wire   [31:0] row_count;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29, 
        SYNOPSYS_UNCONNECTED__30, SYNOPSYS_UNCONNECTED__31, 
        SYNOPSYS_UNCONNECTED__32, SYNOPSYS_UNCONNECTED__33, 
        SYNOPSYS_UNCONNECTED__34;
  assign \_0_net_[1]  = length[1];
  assign \_0_net_[0]  = length[0];
  assign N435 = addr_update_enable_r;

  DFFSR \row_count_reg[0]  ( .D(n342), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[0]) );
  DFFSR \row_count_reg[31]  ( .D(n311), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[31]) );
  DFFSR \row_count_reg[1]  ( .D(n340), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[1]) );
  DFFSR \row_count_reg[2]  ( .D(n339), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[2]) );
  DFFSR \row_count_reg[3]  ( .D(n338), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[3]) );
  DFFSR \row_count_reg[4]  ( .D(n337), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[4]) );
  DFFSR \row_count_reg[5]  ( .D(n336), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[5]) );
  DFFSR \row_count_reg[6]  ( .D(n335), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[6]) );
  DFFSR \row_count_reg[7]  ( .D(n334), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[7]) );
  DFFSR \row_count_reg[8]  ( .D(n333), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[8]) );
  DFFSR \row_count_reg[9]  ( .D(n332), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[9]) );
  DFFSR \row_count_reg[10]  ( .D(n331), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[10]) );
  DFFSR \row_count_reg[11]  ( .D(n330), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[11]) );
  DFFSR \row_count_reg[12]  ( .D(n329), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[12]) );
  DFFSR \row_count_reg[13]  ( .D(n328), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[13]) );
  DFFSR \row_count_reg[14]  ( .D(n327), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[14]) );
  DFFSR \row_count_reg[15]  ( .D(n326), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[15]) );
  DFFSR \row_count_reg[16]  ( .D(n325), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[16]) );
  DFFSR \row_count_reg[17]  ( .D(n324), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[17]) );
  DFFSR \row_count_reg[18]  ( .D(n323), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[18]) );
  DFFSR \row_count_reg[19]  ( .D(n322), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[19]) );
  DFFSR \row_count_reg[20]  ( .D(n321), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[20]) );
  DFFSR \row_count_reg[21]  ( .D(n320), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[21]) );
  DFFSR \row_count_reg[22]  ( .D(n319), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[22]) );
  DFFSR \row_count_reg[23]  ( .D(n318), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[23]) );
  DFFSR \row_count_reg[24]  ( .D(n317), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[24]) );
  DFFSR \row_count_reg[25]  ( .D(n316), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[25]) );
  DFFSR \row_count_reg[26]  ( .D(n315), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[26]) );
  DFFSR \row_count_reg[27]  ( .D(n314), .CLK(HCLK), .R(n89), .S(1'b1), .Q(
        row_count[27]) );
  DFFSR \row_count_reg[28]  ( .D(n313), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        row_count[28]) );
  DFFSR \row_count_reg[29]  ( .D(n312), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        row_count[29]) );
  DFFSR \row_count_reg[30]  ( .D(n341), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        row_count[30]) );
  DFFSR \offset_r_reg[0]  ( .D(n278), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[0]) );
  DFFSR \offset_r_reg[31]  ( .D(n276), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[31]) );
  DFFSR \offset_r_reg[1]  ( .D(n274), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[1]) );
  DFFSR \offset_r_reg[2]  ( .D(n272), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[2]) );
  DFFSR \offset_r_reg[3]  ( .D(n270), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[3]) );
  DFFSR \offset_r_reg[4]  ( .D(n268), .CLK(HCLK), .R(n21), .S(1'b1), .Q(
        offset_r[4]) );
  DFFSR \offset_r_reg[5]  ( .D(n266), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[5]) );
  DFFSR \offset_r_reg[6]  ( .D(n264), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[6]) );
  DFFSR \offset_r_reg[7]  ( .D(n262), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[7]) );
  DFFSR \offset_r_reg[8]  ( .D(n260), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[8]) );
  DFFSR \offset_r_reg[9]  ( .D(n258), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[9]) );
  DFFSR \offset_r_reg[10]  ( .D(n256), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[10]) );
  DFFSR \offset_r_reg[11]  ( .D(n254), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[11]) );
  DFFSR \offset_r_reg[12]  ( .D(n252), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[12]) );
  DFFSR \offset_r_reg[13]  ( .D(n250), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[13]) );
  DFFSR \offset_r_reg[14]  ( .D(n248), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[14]) );
  DFFSR \offset_r_reg[15]  ( .D(n246), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[15]) );
  DFFSR \offset_r_reg[16]  ( .D(n244), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[16]) );
  DFFSR \offset_r_reg[17]  ( .D(n242), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[17]) );
  DFFSR \offset_r_reg[18]  ( .D(n240), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[18]) );
  DFFSR \offset_r_reg[19]  ( .D(n238), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[19]) );
  DFFSR \offset_r_reg[20]  ( .D(n236), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[20]) );
  DFFSR \offset_r_reg[21]  ( .D(n234), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[21]) );
  DFFSR \offset_r_reg[22]  ( .D(n232), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[22]) );
  DFFSR \offset_r_reg[23]  ( .D(n230), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[23]) );
  DFFSR \offset_r_reg[24]  ( .D(n228), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[24]) );
  DFFSR \offset_r_reg[25]  ( .D(n226), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[25]) );
  DFFSR \offset_r_reg[26]  ( .D(n224), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[26]) );
  DFFSR \offset_r_reg[27]  ( .D(n222), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[27]) );
  DFFSR \offset_r_reg[28]  ( .D(n220), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[28]) );
  DFFSR \offset_r_reg[29]  ( .D(n218), .CLK(HCLK), .R(n23), .S(1'b1), .Q(
        offset_r[29]) );
  DFFSR \offset_r_reg[30]  ( .D(n216), .CLK(HCLK), .R(n22), .S(1'b1), .Q(
        offset_r[30]) );
  OAI21X1 U3 ( .A(n59), .B(n98), .C(n28), .Y(n216) );
  AOI22X1 U4 ( .A(N37), .B(n33), .C(offset_r[30]), .D(n27), .Y(n28) );
  OAI21X1 U13 ( .A(n59), .B(n100), .C(n32), .Y(n218) );
  AOI22X1 U14 ( .A(N36), .B(n33), .C(offset_r[29]), .D(n30), .Y(n32) );
  OAI21X1 U17 ( .A(n59), .B(n102), .C(n34), .Y(n220) );
  AOI22X1 U18 ( .A(N35), .B(n33), .C(offset_r[28]), .D(n30), .Y(n34) );
  OAI21X1 U20 ( .A(n57), .B(n104), .C(n36), .Y(n222) );
  AOI22X1 U21 ( .A(N34), .B(n33), .C(offset_r[27]), .D(n30), .Y(n36) );
  OAI21X1 U23 ( .A(n57), .B(n106), .C(n38), .Y(n224) );
  AOI22X1 U24 ( .A(N33), .B(n33), .C(offset_r[26]), .D(n30), .Y(n38) );
  OAI21X1 U26 ( .A(n57), .B(n108), .C(n40), .Y(n226) );
  AOI22X1 U27 ( .A(N32), .B(n33), .C(offset_r[25]), .D(n30), .Y(n40) );
  OAI21X1 U29 ( .A(n57), .B(n110), .C(n42), .Y(n228) );
  AOI22X1 U30 ( .A(N31), .B(n33), .C(offset_r[24]), .D(n27), .Y(n42) );
  OAI21X1 U32 ( .A(n57), .B(n112), .C(n44), .Y(n230) );
  AOI22X1 U33 ( .A(N30), .B(n33), .C(offset_r[23]), .D(n27), .Y(n44) );
  OAI21X1 U35 ( .A(n57), .B(n114), .C(n46), .Y(n232) );
  AOI22X1 U36 ( .A(N29), .B(n33), .C(offset_r[22]), .D(n30), .Y(n46) );
  OAI21X1 U38 ( .A(n57), .B(n116), .C(n48), .Y(n234) );
  AOI22X1 U39 ( .A(N28), .B(n31), .C(offset_r[21]), .D(n27), .Y(n48) );
  OAI21X1 U41 ( .A(n55), .B(n118), .C(n50), .Y(n236) );
  AOI22X1 U42 ( .A(N27), .B(n33), .C(offset_r[20]), .D(n30), .Y(n50) );
  OAI21X1 U44 ( .A(n55), .B(n120), .C(n52), .Y(n238) );
  AOI22X1 U45 ( .A(N26), .B(n31), .C(offset_r[19]), .D(n30), .Y(n52) );
  OAI21X1 U47 ( .A(n55), .B(n122), .C(n54), .Y(n240) );
  AOI22X1 U48 ( .A(N25), .B(n33), .C(offset_r[18]), .D(n30), .Y(n54) );
  OAI21X1 U50 ( .A(n55), .B(n124), .C(n56), .Y(n242) );
  AOI22X1 U51 ( .A(N24), .B(n33), .C(offset_r[17]), .D(n27), .Y(n56) );
  OAI21X1 U53 ( .A(n55), .B(n126), .C(n58), .Y(n244) );
  AOI22X1 U54 ( .A(N23), .B(n33), .C(offset_r[16]), .D(n30), .Y(n58) );
  OAI21X1 U56 ( .A(n55), .B(n128), .C(n60), .Y(n246) );
  AOI22X1 U57 ( .A(N22), .B(n31), .C(offset_r[15]), .D(n27), .Y(n60) );
  OAI21X1 U59 ( .A(n55), .B(n130), .C(n62), .Y(n248) );
  AOI22X1 U60 ( .A(N21), .B(n33), .C(offset_r[14]), .D(n30), .Y(n62) );
  OAI21X1 U62 ( .A(n53), .B(n132), .C(n64), .Y(n250) );
  AOI22X1 U63 ( .A(N20), .B(n33), .C(offset_r[13]), .D(n27), .Y(n64) );
  OAI21X1 U65 ( .A(n53), .B(n134), .C(n66), .Y(n252) );
  AOI22X1 U66 ( .A(N19), .B(n33), .C(offset_r[12]), .D(n30), .Y(n66) );
  OAI21X1 U68 ( .A(n53), .B(n136), .C(n68), .Y(n254) );
  AOI22X1 U69 ( .A(N18), .B(n31), .C(offset_r[11]), .D(n27), .Y(n68) );
  OAI21X1 U71 ( .A(n51), .B(n138), .C(n70), .Y(n256) );
  AOI22X1 U72 ( .A(N17), .B(n31), .C(offset_r[10]), .D(n27), .Y(n70) );
  OAI21X1 U74 ( .A(n51), .B(n140), .C(n72), .Y(n258) );
  AOI22X1 U75 ( .A(N16), .B(n31), .C(offset_r[9]), .D(n27), .Y(n72) );
  OAI21X1 U77 ( .A(n51), .B(n142), .C(n74), .Y(n260) );
  AOI22X1 U78 ( .A(N15), .B(n31), .C(offset_r[8]), .D(n27), .Y(n74) );
  OAI21X1 U80 ( .A(n49), .B(n144), .C(n76), .Y(n262) );
  AOI22X1 U81 ( .A(N14), .B(n31), .C(offset_r[7]), .D(n27), .Y(n76) );
  OAI21X1 U83 ( .A(n49), .B(n146), .C(n78), .Y(n264) );
  AOI22X1 U84 ( .A(N13), .B(n31), .C(offset_r[6]), .D(n27), .Y(n78) );
  OAI21X1 U86 ( .A(n49), .B(n148), .C(n80), .Y(n266) );
  AOI22X1 U87 ( .A(N12), .B(n31), .C(offset_r[5]), .D(n27), .Y(n80) );
  OAI21X1 U89 ( .A(n47), .B(n150), .C(n82), .Y(n268) );
  AOI22X1 U90 ( .A(N11), .B(n31), .C(offset_r[4]), .D(n27), .Y(n82) );
  OAI21X1 U92 ( .A(n47), .B(n152), .C(n84), .Y(n270) );
  AOI22X1 U93 ( .A(N10), .B(n31), .C(offset_r[3]), .D(n27), .Y(n84) );
  OAI21X1 U95 ( .A(n47), .B(n8), .C(n86), .Y(n272) );
  AOI22X1 U96 ( .A(N9), .B(n31), .C(n8), .D(n27), .Y(n86) );
  OAI21X1 U98 ( .A(n45), .B(n154), .C(n88), .Y(n274) );
  AOI22X1 U99 ( .A(N8), .B(n31), .C(offset_r[1]), .D(n27), .Y(n88) );
  OAI21X1 U101 ( .A(n45), .B(n97), .C(n90), .Y(n276) );
  AOI22X1 U102 ( .A(N38), .B(n31), .C(offset_r[31]), .D(n27), .Y(n90) );
  OAI21X1 U104 ( .A(n45), .B(n372), .C(n92), .Y(n278) );
  AOI22X1 U105 ( .A(N7), .B(n31), .C(offset_r[0]), .D(n27), .Y(n92) );
  OAI21X1 U106 ( .A(n93), .B(n94), .C(N435), .Y(n30) );
  OAI22X1 U109 ( .A(plus4_r), .B(n96), .C(N137), .D(n93), .Y(n95) );
  OAI21X1 U112 ( .A(n43), .B(n158), .C(n99), .Y(n311) );
  NAND2X1 U113 ( .A(N235), .B(n43), .Y(n99) );
  OAI21X1 U115 ( .A(n41), .B(n370), .C(n101), .Y(n312) );
  NAND2X1 U116 ( .A(N233), .B(n43), .Y(n101) );
  OAI21X1 U118 ( .A(n41), .B(n369), .C(n103), .Y(n313) );
  NAND2X1 U119 ( .A(N232), .B(n41), .Y(n103) );
  OAI21X1 U121 ( .A(n41), .B(n368), .C(n105), .Y(n314) );
  NAND2X1 U122 ( .A(N231), .B(n41), .Y(n105) );
  OAI21X1 U124 ( .A(n41), .B(n367), .C(n107), .Y(n315) );
  NAND2X1 U125 ( .A(N230), .B(n41), .Y(n107) );
  OAI21X1 U127 ( .A(n41), .B(n366), .C(n109), .Y(n316) );
  NAND2X1 U128 ( .A(N229), .B(n43), .Y(n109) );
  OAI21X1 U130 ( .A(n41), .B(n365), .C(n111), .Y(n317) );
  NAND2X1 U131 ( .A(N228), .B(n41), .Y(n111) );
  OAI21X1 U133 ( .A(n41), .B(n364), .C(n113), .Y(n318) );
  NAND2X1 U134 ( .A(N227), .B(n43), .Y(n113) );
  OAI21X1 U135 ( .A(n41), .B(n363), .C(n115), .Y(n319) );
  NAND2X1 U136 ( .A(N226), .B(n41), .Y(n115) );
  OAI21X1 U137 ( .A(n41), .B(n362), .C(n117), .Y(n320) );
  NAND2X1 U138 ( .A(N225), .B(n43), .Y(n117) );
  OAI21X1 U139 ( .A(n41), .B(n361), .C(n119), .Y(n321) );
  NAND2X1 U140 ( .A(N224), .B(n43), .Y(n119) );
  OAI21X1 U141 ( .A(n41), .B(n360), .C(n121), .Y(n322) );
  NAND2X1 U142 ( .A(N223), .B(n41), .Y(n121) );
  OAI21X1 U143 ( .A(n41), .B(n359), .C(n123), .Y(n323) );
  NAND2X1 U144 ( .A(N222), .B(n41), .Y(n123) );
  OAI21X1 U145 ( .A(n41), .B(n358), .C(n125), .Y(n324) );
  NAND2X1 U146 ( .A(N221), .B(n43), .Y(n125) );
  OAI21X1 U147 ( .A(n43), .B(n357), .C(n127), .Y(n325) );
  NAND2X1 U148 ( .A(N220), .B(n43), .Y(n127) );
  OAI21X1 U149 ( .A(n41), .B(n356), .C(n129), .Y(n326) );
  NAND2X1 U150 ( .A(N219), .B(n43), .Y(n129) );
  OAI21X1 U152 ( .A(n43), .B(n355), .C(n131), .Y(n327) );
  NAND2X1 U153 ( .A(N218), .B(n43), .Y(n131) );
  OAI21X1 U155 ( .A(n41), .B(n354), .C(n133), .Y(n328) );
  NAND2X1 U156 ( .A(N217), .B(n43), .Y(n133) );
  OAI21X1 U158 ( .A(n43), .B(n353), .C(n135), .Y(n329) );
  NAND2X1 U159 ( .A(N216), .B(n43), .Y(n135) );
  OAI21X1 U161 ( .A(n41), .B(n352), .C(n137), .Y(n330) );
  NAND2X1 U162 ( .A(N215), .B(n43), .Y(n137) );
  OAI21X1 U164 ( .A(n43), .B(n351), .C(n139), .Y(n331) );
  NAND2X1 U165 ( .A(N214), .B(n43), .Y(n139) );
  OAI21X1 U167 ( .A(n41), .B(n350), .C(n141), .Y(n332) );
  NAND2X1 U168 ( .A(N213), .B(n43), .Y(n141) );
  OAI21X1 U170 ( .A(n43), .B(n349), .C(n143), .Y(n333) );
  NAND2X1 U171 ( .A(N212), .B(n41), .Y(n143) );
  OAI21X1 U173 ( .A(n43), .B(n348), .C(n145), .Y(n334) );
  NAND2X1 U174 ( .A(N211), .B(n43), .Y(n145) );
  OAI21X1 U175 ( .A(n41), .B(n347), .C(n147), .Y(n335) );
  NAND2X1 U176 ( .A(N210), .B(n43), .Y(n147) );
  OAI21X1 U177 ( .A(n43), .B(n346), .C(n149), .Y(n336) );
  NAND2X1 U178 ( .A(N209), .B(n41), .Y(n149) );
  OAI21X1 U179 ( .A(n43), .B(n345), .C(n151), .Y(n337) );
  NAND2X1 U180 ( .A(N208), .B(n43), .Y(n151) );
  OAI21X1 U181 ( .A(n41), .B(n344), .C(n153), .Y(n338) );
  NAND2X1 U182 ( .A(N207), .B(n41), .Y(n153) );
  OAI21X1 U183 ( .A(n43), .B(n343), .C(n155), .Y(n339) );
  NAND2X1 U184 ( .A(N206), .B(n41), .Y(n155) );
  OAI21X1 U185 ( .A(n43), .B(n160), .C(n157), .Y(n340) );
  NAND2X1 U186 ( .A(N205), .B(n43), .Y(n157) );
  OAI21X1 U187 ( .A(n43), .B(n371), .C(n159), .Y(n341) );
  NAND2X1 U188 ( .A(N234), .B(n43), .Y(n159) );
  OAI21X1 U190 ( .A(n43), .B(n156), .C(n161), .Y(n342) );
  NAND2X1 U191 ( .A(N204), .B(n43), .Y(n161) );
  NAND3X1 U193 ( .A(N435), .B(n93), .C(plus4_r), .Y(n26) );
  NAND3X1 U194 ( .A(n162), .B(n163), .C(n164), .Y(n93) );
  NOR2X1 U196 ( .A(n167), .B(n168), .Y(n166) );
  NAND3X1 U197 ( .A(n169), .B(n170), .C(n171), .Y(n168) );
  NOR2X1 U198 ( .A(n172), .B(n173), .Y(n171) );
  XNOR2X1 U199 ( .A(n360), .B(n24), .Y(n173) );
  XNOR2X1 U201 ( .A(n359), .B(n24), .Y(n172) );
  XNOR2X1 U203 ( .A(row_count[26]), .B(n25), .Y(n170) );
  XNOR2X1 U204 ( .A(row_count[27]), .B(n25), .Y(n169) );
  NAND3X1 U205 ( .A(n174), .B(n175), .C(n176), .Y(n167) );
  NOR2X1 U206 ( .A(n177), .B(n178), .Y(n176) );
  XNOR2X1 U207 ( .A(N337), .B(n344), .Y(n178) );
  XNOR2X1 U209 ( .A(N336), .B(n343), .Y(n177) );
  XNOR2X1 U211 ( .A(N344), .B(row_count[10]), .Y(n175) );
  XNOR2X1 U212 ( .A(N345), .B(row_count[11]), .Y(n174) );
  NOR2X1 U213 ( .A(n179), .B(n180), .Y(n165) );
  NAND3X1 U214 ( .A(n181), .B(n182), .C(n183), .Y(n180) );
  NOR2X1 U215 ( .A(n184), .B(n185), .Y(n183) );
  XNOR2X1 U216 ( .A(n357), .B(n25), .Y(n185) );
  XNOR2X1 U218 ( .A(n358), .B(n25), .Y(n184) );
  XNOR2X1 U220 ( .A(row_count[25]), .B(n25), .Y(n182) );
  XNOR2X1 U221 ( .A(row_count[24]), .B(n25), .Y(n181) );
  NAND3X1 U222 ( .A(n186), .B(n187), .C(n188), .Y(n179) );
  NOR2X1 U223 ( .A(n189), .B(n190), .Y(n188) );
  XNOR2X1 U224 ( .A(n156), .B(N334), .Y(n190) );
  XNOR2X1 U226 ( .A(n160), .B(N335), .Y(n189) );
  XNOR2X1 U228 ( .A(N343), .B(row_count[9]), .Y(n187) );
  XNOR2X1 U229 ( .A(N342), .B(row_count[8]), .Y(n186) );
  NOR2X1 U230 ( .A(n191), .B(n192), .Y(n163) );
  NAND3X1 U231 ( .A(n193), .B(n194), .C(n195), .Y(n192) );
  NOR2X1 U232 ( .A(n196), .B(n197), .Y(n195) );
  XNOR2X1 U233 ( .A(n363), .B(n25), .Y(n197) );
  XNOR2X1 U235 ( .A(n364), .B(n25), .Y(n196) );
  XNOR2X1 U237 ( .A(row_count[31]), .B(n25), .Y(n194) );
  XNOR2X1 U238 ( .A(row_count[30]), .B(n25), .Y(n193) );
  NAND3X1 U239 ( .A(n198), .B(n199), .C(n200), .Y(n191) );
  NOR2X1 U240 ( .A(n201), .B(n202), .Y(n200) );
  XNOR2X1 U241 ( .A(N340), .B(n347), .Y(n202) );
  XNOR2X1 U243 ( .A(N341), .B(n348), .Y(n201) );
  XNOR2X1 U245 ( .A(N349), .B(row_count[15]), .Y(n199) );
  XNOR2X1 U246 ( .A(N348), .B(row_count[14]), .Y(n198) );
  NOR2X1 U247 ( .A(n203), .B(n204), .Y(n162) );
  NAND3X1 U248 ( .A(n205), .B(n206), .C(n207), .Y(n204) );
  NOR2X1 U249 ( .A(n208), .B(n209), .Y(n207) );
  XNOR2X1 U250 ( .A(n362), .B(n25), .Y(n209) );
  XNOR2X1 U252 ( .A(n361), .B(n25), .Y(n208) );
  XNOR2X1 U254 ( .A(row_count[28]), .B(n25), .Y(n206) );
  XNOR2X1 U255 ( .A(row_count[29]), .B(n25), .Y(n205) );
  NAND3X1 U256 ( .A(n210), .B(n211), .C(n212), .Y(n203) );
  NOR2X1 U257 ( .A(n213), .B(n214), .Y(n212) );
  XNOR2X1 U258 ( .A(N339), .B(n346), .Y(n214) );
  XNOR2X1 U260 ( .A(N338), .B(n345), .Y(n213) );
  XNOR2X1 U262 ( .A(N346), .B(row_count[12]), .Y(n211) );
  XNOR2X1 U263 ( .A(N347), .B(row_count[13]), .Y(n210) );
  AND2X2 U195 ( .A(n165), .B(n166), .Y(n164) );
  flex_counter_NUM_CNT_BITS32_2 COLUMN_COUNTER ( .clk(HCLK), .n_rst(n21), 
        .clear(1'b0), .count_enable(N435), .rollover_val({n69, n61, n61, n19, 
        n61, n12, n61, n12, n61, n61, n69, n61, n69, n61, n69, n61, 
        \_0_net_[15] , \_0_net_[14] , \_0_net_[13] , \_0_net_[12] , 
        \_0_net_[11] , \_0_net_[10] , \_0_net_[9] , \_0_net_[8] , \_0_net_[7] , 
        \_0_net_[6] , \_0_net_[5] , \_0_net_[4] , \_0_net_[3] , n75, 
        \_0_net_[1] , \_0_net_[0] }), .rollover_flag(plus4_r) );
  address_update_r_DW_cmp_0 gte_83 ( .A({offset_r[31:3], n8, offset_r[1:0]}), 
        .B({N431, N430, N429, N428, N427, N426, N425, N424, N423, N422, N421, 
        N420, N419, N418, N417, N416, N415, N414, N413, N412, N411, N410, N409, 
        N408, N407, N406, N405, N404, N403, N402, N401, N400}), .TC(1'b0), 
        .GE_LT(1'b1), .GE_GT_EQ(1'b1), .GE_LT_GT_LE(end_of_image) );
  address_update_r_DW01_add_0 add_81 ( .A(addr), .B({offset_r[31:3], n8, 
        offset_r[1:0]}), .CI(1'b0), .SUM(curr_addr) );
  address_update_r_DW01_inc_0 add_75 ( .A(row_count), .SUM({N235, N234, N233, 
        N232, N231, N230, N229, N228, N227, N226, N225, N224, N223, N222, N221, 
        N220, N219, N218, N217, N216, N215, N214, N213, N212, N211, N210, N209, 
        N208, N207, N206, N205, N204}) );
  address_update_r_DW01_add_1 add_74 ( .A({offset_r[31:3], n8, offset_r[1:0]}), 
        .B({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0}), .CI(1'b0), 
        .SUM({N203, N202, N201, N200, N199, N198, N197, N196, N195, N194, N193, 
        N192, N191, N190, N189, N188, N187, N186, N185, N184, N183, N182, N181, 
        N180, N179, N178, N177, N176, N175, SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2}) );
  address_update_r_DW_cmp_1 gte_69 ( .A({offset_r[31:3], n8, offset_r[1:0]}), 
        .B({N136, N135, N134, N133, N132, N131, N130, N129, N128, N127, N126, 
        N125, N124, N123, N122, N121, N120, N119, N118, N117, N116, N115, N114, 
        N113, N112, N111, N110, N109, N108, N107, N106, N105}), .TC(1'b0), 
        .GE_LT(1'b1), .GE_GT_EQ(1'b1), .GE_LT_GT_LE(N137) );
  address_update_r_DW01_inc_1 r326 ( .A({offset_r[31:3], n8, offset_r[1:0]}), 
        .SUM({N38, N37, N36, N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, 
        N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, N13, N12, 
        N11, N10, N9, N8, N7}) );
  address_update_r_DW_mult_uns_1 mult_69 ( .a({length[15], n85, length[13:12], 
        n81, length[10:6], n77, length[4:3], n71, \_0_net_[1] , \_0_net_[0] }), 
        .b({n10, n10, n10, n10, n10, n10, n10, n10, n10, n10, n10, n10, n10, 
        n10, n10, n10, N54, N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, 
        N43, N42, N41, N40, N334}), .product({SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, N87, N86, N85, N84, N83, N82, N81, N80, N79, 
        N78, N77, N76, N75, N74, N73, N72, N71, N70, N69, N68, N67, N66, N65, 
        N64, N63, N62, N61, N60, N59, N58, N57, N56}) );
  address_update_r_DW01_add_3 add_69 ( .A({N87, N86, N85, N84, N83, N82, N81, 
        N80, N79, N78, N77, N76, N75, N74, N73, N72, N71, N70, N69, N68, N67, 
        N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56}), .B({n18, n19, 
        n20, n18, n19, n14, n15, n16, n15, n16, n14, n15, n16, n14, n15, n12, 
        \_0_net_[15] , \_0_net_[14] , \_0_net_[13] , \_0_net_[12] , 
        \_0_net_[11] , \_0_net_[10] , \_0_net_[9] , \_0_net_[8] , \_0_net_[7] , 
        \_0_net_[6] , \_0_net_[5] , \_0_net_[4] , \_0_net_[3] , n75, 
        \_0_net_[1] , \_0_net_[0] }), .CI(1'b0), .SUM({N136, N135, N134, N133, 
        N132, N131, N130, N129, N128, N127, N126, N125, N124, N123, N122, N121, 
        N120, N119, N118, N117, N116, N115, N114, N113, N112, N111, N110, N109, 
        N108, N107, N106, N105}) );
  address_update_r_DW_mult_uns_0 mult_83 ( .a({length[15], n85, length[13:12], 
        n81, length[10:6], n77, length[4:3], n73, \_0_net_[1] , \_0_net_[0] }), 
        .b({n25, n25, n25, n25, n25, n25, n25, n25, n25, n25, n25, n25, n25, 
        n25, n24, n24, N349, N348, N347, N346, N345, N344, N343, N342, N341, 
        N340, N339, N338, N337, N336, N335, N334}), .product({
        SYNOPSYS_UNCONNECTED__19, SYNOPSYS_UNCONNECTED__20, 
        SYNOPSYS_UNCONNECTED__21, SYNOPSYS_UNCONNECTED__22, 
        SYNOPSYS_UNCONNECTED__23, SYNOPSYS_UNCONNECTED__24, 
        SYNOPSYS_UNCONNECTED__25, SYNOPSYS_UNCONNECTED__26, 
        SYNOPSYS_UNCONNECTED__27, SYNOPSYS_UNCONNECTED__28, 
        SYNOPSYS_UNCONNECTED__29, SYNOPSYS_UNCONNECTED__30, 
        SYNOPSYS_UNCONNECTED__31, SYNOPSYS_UNCONNECTED__32, 
        SYNOPSYS_UNCONNECTED__33, SYNOPSYS_UNCONNECTED__34, N382, N381, N380, 
        N379, N378, N377, N376, N375, N374, N373, N372, N371, N370, N369, N368, 
        N367, N366, N365, N364, N363, N362, N361, N360, N359, N358, N357, N356, 
        N355, N354, N353, N352, N351}) );
  address_update_r_DW01_add_2 add_83 ( .A({N382, N381, N380, N379, N378, N377, 
        N376, N375, N374, N373, N372, N371, N370, N369, N368, N367, N366, N365, 
        N364, N363, N362, N361, N360, N359, N358, N357, N356, N355, N354, N353, 
        N352, N351}), .B({n14, n16, n69, n18, n69, n18, n69, n18, n18, n69, 
        n18, n19, n20, n18, n19, n20, \_0_net_[15] , \_0_net_[14] , 
        \_0_net_[13] , \_0_net_[12] , \_0_net_[11] , \_0_net_[10] , 
        \_0_net_[9] , \_0_net_[8] , \_0_net_[7] , \_0_net_[6] , \_0_net_[5] , 
        \_0_net_[4] , \_0_net_[3] , n75, \_0_net_[1] , \_0_net_[0] }), .CI(
        1'b0), .SUM({N431, N430, N429, N428, N427, N426, N425, N424, N423, 
        N422, N421, N420, N419, N418, N417, N416, N415, N414, N413, N412, N411, 
        N410, N409, N408, N407, N406, N405, N404, N403, N402, N401, N400}) );
  OR2X2 U5 ( .A(\sub_83/carry[15] ), .B(width[15]), .Y(n7) );
  BUFX2 U12 ( .A(\_0_net_[31] ), .Y(n61) );
  BUFX2 U15 ( .A(offset_r[2]), .Y(n8) );
  INVX2 U16 ( .A(n29), .Y(n27) );
  INVX2 U19 ( .A(n11), .Y(n12) );
  INVX2 U22 ( .A(n17), .Y(n20) );
  INVX2 U25 ( .A(n13), .Y(n15) );
  INVX2 U28 ( .A(n13), .Y(n14) );
  INVX2 U31 ( .A(n17), .Y(n19) );
  INVX2 U34 ( .A(n17), .Y(n18) );
  INVX2 U37 ( .A(n13), .Y(n16) );
  INVX2 U40 ( .A(n53), .Y(n41) );
  INVX2 U43 ( .A(n49), .Y(n43) );
  INVX2 U46 ( .A(n91), .Y(n22) );
  INVX2 U49 ( .A(n91), .Y(n23) );
  INVX2 U52 ( .A(n91), .Y(n21) );
  INVX2 U55 ( .A(n30), .Y(n29) );
  BUFX2 U58 ( .A(length[2]), .Y(n71) );
  BUFX2 U61 ( .A(length[2]), .Y(n73) );
  INVX2 U64 ( .A(n73), .Y(n75) );
  INVX2 U67 ( .A(n67), .Y(n17) );
  BUFX2 U70 ( .A(\_0_net_[31] ), .Y(n67) );
  INVX2 U73 ( .A(n63), .Y(n11) );
  BUFX2 U76 ( .A(\_0_net_[31] ), .Y(n63) );
  INVX2 U79 ( .A(n87), .Y(n85) );
  INVX2 U82 ( .A(length[14]), .Y(n87) );
  INVX2 U85 ( .A(n65), .Y(n13) );
  BUFX2 U88 ( .A(\_0_net_[31] ), .Y(n65) );
  BUFX2 U91 ( .A(\_0_net_[31] ), .Y(n69) );
  BUFX2 U94 ( .A(n37), .Y(n53) );
  BUFX2 U97 ( .A(n37), .Y(n51) );
  BUFX2 U100 ( .A(n35), .Y(n49) );
  BUFX2 U103 ( .A(n35), .Y(n47) );
  BUFX2 U107 ( .A(n35), .Y(n45) );
  BUFX2 U108 ( .A(n37), .Y(n55) );
  BUFX2 U110 ( .A(n39), .Y(n57) );
  BUFX2 U111 ( .A(n39), .Y(n59) );
  INVX4 U114 ( .A(n91), .Y(n89) );
  INVX2 U117 ( .A(n9), .Y(n31) );
  INVX2 U120 ( .A(n9), .Y(n33) );
  INVX2 U123 ( .A(n7), .Y(n24) );
  INVX2 U126 ( .A(n79), .Y(n77) );
  INVX2 U129 ( .A(length[5]), .Y(n79) );
  INVX2 U132 ( .A(n83), .Y(n81) );
  INVX2 U151 ( .A(length[11]), .Y(n83) );
  INVX2 U154 ( .A(n7), .Y(n25) );
  BUFX2 U157 ( .A(n26), .Y(n37) );
  BUFX2 U160 ( .A(n26), .Y(n35) );
  BUFX2 U163 ( .A(n26), .Y(n39) );
  INVX2 U166 ( .A(HRESETn), .Y(n91) );
  NAND2X1 U169 ( .A(N435), .B(n95), .Y(n9) );
  NOR2X1 U172 ( .A(\sub_69/carry[15] ), .B(width[15]), .Y(n10) );
  XNOR2X1 U189 ( .A(width[15]), .B(\sub_69/carry[15] ), .Y(N54) );
  OR2X1 U192 ( .A(\sub_69/carry[14] ), .B(width[14]), .Y(\sub_69/carry[15] )
         );
  XNOR2X1 U200 ( .A(width[14]), .B(\sub_69/carry[14] ), .Y(N53) );
  OR2X1 U202 ( .A(\sub_69/carry[13] ), .B(width[13]), .Y(\sub_69/carry[14] )
         );
  XNOR2X1 U208 ( .A(width[13]), .B(\sub_69/carry[13] ), .Y(N52) );
  OR2X1 U210 ( .A(\sub_69/carry[12] ), .B(width[12]), .Y(\sub_69/carry[13] )
         );
  XNOR2X1 U217 ( .A(width[12]), .B(\sub_69/carry[12] ), .Y(N51) );
  OR2X1 U219 ( .A(\sub_69/carry[11] ), .B(width[11]), .Y(\sub_69/carry[12] )
         );
  XNOR2X1 U225 ( .A(width[11]), .B(\sub_69/carry[11] ), .Y(N50) );
  OR2X1 U227 ( .A(\sub_69/carry[10] ), .B(width[10]), .Y(\sub_69/carry[11] )
         );
  XNOR2X1 U234 ( .A(width[10]), .B(\sub_69/carry[10] ), .Y(N49) );
  OR2X1 U236 ( .A(\sub_69/carry[9] ), .B(width[9]), .Y(\sub_69/carry[10] ) );
  XNOR2X1 U242 ( .A(width[9]), .B(\sub_69/carry[9] ), .Y(N48) );
  OR2X1 U244 ( .A(\sub_69/carry[8] ), .B(width[8]), .Y(\sub_69/carry[9] ) );
  XNOR2X1 U251 ( .A(width[8]), .B(\sub_69/carry[8] ), .Y(N47) );
  OR2X1 U253 ( .A(\sub_69/carry[7] ), .B(width[7]), .Y(\sub_69/carry[8] ) );
  XNOR2X1 U259 ( .A(width[7]), .B(\sub_69/carry[7] ), .Y(N46) );
  OR2X1 U261 ( .A(\sub_69/carry[6] ), .B(width[6]), .Y(\sub_69/carry[7] ) );
  XNOR2X1 U328 ( .A(width[6]), .B(\sub_69/carry[6] ), .Y(N45) );
  OR2X1 U329 ( .A(\sub_69/carry[5] ), .B(width[5]), .Y(\sub_69/carry[6] ) );
  XNOR2X1 U330 ( .A(width[5]), .B(\sub_69/carry[5] ), .Y(N44) );
  OR2X1 U331 ( .A(\sub_69/carry[4] ), .B(width[4]), .Y(\sub_69/carry[5] ) );
  XNOR2X1 U332 ( .A(width[4]), .B(\sub_69/carry[4] ), .Y(N43) );
  OR2X1 U333 ( .A(\sub_69/carry[3] ), .B(width[3]), .Y(\sub_69/carry[4] ) );
  XNOR2X1 U334 ( .A(width[3]), .B(\sub_69/carry[3] ), .Y(N42) );
  OR2X1 U335 ( .A(\sub_69/carry[2] ), .B(width[2]), .Y(\sub_69/carry[3] ) );
  XNOR2X1 U336 ( .A(width[2]), .B(\sub_69/carry[2] ), .Y(N41) );
  AND2X1 U337 ( .A(width[1]), .B(width[0]), .Y(\sub_69/carry[2] ) );
  XOR2X1 U338 ( .A(width[0]), .B(width[1]), .Y(N40) );
  OR2X1 U339 ( .A(\r325/carry[15] ), .B(length[15]), .Y(\r325/carry[16] ) );
  XNOR2X1 U340 ( .A(length[15]), .B(\r325/carry[15] ), .Y(\_0_net_[15] ) );
  OR2X1 U341 ( .A(\r325/carry[14] ), .B(n85), .Y(\r325/carry[15] ) );
  XNOR2X1 U342 ( .A(n85), .B(\r325/carry[14] ), .Y(\_0_net_[14] ) );
  OR2X1 U343 ( .A(\r325/carry[13] ), .B(length[13]), .Y(\r325/carry[14] ) );
  XNOR2X1 U344 ( .A(length[13]), .B(\r325/carry[13] ), .Y(\_0_net_[13] ) );
  OR2X1 U345 ( .A(\r325/carry[12] ), .B(length[12]), .Y(\r325/carry[13] ) );
  XNOR2X1 U346 ( .A(length[12]), .B(\r325/carry[12] ), .Y(\_0_net_[12] ) );
  OR2X1 U347 ( .A(\r325/carry[11] ), .B(n81), .Y(\r325/carry[12] ) );
  XNOR2X1 U348 ( .A(n81), .B(\r325/carry[11] ), .Y(\_0_net_[11] ) );
  OR2X1 U349 ( .A(\r325/carry[10] ), .B(length[10]), .Y(\r325/carry[11] ) );
  XNOR2X1 U350 ( .A(length[10]), .B(\r325/carry[10] ), .Y(\_0_net_[10] ) );
  OR2X1 U351 ( .A(\r325/carry[9] ), .B(length[9]), .Y(\r325/carry[10] ) );
  XNOR2X1 U352 ( .A(length[9]), .B(\r325/carry[9] ), .Y(\_0_net_[9] ) );
  OR2X1 U353 ( .A(\r325/carry[8] ), .B(length[8]), .Y(\r325/carry[9] ) );
  XNOR2X1 U354 ( .A(length[8]), .B(\r325/carry[8] ), .Y(\_0_net_[8] ) );
  OR2X1 U355 ( .A(\r325/carry[7] ), .B(length[7]), .Y(\r325/carry[8] ) );
  XNOR2X1 U356 ( .A(length[7]), .B(\r325/carry[7] ), .Y(\_0_net_[7] ) );
  OR2X1 U357 ( .A(\r325/carry[6] ), .B(length[6]), .Y(\r325/carry[7] ) );
  XNOR2X1 U358 ( .A(length[6]), .B(\r325/carry[6] ), .Y(\_0_net_[6] ) );
  OR2X1 U359 ( .A(\r325/carry[5] ), .B(n77), .Y(\r325/carry[6] ) );
  XNOR2X1 U360 ( .A(n77), .B(\r325/carry[5] ), .Y(\_0_net_[5] ) );
  OR2X1 U361 ( .A(\r325/carry[4] ), .B(length[4]), .Y(\r325/carry[5] ) );
  XNOR2X1 U362 ( .A(length[4]), .B(\r325/carry[4] ), .Y(\_0_net_[4] ) );
  OR2X1 U363 ( .A(n71), .B(length[3]), .Y(\r325/carry[4] ) );
  XNOR2X1 U364 ( .A(length[3]), .B(n71), .Y(\_0_net_[3] ) );
  XNOR2X1 U365 ( .A(width[15]), .B(\sub_83/carry[15] ), .Y(N349) );
  OR2X1 U366 ( .A(\sub_83/carry[14] ), .B(width[14]), .Y(\sub_83/carry[15] )
         );
  XNOR2X1 U367 ( .A(width[14]), .B(\sub_83/carry[14] ), .Y(N348) );
  OR2X1 U368 ( .A(\sub_83/carry[13] ), .B(width[13]), .Y(\sub_83/carry[14] )
         );
  XNOR2X1 U369 ( .A(width[13]), .B(\sub_83/carry[13] ), .Y(N347) );
  OR2X1 U370 ( .A(\sub_83/carry[12] ), .B(width[12]), .Y(\sub_83/carry[13] )
         );
  XNOR2X1 U371 ( .A(width[12]), .B(\sub_83/carry[12] ), .Y(N346) );
  OR2X1 U372 ( .A(\sub_83/carry[11] ), .B(width[11]), .Y(\sub_83/carry[12] )
         );
  XNOR2X1 U373 ( .A(width[11]), .B(\sub_83/carry[11] ), .Y(N345) );
  OR2X1 U374 ( .A(\sub_83/carry[10] ), .B(width[10]), .Y(\sub_83/carry[11] )
         );
  XNOR2X1 U375 ( .A(width[10]), .B(\sub_83/carry[10] ), .Y(N344) );
  OR2X1 U376 ( .A(\sub_83/carry[9] ), .B(width[9]), .Y(\sub_83/carry[10] ) );
  XNOR2X1 U377 ( .A(width[9]), .B(\sub_83/carry[9] ), .Y(N343) );
  OR2X1 U378 ( .A(\sub_83/carry[8] ), .B(width[8]), .Y(\sub_83/carry[9] ) );
  XNOR2X1 U379 ( .A(width[8]), .B(\sub_83/carry[8] ), .Y(N342) );
  OR2X1 U380 ( .A(\sub_83/carry[7] ), .B(width[7]), .Y(\sub_83/carry[8] ) );
  XNOR2X1 U381 ( .A(width[7]), .B(\sub_83/carry[7] ), .Y(N341) );
  OR2X1 U382 ( .A(\sub_83/carry[6] ), .B(width[6]), .Y(\sub_83/carry[7] ) );
  XNOR2X1 U383 ( .A(width[6]), .B(\sub_83/carry[6] ), .Y(N340) );
  OR2X1 U384 ( .A(\sub_83/carry[5] ), .B(width[5]), .Y(\sub_83/carry[6] ) );
  XNOR2X1 U385 ( .A(width[5]), .B(\sub_83/carry[5] ), .Y(N339) );
  OR2X1 U386 ( .A(\sub_83/carry[4] ), .B(width[4]), .Y(\sub_83/carry[5] ) );
  XNOR2X1 U387 ( .A(width[4]), .B(\sub_83/carry[4] ), .Y(N338) );
  OR2X1 U388 ( .A(\sub_83/carry[3] ), .B(width[3]), .Y(\sub_83/carry[4] ) );
  XNOR2X1 U389 ( .A(width[3]), .B(\sub_83/carry[3] ), .Y(N337) );
  OR2X1 U390 ( .A(\sub_83/carry[2] ), .B(width[2]), .Y(\sub_83/carry[3] ) );
  XNOR2X1 U391 ( .A(width[2]), .B(\sub_83/carry[2] ), .Y(N336) );
  AND2X1 U392 ( .A(width[1]), .B(width[0]), .Y(\sub_83/carry[2] ) );
  XOR2X1 U393 ( .A(width[0]), .B(width[1]), .Y(N335) );
  INVX2 U394 ( .A(width[0]), .Y(N334) );
  INVX2 U395 ( .A(\r325/carry[16] ), .Y(\_0_net_[31] ) );
  INVX2 U396 ( .A(N137), .Y(n94) );
  INVX2 U397 ( .A(n93), .Y(n96) );
  INVX2 U398 ( .A(N203), .Y(n97) );
  INVX2 U399 ( .A(N202), .Y(n98) );
  INVX2 U400 ( .A(N201), .Y(n100) );
  INVX2 U401 ( .A(N200), .Y(n102) );
  INVX2 U402 ( .A(N199), .Y(n104) );
  INVX2 U403 ( .A(N198), .Y(n106) );
  INVX2 U404 ( .A(N197), .Y(n108) );
  INVX2 U405 ( .A(N196), .Y(n110) );
  INVX2 U406 ( .A(N195), .Y(n112) );
  INVX2 U407 ( .A(N194), .Y(n114) );
  INVX2 U408 ( .A(N193), .Y(n116) );
  INVX2 U409 ( .A(N192), .Y(n118) );
  INVX2 U410 ( .A(N191), .Y(n120) );
  INVX2 U411 ( .A(N190), .Y(n122) );
  INVX2 U412 ( .A(N189), .Y(n124) );
  INVX2 U413 ( .A(N188), .Y(n126) );
  INVX2 U414 ( .A(N187), .Y(n128) );
  INVX2 U415 ( .A(N186), .Y(n130) );
  INVX2 U416 ( .A(N185), .Y(n132) );
  INVX2 U417 ( .A(N184), .Y(n134) );
  INVX2 U418 ( .A(N183), .Y(n136) );
  INVX2 U419 ( .A(N182), .Y(n138) );
  INVX2 U420 ( .A(N181), .Y(n140) );
  INVX2 U421 ( .A(N180), .Y(n142) );
  INVX2 U422 ( .A(N179), .Y(n144) );
  INVX2 U423 ( .A(N178), .Y(n146) );
  INVX2 U424 ( .A(N177), .Y(n148) );
  INVX2 U425 ( .A(N176), .Y(n150) );
  INVX2 U426 ( .A(N175), .Y(n152) );
  INVX2 U427 ( .A(offset_r[1]), .Y(n154) );
  INVX2 U428 ( .A(row_count[0]), .Y(n156) );
  INVX2 U429 ( .A(row_count[31]), .Y(n158) );
  INVX2 U430 ( .A(row_count[1]), .Y(n160) );
  INVX2 U431 ( .A(row_count[2]), .Y(n343) );
  INVX2 U432 ( .A(row_count[3]), .Y(n344) );
  INVX2 U433 ( .A(row_count[4]), .Y(n345) );
  INVX2 U434 ( .A(row_count[5]), .Y(n346) );
  INVX2 U435 ( .A(row_count[6]), .Y(n347) );
  INVX2 U436 ( .A(row_count[7]), .Y(n348) );
  INVX2 U437 ( .A(row_count[8]), .Y(n349) );
  INVX2 U438 ( .A(row_count[9]), .Y(n350) );
  INVX2 U439 ( .A(row_count[10]), .Y(n351) );
  INVX2 U440 ( .A(row_count[11]), .Y(n352) );
  INVX2 U441 ( .A(row_count[12]), .Y(n353) );
  INVX2 U442 ( .A(row_count[13]), .Y(n354) );
  INVX2 U443 ( .A(row_count[14]), .Y(n355) );
  INVX2 U444 ( .A(row_count[15]), .Y(n356) );
  INVX2 U445 ( .A(row_count[16]), .Y(n357) );
  INVX2 U446 ( .A(row_count[17]), .Y(n358) );
  INVX2 U447 ( .A(row_count[18]), .Y(n359) );
  INVX2 U448 ( .A(row_count[19]), .Y(n360) );
  INVX2 U449 ( .A(row_count[20]), .Y(n361) );
  INVX2 U450 ( .A(row_count[21]), .Y(n362) );
  INVX2 U451 ( .A(row_count[22]), .Y(n363) );
  INVX2 U452 ( .A(row_count[23]), .Y(n364) );
  INVX2 U453 ( .A(row_count[24]), .Y(n365) );
  INVX2 U454 ( .A(row_count[25]), .Y(n366) );
  INVX2 U455 ( .A(row_count[26]), .Y(n367) );
  INVX2 U456 ( .A(row_count[27]), .Y(n368) );
  INVX2 U457 ( .A(row_count[28]), .Y(n369) );
  INVX2 U458 ( .A(row_count[29]), .Y(n370) );
  INVX2 U459 ( .A(row_count[30]), .Y(n371) );
  INVX2 U460 ( .A(offset_r[0]), .Y(n372) );
endmodule


module flex_counter_NUM_CNT_BITS32_1_DW01_dec_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;
  wire   n11, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75;

  INVX2 U1 ( .A(n61), .Y(SUM[1]) );
  INVX2 U2 ( .A(n74), .Y(SUM[11]) );
  INVX2 U3 ( .A(n71), .Y(SUM[13]) );
  INVX2 U4 ( .A(n68), .Y(SUM[15]) );
  INVX2 U5 ( .A(n65), .Y(SUM[17]) );
  INVX2 U6 ( .A(n62), .Y(SUM[19]) );
  INVX2 U7 ( .A(n57), .Y(SUM[22]) );
  INVX2 U8 ( .A(n54), .Y(SUM[24]) );
  INVX2 U9 ( .A(n51), .Y(SUM[26]) );
  INVX2 U10 ( .A(n48), .Y(SUM[28]) );
  INVX2 U11 ( .A(n59), .Y(n11) );
  INVX2 U12 ( .A(n32), .Y(SUM[9]) );
  INVX2 U13 ( .A(n36), .Y(SUM[7]) );
  INVX2 U14 ( .A(n39), .Y(SUM[5]) );
  INVX2 U15 ( .A(n42), .Y(SUM[3]) );
  INVX2 U16 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U17 ( .A(A[2]), .Y(n17) );
  INVX2 U18 ( .A(A[4]), .Y(n18) );
  INVX2 U19 ( .A(A[6]), .Y(n19) );
  INVX2 U20 ( .A(A[8]), .Y(n20) );
  INVX2 U21 ( .A(A[10]), .Y(n21) );
  INVX2 U22 ( .A(A[12]), .Y(n22) );
  INVX2 U23 ( .A(A[14]), .Y(n23) );
  INVX2 U24 ( .A(A[16]), .Y(n24) );
  INVX2 U25 ( .A(A[18]), .Y(n25) );
  INVX2 U26 ( .A(A[20]), .Y(n26) );
  INVX2 U27 ( .A(A[21]), .Y(n27) );
  INVX2 U28 ( .A(A[23]), .Y(n28) );
  INVX2 U29 ( .A(A[25]), .Y(n29) );
  INVX2 U30 ( .A(A[27]), .Y(n30) );
  INVX2 U31 ( .A(A[29]), .Y(n31) );
  AOI21X1 U32 ( .A(n33), .B(A[9]), .C(n34), .Y(n32) );
  OAI21X1 U33 ( .A(n35), .B(n20), .C(n33), .Y(SUM[8]) );
  AOI21X1 U34 ( .A(n37), .B(A[7]), .C(n35), .Y(n36) );
  OAI21X1 U35 ( .A(n38), .B(n19), .C(n37), .Y(SUM[6]) );
  AOI21X1 U36 ( .A(n40), .B(A[5]), .C(n38), .Y(n39) );
  OAI21X1 U37 ( .A(n41), .B(n18), .C(n40), .Y(SUM[4]) );
  AOI21X1 U38 ( .A(n43), .B(A[3]), .C(n41), .Y(n42) );
  XOR2X1 U39 ( .A(A[31]), .B(n44), .Y(SUM[31]) );
  NOR2X1 U40 ( .A(A[30]), .B(n45), .Y(n44) );
  XNOR2X1 U41 ( .A(A[30]), .B(n45), .Y(SUM[30]) );
  OAI21X1 U42 ( .A(n46), .B(n17), .C(n43), .Y(SUM[2]) );
  OAI21X1 U43 ( .A(n47), .B(n31), .C(n45), .Y(SUM[29]) );
  NAND2X1 U44 ( .A(n47), .B(n31), .Y(n45) );
  AOI21X1 U45 ( .A(n49), .B(A[28]), .C(n47), .Y(n48) );
  NOR2X1 U46 ( .A(n49), .B(A[28]), .Y(n47) );
  OAI21X1 U47 ( .A(n50), .B(n30), .C(n49), .Y(SUM[27]) );
  NAND2X1 U48 ( .A(n50), .B(n30), .Y(n49) );
  AOI21X1 U49 ( .A(n52), .B(A[26]), .C(n50), .Y(n51) );
  NOR2X1 U50 ( .A(n52), .B(A[26]), .Y(n50) );
  OAI21X1 U51 ( .A(n53), .B(n29), .C(n52), .Y(SUM[25]) );
  NAND2X1 U52 ( .A(n53), .B(n29), .Y(n52) );
  AOI21X1 U53 ( .A(n55), .B(A[24]), .C(n53), .Y(n54) );
  NOR2X1 U54 ( .A(n55), .B(A[24]), .Y(n53) );
  OAI21X1 U55 ( .A(n56), .B(n28), .C(n55), .Y(SUM[23]) );
  NAND2X1 U56 ( .A(n56), .B(n28), .Y(n55) );
  AOI21X1 U57 ( .A(n58), .B(A[22]), .C(n56), .Y(n57) );
  NOR2X1 U58 ( .A(n58), .B(A[22]), .Y(n56) );
  OAI21X1 U59 ( .A(n11), .B(n27), .C(n58), .Y(SUM[21]) );
  NAND2X1 U60 ( .A(n11), .B(n27), .Y(n58) );
  OAI21X1 U61 ( .A(n60), .B(n26), .C(n59), .Y(SUM[20]) );
  NAND2X1 U62 ( .A(n60), .B(n26), .Y(n59) );
  AOI21X1 U63 ( .A(A[0]), .B(A[1]), .C(n46), .Y(n61) );
  AOI21X1 U64 ( .A(n63), .B(A[19]), .C(n60), .Y(n62) );
  NOR2X1 U65 ( .A(n63), .B(A[19]), .Y(n60) );
  OAI21X1 U66 ( .A(n64), .B(n25), .C(n63), .Y(SUM[18]) );
  NAND2X1 U67 ( .A(n64), .B(n25), .Y(n63) );
  AOI21X1 U68 ( .A(n66), .B(A[17]), .C(n64), .Y(n65) );
  NOR2X1 U69 ( .A(n66), .B(A[17]), .Y(n64) );
  OAI21X1 U70 ( .A(n67), .B(n24), .C(n66), .Y(SUM[16]) );
  NAND2X1 U71 ( .A(n67), .B(n24), .Y(n66) );
  AOI21X1 U72 ( .A(n69), .B(A[15]), .C(n67), .Y(n68) );
  NOR2X1 U73 ( .A(n69), .B(A[15]), .Y(n67) );
  OAI21X1 U74 ( .A(n70), .B(n23), .C(n69), .Y(SUM[14]) );
  NAND2X1 U75 ( .A(n70), .B(n23), .Y(n69) );
  AOI21X1 U76 ( .A(n72), .B(A[13]), .C(n70), .Y(n71) );
  NOR2X1 U77 ( .A(n72), .B(A[13]), .Y(n70) );
  OAI21X1 U78 ( .A(n73), .B(n22), .C(n72), .Y(SUM[12]) );
  NAND2X1 U79 ( .A(n73), .B(n22), .Y(n72) );
  AOI21X1 U80 ( .A(n75), .B(A[11]), .C(n73), .Y(n74) );
  NOR2X1 U81 ( .A(n75), .B(A[11]), .Y(n73) );
  OAI21X1 U82 ( .A(n34), .B(n21), .C(n75), .Y(SUM[10]) );
  NAND2X1 U83 ( .A(n34), .B(n21), .Y(n75) );
  NOR2X1 U84 ( .A(n33), .B(A[9]), .Y(n34) );
  NAND2X1 U85 ( .A(n35), .B(n20), .Y(n33) );
  NOR2X1 U86 ( .A(n37), .B(A[7]), .Y(n35) );
  NAND2X1 U87 ( .A(n38), .B(n19), .Y(n37) );
  NOR2X1 U88 ( .A(n40), .B(A[5]), .Y(n38) );
  NAND2X1 U89 ( .A(n41), .B(n18), .Y(n40) );
  NOR2X1 U90 ( .A(n43), .B(A[3]), .Y(n41) );
  NAND2X1 U91 ( .A(n46), .B(n17), .Y(n43) );
  NOR2X1 U92 ( .A(A[1]), .B(A[0]), .Y(n46) );
endmodule


module flex_counter_NUM_CNT_BITS32_1_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module flex_counter_NUM_CNT_BITS32_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [31:0] rollover_val;
  output [31:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n468, n469, n470, n471, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13,
         N14, N15, N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26, N27,
         N28, N29, N30, N31, N32, N33, N34, N35, N36, N37, N38, N39, N40, N41,
         N42, N43, N44, N45, N46, N47, N48, N49, N50, N51, N52, N53, N54, N55,
         N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, N67, n3, n6,
         n7, n8, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n135, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434;

  DFFSR \count_out_reg[0]  ( .D(n257), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n258), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n259), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n260), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n261), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n262), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n263), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(n264), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(n265), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(n266), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[10]  ( .D(n267), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[11]  ( .D(n268), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[12]  ( .D(n269), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[13]  ( .D(n270), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[14]  ( .D(n271), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[14]) );
  DFFSR \count_out_reg[15]  ( .D(n272), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[15]) );
  DFFSR \count_out_reg[16]  ( .D(n273), .CLK(clk), .R(n44), .S(1'b1), .Q(n471)
         );
  DFFSR \count_out_reg[17]  ( .D(n274), .CLK(clk), .R(n44), .S(1'b1), .Q(n470)
         );
  DFFSR \count_out_reg[18]  ( .D(n275), .CLK(clk), .R(n44), .S(1'b1), .Q(n469)
         );
  DFFSR \count_out_reg[19]  ( .D(n276), .CLK(clk), .R(n44), .S(1'b1), .Q(n468)
         );
  DFFSR \count_out_reg[20]  ( .D(n277), .CLK(clk), .R(n44), .S(1'b1), .Q(
        count_out[20]) );
  DFFSR \count_out_reg[21]  ( .D(n278), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[21]) );
  DFFSR \count_out_reg[22]  ( .D(n279), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[22]) );
  DFFSR \count_out_reg[23]  ( .D(n280), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[23]) );
  DFFSR \count_out_reg[24]  ( .D(n281), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[24]) );
  DFFSR \count_out_reg[25]  ( .D(n282), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[25]) );
  DFFSR \count_out_reg[26]  ( .D(n283), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[26]) );
  DFFSR \count_out_reg[27]  ( .D(n284), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[27]) );
  DFFSR \count_out_reg[28]  ( .D(n285), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[28]) );
  DFFSR \count_out_reg[29]  ( .D(n286), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[29]) );
  DFFSR \count_out_reg[30]  ( .D(n287), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[30]) );
  DFFSR \count_out_reg[31]  ( .D(n288), .CLK(clk), .R(n43), .S(1'b1), .Q(
        count_out[31]) );
  DFFSR rollover_flag_reg ( .D(n289), .CLK(clk), .R(n43), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U70 ( .A(n434), .B(n433), .C(n432), .Y(n289) );
  NAND2X1 U71 ( .A(rollover_flag), .B(n431), .Y(n432) );
  NAND2X1 U72 ( .A(n430), .B(n429), .Y(n433) );
  NOR2X1 U73 ( .A(n428), .B(n427), .Y(n429) );
  NAND3X1 U74 ( .A(n426), .B(n425), .C(n424), .Y(n427) );
  NOR2X1 U75 ( .A(n423), .B(n422), .Y(n424) );
  XNOR2X1 U76 ( .A(n135), .B(N66), .Y(n422) );
  XNOR2X1 U77 ( .A(n255), .B(N67), .Y(n423) );
  XNOR2X1 U78 ( .A(count_out[27]), .B(N63), .Y(n425) );
  XNOR2X1 U79 ( .A(count_out[26]), .B(N62), .Y(n426) );
  NAND3X1 U80 ( .A(n421), .B(n420), .C(n419), .Y(n428) );
  NOR2X1 U81 ( .A(n418), .B(n417), .Y(n419) );
  XNOR2X1 U82 ( .A(n64), .B(N54), .Y(n417) );
  XNOR2X1 U83 ( .A(n65), .B(N55), .Y(n418) );
  XNOR2X1 U84 ( .A(count_out[23]), .B(N59), .Y(n420) );
  NOR2X1 U85 ( .A(n416), .B(n415), .Y(n421) );
  XNOR2X1 U86 ( .A(n55), .B(N45), .Y(n415) );
  XNOR2X1 U87 ( .A(n68), .B(N58), .Y(n416) );
  NOR2X1 U88 ( .A(n414), .B(n413), .Y(n430) );
  NAND3X1 U89 ( .A(n412), .B(n411), .C(n410), .Y(n413) );
  NOR2X1 U90 ( .A(n409), .B(n408), .Y(n410) );
  XNOR2X1 U91 ( .A(n60), .B(N50), .Y(n408) );
  XNOR2X1 U92 ( .A(n61), .B(N51), .Y(n409) );
  XNOR2X1 U93 ( .A(count_out[11]), .B(N47), .Y(n411) );
  XNOR2X1 U94 ( .A(count_out[10]), .B(N46), .Y(n412) );
  NAND3X1 U95 ( .A(n407), .B(n406), .C(n405), .Y(n414) );
  NOR2X1 U96 ( .A(n404), .B(n403), .Y(n405) );
  XNOR2X1 U97 ( .A(n52), .B(N42), .Y(n403) );
  XNOR2X1 U98 ( .A(n53), .B(N43), .Y(n404) );
  XNOR2X1 U99 ( .A(count_out[3]), .B(N39), .Y(n406) );
  XNOR2X1 U100 ( .A(count_out[2]), .B(N38), .Y(n407) );
  NAND2X1 U101 ( .A(n402), .B(n401), .Y(n434) );
  NOR2X1 U102 ( .A(n400), .B(n399), .Y(n401) );
  NAND3X1 U103 ( .A(n398), .B(n397), .C(n396), .Y(n399) );
  NOR2X1 U104 ( .A(n395), .B(n394), .Y(n396) );
  XNOR2X1 U105 ( .A(n74), .B(N64), .Y(n394) );
  XNOR2X1 U106 ( .A(n63), .B(N53), .Y(n395) );
  XNOR2X1 U107 ( .A(count_out[29]), .B(N65), .Y(n397) );
  XNOR2X1 U108 ( .A(count_out[24]), .B(N60), .Y(n398) );
  NAND3X1 U109 ( .A(n393), .B(n392), .C(n391), .Y(n400) );
  NOR2X1 U110 ( .A(n390), .B(n389), .Y(n391) );
  XNOR2X1 U111 ( .A(n62), .B(N52), .Y(n389) );
  XNOR2X1 U112 ( .A(n67), .B(N57), .Y(n390) );
  XNOR2X1 U113 ( .A(count_out[20]), .B(N56), .Y(n392) );
  NOR2X1 U114 ( .A(clear), .B(n431), .Y(n393) );
  NOR2X1 U115 ( .A(n388), .B(n387), .Y(n402) );
  NAND3X1 U116 ( .A(n386), .B(n385), .C(n384), .Y(n387) );
  NOR2X1 U117 ( .A(n383), .B(n382), .Y(n384) );
  XNOR2X1 U118 ( .A(n58), .B(N48), .Y(n382) );
  XNOR2X1 U119 ( .A(n47), .B(N37), .Y(n383) );
  XNOR2X1 U120 ( .A(count_out[13]), .B(N49), .Y(n385) );
  XNOR2X1 U121 ( .A(count_out[8]), .B(N44), .Y(n386) );
  NAND3X1 U122 ( .A(n381), .B(n380), .C(n379), .Y(n388) );
  NOR2X1 U123 ( .A(n378), .B(n377), .Y(n379) );
  XNOR2X1 U124 ( .A(n50), .B(N40), .Y(n377) );
  XNOR2X1 U125 ( .A(n71), .B(N61), .Y(n378) );
  XNOR2X1 U126 ( .A(count_out[5]), .B(N41), .Y(n380) );
  XNOR2X1 U127 ( .A(count_out[0]), .B(N36), .Y(n381) );
  OAI21X1 U128 ( .A(n255), .B(n7), .C(n376), .Y(n288) );
  NAND2X1 U129 ( .A(N35), .B(n42), .Y(n376) );
  OAI21X1 U130 ( .A(n135), .B(n7), .C(n375), .Y(n287) );
  NAND2X1 U131 ( .A(N34), .B(n42), .Y(n375) );
  OAI21X1 U132 ( .A(n75), .B(n7), .C(n374), .Y(n286) );
  NAND2X1 U133 ( .A(N33), .B(n42), .Y(n374) );
  OAI21X1 U134 ( .A(n74), .B(n7), .C(n373), .Y(n285) );
  NAND2X1 U135 ( .A(N32), .B(n42), .Y(n373) );
  OAI21X1 U136 ( .A(n73), .B(n7), .C(n372), .Y(n284) );
  NAND2X1 U137 ( .A(N31), .B(n42), .Y(n372) );
  OAI21X1 U138 ( .A(n72), .B(n7), .C(n371), .Y(n283) );
  NAND2X1 U139 ( .A(N30), .B(n42), .Y(n371) );
  OAI21X1 U140 ( .A(n71), .B(n7), .C(n370), .Y(n282) );
  NAND2X1 U141 ( .A(N29), .B(n42), .Y(n370) );
  OAI21X1 U142 ( .A(n70), .B(n7), .C(n369), .Y(n281) );
  NAND2X1 U143 ( .A(N28), .B(n42), .Y(n369) );
  OAI21X1 U144 ( .A(n69), .B(n7), .C(n368), .Y(n280) );
  NAND2X1 U145 ( .A(N27), .B(n42), .Y(n368) );
  OAI21X1 U146 ( .A(n68), .B(n7), .C(n367), .Y(n279) );
  NAND2X1 U147 ( .A(N26), .B(n42), .Y(n367) );
  OAI21X1 U148 ( .A(n67), .B(n7), .C(n366), .Y(n278) );
  NAND2X1 U149 ( .A(N25), .B(n42), .Y(n366) );
  OAI21X1 U150 ( .A(n66), .B(n7), .C(n365), .Y(n277) );
  NAND2X1 U151 ( .A(N24), .B(n42), .Y(n365) );
  OAI21X1 U152 ( .A(n65), .B(n8), .C(n364), .Y(n276) );
  NAND2X1 U153 ( .A(N23), .B(n42), .Y(n364) );
  OAI21X1 U154 ( .A(n64), .B(n8), .C(n363), .Y(n275) );
  NAND2X1 U155 ( .A(N22), .B(n42), .Y(n363) );
  OAI21X1 U156 ( .A(n63), .B(n8), .C(n362), .Y(n274) );
  NAND2X1 U157 ( .A(N21), .B(n42), .Y(n362) );
  OAI21X1 U158 ( .A(n62), .B(n8), .C(n361), .Y(n273) );
  NAND2X1 U159 ( .A(N20), .B(n42), .Y(n361) );
  OAI21X1 U160 ( .A(n61), .B(n8), .C(n360), .Y(n272) );
  NAND2X1 U161 ( .A(N19), .B(n42), .Y(n360) );
  OAI21X1 U162 ( .A(n60), .B(n8), .C(n359), .Y(n271) );
  NAND2X1 U163 ( .A(N18), .B(n42), .Y(n359) );
  OAI21X1 U164 ( .A(n59), .B(n8), .C(n358), .Y(n270) );
  NAND2X1 U165 ( .A(N17), .B(n42), .Y(n358) );
  OAI21X1 U166 ( .A(n58), .B(n8), .C(n357), .Y(n269) );
  NAND2X1 U167 ( .A(N16), .B(n42), .Y(n357) );
  OAI21X1 U168 ( .A(n57), .B(n8), .C(n356), .Y(n268) );
  NAND2X1 U169 ( .A(N15), .B(n42), .Y(n356) );
  OAI21X1 U170 ( .A(n56), .B(n8), .C(n355), .Y(n267) );
  NAND2X1 U171 ( .A(N14), .B(n42), .Y(n355) );
  OAI21X1 U172 ( .A(n55), .B(n8), .C(n354), .Y(n266) );
  NAND2X1 U173 ( .A(N13), .B(n42), .Y(n354) );
  OAI21X1 U174 ( .A(n54), .B(n8), .C(n353), .Y(n265) );
  NAND2X1 U175 ( .A(N12), .B(n42), .Y(n353) );
  OAI21X1 U176 ( .A(n53), .B(n8), .C(n352), .Y(n264) );
  NAND2X1 U177 ( .A(N11), .B(n42), .Y(n352) );
  OAI21X1 U178 ( .A(n52), .B(n7), .C(n351), .Y(n263) );
  NAND2X1 U179 ( .A(N10), .B(n42), .Y(n351) );
  OAI21X1 U180 ( .A(n51), .B(n7), .C(n350), .Y(n262) );
  NAND2X1 U181 ( .A(N9), .B(n42), .Y(n350) );
  OAI21X1 U182 ( .A(n50), .B(n8), .C(n349), .Y(n261) );
  NAND2X1 U183 ( .A(N8), .B(n42), .Y(n349) );
  OAI21X1 U184 ( .A(n49), .B(n7), .C(n348), .Y(n260) );
  NAND2X1 U185 ( .A(N7), .B(n42), .Y(n348) );
  OAI21X1 U186 ( .A(n48), .B(n8), .C(n347), .Y(n259) );
  NAND2X1 U187 ( .A(N6), .B(n42), .Y(n347) );
  OAI21X1 U188 ( .A(n47), .B(n7), .C(n346), .Y(n258) );
  NAND2X1 U189 ( .A(N5), .B(n42), .Y(n346) );
  OAI21X1 U190 ( .A(n46), .B(n8), .C(n345), .Y(n257) );
  NAND2X1 U191 ( .A(N4), .B(n42), .Y(n345) );
  OAI21X1 U193 ( .A(n343), .B(n342), .C(n256), .Y(n344) );
  NAND2X1 U194 ( .A(n341), .B(n340), .Y(n342) );
  NOR2X1 U195 ( .A(n339), .B(n338), .Y(n340) );
  NAND3X1 U196 ( .A(n337), .B(n336), .C(n335), .Y(n338) );
  NOR2X1 U197 ( .A(n334), .B(n333), .Y(n335) );
  XNOR2X1 U198 ( .A(rollover_val[30]), .B(n135), .Y(n333) );
  XNOR2X1 U199 ( .A(rollover_val[31]), .B(n255), .Y(n334) );
  XNOR2X1 U200 ( .A(count_out[27]), .B(rollover_val[27]), .Y(n336) );
  XNOR2X1 U201 ( .A(count_out[26]), .B(rollover_val[26]), .Y(n337) );
  NAND3X1 U202 ( .A(n332), .B(n331), .C(n330), .Y(n339) );
  NOR2X1 U203 ( .A(n329), .B(n328), .Y(n330) );
  XNOR2X1 U204 ( .A(rollover_val[22]), .B(n68), .Y(n328) );
  XNOR2X1 U205 ( .A(rollover_val[23]), .B(n69), .Y(n329) );
  XNOR2X1 U206 ( .A(n468), .B(rollover_val[19]), .Y(n331) );
  XNOR2X1 U207 ( .A(n469), .B(rollover_val[18]), .Y(n332) );
  NOR2X1 U208 ( .A(n327), .B(n326), .Y(n341) );
  NAND3X1 U209 ( .A(n325), .B(n324), .C(n323), .Y(n326) );
  NOR2X1 U210 ( .A(n322), .B(n321), .Y(n323) );
  XNOR2X1 U211 ( .A(rollover_val[14]), .B(n60), .Y(n321) );
  XNOR2X1 U212 ( .A(rollover_val[15]), .B(n61), .Y(n322) );
  XNOR2X1 U213 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n324) );
  XNOR2X1 U214 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n325) );
  NAND3X1 U215 ( .A(n320), .B(n319), .C(n318), .Y(n327) );
  NOR2X1 U216 ( .A(n317), .B(n316), .Y(n318) );
  XNOR2X1 U217 ( .A(rollover_val[6]), .B(n52), .Y(n316) );
  XNOR2X1 U218 ( .A(rollover_val[7]), .B(n53), .Y(n317) );
  XNOR2X1 U219 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n319) );
  XNOR2X1 U220 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n320) );
  NAND2X1 U221 ( .A(n315), .B(n314), .Y(n343) );
  NOR2X1 U222 ( .A(n313), .B(n312), .Y(n314) );
  NAND3X1 U223 ( .A(n311), .B(n310), .C(n309), .Y(n312) );
  NOR2X1 U224 ( .A(n308), .B(n307), .Y(n309) );
  XNOR2X1 U225 ( .A(rollover_val[29]), .B(n75), .Y(n307) );
  XNOR2X1 U226 ( .A(rollover_val[28]), .B(n74), .Y(n308) );
  XNOR2X1 U227 ( .A(count_out[24]), .B(rollover_val[24]), .Y(n310) );
  XNOR2X1 U228 ( .A(count_out[25]), .B(rollover_val[25]), .Y(n311) );
  NAND3X1 U229 ( .A(n306), .B(n305), .C(n304), .Y(n313) );
  NOR2X1 U230 ( .A(n303), .B(n302), .Y(n304) );
  XNOR2X1 U231 ( .A(rollover_val[21]), .B(n67), .Y(n302) );
  XNOR2X1 U232 ( .A(rollover_val[20]), .B(n66), .Y(n303) );
  XNOR2X1 U233 ( .A(n471), .B(rollover_val[16]), .Y(n305) );
  XNOR2X1 U234 ( .A(n470), .B(rollover_val[17]), .Y(n306) );
  NOR2X1 U235 ( .A(n301), .B(n300), .Y(n315) );
  NAND3X1 U236 ( .A(n299), .B(n298), .C(n297), .Y(n300) );
  NOR2X1 U237 ( .A(n296), .B(n295), .Y(n297) );
  XNOR2X1 U238 ( .A(rollover_val[13]), .B(n59), .Y(n295) );
  XNOR2X1 U239 ( .A(rollover_val[12]), .B(n58), .Y(n296) );
  XNOR2X1 U240 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n298) );
  XNOR2X1 U241 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n299) );
  NAND3X1 U242 ( .A(n294), .B(n293), .C(n292), .Y(n301) );
  NOR2X1 U243 ( .A(n291), .B(n290), .Y(n292) );
  XNOR2X1 U244 ( .A(rollover_val[5]), .B(n51), .Y(n290) );
  XNOR2X1 U245 ( .A(rollover_val[4]), .B(n50), .Y(n291) );
  XNOR2X1 U246 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n293) );
  XNOR2X1 U247 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n294) );
  NOR2X1 U248 ( .A(clear), .B(count_enable), .Y(n431) );
  flex_counter_NUM_CNT_BITS32_1_DW01_dec_0 sub_56 ( .A(rollover_val), .SUM({
        N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55, N54, 
        N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  flex_counter_NUM_CNT_BITS32_1_DW01_inc_0 add_54 ( .A({count_out[31:21], n3, 
        n468, n469, n470, n471, count_out[15:0]}), .SUM({N35, N34, N33, N32, 
        N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, N20, N19, N18, 
        N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, N5, N4}) );
  INVX2 U36 ( .A(n64), .Y(count_out[18]) );
  INVX1 U37 ( .A(n469), .Y(n64) );
  INVX2 U38 ( .A(n62), .Y(count_out[16]) );
  INVX1 U39 ( .A(n471), .Y(n62) );
  INVX2 U40 ( .A(n66), .Y(n3) );
  INVX1 U41 ( .A(count_out[20]), .Y(n66) );
  INVX2 U42 ( .A(n65), .Y(count_out[19]) );
  INVX1 U43 ( .A(n468), .Y(n65) );
  INVX2 U44 ( .A(n63), .Y(count_out[17]) );
  INVX1 U45 ( .A(n470), .Y(n63) );
  INVX2 U46 ( .A(n431), .Y(n7) );
  INVX2 U47 ( .A(n431), .Y(n8) );
  INVX2 U48 ( .A(n45), .Y(n43) );
  INVX2 U49 ( .A(n45), .Y(n44) );
  INVX2 U50 ( .A(n6), .Y(n42) );
  INVX2 U51 ( .A(n_rst), .Y(n45) );
  OR2X1 U52 ( .A(n431), .B(n344), .Y(n6) );
  INVX2 U53 ( .A(count_out[0]), .Y(n46) );
  INVX2 U54 ( .A(count_out[1]), .Y(n47) );
  INVX2 U55 ( .A(count_out[2]), .Y(n48) );
  INVX2 U56 ( .A(count_out[3]), .Y(n49) );
  INVX2 U57 ( .A(count_out[4]), .Y(n50) );
  INVX2 U58 ( .A(count_out[5]), .Y(n51) );
  INVX2 U59 ( .A(count_out[6]), .Y(n52) );
  INVX2 U60 ( .A(count_out[7]), .Y(n53) );
  INVX2 U61 ( .A(count_out[8]), .Y(n54) );
  INVX2 U62 ( .A(count_out[9]), .Y(n55) );
  INVX2 U63 ( .A(count_out[10]), .Y(n56) );
  INVX2 U64 ( .A(count_out[11]), .Y(n57) );
  INVX2 U65 ( .A(count_out[12]), .Y(n58) );
  INVX2 U66 ( .A(count_out[13]), .Y(n59) );
  INVX2 U67 ( .A(count_out[14]), .Y(n60) );
  INVX2 U68 ( .A(count_out[15]), .Y(n61) );
  INVX2 U69 ( .A(count_out[21]), .Y(n67) );
  INVX2 U192 ( .A(count_out[22]), .Y(n68) );
  INVX2 U249 ( .A(count_out[23]), .Y(n69) );
  INVX2 U250 ( .A(count_out[24]), .Y(n70) );
  INVX2 U251 ( .A(count_out[25]), .Y(n71) );
  INVX2 U252 ( .A(count_out[26]), .Y(n72) );
  INVX2 U253 ( .A(count_out[27]), .Y(n73) );
  INVX2 U254 ( .A(count_out[28]), .Y(n74) );
  INVX2 U255 ( .A(count_out[29]), .Y(n75) );
  INVX2 U256 ( .A(count_out[30]), .Y(n135) );
  INVX2 U257 ( .A(count_out[31]), .Y(n255) );
  INVX2 U258 ( .A(clear), .Y(n256) );
endmodule


module get_address_r_DW_mult_uns_0 ( a, b, product );
  input [15:0] a;
  input [31:0] b;
  output [47:0] product;
  wire   n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n119, n120, n121, n122, n123, n124, n125, n126,
         n127, n128, n129, n130, n131, n132, n133, n134, n135, n136, n137,
         n138, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n444, n445, n446, n447, n448, n449, n450, n451,
         n453, n454, n455, n456, n457, n458, n459, n460, n461, n462, n463,
         n464, n465, n466, n467, n469, n470, n471, n472, n473, n474, n475,
         n476, n477, n478, n479, n480, n481, n482, n483, n484, n485, n487,
         n488, n489, n490, n491, n492, n493, n494, n495, n496, n497, n498,
         n499, n500, n501, n502, n503, n504, n505, n507, n508, n509, n510,
         n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521,
         n522, n523, n524, n525, n526, n527, n529, n530, n531, n532, n533,
         n534, n535, n536, n537, n538, n539, n540, n541, n542, n543, n544,
         n545, n546, n547, n548, n549, n550, n551, n553, n554, n555, n556,
         n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n579,
         n580, n581, n582, n583, n584, n585, n586, n587, n588, n589, n590,
         n591, n592, n593, n594, n595, n596, n597, n598, n599, n600, n601,
         n602, n603, n604, n605, n607, n608, n609, n610, n611, n612, n613,
         n614, n615, n616, n617, n618, n619, n620, n621, n622, n623, n624,
         n625, n626, n627, n628, n629, n630, n631, n632, n633, n634, n635,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n1028, n1029, n1030,
         n1031, n1032, n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040,
         n1041, n1042, n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050,
         n1051, n1052, n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060,
         n1061, n1062, n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070,
         n1071, n1072, n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080,
         n1081, n1082, n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090,
         n1091, n1092, n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100,
         n1101, n1102, n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110,
         n1111, n1112, n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1120,
         n1121, n1122, n1123, n1124, n1125, n1126, n1127, n1128, n1129, n1130,
         n1131, n1132, n1133, n1134, n1135, n1136, n1137, n1138, n1139, n1140,
         n1141, n1142, n1143, n1144, n1145, n1146, n1147, n1148, n1149, n1150,
         n1151, n1152, n1153, n1154, n1155, n1156, n1157, n1158, n1159, n1160,
         n1161, n1162, n1163, n1164, n1165, n1166, n1167, n1168, n1169, n1170,
         n1171, n1172, n1173, n1174, n1175, n1176, n1177, n1178, n1179, n1180,
         n1181, n1182, n1183, n1184, n1185, n1186, n1187, n1188, n1189, n1190,
         n1191, n1192, n1193, n1194, n1195, n1196, n1197, n1198, n1199, n1200,
         n1201, n1202, n1203, n1204, n1205, n1206, n1207, n1208, n1209, n1210,
         n1211, n1212, n1213, n1214, n1215, n1216, n1217, n1218, n1219, n1220,
         n1221, n1222, n1223, n1224, n1225, n1226, n1227, n1228, n1229, n1230,
         n1231, n1232, n1233, n1234, n1235, n1236, n1237, n1238, n1239, n1240,
         n1241, n1242, n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250,
         n1251, n1252, n1253, n1254, n1255, n1256, n1257, n1258, n1259, n1260,
         n1261, n1262, n1263, n1264, n1265, n1266, n1267, n1268, n1269, n1270,
         n1271, n1272, n1273, n1274, n1275, n1276, n1277, n1278, n1279, n1280,
         n1281, n1282, n1283, n1284, n1285, n1286, n1287, n1288, n1289, n1290,
         n1291, n1292, n1293, n1294, n1295, n1296, n1297, n1298, n1299, n1300,
         n1301, n1302, n1303, n1304, n1305, n1306, n1307, n1308, n1309, n1310,
         n1311, n1312, n1313, n1314, n1315, n1316, n1317, n1318, n1319, n1320,
         n1321, n1322, n1323, n1324, n1325, n1326, n1327, n1328, n1329, n1330,
         n1331, n1332, n1333, n1334, n1335, n1336, n1337, n1338, n1339, n1340,
         n1341, n1342, n1343, n1344, n1345, n1346, n1347, n1348, n1349, n1350,
         n1351, n1352, n1353, n1354, n1355, n1356;

  FAX1 U68 ( .A(n133), .B(n120), .C(n76), .YC(n75), .YS(product[30]) );
  FAX1 U69 ( .A(n147), .B(n134), .C(n77), .YC(n76), .YS(product[29]) );
  FAX1 U70 ( .A(n161), .B(n148), .C(n78), .YC(n77), .YS(product[28]) );
  FAX1 U71 ( .A(n175), .B(n162), .C(n79), .YC(n78), .YS(product[27]) );
  FAX1 U72 ( .A(n189), .B(n176), .C(n80), .YC(n79), .YS(product[26]) );
  FAX1 U73 ( .A(n203), .B(n190), .C(n81), .YC(n80), .YS(product[25]) );
  FAX1 U74 ( .A(n217), .B(n204), .C(n82), .YC(n81), .YS(product[24]) );
  FAX1 U75 ( .A(n231), .B(n218), .C(n83), .YC(n82), .YS(product[23]) );
  FAX1 U76 ( .A(n245), .B(n232), .C(n84), .YC(n83), .YS(product[22]) );
  FAX1 U77 ( .A(n259), .B(n246), .C(n85), .YC(n84), .YS(product[21]) );
  FAX1 U78 ( .A(n273), .B(n260), .C(n86), .YC(n85), .YS(product[20]) );
  FAX1 U79 ( .A(n287), .B(n274), .C(n87), .YC(n86), .YS(product[19]) );
  FAX1 U80 ( .A(n301), .B(n288), .C(n88), .YC(n87), .YS(product[18]) );
  FAX1 U81 ( .A(n315), .B(n302), .C(n89), .YC(n88), .YS(product[17]) );
  FAX1 U82 ( .A(n329), .B(n316), .C(n90), .YC(n89), .YS(product[16]) );
  FAX1 U83 ( .A(n343), .B(n330), .C(n91), .YC(n90), .YS(product[15]) );
  FAX1 U84 ( .A(n355), .B(n344), .C(n92), .YC(n91), .YS(product[14]) );
  FAX1 U85 ( .A(n367), .B(n356), .C(n93), .YC(n92), .YS(product[13]) );
  FAX1 U86 ( .A(n377), .B(n368), .C(n94), .YC(n93), .YS(product[12]) );
  FAX1 U87 ( .A(n387), .B(n378), .C(n95), .YC(n94), .YS(product[11]) );
  FAX1 U88 ( .A(n395), .B(n388), .C(n96), .YC(n95), .YS(product[10]) );
  FAX1 U89 ( .A(n403), .B(n396), .C(n97), .YC(n96), .YS(product[9]) );
  FAX1 U90 ( .A(n409), .B(n404), .C(n98), .YC(n97), .YS(product[8]) );
  FAX1 U91 ( .A(n415), .B(n410), .C(n99), .YC(n98), .YS(product[7]) );
  FAX1 U92 ( .A(n419), .B(n416), .C(n100), .YC(n99), .YS(product[6]) );
  FAX1 U93 ( .A(n423), .B(n420), .C(n101), .YC(n100), .YS(product[5]) );
  FAX1 U94 ( .A(n425), .B(n424), .C(n102), .YC(n101), .YS(product[4]) );
  FAX1 U95 ( .A(n450), .B(n426), .C(n103), .YC(n102), .YS(product[3]) );
  FAX1 U96 ( .A(n665), .B(n635), .C(n104), .YC(n103), .YS(product[2]) );
  HAX1 U97 ( .A(n451), .B(n666), .YC(n104), .YS(product[1]) );
  FAX1 U112 ( .A(n124), .B(n135), .C(n122), .YC(n119), .YS(n120) );
  FAX1 U113 ( .A(n139), .B(n137), .C(n126), .YC(n121), .YS(n122) );
  FAX1 U114 ( .A(n141), .B(n132), .C(n128), .YC(n123), .YS(n124) );
  FAX1 U115 ( .A(n145), .B(n143), .C(n130), .YC(n125), .YS(n126) );
  FAX1 U116 ( .A(n553), .B(n507), .C(n529), .YC(n127), .YS(n128) );
  FAX1 U117 ( .A(n579), .B(n469), .C(n487), .YC(n129), .YS(n130) );
  FAX1 U118 ( .A(n453), .B(n637), .C(n607), .YC(n131), .YS(n132) );
  FAX1 U119 ( .A(n138), .B(n149), .C(n136), .YC(n133), .YS(n134) );
  FAX1 U120 ( .A(n153), .B(n151), .C(n140), .YC(n135), .YS(n136) );
  FAX1 U121 ( .A(n155), .B(n146), .C(n142), .YC(n137), .YS(n138) );
  FAX1 U122 ( .A(n159), .B(n157), .C(n144), .YC(n139), .YS(n140) );
  FAX1 U123 ( .A(n554), .B(n508), .C(n530), .YC(n141), .YS(n142) );
  FAX1 U124 ( .A(n580), .B(n470), .C(n488), .YC(n143), .YS(n144) );
  FAX1 U125 ( .A(n454), .B(n638), .C(n608), .YC(n145), .YS(n146) );
  FAX1 U126 ( .A(n152), .B(n163), .C(n150), .YC(n147), .YS(n148) );
  FAX1 U127 ( .A(n167), .B(n165), .C(n154), .YC(n149), .YS(n150) );
  FAX1 U128 ( .A(n169), .B(n160), .C(n156), .YC(n151), .YS(n152) );
  FAX1 U129 ( .A(n173), .B(n171), .C(n158), .YC(n153), .YS(n154) );
  FAX1 U130 ( .A(n555), .B(n509), .C(n531), .YC(n155), .YS(n156) );
  FAX1 U131 ( .A(n581), .B(n471), .C(n489), .YC(n157), .YS(n158) );
  FAX1 U132 ( .A(n455), .B(n639), .C(n609), .YC(n159), .YS(n160) );
  FAX1 U133 ( .A(n166), .B(n177), .C(n164), .YC(n161), .YS(n162) );
  FAX1 U134 ( .A(n181), .B(n179), .C(n168), .YC(n163), .YS(n164) );
  FAX1 U135 ( .A(n183), .B(n174), .C(n170), .YC(n165), .YS(n166) );
  FAX1 U136 ( .A(n187), .B(n185), .C(n172), .YC(n167), .YS(n168) );
  FAX1 U137 ( .A(n556), .B(n510), .C(n532), .YC(n169), .YS(n170) );
  FAX1 U138 ( .A(n582), .B(n472), .C(n490), .YC(n171), .YS(n172) );
  FAX1 U139 ( .A(n456), .B(n640), .C(n610), .YC(n173), .YS(n174) );
  FAX1 U140 ( .A(n180), .B(n191), .C(n178), .YC(n175), .YS(n176) );
  FAX1 U141 ( .A(n195), .B(n193), .C(n182), .YC(n177), .YS(n178) );
  FAX1 U142 ( .A(n197), .B(n188), .C(n184), .YC(n179), .YS(n180) );
  FAX1 U143 ( .A(n201), .B(n199), .C(n186), .YC(n181), .YS(n182) );
  FAX1 U144 ( .A(n557), .B(n511), .C(n533), .YC(n183), .YS(n184) );
  FAX1 U145 ( .A(n583), .B(n473), .C(n491), .YC(n185), .YS(n186) );
  FAX1 U146 ( .A(n457), .B(n641), .C(n611), .YC(n187), .YS(n188) );
  FAX1 U147 ( .A(n194), .B(n205), .C(n192), .YC(n189), .YS(n190) );
  FAX1 U148 ( .A(n209), .B(n207), .C(n196), .YC(n191), .YS(n192) );
  FAX1 U149 ( .A(n211), .B(n202), .C(n198), .YC(n193), .YS(n194) );
  FAX1 U150 ( .A(n215), .B(n213), .C(n200), .YC(n195), .YS(n196) );
  FAX1 U151 ( .A(n558), .B(n512), .C(n534), .YC(n197), .YS(n198) );
  FAX1 U152 ( .A(n584), .B(n474), .C(n492), .YC(n199), .YS(n200) );
  FAX1 U153 ( .A(n458), .B(n642), .C(n612), .YC(n201), .YS(n202) );
  FAX1 U154 ( .A(n208), .B(n219), .C(n206), .YC(n203), .YS(n204) );
  FAX1 U155 ( .A(n223), .B(n221), .C(n210), .YC(n205), .YS(n206) );
  FAX1 U156 ( .A(n225), .B(n216), .C(n212), .YC(n207), .YS(n208) );
  FAX1 U157 ( .A(n229), .B(n227), .C(n214), .YC(n209), .YS(n210) );
  FAX1 U158 ( .A(n559), .B(n513), .C(n535), .YC(n211), .YS(n212) );
  FAX1 U159 ( .A(n585), .B(n475), .C(n493), .YC(n213), .YS(n214) );
  FAX1 U160 ( .A(n459), .B(n643), .C(n613), .YC(n215), .YS(n216) );
  FAX1 U161 ( .A(n222), .B(n233), .C(n220), .YC(n217), .YS(n218) );
  FAX1 U162 ( .A(n237), .B(n235), .C(n224), .YC(n219), .YS(n220) );
  FAX1 U163 ( .A(n239), .B(n230), .C(n226), .YC(n221), .YS(n222) );
  FAX1 U164 ( .A(n243), .B(n241), .C(n228), .YC(n223), .YS(n224) );
  FAX1 U165 ( .A(n560), .B(n514), .C(n536), .YC(n225), .YS(n226) );
  FAX1 U166 ( .A(n586), .B(n476), .C(n494), .YC(n227), .YS(n228) );
  FAX1 U167 ( .A(n460), .B(n644), .C(n614), .YC(n229), .YS(n230) );
  FAX1 U168 ( .A(n236), .B(n247), .C(n234), .YC(n231), .YS(n232) );
  FAX1 U169 ( .A(n251), .B(n249), .C(n238), .YC(n233), .YS(n234) );
  FAX1 U170 ( .A(n253), .B(n244), .C(n240), .YC(n235), .YS(n236) );
  FAX1 U171 ( .A(n257), .B(n255), .C(n242), .YC(n237), .YS(n238) );
  FAX1 U172 ( .A(n561), .B(n515), .C(n537), .YC(n239), .YS(n240) );
  FAX1 U173 ( .A(n587), .B(n477), .C(n495), .YC(n241), .YS(n242) );
  FAX1 U174 ( .A(n461), .B(n645), .C(n615), .YC(n243), .YS(n244) );
  FAX1 U175 ( .A(n250), .B(n261), .C(n248), .YC(n245), .YS(n246) );
  FAX1 U176 ( .A(n265), .B(n263), .C(n252), .YC(n247), .YS(n248) );
  FAX1 U177 ( .A(n267), .B(n258), .C(n254), .YC(n249), .YS(n250) );
  FAX1 U178 ( .A(n271), .B(n269), .C(n256), .YC(n251), .YS(n252) );
  FAX1 U179 ( .A(n562), .B(n516), .C(n538), .YC(n253), .YS(n254) );
  FAX1 U180 ( .A(n588), .B(n478), .C(n496), .YC(n255), .YS(n256) );
  FAX1 U181 ( .A(n462), .B(n646), .C(n616), .YC(n257), .YS(n258) );
  FAX1 U182 ( .A(n264), .B(n275), .C(n262), .YC(n259), .YS(n260) );
  FAX1 U183 ( .A(n279), .B(n277), .C(n266), .YC(n261), .YS(n262) );
  FAX1 U184 ( .A(n281), .B(n272), .C(n268), .YC(n263), .YS(n264) );
  FAX1 U185 ( .A(n285), .B(n283), .C(n270), .YC(n265), .YS(n266) );
  FAX1 U186 ( .A(n563), .B(n517), .C(n539), .YC(n267), .YS(n268) );
  FAX1 U187 ( .A(n589), .B(n479), .C(n497), .YC(n269), .YS(n270) );
  FAX1 U188 ( .A(n463), .B(n647), .C(n617), .YC(n271), .YS(n272) );
  FAX1 U189 ( .A(n278), .B(n289), .C(n276), .YC(n273), .YS(n274) );
  FAX1 U190 ( .A(n293), .B(n291), .C(n280), .YC(n275), .YS(n276) );
  FAX1 U191 ( .A(n295), .B(n286), .C(n282), .YC(n277), .YS(n278) );
  FAX1 U192 ( .A(n299), .B(n297), .C(n284), .YC(n279), .YS(n280) );
  FAX1 U193 ( .A(n564), .B(n518), .C(n540), .YC(n281), .YS(n282) );
  FAX1 U194 ( .A(n590), .B(n480), .C(n498), .YC(n283), .YS(n284) );
  FAX1 U195 ( .A(n464), .B(n648), .C(n618), .YC(n285), .YS(n286) );
  FAX1 U196 ( .A(n292), .B(n303), .C(n290), .YC(n287), .YS(n288) );
  FAX1 U197 ( .A(n307), .B(n305), .C(n294), .YC(n289), .YS(n290) );
  FAX1 U198 ( .A(n309), .B(n300), .C(n296), .YC(n291), .YS(n292) );
  FAX1 U199 ( .A(n313), .B(n311), .C(n298), .YC(n293), .YS(n294) );
  FAX1 U200 ( .A(n565), .B(n519), .C(n541), .YC(n295), .YS(n296) );
  FAX1 U201 ( .A(n591), .B(n481), .C(n499), .YC(n297), .YS(n298) );
  FAX1 U202 ( .A(n465), .B(n649), .C(n619), .YC(n299), .YS(n300) );
  FAX1 U203 ( .A(n306), .B(n317), .C(n304), .YC(n301), .YS(n302) );
  FAX1 U204 ( .A(n321), .B(n308), .C(n319), .YC(n303), .YS(n304) );
  FAX1 U205 ( .A(n323), .B(n314), .C(n310), .YC(n305), .YS(n306) );
  FAX1 U206 ( .A(n327), .B(n325), .C(n312), .YC(n307), .YS(n308) );
  FAX1 U207 ( .A(n566), .B(n520), .C(n542), .YC(n309), .YS(n310) );
  FAX1 U208 ( .A(n592), .B(n482), .C(n500), .YC(n311), .YS(n312) );
  FAX1 U209 ( .A(n466), .B(n650), .C(n620), .YC(n313), .YS(n314) );
  FAX1 U210 ( .A(n320), .B(n331), .C(n318), .YC(n315), .YS(n316) );
  FAX1 U211 ( .A(n335), .B(n322), .C(n333), .YC(n317), .YS(n318) );
  FAX1 U212 ( .A(n328), .B(n324), .C(n326), .YC(n319), .YS(n320) );
  FAX1 U213 ( .A(n341), .B(n339), .C(n337), .YC(n321), .YS(n322) );
  FAX1 U214 ( .A(n567), .B(n521), .C(n543), .YC(n323), .YS(n324) );
  FAX1 U215 ( .A(n593), .B(n483), .C(n501), .YC(n325), .YS(n326) );
  FAX1 U216 ( .A(n467), .B(n651), .C(n621), .YC(n327), .YS(n328) );
  FAX1 U217 ( .A(n334), .B(n345), .C(n332), .YC(n329), .YS(n330) );
  FAX1 U218 ( .A(n349), .B(n336), .C(n347), .YC(n331), .YS(n332) );
  FAX1 U219 ( .A(n351), .B(n338), .C(n340), .YC(n333), .YS(n334) );
  FAX1 U220 ( .A(n594), .B(n342), .C(n353), .YC(n335), .YS(n336) );
  FAX1 U221 ( .A(n622), .B(n522), .C(n568), .YC(n337), .YS(n338) );
  FAX1 U222 ( .A(n544), .B(n484), .C(n502), .YC(n339), .YS(n340) );
  HAX1 U223 ( .A(n652), .B(n444), .YC(n341), .YS(n342) );
  FAX1 U224 ( .A(n348), .B(n357), .C(n346), .YC(n343), .YS(n344) );
  FAX1 U225 ( .A(n354), .B(n350), .C(n359), .YC(n345), .YS(n346) );
  FAX1 U226 ( .A(n363), .B(n361), .C(n352), .YC(n347), .YS(n348) );
  FAX1 U227 ( .A(n595), .B(n569), .C(n365), .YC(n349), .YS(n350) );
  FAX1 U228 ( .A(n623), .B(n523), .C(n545), .YC(n351), .YS(n352) );
  FAX1 U229 ( .A(n653), .B(n503), .C(n485), .YC(n353), .YS(n354) );
  FAX1 U230 ( .A(n360), .B(n369), .C(n358), .YC(n355), .YS(n356) );
  FAX1 U231 ( .A(n362), .B(n364), .C(n371), .YC(n357), .YS(n358) );
  FAX1 U232 ( .A(n366), .B(n375), .C(n373), .YC(n359), .YS(n360) );
  FAX1 U233 ( .A(n570), .B(n504), .C(n524), .YC(n361), .YS(n362) );
  FAX1 U234 ( .A(n546), .B(n624), .C(n596), .YC(n363), .YS(n364) );
  HAX1 U235 ( .A(n654), .B(n445), .YC(n365), .YS(n366) );
  FAX1 U236 ( .A(n372), .B(n379), .C(n370), .YC(n367), .YS(n368) );
  FAX1 U237 ( .A(n376), .B(n374), .C(n381), .YC(n369), .YS(n370) );
  FAX1 U238 ( .A(n597), .B(n385), .C(n383), .YC(n371), .YS(n372) );
  FAX1 U239 ( .A(n625), .B(n547), .C(n571), .YC(n373), .YS(n374) );
  FAX1 U240 ( .A(n655), .B(n525), .C(n505), .YC(n375), .YS(n376) );
  FAX1 U241 ( .A(n382), .B(n389), .C(n380), .YC(n377), .YS(n378) );
  FAX1 U242 ( .A(n393), .B(n391), .C(n384), .YC(n379), .YS(n380) );
  FAX1 U243 ( .A(n598), .B(n548), .C(n386), .YC(n381), .YS(n382) );
  FAX1 U244 ( .A(n572), .B(n526), .C(n626), .YC(n383), .YS(n384) );
  HAX1 U245 ( .A(n656), .B(n446), .YC(n385), .YS(n386) );
  FAX1 U246 ( .A(n392), .B(n397), .C(n390), .YC(n387), .YS(n388) );
  FAX1 U247 ( .A(n401), .B(n399), .C(n394), .YC(n389), .YS(n390) );
  FAX1 U248 ( .A(n627), .B(n573), .C(n599), .YC(n391), .YS(n392) );
  FAX1 U249 ( .A(n657), .B(n549), .C(n527), .YC(n393), .YS(n394) );
  FAX1 U250 ( .A(n400), .B(n405), .C(n398), .YC(n395), .YS(n396) );
  FAX1 U251 ( .A(n628), .B(n402), .C(n407), .YC(n397), .YS(n398) );
  FAX1 U252 ( .A(n574), .B(n550), .C(n600), .YC(n399), .YS(n400) );
  HAX1 U253 ( .A(n658), .B(n447), .YC(n401), .YS(n402) );
  FAX1 U254 ( .A(n411), .B(n408), .C(n406), .YC(n403), .YS(n404) );
  FAX1 U255 ( .A(n629), .B(n601), .C(n413), .YC(n405), .YS(n406) );
  FAX1 U256 ( .A(n659), .B(n575), .C(n551), .YC(n407), .YS(n408) );
  FAX1 U257 ( .A(n414), .B(n417), .C(n412), .YC(n409), .YS(n410) );
  FAX1 U258 ( .A(n630), .B(n576), .C(n602), .YC(n411), .YS(n412) );
  HAX1 U259 ( .A(n660), .B(n448), .YC(n413), .YS(n414) );
  FAX1 U260 ( .A(n631), .B(n421), .C(n418), .YC(n415), .YS(n416) );
  FAX1 U261 ( .A(n661), .B(n603), .C(n577), .YC(n417), .YS(n418) );
  FAX1 U262 ( .A(n632), .B(n604), .C(n422), .YC(n419), .YS(n420) );
  HAX1 U263 ( .A(n662), .B(n449), .YC(n421), .YS(n422) );
  FAX1 U264 ( .A(n663), .B(n633), .C(n605), .YC(n423), .YS(n424) );
  HAX1 U265 ( .A(n664), .B(n634), .YC(n425), .YS(n426) );
  AND2X2 U794 ( .A(a[1]), .B(n1086), .Y(n1028) );
  INVX1 U795 ( .A(a[3]), .Y(n1111) );
  INVX1 U796 ( .A(a[1]), .Y(n1112) );
  INVX2 U797 ( .A(n1029), .Y(n1039) );
  INVX2 U798 ( .A(n1102), .Y(n1105) );
  INVX2 U799 ( .A(n1094), .Y(n1097) );
  INVX2 U800 ( .A(n1095), .Y(n1096) );
  INVX2 U801 ( .A(n1099), .Y(n1100) );
  INVX2 U802 ( .A(n1098), .Y(n1101) );
  AND2X2 U803 ( .A(n1108), .B(n1356), .Y(n1029) );
  INVX2 U804 ( .A(n1337), .Y(n1080) );
  INVX2 U805 ( .A(n1340), .Y(n1076) );
  INVX2 U806 ( .A(n1337), .Y(n1081) );
  INVX2 U807 ( .A(n1343), .Y(n1075) );
  INVX2 U808 ( .A(n1346), .Y(n1072) );
  INVX2 U809 ( .A(n1103), .Y(n1106) );
  INVX2 U810 ( .A(n1349), .Y(n1110) );
  INVX2 U811 ( .A(n1084), .Y(n1083) );
  INVX2 U812 ( .A(n1084), .Y(n1082) );
  INVX2 U813 ( .A(n1079), .Y(n1077) );
  INVX2 U814 ( .A(n1079), .Y(n1078) );
  INVX2 U815 ( .A(n1352), .Y(n1109) );
  INVX2 U816 ( .A(a[7]), .Y(n1073) );
  INVX2 U817 ( .A(a[9]), .Y(n1070) );
  INVX2 U818 ( .A(a[7]), .Y(n1074) );
  INVX2 U819 ( .A(n1355), .Y(n1108) );
  INVX2 U820 ( .A(a[9]), .Y(n1071) );
  INVX2 U821 ( .A(n1028), .Y(n1092) );
  INVX2 U822 ( .A(n1028), .Y(n1093) );
  BUFX2 U823 ( .A(a[15]), .Y(n1102) );
  BUFX2 U824 ( .A(a[5]), .Y(n1094) );
  BUFX2 U825 ( .A(a[11]), .Y(n1098) );
  BUFX2 U826 ( .A(a[15]), .Y(n1103) );
  BUFX2 U827 ( .A(a[15]), .Y(n1104) );
  BUFX2 U828 ( .A(a[5]), .Y(n1095) );
  BUFX2 U829 ( .A(a[11]), .Y(n1099) );
  INVX2 U830 ( .A(a[0]), .Y(n1085) );
  INVX2 U831 ( .A(n1030), .Y(n1087) );
  INVX2 U832 ( .A(n1031), .Y(n1089) );
  INVX2 U833 ( .A(n1032), .Y(n1090) );
  INVX2 U834 ( .A(n1035), .Y(n1088) );
  INVX2 U835 ( .A(n1033), .Y(n1037) );
  INVX2 U836 ( .A(a[0]), .Y(n1086) );
  INVX2 U837 ( .A(n1034), .Y(n1038) );
  INVX2 U838 ( .A(n1040), .Y(n1041) );
  INVX2 U839 ( .A(n1048), .Y(n1049) );
  INVX2 U840 ( .A(n1056), .Y(n1057) );
  INVX2 U841 ( .A(n1064), .Y(n1065) );
  INVX2 U842 ( .A(n1046), .Y(n1047) );
  INVX2 U843 ( .A(n1050), .Y(n1051) );
  INVX2 U844 ( .A(n1052), .Y(n1053) );
  INVX2 U845 ( .A(n1062), .Y(n1063) );
  INVX2 U846 ( .A(n1066), .Y(n1067) );
  INVX2 U847 ( .A(n1068), .Y(n1069) );
  INVX2 U848 ( .A(n1032), .Y(n1091) );
  INVX4 U849 ( .A(a[13]), .Y(n1036) );
  INVX2 U850 ( .A(n1112), .Y(n1084) );
  INVX2 U851 ( .A(n1111), .Y(n1079) );
  INVX2 U852 ( .A(b[0]), .Y(n1107) );
  INVX2 U853 ( .A(b[1]), .Y(n1040) );
  INVX2 U854 ( .A(b[5]), .Y(n1048) );
  INVX2 U855 ( .A(b[9]), .Y(n1056) );
  INVX2 U856 ( .A(b[13]), .Y(n1064) );
  INVX2 U857 ( .A(b[4]), .Y(n1046) );
  INVX2 U858 ( .A(b[6]), .Y(n1050) );
  INVX2 U859 ( .A(b[7]), .Y(n1052) );
  INVX2 U860 ( .A(b[12]), .Y(n1062) );
  INVX2 U861 ( .A(b[14]), .Y(n1066) );
  INVX2 U862 ( .A(b[15]), .Y(n1068) );
  AND2X2 U863 ( .A(n1076), .B(n1341), .Y(n1030) );
  AND2X2 U864 ( .A(n1075), .B(n1344), .Y(n1031) );
  AND2X2 U865 ( .A(n1080), .B(n1338), .Y(n1032) );
  INVX2 U866 ( .A(n1042), .Y(n1043) );
  INVX2 U867 ( .A(b[2]), .Y(n1042) );
  INVX2 U868 ( .A(n1044), .Y(n1045) );
  INVX2 U869 ( .A(b[3]), .Y(n1044) );
  INVX2 U870 ( .A(n1054), .Y(n1055) );
  INVX2 U871 ( .A(b[8]), .Y(n1054) );
  INVX2 U872 ( .A(n1058), .Y(n1059) );
  INVX2 U873 ( .A(b[10]), .Y(n1058) );
  INVX2 U874 ( .A(n1060), .Y(n1061) );
  INVX2 U875 ( .A(b[11]), .Y(n1060) );
  AND2X2 U876 ( .A(n1110), .B(n1350), .Y(n1033) );
  AND2X2 U877 ( .A(n1109), .B(n1353), .Y(n1034) );
  AND2X2 U878 ( .A(n1072), .B(n1347), .Y(n1035) );
  XOR2X1 U879 ( .A(n1113), .B(n1114), .Y(product[31]) );
  XOR2X1 U880 ( .A(n1115), .B(n1116), .Y(n1114) );
  XNOR2X1 U881 ( .A(n127), .B(n125), .Y(n1116) );
  XOR2X1 U882 ( .A(n1117), .B(n1118), .Y(n1115) );
  XOR2X1 U883 ( .A(n1119), .B(n1120), .Y(n1118) );
  XOR2X1 U884 ( .A(n1121), .B(n119), .Y(n1120) );
  NAND2X1 U885 ( .A(n1069), .B(n1103), .Y(n1121) );
  XNOR2X1 U886 ( .A(n123), .B(n121), .Y(n1119) );
  XOR2X1 U887 ( .A(n1122), .B(n1123), .Y(n1117) );
  XOR2X1 U888 ( .A(n1124), .B(n1125), .Y(n1123) );
  OAI22X1 U889 ( .A(n1108), .B(n1126), .C(n1127), .D(n1039), .Y(n1125) );
  XOR2X1 U890 ( .A(b[17]), .B(n1105), .Y(n1126) );
  OAI22X1 U891 ( .A(n1110), .B(n1128), .C(n1129), .D(n1037), .Y(n1124) );
  XOR2X1 U892 ( .A(b[21]), .B(n1100), .Y(n1128) );
  XNOR2X1 U893 ( .A(n1130), .B(n1131), .Y(n1122) );
  OAI22X1 U894 ( .A(n1087), .B(n1132), .C(n1133), .D(n1076), .Y(n1131) );
  XOR2X1 U895 ( .A(b[27]), .B(n1096), .Y(n1133) );
  XOR2X1 U896 ( .A(n1134), .B(n1135), .Y(n1130) );
  XNOR2X1 U897 ( .A(n1136), .B(n1137), .Y(n1135) );
  XOR2X1 U898 ( .A(n1138), .B(n1139), .Y(n1137) );
  OAI22X1 U899 ( .A(n1072), .B(n1140), .C(n1141), .D(n1088), .Y(n1139) );
  XOR2X1 U900 ( .A(b[23]), .B(n1070), .Y(n1140) );
  OAI22X1 U901 ( .A(n1075), .B(n1142), .C(n1143), .D(n1089), .Y(n1138) );
  XOR2X1 U902 ( .A(b[25]), .B(n1073), .Y(n1142) );
  OAI22X1 U903 ( .A(n1038), .B(n1144), .C(n1145), .D(n1109), .Y(n1136) );
  XOR2X1 U904 ( .A(b[19]), .B(n1036), .Y(n1145) );
  XNOR2X1 U905 ( .A(n1146), .B(n1147), .Y(n1134) );
  OAI22X1 U906 ( .A(n1091), .B(n1148), .C(n1149), .D(n1080), .Y(n1147) );
  XOR2X1 U907 ( .A(b[29]), .B(n1077), .Y(n1149) );
  OAI22X1 U908 ( .A(n1150), .B(n1085), .C(n1151), .D(n1092), .Y(n1146) );
  XOR2X1 U909 ( .A(n1112), .B(b[31]), .Y(n1150) );
  XOR2X1 U910 ( .A(n129), .B(n1152), .Y(n1113) );
  XOR2X1 U911 ( .A(n75), .B(n131), .Y(n1152) );
  NOR2X1 U912 ( .A(n1086), .B(n1107), .Y(product[0]) );
  OAI22X1 U913 ( .A(n1153), .B(n1086), .C(b[0]), .D(n1092), .Y(n666) );
  OAI22X1 U914 ( .A(n1154), .B(n1086), .C(n1153), .D(n1092), .Y(n665) );
  XOR2X1 U915 ( .A(n1041), .B(n1112), .Y(n1153) );
  OAI22X1 U916 ( .A(n1155), .B(n1086), .C(n1154), .D(n1092), .Y(n664) );
  XOR2X1 U917 ( .A(n1043), .B(n1112), .Y(n1154) );
  OAI22X1 U918 ( .A(n1156), .B(n1086), .C(n1155), .D(n1092), .Y(n663) );
  XOR2X1 U919 ( .A(n1045), .B(n1112), .Y(n1155) );
  OAI22X1 U920 ( .A(n1157), .B(n1086), .C(n1156), .D(n1092), .Y(n662) );
  XOR2X1 U921 ( .A(n1047), .B(n1083), .Y(n1156) );
  OAI22X1 U922 ( .A(n1158), .B(n1086), .C(n1157), .D(n1092), .Y(n661) );
  XOR2X1 U923 ( .A(n1049), .B(n1083), .Y(n1157) );
  OAI22X1 U924 ( .A(n1159), .B(n1086), .C(n1158), .D(n1092), .Y(n660) );
  XOR2X1 U925 ( .A(n1051), .B(n1083), .Y(n1158) );
  OAI22X1 U926 ( .A(n1160), .B(n1086), .C(n1159), .D(n1092), .Y(n659) );
  XOR2X1 U927 ( .A(n1053), .B(n1083), .Y(n1159) );
  OAI22X1 U928 ( .A(n1161), .B(n1086), .C(n1160), .D(n1092), .Y(n658) );
  XOR2X1 U929 ( .A(n1055), .B(n1083), .Y(n1160) );
  OAI22X1 U930 ( .A(n1162), .B(n1086), .C(n1161), .D(n1092), .Y(n657) );
  XOR2X1 U931 ( .A(n1057), .B(n1083), .Y(n1161) );
  OAI22X1 U932 ( .A(n1163), .B(n1086), .C(n1162), .D(n1092), .Y(n656) );
  XOR2X1 U933 ( .A(n1059), .B(n1083), .Y(n1162) );
  OAI22X1 U934 ( .A(n1164), .B(n1085), .C(n1163), .D(n1093), .Y(n655) );
  XOR2X1 U935 ( .A(n1061), .B(n1083), .Y(n1163) );
  OAI22X1 U936 ( .A(n1165), .B(n1086), .C(n1164), .D(n1093), .Y(n654) );
  XOR2X1 U937 ( .A(n1063), .B(n1083), .Y(n1164) );
  OAI22X1 U938 ( .A(n1166), .B(n1085), .C(n1165), .D(n1093), .Y(n653) );
  XOR2X1 U939 ( .A(n1065), .B(n1083), .Y(n1165) );
  OAI22X1 U940 ( .A(n1167), .B(n1085), .C(n1166), .D(n1093), .Y(n652) );
  XOR2X1 U941 ( .A(n1067), .B(n1083), .Y(n1166) );
  OAI22X1 U942 ( .A(n1168), .B(n1086), .C(n1167), .D(n1093), .Y(n651) );
  XOR2X1 U943 ( .A(n1069), .B(n1083), .Y(n1167) );
  OAI22X1 U944 ( .A(n1169), .B(n1085), .C(n1168), .D(n1093), .Y(n650) );
  XOR2X1 U945 ( .A(b[16]), .B(n1082), .Y(n1168) );
  OAI22X1 U946 ( .A(n1170), .B(n1086), .C(n1169), .D(n1093), .Y(n649) );
  XOR2X1 U947 ( .A(b[17]), .B(n1082), .Y(n1169) );
  OAI22X1 U948 ( .A(n1171), .B(n1085), .C(n1170), .D(n1093), .Y(n648) );
  XOR2X1 U949 ( .A(b[18]), .B(n1082), .Y(n1170) );
  OAI22X1 U950 ( .A(n1172), .B(n1085), .C(n1171), .D(n1093), .Y(n647) );
  XOR2X1 U951 ( .A(b[19]), .B(n1082), .Y(n1171) );
  OAI22X1 U952 ( .A(n1173), .B(n1085), .C(n1172), .D(n1093), .Y(n646) );
  XOR2X1 U953 ( .A(b[20]), .B(n1082), .Y(n1172) );
  OAI22X1 U954 ( .A(n1174), .B(n1085), .C(n1173), .D(n1093), .Y(n645) );
  XOR2X1 U955 ( .A(b[21]), .B(n1082), .Y(n1173) );
  OAI22X1 U956 ( .A(n1175), .B(n1086), .C(n1174), .D(n1093), .Y(n644) );
  XOR2X1 U957 ( .A(b[22]), .B(n1082), .Y(n1174) );
  OAI22X1 U958 ( .A(n1176), .B(n1085), .C(n1175), .D(n1092), .Y(n643) );
  XOR2X1 U959 ( .A(b[23]), .B(n1083), .Y(n1175) );
  OAI22X1 U960 ( .A(n1177), .B(n1085), .C(n1176), .D(n1093), .Y(n642) );
  XOR2X1 U961 ( .A(b[24]), .B(n1082), .Y(n1176) );
  OAI22X1 U962 ( .A(n1178), .B(n1085), .C(n1177), .D(n1092), .Y(n641) );
  XOR2X1 U963 ( .A(b[25]), .B(n1082), .Y(n1177) );
  OAI22X1 U964 ( .A(n1179), .B(n1085), .C(n1178), .D(n1093), .Y(n640) );
  XOR2X1 U965 ( .A(b[26]), .B(n1082), .Y(n1178) );
  OAI22X1 U966 ( .A(n1180), .B(n1085), .C(n1179), .D(n1092), .Y(n639) );
  XOR2X1 U967 ( .A(b[27]), .B(n1082), .Y(n1179) );
  OAI22X1 U968 ( .A(n1181), .B(n1085), .C(n1180), .D(n1093), .Y(n638) );
  XOR2X1 U969 ( .A(b[28]), .B(n1082), .Y(n1180) );
  OAI22X1 U970 ( .A(n1151), .B(n1085), .C(n1181), .D(n1092), .Y(n637) );
  XOR2X1 U971 ( .A(b[29]), .B(n1082), .Y(n1181) );
  XOR2X1 U972 ( .A(n1112), .B(b[30]), .Y(n1151) );
  NOR2X1 U973 ( .A(n1080), .B(n1107), .Y(n635) );
  OAI22X1 U974 ( .A(n1081), .B(n1182), .C(n1183), .D(n1090), .Y(n634) );
  XOR2X1 U975 ( .A(n1107), .B(a[3]), .Y(n1183) );
  OAI22X1 U976 ( .A(n1081), .B(n1184), .C(n1182), .D(n1090), .Y(n633) );
  XOR2X1 U977 ( .A(b[1]), .B(n1077), .Y(n1182) );
  OAI22X1 U978 ( .A(n1080), .B(n1185), .C(n1184), .D(n1090), .Y(n632) );
  XOR2X1 U979 ( .A(n1043), .B(n1077), .Y(n1184) );
  OAI22X1 U980 ( .A(n1081), .B(n1186), .C(n1185), .D(n1090), .Y(n631) );
  XOR2X1 U981 ( .A(n1045), .B(n1077), .Y(n1185) );
  OAI22X1 U982 ( .A(n1081), .B(n1187), .C(n1186), .D(n1090), .Y(n630) );
  XOR2X1 U983 ( .A(b[4]), .B(n1077), .Y(n1186) );
  OAI22X1 U984 ( .A(n1081), .B(n1188), .C(n1187), .D(n1090), .Y(n629) );
  XOR2X1 U985 ( .A(b[5]), .B(n1077), .Y(n1187) );
  OAI22X1 U986 ( .A(n1081), .B(n1189), .C(n1188), .D(n1090), .Y(n628) );
  XOR2X1 U987 ( .A(b[6]), .B(n1077), .Y(n1188) );
  OAI22X1 U988 ( .A(n1081), .B(n1190), .C(n1189), .D(n1090), .Y(n627) );
  XOR2X1 U989 ( .A(b[7]), .B(n1077), .Y(n1189) );
  OAI22X1 U990 ( .A(n1081), .B(n1191), .C(n1190), .D(n1090), .Y(n626) );
  XOR2X1 U991 ( .A(n1055), .B(n1077), .Y(n1190) );
  OAI22X1 U992 ( .A(n1081), .B(n1192), .C(n1191), .D(n1090), .Y(n625) );
  XOR2X1 U993 ( .A(b[9]), .B(n1077), .Y(n1191) );
  OAI22X1 U994 ( .A(n1081), .B(n1193), .C(n1192), .D(n1090), .Y(n624) );
  XOR2X1 U995 ( .A(n1059), .B(n1077), .Y(n1192) );
  OAI22X1 U996 ( .A(n1081), .B(n1194), .C(n1193), .D(n1090), .Y(n623) );
  XOR2X1 U997 ( .A(n1061), .B(n1077), .Y(n1193) );
  OAI22X1 U998 ( .A(n1081), .B(n1195), .C(n1194), .D(n1090), .Y(n622) );
  XOR2X1 U999 ( .A(b[12]), .B(n1077), .Y(n1194) );
  OAI22X1 U1000 ( .A(n1081), .B(n1196), .C(n1195), .D(n1090), .Y(n621) );
  XOR2X1 U1001 ( .A(b[13]), .B(n1078), .Y(n1195) );
  OAI22X1 U1002 ( .A(n1081), .B(n1197), .C(n1196), .D(n1091), .Y(n620) );
  XOR2X1 U1003 ( .A(b[14]), .B(n1078), .Y(n1196) );
  OAI22X1 U1004 ( .A(n1080), .B(n1198), .C(n1197), .D(n1091), .Y(n619) );
  XOR2X1 U1005 ( .A(b[15]), .B(n1078), .Y(n1197) );
  OAI22X1 U1006 ( .A(n1080), .B(n1199), .C(n1198), .D(n1090), .Y(n618) );
  XOR2X1 U1007 ( .A(b[16]), .B(n1078), .Y(n1198) );
  OAI22X1 U1008 ( .A(n1080), .B(n1200), .C(n1199), .D(n1091), .Y(n617) );
  XOR2X1 U1009 ( .A(b[17]), .B(n1078), .Y(n1199) );
  OAI22X1 U1010 ( .A(n1080), .B(n1201), .C(n1200), .D(n1091), .Y(n616) );
  XOR2X1 U1011 ( .A(b[18]), .B(n1078), .Y(n1200) );
  OAI22X1 U1012 ( .A(n1080), .B(n1202), .C(n1201), .D(n1091), .Y(n615) );
  XOR2X1 U1013 ( .A(b[19]), .B(n1078), .Y(n1201) );
  OAI22X1 U1014 ( .A(n1080), .B(n1203), .C(n1202), .D(n1091), .Y(n614) );
  XOR2X1 U1015 ( .A(b[20]), .B(n1078), .Y(n1202) );
  OAI22X1 U1016 ( .A(n1080), .B(n1204), .C(n1203), .D(n1091), .Y(n613) );
  XOR2X1 U1017 ( .A(b[21]), .B(n1078), .Y(n1203) );
  OAI22X1 U1018 ( .A(n1081), .B(n1205), .C(n1204), .D(n1091), .Y(n612) );
  XOR2X1 U1019 ( .A(b[22]), .B(n1078), .Y(n1204) );
  OAI22X1 U1020 ( .A(n1080), .B(n1206), .C(n1205), .D(n1091), .Y(n611) );
  XOR2X1 U1021 ( .A(b[23]), .B(n1078), .Y(n1205) );
  OAI22X1 U1022 ( .A(n1080), .B(n1207), .C(n1206), .D(n1091), .Y(n610) );
  XOR2X1 U1023 ( .A(b[24]), .B(n1078), .Y(n1206) );
  OAI22X1 U1024 ( .A(n1080), .B(n1208), .C(n1207), .D(n1091), .Y(n609) );
  XOR2X1 U1025 ( .A(b[25]), .B(n1078), .Y(n1207) );
  OAI22X1 U1026 ( .A(n1080), .B(n1209), .C(n1208), .D(n1091), .Y(n608) );
  XOR2X1 U1027 ( .A(b[26]), .B(n1111), .Y(n1208) );
  OAI22X1 U1028 ( .A(n1080), .B(n1148), .C(n1209), .D(n1091), .Y(n607) );
  XOR2X1 U1029 ( .A(b[27]), .B(n1111), .Y(n1209) );
  XNOR2X1 U1030 ( .A(b[28]), .B(a[3]), .Y(n1148) );
  NOR2X1 U1031 ( .A(n1076), .B(n1107), .Y(n605) );
  OAI22X1 U1032 ( .A(n1076), .B(n1210), .C(n1211), .D(n1087), .Y(n604) );
  XOR2X1 U1033 ( .A(n1107), .B(a[5]), .Y(n1211) );
  OAI22X1 U1034 ( .A(n1076), .B(n1212), .C(n1210), .D(n1087), .Y(n603) );
  XOR2X1 U1035 ( .A(n1041), .B(n1096), .Y(n1210) );
  OAI22X1 U1036 ( .A(n1076), .B(n1213), .C(n1212), .D(n1087), .Y(n602) );
  XOR2X1 U1037 ( .A(n1043), .B(n1096), .Y(n1212) );
  OAI22X1 U1038 ( .A(n1076), .B(n1214), .C(n1213), .D(n1087), .Y(n601) );
  XOR2X1 U1039 ( .A(n1045), .B(n1096), .Y(n1213) );
  OAI22X1 U1040 ( .A(n1076), .B(n1215), .C(n1214), .D(n1087), .Y(n600) );
  XOR2X1 U1041 ( .A(n1047), .B(n1096), .Y(n1214) );
  OAI22X1 U1042 ( .A(n1076), .B(n1216), .C(n1215), .D(n1087), .Y(n599) );
  XOR2X1 U1043 ( .A(n1049), .B(n1096), .Y(n1215) );
  OAI22X1 U1044 ( .A(n1076), .B(n1217), .C(n1216), .D(n1087), .Y(n598) );
  XOR2X1 U1045 ( .A(n1051), .B(n1096), .Y(n1216) );
  OAI22X1 U1046 ( .A(n1076), .B(n1218), .C(n1217), .D(n1087), .Y(n597) );
  XOR2X1 U1047 ( .A(n1053), .B(n1096), .Y(n1217) );
  OAI22X1 U1048 ( .A(n1076), .B(n1219), .C(n1218), .D(n1087), .Y(n596) );
  XOR2X1 U1049 ( .A(n1055), .B(n1096), .Y(n1218) );
  OAI22X1 U1050 ( .A(n1076), .B(n1220), .C(n1219), .D(n1087), .Y(n595) );
  XOR2X1 U1051 ( .A(n1057), .B(n1096), .Y(n1219) );
  OAI22X1 U1052 ( .A(n1076), .B(n1221), .C(n1220), .D(n1087), .Y(n594) );
  XOR2X1 U1053 ( .A(n1059), .B(n1096), .Y(n1220) );
  OAI22X1 U1054 ( .A(n1076), .B(n1222), .C(n1221), .D(n1087), .Y(n593) );
  XOR2X1 U1055 ( .A(n1061), .B(n1096), .Y(n1221) );
  OAI22X1 U1056 ( .A(n1076), .B(n1223), .C(n1222), .D(n1087), .Y(n592) );
  XOR2X1 U1057 ( .A(n1063), .B(n1096), .Y(n1222) );
  OAI22X1 U1058 ( .A(n1076), .B(n1224), .C(n1223), .D(n1087), .Y(n591) );
  XOR2X1 U1059 ( .A(n1065), .B(n1097), .Y(n1223) );
  OAI22X1 U1060 ( .A(n1076), .B(n1225), .C(n1224), .D(n1087), .Y(n590) );
  XOR2X1 U1061 ( .A(n1067), .B(n1097), .Y(n1224) );
  OAI22X1 U1062 ( .A(n1076), .B(n1226), .C(n1225), .D(n1087), .Y(n589) );
  XOR2X1 U1063 ( .A(n1069), .B(n1097), .Y(n1225) );
  OAI22X1 U1064 ( .A(n1076), .B(n1227), .C(n1226), .D(n1087), .Y(n588) );
  XOR2X1 U1065 ( .A(b[16]), .B(n1097), .Y(n1226) );
  OAI22X1 U1066 ( .A(n1076), .B(n1228), .C(n1227), .D(n1087), .Y(n587) );
  XOR2X1 U1067 ( .A(b[17]), .B(n1097), .Y(n1227) );
  OAI22X1 U1068 ( .A(n1076), .B(n1229), .C(n1228), .D(n1087), .Y(n586) );
  XOR2X1 U1069 ( .A(b[18]), .B(n1097), .Y(n1228) );
  OAI22X1 U1070 ( .A(n1076), .B(n1230), .C(n1229), .D(n1087), .Y(n585) );
  XOR2X1 U1071 ( .A(b[19]), .B(n1097), .Y(n1229) );
  OAI22X1 U1072 ( .A(n1076), .B(n1231), .C(n1230), .D(n1087), .Y(n584) );
  XOR2X1 U1073 ( .A(b[20]), .B(n1097), .Y(n1230) );
  OAI22X1 U1074 ( .A(n1076), .B(n1232), .C(n1231), .D(n1087), .Y(n583) );
  XOR2X1 U1075 ( .A(b[21]), .B(n1097), .Y(n1231) );
  OAI22X1 U1076 ( .A(n1076), .B(n1233), .C(n1232), .D(n1087), .Y(n582) );
  XOR2X1 U1077 ( .A(b[22]), .B(n1097), .Y(n1232) );
  OAI22X1 U1078 ( .A(n1076), .B(n1234), .C(n1233), .D(n1087), .Y(n581) );
  XOR2X1 U1079 ( .A(b[23]), .B(n1097), .Y(n1233) );
  OAI22X1 U1080 ( .A(n1076), .B(n1235), .C(n1234), .D(n1087), .Y(n580) );
  XOR2X1 U1081 ( .A(b[24]), .B(n1097), .Y(n1234) );
  OAI22X1 U1082 ( .A(n1076), .B(n1132), .C(n1235), .D(n1087), .Y(n579) );
  XOR2X1 U1083 ( .A(b[25]), .B(n1097), .Y(n1235) );
  XNOR2X1 U1084 ( .A(b[26]), .B(n1094), .Y(n1132) );
  NOR2X1 U1085 ( .A(n1075), .B(n1107), .Y(n577) );
  OAI22X1 U1086 ( .A(n1075), .B(n1236), .C(n1237), .D(n1089), .Y(n576) );
  XOR2X1 U1087 ( .A(n1107), .B(a[7]), .Y(n1237) );
  OAI22X1 U1088 ( .A(n1075), .B(n1238), .C(n1236), .D(n1089), .Y(n575) );
  XOR2X1 U1089 ( .A(b[1]), .B(n1073), .Y(n1236) );
  OAI22X1 U1090 ( .A(n1075), .B(n1239), .C(n1238), .D(n1089), .Y(n574) );
  XOR2X1 U1091 ( .A(n1043), .B(n1073), .Y(n1238) );
  OAI22X1 U1092 ( .A(n1075), .B(n1240), .C(n1239), .D(n1089), .Y(n573) );
  XOR2X1 U1093 ( .A(n1045), .B(n1073), .Y(n1239) );
  OAI22X1 U1094 ( .A(n1075), .B(n1241), .C(n1240), .D(n1089), .Y(n572) );
  XOR2X1 U1095 ( .A(b[4]), .B(n1073), .Y(n1240) );
  OAI22X1 U1096 ( .A(n1075), .B(n1242), .C(n1241), .D(n1089), .Y(n571) );
  XOR2X1 U1097 ( .A(b[5]), .B(n1073), .Y(n1241) );
  OAI22X1 U1098 ( .A(n1075), .B(n1243), .C(n1242), .D(n1089), .Y(n570) );
  XOR2X1 U1099 ( .A(b[6]), .B(n1073), .Y(n1242) );
  OAI22X1 U1100 ( .A(n1075), .B(n1244), .C(n1243), .D(n1089), .Y(n569) );
  XOR2X1 U1101 ( .A(b[7]), .B(n1073), .Y(n1243) );
  OAI22X1 U1102 ( .A(n1075), .B(n1245), .C(n1244), .D(n1089), .Y(n568) );
  XOR2X1 U1103 ( .A(n1055), .B(n1073), .Y(n1244) );
  OAI22X1 U1104 ( .A(n1075), .B(n1246), .C(n1245), .D(n1089), .Y(n567) );
  XOR2X1 U1105 ( .A(b[9]), .B(n1073), .Y(n1245) );
  OAI22X1 U1106 ( .A(n1075), .B(n1247), .C(n1246), .D(n1089), .Y(n566) );
  XOR2X1 U1107 ( .A(n1059), .B(n1073), .Y(n1246) );
  OAI22X1 U1108 ( .A(n1075), .B(n1248), .C(n1247), .D(n1089), .Y(n565) );
  XOR2X1 U1109 ( .A(n1061), .B(n1073), .Y(n1247) );
  OAI22X1 U1110 ( .A(n1075), .B(n1249), .C(n1248), .D(n1089), .Y(n564) );
  XOR2X1 U1111 ( .A(b[12]), .B(n1073), .Y(n1248) );
  OAI22X1 U1112 ( .A(n1075), .B(n1250), .C(n1249), .D(n1089), .Y(n563) );
  XOR2X1 U1113 ( .A(b[13]), .B(n1074), .Y(n1249) );
  OAI22X1 U1114 ( .A(n1075), .B(n1251), .C(n1250), .D(n1089), .Y(n562) );
  XOR2X1 U1115 ( .A(b[14]), .B(n1074), .Y(n1250) );
  OAI22X1 U1116 ( .A(n1075), .B(n1252), .C(n1251), .D(n1089), .Y(n561) );
  XOR2X1 U1117 ( .A(b[15]), .B(n1074), .Y(n1251) );
  OAI22X1 U1118 ( .A(n1075), .B(n1253), .C(n1252), .D(n1089), .Y(n560) );
  XOR2X1 U1119 ( .A(b[16]), .B(n1074), .Y(n1252) );
  OAI22X1 U1120 ( .A(n1075), .B(n1254), .C(n1253), .D(n1089), .Y(n559) );
  XOR2X1 U1121 ( .A(b[17]), .B(n1074), .Y(n1253) );
  OAI22X1 U1122 ( .A(n1075), .B(n1255), .C(n1254), .D(n1089), .Y(n558) );
  XOR2X1 U1123 ( .A(b[18]), .B(n1074), .Y(n1254) );
  OAI22X1 U1124 ( .A(n1075), .B(n1256), .C(n1255), .D(n1089), .Y(n557) );
  XOR2X1 U1125 ( .A(b[19]), .B(n1074), .Y(n1255) );
  OAI22X1 U1126 ( .A(n1075), .B(n1257), .C(n1256), .D(n1089), .Y(n556) );
  XOR2X1 U1127 ( .A(b[20]), .B(n1074), .Y(n1256) );
  OAI22X1 U1128 ( .A(n1075), .B(n1258), .C(n1257), .D(n1089), .Y(n555) );
  XOR2X1 U1129 ( .A(b[21]), .B(n1074), .Y(n1257) );
  OAI22X1 U1130 ( .A(n1075), .B(n1259), .C(n1258), .D(n1089), .Y(n554) );
  XOR2X1 U1131 ( .A(b[22]), .B(n1074), .Y(n1258) );
  OAI22X1 U1132 ( .A(n1075), .B(n1143), .C(n1259), .D(n1089), .Y(n553) );
  XOR2X1 U1133 ( .A(b[23]), .B(n1074), .Y(n1259) );
  XOR2X1 U1134 ( .A(b[24]), .B(n1074), .Y(n1143) );
  NOR2X1 U1135 ( .A(n1072), .B(n1107), .Y(n551) );
  OAI22X1 U1136 ( .A(n1072), .B(n1260), .C(n1261), .D(n1088), .Y(n550) );
  XOR2X1 U1137 ( .A(n1107), .B(a[9]), .Y(n1261) );
  OAI22X1 U1138 ( .A(n1072), .B(n1262), .C(n1260), .D(n1088), .Y(n549) );
  XOR2X1 U1139 ( .A(n1041), .B(n1070), .Y(n1260) );
  OAI22X1 U1140 ( .A(n1072), .B(n1263), .C(n1262), .D(n1088), .Y(n548) );
  XOR2X1 U1141 ( .A(n1043), .B(n1070), .Y(n1262) );
  OAI22X1 U1142 ( .A(n1072), .B(n1264), .C(n1263), .D(n1088), .Y(n547) );
  XOR2X1 U1143 ( .A(n1045), .B(n1070), .Y(n1263) );
  OAI22X1 U1144 ( .A(n1072), .B(n1265), .C(n1264), .D(n1088), .Y(n546) );
  XOR2X1 U1145 ( .A(n1047), .B(n1070), .Y(n1264) );
  OAI22X1 U1146 ( .A(n1072), .B(n1266), .C(n1265), .D(n1088), .Y(n545) );
  XOR2X1 U1147 ( .A(n1049), .B(n1070), .Y(n1265) );
  OAI22X1 U1148 ( .A(n1072), .B(n1267), .C(n1266), .D(n1088), .Y(n544) );
  XOR2X1 U1149 ( .A(n1051), .B(n1070), .Y(n1266) );
  OAI22X1 U1150 ( .A(n1072), .B(n1268), .C(n1267), .D(n1088), .Y(n543) );
  XOR2X1 U1151 ( .A(n1053), .B(n1070), .Y(n1267) );
  OAI22X1 U1152 ( .A(n1072), .B(n1269), .C(n1268), .D(n1088), .Y(n542) );
  XOR2X1 U1153 ( .A(n1055), .B(n1070), .Y(n1268) );
  OAI22X1 U1154 ( .A(n1072), .B(n1270), .C(n1269), .D(n1088), .Y(n541) );
  XOR2X1 U1155 ( .A(n1057), .B(n1070), .Y(n1269) );
  OAI22X1 U1156 ( .A(n1072), .B(n1271), .C(n1270), .D(n1088), .Y(n540) );
  XOR2X1 U1157 ( .A(n1059), .B(n1070), .Y(n1270) );
  OAI22X1 U1158 ( .A(n1072), .B(n1272), .C(n1271), .D(n1088), .Y(n539) );
  XOR2X1 U1159 ( .A(n1061), .B(n1070), .Y(n1271) );
  OAI22X1 U1160 ( .A(n1072), .B(n1273), .C(n1272), .D(n1088), .Y(n538) );
  XOR2X1 U1161 ( .A(n1063), .B(n1070), .Y(n1272) );
  OAI22X1 U1162 ( .A(n1072), .B(n1274), .C(n1273), .D(n1088), .Y(n537) );
  XOR2X1 U1163 ( .A(n1065), .B(n1071), .Y(n1273) );
  OAI22X1 U1164 ( .A(n1072), .B(n1275), .C(n1274), .D(n1088), .Y(n536) );
  XOR2X1 U1165 ( .A(n1067), .B(n1071), .Y(n1274) );
  OAI22X1 U1166 ( .A(n1072), .B(n1276), .C(n1275), .D(n1088), .Y(n535) );
  XOR2X1 U1167 ( .A(n1069), .B(n1071), .Y(n1275) );
  OAI22X1 U1168 ( .A(n1072), .B(n1277), .C(n1276), .D(n1088), .Y(n534) );
  XOR2X1 U1169 ( .A(b[16]), .B(n1071), .Y(n1276) );
  OAI22X1 U1170 ( .A(n1072), .B(n1278), .C(n1277), .D(n1088), .Y(n533) );
  XOR2X1 U1171 ( .A(b[17]), .B(n1071), .Y(n1277) );
  OAI22X1 U1172 ( .A(n1072), .B(n1279), .C(n1278), .D(n1088), .Y(n532) );
  XOR2X1 U1173 ( .A(b[18]), .B(n1071), .Y(n1278) );
  OAI22X1 U1174 ( .A(n1072), .B(n1280), .C(n1279), .D(n1088), .Y(n531) );
  XOR2X1 U1175 ( .A(b[19]), .B(n1071), .Y(n1279) );
  OAI22X1 U1176 ( .A(n1072), .B(n1281), .C(n1280), .D(n1088), .Y(n530) );
  XOR2X1 U1177 ( .A(b[20]), .B(n1071), .Y(n1280) );
  OAI22X1 U1178 ( .A(n1072), .B(n1141), .C(n1281), .D(n1088), .Y(n529) );
  XOR2X1 U1179 ( .A(b[21]), .B(n1071), .Y(n1281) );
  XOR2X1 U1180 ( .A(b[22]), .B(n1071), .Y(n1141) );
  NOR2X1 U1181 ( .A(n1110), .B(n1107), .Y(n527) );
  OAI22X1 U1182 ( .A(n1110), .B(n1282), .C(n1283), .D(n1037), .Y(n526) );
  XOR2X1 U1183 ( .A(n1107), .B(n1098), .Y(n1283) );
  OAI22X1 U1184 ( .A(n1110), .B(n1284), .C(n1282), .D(n1037), .Y(n525) );
  XOR2X1 U1185 ( .A(n1041), .B(n1100), .Y(n1282) );
  OAI22X1 U1186 ( .A(n1110), .B(n1285), .C(n1284), .D(n1037), .Y(n524) );
  XOR2X1 U1187 ( .A(n1043), .B(n1100), .Y(n1284) );
  OAI22X1 U1188 ( .A(n1110), .B(n1286), .C(n1285), .D(n1037), .Y(n523) );
  XOR2X1 U1189 ( .A(n1045), .B(n1100), .Y(n1285) );
  OAI22X1 U1190 ( .A(n1110), .B(n1287), .C(n1286), .D(n1037), .Y(n522) );
  XOR2X1 U1191 ( .A(b[4]), .B(n1100), .Y(n1286) );
  OAI22X1 U1192 ( .A(n1110), .B(n1288), .C(n1287), .D(n1037), .Y(n521) );
  XOR2X1 U1193 ( .A(n1049), .B(n1100), .Y(n1287) );
  OAI22X1 U1194 ( .A(n1110), .B(n1289), .C(n1288), .D(n1037), .Y(n520) );
  XOR2X1 U1195 ( .A(b[6]), .B(n1100), .Y(n1288) );
  OAI22X1 U1196 ( .A(n1110), .B(n1290), .C(n1289), .D(n1037), .Y(n519) );
  XOR2X1 U1197 ( .A(b[7]), .B(n1100), .Y(n1289) );
  OAI22X1 U1198 ( .A(n1110), .B(n1291), .C(n1290), .D(n1037), .Y(n518) );
  XOR2X1 U1199 ( .A(n1055), .B(n1100), .Y(n1290) );
  OAI22X1 U1200 ( .A(n1110), .B(n1292), .C(n1291), .D(n1037), .Y(n517) );
  XOR2X1 U1201 ( .A(n1057), .B(n1100), .Y(n1291) );
  OAI22X1 U1202 ( .A(n1110), .B(n1293), .C(n1292), .D(n1037), .Y(n516) );
  XOR2X1 U1203 ( .A(n1059), .B(n1100), .Y(n1292) );
  OAI22X1 U1204 ( .A(n1110), .B(n1294), .C(n1293), .D(n1037), .Y(n515) );
  XOR2X1 U1205 ( .A(n1061), .B(n1100), .Y(n1293) );
  OAI22X1 U1206 ( .A(n1110), .B(n1295), .C(n1294), .D(n1037), .Y(n514) );
  XOR2X1 U1207 ( .A(b[12]), .B(n1100), .Y(n1294) );
  OAI22X1 U1208 ( .A(n1110), .B(n1296), .C(n1295), .D(n1037), .Y(n513) );
  XOR2X1 U1209 ( .A(n1065), .B(n1101), .Y(n1295) );
  OAI22X1 U1210 ( .A(n1110), .B(n1297), .C(n1296), .D(n1037), .Y(n512) );
  XOR2X1 U1211 ( .A(b[14]), .B(n1101), .Y(n1296) );
  OAI22X1 U1212 ( .A(n1110), .B(n1298), .C(n1297), .D(n1037), .Y(n511) );
  XOR2X1 U1213 ( .A(b[15]), .B(n1101), .Y(n1297) );
  OAI22X1 U1214 ( .A(n1110), .B(n1299), .C(n1298), .D(n1037), .Y(n510) );
  XOR2X1 U1215 ( .A(b[16]), .B(n1101), .Y(n1298) );
  OAI22X1 U1216 ( .A(n1110), .B(n1300), .C(n1299), .D(n1037), .Y(n509) );
  XOR2X1 U1217 ( .A(b[17]), .B(n1101), .Y(n1299) );
  OAI22X1 U1218 ( .A(n1110), .B(n1301), .C(n1300), .D(n1037), .Y(n508) );
  XOR2X1 U1219 ( .A(b[18]), .B(n1101), .Y(n1300) );
  OAI22X1 U1220 ( .A(n1110), .B(n1129), .C(n1301), .D(n1037), .Y(n507) );
  XOR2X1 U1221 ( .A(b[19]), .B(n1101), .Y(n1301) );
  XOR2X1 U1222 ( .A(b[20]), .B(n1101), .Y(n1129) );
  NOR2X1 U1223 ( .A(n1109), .B(n1107), .Y(n505) );
  OAI22X1 U1224 ( .A(n1109), .B(n1302), .C(n1303), .D(n1038), .Y(n504) );
  XOR2X1 U1225 ( .A(n1036), .B(b[0]), .Y(n1303) );
  OAI22X1 U1226 ( .A(n1109), .B(n1304), .C(n1302), .D(n1038), .Y(n503) );
  XOR2X1 U1227 ( .A(n1041), .B(n1036), .Y(n1302) );
  OAI22X1 U1228 ( .A(n1109), .B(n1305), .C(n1304), .D(n1038), .Y(n502) );
  XOR2X1 U1229 ( .A(n1043), .B(n1036), .Y(n1304) );
  OAI22X1 U1230 ( .A(n1109), .B(n1306), .C(n1305), .D(n1038), .Y(n501) );
  XOR2X1 U1231 ( .A(n1045), .B(n1036), .Y(n1305) );
  OAI22X1 U1232 ( .A(n1109), .B(n1307), .C(n1306), .D(n1038), .Y(n500) );
  XOR2X1 U1233 ( .A(n1047), .B(n1036), .Y(n1306) );
  OAI22X1 U1234 ( .A(n1109), .B(n1308), .C(n1307), .D(n1038), .Y(n499) );
  XOR2X1 U1235 ( .A(n1049), .B(n1036), .Y(n1307) );
  OAI22X1 U1236 ( .A(n1109), .B(n1309), .C(n1308), .D(n1038), .Y(n498) );
  XOR2X1 U1237 ( .A(n1051), .B(n1036), .Y(n1308) );
  OAI22X1 U1238 ( .A(n1109), .B(n1310), .C(n1309), .D(n1038), .Y(n497) );
  XOR2X1 U1239 ( .A(n1053), .B(n1036), .Y(n1309) );
  OAI22X1 U1240 ( .A(n1109), .B(n1311), .C(n1310), .D(n1038), .Y(n496) );
  XOR2X1 U1241 ( .A(n1055), .B(n1036), .Y(n1310) );
  OAI22X1 U1242 ( .A(n1109), .B(n1312), .C(n1311), .D(n1038), .Y(n495) );
  XOR2X1 U1243 ( .A(n1057), .B(n1036), .Y(n1311) );
  OAI22X1 U1244 ( .A(n1109), .B(n1313), .C(n1312), .D(n1038), .Y(n494) );
  XOR2X1 U1245 ( .A(n1059), .B(n1036), .Y(n1312) );
  OAI22X1 U1246 ( .A(n1109), .B(n1314), .C(n1313), .D(n1038), .Y(n493) );
  XOR2X1 U1247 ( .A(n1061), .B(n1036), .Y(n1313) );
  OAI22X1 U1248 ( .A(n1109), .B(n1315), .C(n1314), .D(n1038), .Y(n492) );
  XOR2X1 U1249 ( .A(n1063), .B(n1036), .Y(n1314) );
  OAI22X1 U1250 ( .A(n1109), .B(n1316), .C(n1315), .D(n1038), .Y(n491) );
  XOR2X1 U1251 ( .A(n1065), .B(n1036), .Y(n1315) );
  OAI22X1 U1252 ( .A(n1109), .B(n1317), .C(n1316), .D(n1038), .Y(n490) );
  XOR2X1 U1253 ( .A(n1067), .B(n1036), .Y(n1316) );
  OAI22X1 U1254 ( .A(n1109), .B(n1318), .C(n1317), .D(n1038), .Y(n489) );
  XOR2X1 U1255 ( .A(n1069), .B(n1036), .Y(n1317) );
  OAI22X1 U1256 ( .A(n1109), .B(n1319), .C(n1318), .D(n1038), .Y(n488) );
  XOR2X1 U1257 ( .A(b[16]), .B(n1036), .Y(n1318) );
  OAI22X1 U1258 ( .A(n1109), .B(n1144), .C(n1319), .D(n1038), .Y(n487) );
  XOR2X1 U1259 ( .A(b[17]), .B(n1036), .Y(n1319) );
  XNOR2X1 U1260 ( .A(b[18]), .B(a[13]), .Y(n1144) );
  NOR2X1 U1261 ( .A(n1108), .B(n1107), .Y(n485) );
  OAI22X1 U1262 ( .A(n1108), .B(n1320), .C(n1321), .D(n1039), .Y(n484) );
  XOR2X1 U1263 ( .A(n1107), .B(n1102), .Y(n1321) );
  OAI22X1 U1264 ( .A(n1108), .B(n1322), .C(n1320), .D(n1039), .Y(n483) );
  XOR2X1 U1265 ( .A(b[1]), .B(n1106), .Y(n1320) );
  OAI22X1 U1266 ( .A(n1108), .B(n1323), .C(n1322), .D(n1039), .Y(n482) );
  XOR2X1 U1267 ( .A(n1043), .B(n1106), .Y(n1322) );
  OAI22X1 U1268 ( .A(n1108), .B(n1324), .C(n1323), .D(n1039), .Y(n481) );
  XOR2X1 U1269 ( .A(n1045), .B(n1106), .Y(n1323) );
  OAI22X1 U1270 ( .A(n1108), .B(n1325), .C(n1324), .D(n1039), .Y(n480) );
  XOR2X1 U1271 ( .A(n1047), .B(n1106), .Y(n1324) );
  OAI22X1 U1272 ( .A(n1108), .B(n1326), .C(n1325), .D(n1039), .Y(n479) );
  XOR2X1 U1273 ( .A(b[5]), .B(n1105), .Y(n1325) );
  OAI22X1 U1274 ( .A(n1108), .B(n1327), .C(n1326), .D(n1039), .Y(n478) );
  XOR2X1 U1275 ( .A(n1051), .B(n1105), .Y(n1326) );
  OAI22X1 U1276 ( .A(n1108), .B(n1328), .C(n1327), .D(n1039), .Y(n477) );
  XOR2X1 U1277 ( .A(n1053), .B(n1105), .Y(n1327) );
  OAI22X1 U1278 ( .A(n1108), .B(n1329), .C(n1328), .D(n1039), .Y(n476) );
  XOR2X1 U1279 ( .A(n1055), .B(n1105), .Y(n1328) );
  OAI22X1 U1280 ( .A(n1108), .B(n1330), .C(n1329), .D(n1039), .Y(n475) );
  XOR2X1 U1281 ( .A(b[9]), .B(n1105), .Y(n1329) );
  OAI22X1 U1282 ( .A(n1108), .B(n1331), .C(n1330), .D(n1039), .Y(n474) );
  XOR2X1 U1283 ( .A(n1059), .B(n1105), .Y(n1330) );
  OAI22X1 U1284 ( .A(n1108), .B(n1332), .C(n1331), .D(n1039), .Y(n473) );
  XOR2X1 U1285 ( .A(n1061), .B(n1105), .Y(n1331) );
  OAI22X1 U1286 ( .A(n1108), .B(n1333), .C(n1332), .D(n1039), .Y(n472) );
  XOR2X1 U1287 ( .A(n1063), .B(n1105), .Y(n1332) );
  OAI22X1 U1288 ( .A(n1108), .B(n1334), .C(n1333), .D(n1039), .Y(n471) );
  XOR2X1 U1289 ( .A(b[13]), .B(n1105), .Y(n1333) );
  OAI22X1 U1290 ( .A(n1108), .B(n1335), .C(n1334), .D(n1039), .Y(n470) );
  XOR2X1 U1291 ( .A(n1067), .B(n1105), .Y(n1334) );
  OAI22X1 U1292 ( .A(n1108), .B(n1127), .C(n1335), .D(n1039), .Y(n469) );
  XOR2X1 U1293 ( .A(n1069), .B(n1105), .Y(n1335) );
  XOR2X1 U1294 ( .A(b[16]), .B(n1105), .Y(n1127) );
  NOR2X1 U1295 ( .A(n1106), .B(n1107), .Y(n467) );
  AND2X1 U1296 ( .A(n1103), .B(n1041), .Y(n466) );
  AND2X1 U1297 ( .A(n1103), .B(n1043), .Y(n465) );
  AND2X1 U1298 ( .A(n1104), .B(n1045), .Y(n464) );
  AND2X1 U1299 ( .A(n1104), .B(n1047), .Y(n463) );
  AND2X1 U1300 ( .A(n1104), .B(n1049), .Y(n462) );
  AND2X1 U1301 ( .A(n1104), .B(n1051), .Y(n461) );
  AND2X1 U1302 ( .A(n1104), .B(n1053), .Y(n460) );
  AND2X1 U1303 ( .A(n1104), .B(n1055), .Y(n459) );
  AND2X1 U1304 ( .A(n1104), .B(n1057), .Y(n458) );
  AND2X1 U1305 ( .A(n1104), .B(n1059), .Y(n457) );
  AND2X1 U1306 ( .A(n1104), .B(n1061), .Y(n456) );
  AND2X1 U1307 ( .A(n1104), .B(n1063), .Y(n455) );
  AND2X1 U1308 ( .A(n1104), .B(n1065), .Y(n454) );
  AND2X1 U1309 ( .A(n1103), .B(n1067), .Y(n453) );
  OAI21X1 U1310 ( .A(b[0]), .B(n1112), .C(n1093), .Y(n451) );
  OAI21X1 U1311 ( .A(n1111), .B(n1091), .C(n1336), .Y(n450) );
  NAND3X1 U1312 ( .A(n1337), .B(n1107), .C(a[3]), .Y(n1336) );
  XOR2X1 U1313 ( .A(a[3]), .B(a[2]), .Y(n1338) );
  XOR2X1 U1314 ( .A(a[2]), .B(a[1]), .Y(n1337) );
  OAI21X1 U1315 ( .A(n1097), .B(n1087), .C(n1339), .Y(n449) );
  NAND3X1 U1316 ( .A(n1340), .B(n1107), .C(n1095), .Y(n1339) );
  XOR2X1 U1317 ( .A(n1094), .B(a[4]), .Y(n1341) );
  XOR2X1 U1318 ( .A(a[4]), .B(a[3]), .Y(n1340) );
  OAI21X1 U1319 ( .A(n1074), .B(n1089), .C(n1342), .Y(n448) );
  NAND3X1 U1320 ( .A(n1343), .B(n1107), .C(a[7]), .Y(n1342) );
  XOR2X1 U1321 ( .A(a[7]), .B(a[6]), .Y(n1344) );
  XOR2X1 U1322 ( .A(a[6]), .B(n1095), .Y(n1343) );
  OAI21X1 U1323 ( .A(n1071), .B(n1088), .C(n1345), .Y(n447) );
  NAND3X1 U1324 ( .A(n1346), .B(n1107), .C(a[9]), .Y(n1345) );
  XOR2X1 U1325 ( .A(a[9]), .B(a[8]), .Y(n1347) );
  XOR2X1 U1326 ( .A(a[8]), .B(a[7]), .Y(n1346) );
  OAI21X1 U1327 ( .A(n1101), .B(n1037), .C(n1348), .Y(n446) );
  NAND3X1 U1328 ( .A(n1349), .B(n1107), .C(n1099), .Y(n1348) );
  XOR2X1 U1329 ( .A(n1098), .B(a[10]), .Y(n1350) );
  XOR2X1 U1330 ( .A(a[10]), .B(a[9]), .Y(n1349) );
  OAI21X1 U1331 ( .A(n1036), .B(n1038), .C(n1351), .Y(n445) );
  NAND3X1 U1332 ( .A(n1352), .B(n1107), .C(a[13]), .Y(n1351) );
  XOR2X1 U1333 ( .A(a[13]), .B(a[12]), .Y(n1353) );
  XOR2X1 U1334 ( .A(a[12]), .B(n1099), .Y(n1352) );
  OAI21X1 U1335 ( .A(n1106), .B(n1039), .C(n1354), .Y(n444) );
  NAND3X1 U1336 ( .A(n1355), .B(n1107), .C(n1103), .Y(n1354) );
  XOR2X1 U1337 ( .A(n1102), .B(a[14]), .Y(n1356) );
  XOR2X1 U1338 ( .A(a[14]), .B(a[13]), .Y(n1355) );
endmodule


module get_address_r_DW01_add_0 ( A, B, CI, SUM, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [31:1] carry;

  FAX1 U1_31 ( .A(A[31]), .B(B[31]), .C(carry[31]), .YS(SUM[31]) );
  FAX1 U1_30 ( .A(A[30]), .B(B[30]), .C(carry[30]), .YC(carry[31]), .YS(
        SUM[30]) );
  FAX1 U1_29 ( .A(A[29]), .B(B[29]), .C(carry[29]), .YC(carry[30]), .YS(
        SUM[29]) );
  FAX1 U1_28 ( .A(A[28]), .B(B[28]), .C(carry[28]), .YC(carry[29]), .YS(
        SUM[28]) );
  FAX1 U1_27 ( .A(A[27]), .B(B[27]), .C(carry[27]), .YC(carry[28]), .YS(
        SUM[27]) );
  FAX1 U1_26 ( .A(A[26]), .B(B[26]), .C(carry[26]), .YC(carry[27]), .YS(
        SUM[26]) );
  FAX1 U1_25 ( .A(A[25]), .B(B[25]), .C(carry[25]), .YC(carry[26]), .YS(
        SUM[25]) );
  FAX1 U1_24 ( .A(A[24]), .B(B[24]), .C(carry[24]), .YC(carry[25]), .YS(
        SUM[24]) );
  FAX1 U1_23 ( .A(A[23]), .B(B[23]), .C(carry[23]), .YC(carry[24]), .YS(
        SUM[23]) );
  FAX1 U1_22 ( .A(A[22]), .B(B[22]), .C(carry[22]), .YC(carry[23]), .YS(
        SUM[22]) );
  FAX1 U1_21 ( .A(A[21]), .B(B[21]), .C(carry[21]), .YC(carry[22]), .YS(
        SUM[21]) );
  FAX1 U1_20 ( .A(A[20]), .B(B[20]), .C(carry[20]), .YC(carry[21]), .YS(
        SUM[20]) );
  FAX1 U1_19 ( .A(A[19]), .B(B[19]), .C(carry[19]), .YC(carry[20]), .YS(
        SUM[19]) );
  FAX1 U1_18 ( .A(A[18]), .B(B[18]), .C(carry[18]), .YC(carry[19]), .YS(
        SUM[18]) );
  FAX1 U1_17 ( .A(A[17]), .B(B[17]), .C(carry[17]), .YC(carry[18]), .YS(
        SUM[17]) );
  FAX1 U1_16 ( .A(A[16]), .B(B[16]), .C(carry[16]), .YC(carry[17]), .YS(
        SUM[16]) );
  FAX1 U1_15 ( .A(A[15]), .B(B[15]), .C(carry[15]), .YC(carry[16]), .YS(
        SUM[15]) );
  FAX1 U1_14 ( .A(A[14]), .B(B[14]), .C(carry[14]), .YC(carry[15]), .YS(
        SUM[14]) );
  FAX1 U1_13 ( .A(A[13]), .B(B[13]), .C(carry[13]), .YC(carry[14]), .YS(
        SUM[13]) );
  FAX1 U1_12 ( .A(A[12]), .B(B[12]), .C(carry[12]), .YC(carry[13]), .YS(
        SUM[12]) );
  FAX1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .YC(carry[12]), .YS(
        SUM[11]) );
  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YC(carry[11]), .YS(
        SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module get_address_r ( HCLK, HRESETn, addr_enable_r, curr_addr, length, width, 
        start_addr_r, transfer_addr_complete_r );
  input [31:0] curr_addr;
  input [15:0] length;
  input [15:0] width;
  output [31:0] start_addr_r;
  input HCLK, HRESETn, addr_enable_r;
  output transfer_addr_complete_r;
  wire   N9, N8, N7, N6, N5, N4, N31, N30, N3, N29, N28, N27, N26, N25, N24,
         N23, N22, N21, N20, N2, N19, N18, N17, N16, N15, N14, N13, N12, N11,
         N10, N1, N0;
  wire   [31:0] row_count;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;

  flex_counter_NUM_CNT_BITS32_1 ROW_COUNTER ( .clk(HCLK), .n_rst(HRESETn), 
        .clear(1'b0), .count_enable(addr_enable_r), .rollover_val({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0}), .count_out(row_count), 
        .rollover_flag(transfer_addr_complete_r) );
  get_address_r_DW_mult_uns_0 mult_35 ( .a(length), .b(row_count), .product({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, N31, N30, N29, N28, 
        N27, N26, N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, 
        N13, N12, N11, N10, N9, N8, N7, N6, N5, N4, N3, N2, N1, N0}) );
  get_address_r_DW01_add_0 add_35 ( .A(curr_addr), .B({N31, N30, N29, N28, N27, 
        N26, N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15, N14, N13, 
        N12, N11, N10, N9, N8, N7, N6, N5, N4, N3, N2, N1, N0}), .CI(1'b0), 
        .SUM(start_addr_r) );
endmodule


module flex_counter_NUM_CNT_BITS32_0_DW01_dec_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;
  wire   n11, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75;

  INVX2 U1 ( .A(n61), .Y(SUM[1]) );
  INVX2 U2 ( .A(n74), .Y(SUM[11]) );
  INVX2 U3 ( .A(n71), .Y(SUM[13]) );
  INVX2 U4 ( .A(n68), .Y(SUM[15]) );
  INVX2 U5 ( .A(n65), .Y(SUM[17]) );
  INVX2 U6 ( .A(n62), .Y(SUM[19]) );
  INVX2 U7 ( .A(n57), .Y(SUM[22]) );
  INVX2 U8 ( .A(n54), .Y(SUM[24]) );
  INVX2 U9 ( .A(n51), .Y(SUM[26]) );
  INVX2 U10 ( .A(n48), .Y(SUM[28]) );
  INVX2 U11 ( .A(n59), .Y(n11) );
  INVX2 U12 ( .A(n32), .Y(SUM[9]) );
  INVX2 U13 ( .A(n36), .Y(SUM[7]) );
  INVX2 U14 ( .A(n39), .Y(SUM[5]) );
  INVX2 U15 ( .A(n42), .Y(SUM[3]) );
  INVX2 U16 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U17 ( .A(A[2]), .Y(n17) );
  INVX2 U18 ( .A(A[4]), .Y(n18) );
  INVX2 U19 ( .A(A[6]), .Y(n19) );
  INVX2 U20 ( .A(A[8]), .Y(n20) );
  INVX2 U21 ( .A(A[10]), .Y(n21) );
  INVX2 U22 ( .A(A[12]), .Y(n22) );
  INVX2 U23 ( .A(A[14]), .Y(n23) );
  INVX2 U24 ( .A(A[16]), .Y(n24) );
  INVX2 U25 ( .A(A[18]), .Y(n25) );
  INVX2 U26 ( .A(A[20]), .Y(n26) );
  INVX2 U27 ( .A(A[21]), .Y(n27) );
  INVX2 U28 ( .A(A[23]), .Y(n28) );
  INVX2 U29 ( .A(A[25]), .Y(n29) );
  INVX2 U30 ( .A(A[27]), .Y(n30) );
  INVX2 U31 ( .A(A[29]), .Y(n31) );
  AOI21X1 U32 ( .A(n33), .B(A[9]), .C(n34), .Y(n32) );
  OAI21X1 U33 ( .A(n35), .B(n20), .C(n33), .Y(SUM[8]) );
  AOI21X1 U34 ( .A(n37), .B(A[7]), .C(n35), .Y(n36) );
  OAI21X1 U35 ( .A(n38), .B(n19), .C(n37), .Y(SUM[6]) );
  AOI21X1 U36 ( .A(n40), .B(A[5]), .C(n38), .Y(n39) );
  OAI21X1 U37 ( .A(n41), .B(n18), .C(n40), .Y(SUM[4]) );
  AOI21X1 U38 ( .A(n43), .B(A[3]), .C(n41), .Y(n42) );
  XOR2X1 U39 ( .A(A[31]), .B(n44), .Y(SUM[31]) );
  NOR2X1 U40 ( .A(A[30]), .B(n45), .Y(n44) );
  XNOR2X1 U41 ( .A(A[30]), .B(n45), .Y(SUM[30]) );
  OAI21X1 U42 ( .A(n46), .B(n17), .C(n43), .Y(SUM[2]) );
  OAI21X1 U43 ( .A(n47), .B(n31), .C(n45), .Y(SUM[29]) );
  NAND2X1 U44 ( .A(n47), .B(n31), .Y(n45) );
  AOI21X1 U45 ( .A(n49), .B(A[28]), .C(n47), .Y(n48) );
  NOR2X1 U46 ( .A(n49), .B(A[28]), .Y(n47) );
  OAI21X1 U47 ( .A(n50), .B(n30), .C(n49), .Y(SUM[27]) );
  NAND2X1 U48 ( .A(n50), .B(n30), .Y(n49) );
  AOI21X1 U49 ( .A(n52), .B(A[26]), .C(n50), .Y(n51) );
  NOR2X1 U50 ( .A(n52), .B(A[26]), .Y(n50) );
  OAI21X1 U51 ( .A(n53), .B(n29), .C(n52), .Y(SUM[25]) );
  NAND2X1 U52 ( .A(n53), .B(n29), .Y(n52) );
  AOI21X1 U53 ( .A(n55), .B(A[24]), .C(n53), .Y(n54) );
  NOR2X1 U54 ( .A(n55), .B(A[24]), .Y(n53) );
  OAI21X1 U55 ( .A(n56), .B(n28), .C(n55), .Y(SUM[23]) );
  NAND2X1 U56 ( .A(n56), .B(n28), .Y(n55) );
  AOI21X1 U57 ( .A(n58), .B(A[22]), .C(n56), .Y(n57) );
  NOR2X1 U58 ( .A(n58), .B(A[22]), .Y(n56) );
  OAI21X1 U59 ( .A(n11), .B(n27), .C(n58), .Y(SUM[21]) );
  NAND2X1 U60 ( .A(n11), .B(n27), .Y(n58) );
  OAI21X1 U61 ( .A(n60), .B(n26), .C(n59), .Y(SUM[20]) );
  NAND2X1 U62 ( .A(n60), .B(n26), .Y(n59) );
  AOI21X1 U63 ( .A(A[0]), .B(A[1]), .C(n46), .Y(n61) );
  AOI21X1 U64 ( .A(n63), .B(A[19]), .C(n60), .Y(n62) );
  NOR2X1 U65 ( .A(n63), .B(A[19]), .Y(n60) );
  OAI21X1 U66 ( .A(n64), .B(n25), .C(n63), .Y(SUM[18]) );
  NAND2X1 U67 ( .A(n64), .B(n25), .Y(n63) );
  AOI21X1 U68 ( .A(n66), .B(A[17]), .C(n64), .Y(n65) );
  NOR2X1 U69 ( .A(n66), .B(A[17]), .Y(n64) );
  OAI21X1 U70 ( .A(n67), .B(n24), .C(n66), .Y(SUM[16]) );
  NAND2X1 U71 ( .A(n67), .B(n24), .Y(n66) );
  AOI21X1 U72 ( .A(n69), .B(A[15]), .C(n67), .Y(n68) );
  NOR2X1 U73 ( .A(n69), .B(A[15]), .Y(n67) );
  OAI21X1 U74 ( .A(n70), .B(n23), .C(n69), .Y(SUM[14]) );
  NAND2X1 U75 ( .A(n70), .B(n23), .Y(n69) );
  AOI21X1 U76 ( .A(n72), .B(A[13]), .C(n70), .Y(n71) );
  NOR2X1 U77 ( .A(n72), .B(A[13]), .Y(n70) );
  OAI21X1 U78 ( .A(n73), .B(n22), .C(n72), .Y(SUM[12]) );
  NAND2X1 U79 ( .A(n73), .B(n22), .Y(n72) );
  AOI21X1 U80 ( .A(n75), .B(A[11]), .C(n73), .Y(n74) );
  NOR2X1 U81 ( .A(n75), .B(A[11]), .Y(n73) );
  OAI21X1 U82 ( .A(n34), .B(n21), .C(n75), .Y(SUM[10]) );
  NAND2X1 U83 ( .A(n34), .B(n21), .Y(n75) );
  NOR2X1 U84 ( .A(n33), .B(A[9]), .Y(n34) );
  NAND2X1 U85 ( .A(n35), .B(n20), .Y(n33) );
  NOR2X1 U86 ( .A(n37), .B(A[7]), .Y(n35) );
  NAND2X1 U87 ( .A(n38), .B(n19), .Y(n37) );
  NOR2X1 U88 ( .A(n40), .B(A[5]), .Y(n38) );
  NAND2X1 U89 ( .A(n41), .B(n18), .Y(n40) );
  NOR2X1 U90 ( .A(n43), .B(A[3]), .Y(n41) );
  NAND2X1 U91 ( .A(n46), .B(n17), .Y(n43) );
  NOR2X1 U92 ( .A(A[1]), .B(A[0]), .Y(n46) );
endmodule


module flex_counter_NUM_CNT_BITS32_0_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module flex_counter_NUM_CNT_BITS32_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [31:0] rollover_val;
  output [31:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32,
         N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46,
         N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60,
         N61, N62, N63, N64, N65, N66, N67, n1, n2, n3, n4, n5, n6, n7, n8,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n135, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372, n373, n374, n375, n376,
         n377, n378, n379, n380, n381, n382, n383, n384, n385, n386, n387,
         n388, n389, n390, n391, n392, n393, n394, n395, n396, n397, n398,
         n399, n400, n401, n402, n403, n404, n405, n406, n407, n408, n409,
         n410, n411, n412, n413, n414, n415, n416, n417, n418, n419, n420,
         n421, n422, n423, n424;

  DFFSR \count_out_reg[0]  ( .D(n73), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n74), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n75), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n135), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n251), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n252), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n253), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(n254), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(n255), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(n256), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[10]  ( .D(n257), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[11]  ( .D(n258), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[12]  ( .D(n259), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[13]  ( .D(n260), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[14]  ( .D(n261), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[14]) );
  DFFSR \count_out_reg[15]  ( .D(n262), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[15]) );
  DFFSR \count_out_reg[16]  ( .D(n263), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[16]) );
  DFFSR \count_out_reg[17]  ( .D(n264), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[17]) );
  DFFSR \count_out_reg[18]  ( .D(n265), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[18]) );
  DFFSR \count_out_reg[19]  ( .D(n266), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[19]) );
  DFFSR \count_out_reg[20]  ( .D(n267), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[20]) );
  DFFSR \count_out_reg[21]  ( .D(n268), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[21]) );
  DFFSR \count_out_reg[22]  ( .D(n269), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[22]) );
  DFFSR \count_out_reg[23]  ( .D(n270), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[23]) );
  DFFSR \count_out_reg[24]  ( .D(n271), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[24]) );
  DFFSR \count_out_reg[25]  ( .D(n272), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[25]) );
  DFFSR \count_out_reg[26]  ( .D(n273), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[26]) );
  DFFSR \count_out_reg[27]  ( .D(n274), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[27]) );
  DFFSR \count_out_reg[28]  ( .D(n275), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[28]) );
  DFFSR \count_out_reg[29]  ( .D(n276), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[29]) );
  DFFSR \count_out_reg[30]  ( .D(n277), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[30]) );
  DFFSR \count_out_reg[31]  ( .D(n278), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[31]) );
  DFFSR rollover_flag_reg ( .D(n279), .CLK(clk), .R(n5), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U70 ( .A(n424), .B(n423), .C(n422), .Y(n279) );
  NAND2X1 U71 ( .A(rollover_flag), .B(n421), .Y(n422) );
  NAND2X1 U72 ( .A(n420), .B(n419), .Y(n423) );
  NOR2X1 U73 ( .A(n418), .B(n417), .Y(n419) );
  NAND3X1 U74 ( .A(n416), .B(n415), .C(n414), .Y(n417) );
  NOR2X1 U75 ( .A(n413), .B(n412), .Y(n414) );
  XNOR2X1 U76 ( .A(n70), .B(N66), .Y(n412) );
  XNOR2X1 U77 ( .A(n71), .B(N67), .Y(n413) );
  XNOR2X1 U78 ( .A(count_out[27]), .B(N63), .Y(n415) );
  XNOR2X1 U79 ( .A(count_out[26]), .B(N62), .Y(n416) );
  NAND3X1 U80 ( .A(n411), .B(n410), .C(n409), .Y(n418) );
  NOR2X1 U81 ( .A(n408), .B(n407), .Y(n409) );
  XNOR2X1 U82 ( .A(n58), .B(N54), .Y(n407) );
  XNOR2X1 U83 ( .A(n59), .B(N55), .Y(n408) );
  XNOR2X1 U84 ( .A(count_out[23]), .B(N59), .Y(n410) );
  NOR2X1 U85 ( .A(n406), .B(n405), .Y(n411) );
  XNOR2X1 U86 ( .A(n49), .B(N45), .Y(n405) );
  XNOR2X1 U87 ( .A(n62), .B(N58), .Y(n406) );
  NOR2X1 U88 ( .A(n404), .B(n403), .Y(n420) );
  NAND3X1 U89 ( .A(n402), .B(n401), .C(n400), .Y(n403) );
  NOR2X1 U90 ( .A(n399), .B(n398), .Y(n400) );
  XNOR2X1 U91 ( .A(n54), .B(N50), .Y(n398) );
  XNOR2X1 U92 ( .A(n55), .B(N51), .Y(n399) );
  XNOR2X1 U93 ( .A(count_out[11]), .B(N47), .Y(n401) );
  XNOR2X1 U94 ( .A(count_out[10]), .B(N46), .Y(n402) );
  NAND3X1 U95 ( .A(n397), .B(n396), .C(n395), .Y(n404) );
  NOR2X1 U96 ( .A(n394), .B(n393), .Y(n395) );
  XNOR2X1 U97 ( .A(n46), .B(N42), .Y(n393) );
  XNOR2X1 U98 ( .A(n47), .B(N43), .Y(n394) );
  XNOR2X1 U99 ( .A(count_out[3]), .B(N39), .Y(n396) );
  XNOR2X1 U100 ( .A(count_out[2]), .B(N38), .Y(n397) );
  NAND2X1 U101 ( .A(n392), .B(n391), .Y(n424) );
  NOR2X1 U102 ( .A(n390), .B(n389), .Y(n391) );
  NAND3X1 U103 ( .A(n388), .B(n387), .C(n386), .Y(n389) );
  NOR2X1 U104 ( .A(n385), .B(n384), .Y(n386) );
  XNOR2X1 U105 ( .A(n68), .B(N64), .Y(n384) );
  XNOR2X1 U106 ( .A(n57), .B(N53), .Y(n385) );
  XNOR2X1 U107 ( .A(count_out[29]), .B(N65), .Y(n387) );
  XNOR2X1 U108 ( .A(count_out[24]), .B(N60), .Y(n388) );
  NAND3X1 U109 ( .A(n383), .B(n382), .C(n381), .Y(n390) );
  NOR2X1 U110 ( .A(n380), .B(n379), .Y(n381) );
  XNOR2X1 U111 ( .A(n56), .B(N52), .Y(n379) );
  XNOR2X1 U112 ( .A(n61), .B(N57), .Y(n380) );
  XNOR2X1 U113 ( .A(count_out[20]), .B(N56), .Y(n382) );
  NOR2X1 U114 ( .A(clear), .B(n421), .Y(n383) );
  NOR2X1 U115 ( .A(n378), .B(n377), .Y(n392) );
  NAND3X1 U116 ( .A(n376), .B(n375), .C(n374), .Y(n377) );
  NOR2X1 U117 ( .A(n373), .B(n372), .Y(n374) );
  XNOR2X1 U118 ( .A(n52), .B(N48), .Y(n372) );
  XNOR2X1 U119 ( .A(n8), .B(N37), .Y(n373) );
  XNOR2X1 U120 ( .A(count_out[13]), .B(N49), .Y(n375) );
  XNOR2X1 U121 ( .A(count_out[8]), .B(N44), .Y(n376) );
  NAND3X1 U122 ( .A(n371), .B(n370), .C(n369), .Y(n378) );
  NOR2X1 U123 ( .A(n368), .B(n367), .Y(n369) );
  XNOR2X1 U124 ( .A(n44), .B(N40), .Y(n367) );
  XNOR2X1 U125 ( .A(n65), .B(N61), .Y(n368) );
  XNOR2X1 U126 ( .A(count_out[5]), .B(N41), .Y(n370) );
  XNOR2X1 U127 ( .A(count_out[0]), .B(N36), .Y(n371) );
  OAI21X1 U128 ( .A(n71), .B(n2), .C(n366), .Y(n278) );
  NAND2X1 U129 ( .A(N35), .B(n4), .Y(n366) );
  OAI21X1 U130 ( .A(n70), .B(n2), .C(n365), .Y(n277) );
  NAND2X1 U131 ( .A(N34), .B(n4), .Y(n365) );
  OAI21X1 U132 ( .A(n69), .B(n2), .C(n364), .Y(n276) );
  NAND2X1 U133 ( .A(N33), .B(n4), .Y(n364) );
  OAI21X1 U134 ( .A(n68), .B(n2), .C(n363), .Y(n275) );
  NAND2X1 U135 ( .A(N32), .B(n4), .Y(n363) );
  OAI21X1 U136 ( .A(n67), .B(n2), .C(n362), .Y(n274) );
  NAND2X1 U137 ( .A(N31), .B(n4), .Y(n362) );
  OAI21X1 U138 ( .A(n66), .B(n2), .C(n361), .Y(n273) );
  NAND2X1 U139 ( .A(N30), .B(n4), .Y(n361) );
  OAI21X1 U140 ( .A(n65), .B(n2), .C(n360), .Y(n272) );
  NAND2X1 U141 ( .A(N29), .B(n4), .Y(n360) );
  OAI21X1 U142 ( .A(n64), .B(n2), .C(n359), .Y(n271) );
  NAND2X1 U143 ( .A(N28), .B(n4), .Y(n359) );
  OAI21X1 U144 ( .A(n63), .B(n2), .C(n358), .Y(n270) );
  NAND2X1 U145 ( .A(N27), .B(n4), .Y(n358) );
  OAI21X1 U146 ( .A(n62), .B(n2), .C(n357), .Y(n269) );
  NAND2X1 U147 ( .A(N26), .B(n4), .Y(n357) );
  OAI21X1 U148 ( .A(n61), .B(n2), .C(n356), .Y(n268) );
  NAND2X1 U149 ( .A(N25), .B(n4), .Y(n356) );
  OAI21X1 U150 ( .A(n60), .B(n2), .C(n355), .Y(n267) );
  NAND2X1 U151 ( .A(N24), .B(n4), .Y(n355) );
  OAI21X1 U152 ( .A(n59), .B(n3), .C(n354), .Y(n266) );
  NAND2X1 U153 ( .A(N23), .B(n4), .Y(n354) );
  OAI21X1 U154 ( .A(n58), .B(n3), .C(n353), .Y(n265) );
  NAND2X1 U155 ( .A(N22), .B(n4), .Y(n353) );
  OAI21X1 U156 ( .A(n57), .B(n3), .C(n352), .Y(n264) );
  NAND2X1 U157 ( .A(N21), .B(n4), .Y(n352) );
  OAI21X1 U158 ( .A(n56), .B(n3), .C(n351), .Y(n263) );
  NAND2X1 U159 ( .A(N20), .B(n4), .Y(n351) );
  OAI21X1 U160 ( .A(n55), .B(n3), .C(n350), .Y(n262) );
  NAND2X1 U161 ( .A(N19), .B(n4), .Y(n350) );
  OAI21X1 U162 ( .A(n54), .B(n3), .C(n349), .Y(n261) );
  NAND2X1 U163 ( .A(N18), .B(n4), .Y(n349) );
  OAI21X1 U164 ( .A(n53), .B(n3), .C(n348), .Y(n260) );
  NAND2X1 U165 ( .A(N17), .B(n4), .Y(n348) );
  OAI21X1 U166 ( .A(n52), .B(n3), .C(n347), .Y(n259) );
  NAND2X1 U167 ( .A(N16), .B(n4), .Y(n347) );
  OAI21X1 U168 ( .A(n51), .B(n3), .C(n346), .Y(n258) );
  NAND2X1 U169 ( .A(N15), .B(n4), .Y(n346) );
  OAI21X1 U170 ( .A(n50), .B(n3), .C(n345), .Y(n257) );
  NAND2X1 U171 ( .A(N14), .B(n4), .Y(n345) );
  OAI21X1 U172 ( .A(n49), .B(n3), .C(n344), .Y(n256) );
  NAND2X1 U173 ( .A(N13), .B(n4), .Y(n344) );
  OAI21X1 U174 ( .A(n48), .B(n3), .C(n343), .Y(n255) );
  NAND2X1 U175 ( .A(N12), .B(n4), .Y(n343) );
  OAI21X1 U176 ( .A(n47), .B(n3), .C(n342), .Y(n254) );
  NAND2X1 U177 ( .A(N11), .B(n4), .Y(n342) );
  OAI21X1 U178 ( .A(n46), .B(n2), .C(n341), .Y(n253) );
  NAND2X1 U179 ( .A(N10), .B(n4), .Y(n341) );
  OAI21X1 U180 ( .A(n45), .B(n3), .C(n340), .Y(n252) );
  NAND2X1 U181 ( .A(N9), .B(n4), .Y(n340) );
  OAI21X1 U182 ( .A(n44), .B(n2), .C(n339), .Y(n251) );
  NAND2X1 U183 ( .A(N8), .B(n4), .Y(n339) );
  OAI21X1 U184 ( .A(n43), .B(n3), .C(n338), .Y(n135) );
  NAND2X1 U185 ( .A(N7), .B(n4), .Y(n338) );
  OAI21X1 U186 ( .A(n42), .B(n2), .C(n337), .Y(n75) );
  NAND2X1 U187 ( .A(N6), .B(n4), .Y(n337) );
  OAI21X1 U188 ( .A(n8), .B(n3), .C(n336), .Y(n74) );
  NAND2X1 U189 ( .A(N5), .B(n4), .Y(n336) );
  OAI21X1 U190 ( .A(n7), .B(n2), .C(n335), .Y(n73) );
  NAND2X1 U191 ( .A(N4), .B(n4), .Y(n335) );
  OAI21X1 U193 ( .A(n333), .B(n332), .C(n72), .Y(n334) );
  NAND2X1 U194 ( .A(n331), .B(n330), .Y(n332) );
  NOR2X1 U195 ( .A(n329), .B(n328), .Y(n330) );
  NAND3X1 U196 ( .A(n327), .B(n326), .C(n325), .Y(n328) );
  NOR2X1 U197 ( .A(n324), .B(n323), .Y(n325) );
  XNOR2X1 U198 ( .A(rollover_val[30]), .B(n70), .Y(n323) );
  XNOR2X1 U199 ( .A(rollover_val[31]), .B(n71), .Y(n324) );
  XNOR2X1 U200 ( .A(count_out[27]), .B(rollover_val[27]), .Y(n326) );
  XNOR2X1 U201 ( .A(count_out[26]), .B(rollover_val[26]), .Y(n327) );
  NAND3X1 U202 ( .A(n322), .B(n321), .C(n320), .Y(n329) );
  NOR2X1 U203 ( .A(n319), .B(n318), .Y(n320) );
  XNOR2X1 U204 ( .A(rollover_val[22]), .B(n62), .Y(n318) );
  XNOR2X1 U205 ( .A(rollover_val[23]), .B(n63), .Y(n319) );
  XNOR2X1 U206 ( .A(count_out[19]), .B(rollover_val[19]), .Y(n321) );
  XNOR2X1 U207 ( .A(count_out[18]), .B(rollover_val[18]), .Y(n322) );
  NOR2X1 U208 ( .A(n317), .B(n316), .Y(n331) );
  NAND3X1 U209 ( .A(n315), .B(n314), .C(n313), .Y(n316) );
  NOR2X1 U210 ( .A(n312), .B(n311), .Y(n313) );
  XNOR2X1 U211 ( .A(rollover_val[14]), .B(n54), .Y(n311) );
  XNOR2X1 U212 ( .A(rollover_val[15]), .B(n55), .Y(n312) );
  XNOR2X1 U213 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n314) );
  XNOR2X1 U214 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n315) );
  NAND3X1 U215 ( .A(n310), .B(n309), .C(n308), .Y(n317) );
  NOR2X1 U216 ( .A(n307), .B(n306), .Y(n308) );
  XNOR2X1 U217 ( .A(rollover_val[6]), .B(n46), .Y(n306) );
  XNOR2X1 U218 ( .A(rollover_val[7]), .B(n47), .Y(n307) );
  XNOR2X1 U219 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n309) );
  XNOR2X1 U220 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n310) );
  NAND2X1 U221 ( .A(n305), .B(n304), .Y(n333) );
  NOR2X1 U222 ( .A(n303), .B(n302), .Y(n304) );
  NAND3X1 U223 ( .A(n301), .B(n300), .C(n299), .Y(n302) );
  NOR2X1 U224 ( .A(n298), .B(n297), .Y(n299) );
  XNOR2X1 U225 ( .A(rollover_val[29]), .B(n69), .Y(n297) );
  XNOR2X1 U226 ( .A(rollover_val[28]), .B(n68), .Y(n298) );
  XNOR2X1 U227 ( .A(count_out[24]), .B(rollover_val[24]), .Y(n300) );
  XNOR2X1 U228 ( .A(count_out[25]), .B(rollover_val[25]), .Y(n301) );
  NAND3X1 U229 ( .A(n296), .B(n295), .C(n294), .Y(n303) );
  NOR2X1 U230 ( .A(n293), .B(n292), .Y(n294) );
  XNOR2X1 U231 ( .A(rollover_val[21]), .B(n61), .Y(n292) );
  XNOR2X1 U232 ( .A(rollover_val[20]), .B(n60), .Y(n293) );
  XNOR2X1 U233 ( .A(count_out[16]), .B(rollover_val[16]), .Y(n295) );
  XNOR2X1 U234 ( .A(count_out[17]), .B(rollover_val[17]), .Y(n296) );
  NOR2X1 U235 ( .A(n291), .B(n290), .Y(n305) );
  NAND3X1 U236 ( .A(n289), .B(n288), .C(n287), .Y(n290) );
  NOR2X1 U237 ( .A(n286), .B(n285), .Y(n287) );
  XNOR2X1 U238 ( .A(rollover_val[13]), .B(n53), .Y(n285) );
  XNOR2X1 U239 ( .A(rollover_val[12]), .B(n52), .Y(n286) );
  XNOR2X1 U240 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n288) );
  XNOR2X1 U241 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n289) );
  NAND3X1 U242 ( .A(n284), .B(n283), .C(n282), .Y(n291) );
  NOR2X1 U243 ( .A(n281), .B(n280), .Y(n282) );
  XNOR2X1 U244 ( .A(rollover_val[5]), .B(n45), .Y(n280) );
  XNOR2X1 U245 ( .A(rollover_val[4]), .B(n44), .Y(n281) );
  XNOR2X1 U246 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n283) );
  XNOR2X1 U247 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n284) );
  NOR2X1 U248 ( .A(clear), .B(count_enable), .Y(n421) );
  flex_counter_NUM_CNT_BITS32_0_DW01_dec_0 sub_56 ( .A(rollover_val), .SUM({
        N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55, N54, 
        N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  flex_counter_NUM_CNT_BITS32_0_DW01_inc_0 add_54 ( .A(count_out), .SUM({N35, 
        N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, 
        N20, N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5, N4}) );
  INVX2 U36 ( .A(n6), .Y(n5) );
  INVX2 U37 ( .A(n_rst), .Y(n6) );
  INVX2 U38 ( .A(n421), .Y(n2) );
  INVX2 U39 ( .A(n421), .Y(n3) );
  INVX2 U40 ( .A(n1), .Y(n4) );
  OR2X1 U41 ( .A(n421), .B(n334), .Y(n1) );
  INVX2 U42 ( .A(count_out[0]), .Y(n7) );
  INVX2 U43 ( .A(count_out[1]), .Y(n8) );
  INVX2 U44 ( .A(count_out[2]), .Y(n42) );
  INVX2 U45 ( .A(count_out[3]), .Y(n43) );
  INVX2 U46 ( .A(count_out[4]), .Y(n44) );
  INVX2 U47 ( .A(count_out[5]), .Y(n45) );
  INVX2 U48 ( .A(count_out[6]), .Y(n46) );
  INVX2 U49 ( .A(count_out[7]), .Y(n47) );
  INVX2 U50 ( .A(count_out[8]), .Y(n48) );
  INVX2 U51 ( .A(count_out[9]), .Y(n49) );
  INVX2 U52 ( .A(count_out[10]), .Y(n50) );
  INVX2 U53 ( .A(count_out[11]), .Y(n51) );
  INVX2 U54 ( .A(count_out[12]), .Y(n52) );
  INVX2 U55 ( .A(count_out[13]), .Y(n53) );
  INVX2 U56 ( .A(count_out[14]), .Y(n54) );
  INVX2 U57 ( .A(count_out[15]), .Y(n55) );
  INVX2 U58 ( .A(count_out[16]), .Y(n56) );
  INVX2 U59 ( .A(count_out[17]), .Y(n57) );
  INVX2 U60 ( .A(count_out[18]), .Y(n58) );
  INVX2 U61 ( .A(count_out[19]), .Y(n59) );
  INVX2 U62 ( .A(count_out[20]), .Y(n60) );
  INVX2 U63 ( .A(count_out[21]), .Y(n61) );
  INVX2 U64 ( .A(count_out[22]), .Y(n62) );
  INVX2 U65 ( .A(count_out[23]), .Y(n63) );
  INVX2 U66 ( .A(count_out[24]), .Y(n64) );
  INVX2 U67 ( .A(count_out[25]), .Y(n65) );
  INVX2 U68 ( .A(count_out[26]), .Y(n66) );
  INVX2 U69 ( .A(count_out[27]), .Y(n67) );
  INVX2 U192 ( .A(count_out[28]), .Y(n68) );
  INVX2 U249 ( .A(count_out[29]), .Y(n69) );
  INVX2 U250 ( .A(count_out[30]), .Y(n70) );
  INVX2 U251 ( .A(count_out[31]), .Y(n71) );
  INVX2 U252 ( .A(clear), .Y(n72) );
endmodule


module fifo_r ( HCLK, HRESETn, shift_enable, load_enable, HRDATA, data_in, 
        transfer_data_complete_r );
  input [31:0] HRDATA;
  output [7:0] data_in;
  input HCLK, HRESETn, shift_enable, load_enable;
  output transfer_data_complete_r;
  wire   n66, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n92, n93, n94, n95,
         n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n67, n91, n132, n133, n134,
         n135, n136, n137;
  wire   [23:0] array_out;

  DFFSR \array_out_reg[7]  ( .D(n124), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[7]) );
  DFFSR \array_out_reg[15]  ( .D(n116), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[15]) );
  DFFSR \array_out_reg[23]  ( .D(n108), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[23]) );
  DFFSR \array_out_reg[31]  ( .D(n100), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        data_in[7]) );
  DFFSR \array_out_reg[6]  ( .D(n125), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[6]) );
  DFFSR \array_out_reg[14]  ( .D(n117), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[14]) );
  DFFSR \array_out_reg[22]  ( .D(n109), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        array_out[22]) );
  DFFSR \array_out_reg[30]  ( .D(n101), .CLK(HCLK), .R(1'b1), .S(n35), .Q(
        data_in[6]) );
  DFFSR \array_out_reg[5]  ( .D(n126), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[5]) );
  DFFSR \array_out_reg[13]  ( .D(n118), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[13]) );
  DFFSR \array_out_reg[21]  ( .D(n110), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[21]) );
  DFFSR \array_out_reg[29]  ( .D(n102), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[5]) );
  DFFSR \array_out_reg[4]  ( .D(n127), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[4]) );
  DFFSR \array_out_reg[12]  ( .D(n119), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[12]) );
  DFFSR \array_out_reg[20]  ( .D(n111), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[20]) );
  DFFSR \array_out_reg[28]  ( .D(n103), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[4]) );
  DFFSR \array_out_reg[3]  ( .D(n128), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[3]) );
  DFFSR \array_out_reg[11]  ( .D(n120), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[11]) );
  DFFSR \array_out_reg[19]  ( .D(n112), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[19]) );
  DFFSR \array_out_reg[27]  ( .D(n104), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[3]) );
  DFFSR \array_out_reg[2]  ( .D(n129), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[2]) );
  DFFSR \array_out_reg[10]  ( .D(n121), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[10]) );
  DFFSR \array_out_reg[18]  ( .D(n113), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[18]) );
  DFFSR \array_out_reg[26]  ( .D(n105), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[2]) );
  DFFSR \array_out_reg[1]  ( .D(n130), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[1]) );
  DFFSR \array_out_reg[9]  ( .D(n122), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[9]) );
  DFFSR \array_out_reg[17]  ( .D(n114), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[17]) );
  DFFSR \array_out_reg[25]  ( .D(n106), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[1]) );
  DFFSR \array_out_reg[0]  ( .D(n131), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[0]) );
  DFFSR \array_out_reg[8]  ( .D(n123), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        array_out[8]) );
  DFFSR \array_out_reg[16]  ( .D(n115), .CLK(HCLK), .R(1'b1), .S(n37), .Q(
        array_out[16]) );
  DFFSR \array_out_reg[24]  ( .D(n107), .CLK(HCLK), .R(1'b1), .S(n36), .Q(
        data_in[0]) );
  OAI21X1 U68 ( .A(n34), .B(n44), .C(n66), .Y(n100) );
  AOI22X1 U69 ( .A(load_enable), .B(HRDATA[31]), .C(array_out[23]), .D(n39), 
        .Y(n66) );
  OAI21X1 U70 ( .A(n34), .B(n47), .C(n68), .Y(n101) );
  AOI22X1 U71 ( .A(HRDATA[30]), .B(load_enable), .C(array_out[22]), .D(n39), 
        .Y(n68) );
  OAI21X1 U72 ( .A(n34), .B(n50), .C(n69), .Y(n102) );
  AOI22X1 U73 ( .A(HRDATA[29]), .B(load_enable), .C(array_out[21]), .D(n39), 
        .Y(n69) );
  OAI21X1 U74 ( .A(n34), .B(n53), .C(n70), .Y(n103) );
  AOI22X1 U75 ( .A(HRDATA[28]), .B(load_enable), .C(array_out[20]), .D(n39), 
        .Y(n70) );
  OAI21X1 U76 ( .A(n34), .B(n56), .C(n71), .Y(n104) );
  AOI22X1 U77 ( .A(HRDATA[27]), .B(load_enable), .C(array_out[19]), .D(n39), 
        .Y(n71) );
  OAI21X1 U78 ( .A(n34), .B(n59), .C(n72), .Y(n105) );
  AOI22X1 U79 ( .A(HRDATA[26]), .B(load_enable), .C(array_out[18]), .D(n39), 
        .Y(n72) );
  OAI21X1 U80 ( .A(n34), .B(n62), .C(n73), .Y(n106) );
  AOI22X1 U81 ( .A(HRDATA[25]), .B(load_enable), .C(array_out[17]), .D(n39), 
        .Y(n73) );
  OAI21X1 U82 ( .A(n34), .B(n65), .C(n74), .Y(n107) );
  AOI22X1 U83 ( .A(HRDATA[24]), .B(load_enable), .C(array_out[16]), .D(n39), 
        .Y(n74) );
  OAI21X1 U84 ( .A(n43), .B(n34), .C(n75), .Y(n108) );
  AOI22X1 U85 ( .A(HRDATA[23]), .B(load_enable), .C(array_out[15]), .D(n39), 
        .Y(n75) );
  OAI21X1 U86 ( .A(n34), .B(n46), .C(n76), .Y(n109) );
  AOI22X1 U87 ( .A(HRDATA[22]), .B(load_enable), .C(array_out[14]), .D(n39), 
        .Y(n76) );
  OAI21X1 U88 ( .A(n34), .B(n49), .C(n77), .Y(n110) );
  AOI22X1 U89 ( .A(HRDATA[21]), .B(load_enable), .C(array_out[13]), .D(n39), 
        .Y(n77) );
  OAI21X1 U90 ( .A(n34), .B(n52), .C(n78), .Y(n111) );
  AOI22X1 U91 ( .A(HRDATA[20]), .B(load_enable), .C(array_out[12]), .D(n39), 
        .Y(n78) );
  OAI21X1 U92 ( .A(n34), .B(n55), .C(n79), .Y(n112) );
  AOI22X1 U93 ( .A(HRDATA[19]), .B(load_enable), .C(array_out[11]), .D(n39), 
        .Y(n79) );
  OAI21X1 U94 ( .A(n34), .B(n58), .C(n80), .Y(n113) );
  AOI22X1 U95 ( .A(HRDATA[18]), .B(load_enable), .C(array_out[10]), .D(n40), 
        .Y(n80) );
  OAI21X1 U96 ( .A(n34), .B(n61), .C(n81), .Y(n114) );
  AOI22X1 U97 ( .A(HRDATA[17]), .B(load_enable), .C(array_out[9]), .D(n40), 
        .Y(n81) );
  OAI21X1 U98 ( .A(n34), .B(n64), .C(n82), .Y(n115) );
  AOI22X1 U99 ( .A(HRDATA[16]), .B(load_enable), .C(array_out[8]), .D(n40), 
        .Y(n82) );
  OAI21X1 U100 ( .A(n34), .B(n42), .C(n83), .Y(n116) );
  AOI22X1 U101 ( .A(HRDATA[15]), .B(load_enable), .C(array_out[7]), .D(n40), 
        .Y(n83) );
  OAI21X1 U102 ( .A(n34), .B(n45), .C(n84), .Y(n117) );
  AOI22X1 U103 ( .A(HRDATA[14]), .B(load_enable), .C(array_out[6]), .D(n40), 
        .Y(n84) );
  OAI21X1 U104 ( .A(n34), .B(n48), .C(n85), .Y(n118) );
  AOI22X1 U105 ( .A(HRDATA[13]), .B(load_enable), .C(array_out[5]), .D(n40), 
        .Y(n85) );
  OAI21X1 U106 ( .A(n34), .B(n51), .C(n86), .Y(n119) );
  AOI22X1 U107 ( .A(HRDATA[12]), .B(load_enable), .C(array_out[4]), .D(n40), 
        .Y(n86) );
  OAI21X1 U108 ( .A(n34), .B(n54), .C(n87), .Y(n120) );
  AOI22X1 U109 ( .A(HRDATA[11]), .B(load_enable), .C(array_out[3]), .D(n40), 
        .Y(n87) );
  OAI21X1 U110 ( .A(n34), .B(n57), .C(n88), .Y(n121) );
  AOI22X1 U111 ( .A(HRDATA[10]), .B(load_enable), .C(array_out[2]), .D(n40), 
        .Y(n88) );
  OAI21X1 U112 ( .A(n34), .B(n60), .C(n89), .Y(n122) );
  AOI22X1 U113 ( .A(HRDATA[9]), .B(load_enable), .C(array_out[1]), .D(n40), 
        .Y(n89) );
  OAI21X1 U114 ( .A(n34), .B(n63), .C(n90), .Y(n123) );
  AOI22X1 U115 ( .A(HRDATA[8]), .B(load_enable), .C(array_out[0]), .D(n40), 
        .Y(n90) );
  OAI21X1 U116 ( .A(n38), .B(n67), .C(n92), .Y(n124) );
  AOI21X1 U117 ( .A(array_out[7]), .B(n38), .C(n40), .Y(n92) );
  OAI21X1 U118 ( .A(n38), .B(n91), .C(n93), .Y(n125) );
  AOI21X1 U119 ( .A(array_out[6]), .B(n38), .C(n40), .Y(n93) );
  OAI21X1 U120 ( .A(n38), .B(n132), .C(n94), .Y(n126) );
  AOI21X1 U121 ( .A(array_out[5]), .B(n38), .C(n39), .Y(n94) );
  OAI21X1 U122 ( .A(n38), .B(n133), .C(n95), .Y(n127) );
  AOI21X1 U123 ( .A(array_out[4]), .B(n38), .C(n40), .Y(n95) );
  OAI21X1 U124 ( .A(n38), .B(n134), .C(n96), .Y(n128) );
  AOI21X1 U125 ( .A(array_out[3]), .B(n38), .C(n40), .Y(n96) );
  OAI21X1 U126 ( .A(n38), .B(n135), .C(n97), .Y(n129) );
  AOI21X1 U127 ( .A(array_out[2]), .B(n38), .C(n39), .Y(n97) );
  OAI21X1 U128 ( .A(n38), .B(n136), .C(n98), .Y(n130) );
  AOI21X1 U129 ( .A(array_out[1]), .B(n38), .C(n39), .Y(n98) );
  OAI21X1 U130 ( .A(n38), .B(n137), .C(n99), .Y(n131) );
  AOI21X1 U131 ( .A(array_out[0]), .B(n38), .C(n40), .Y(n99) );
  flex_counter_NUM_CNT_BITS32_0 SHIFT_COUNTER_READ ( .clk(HCLK), .n_rst(n35), 
        .clear(1'b0), .count_enable(shift_enable), .rollover_val({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b1}), .rollover_flag(
        transfer_data_complete_r) );
  OR2X2 U35 ( .A(load_enable), .B(shift_enable), .Y(n34) );
  INVX2 U36 ( .A(n33), .Y(n39) );
  INVX2 U37 ( .A(n33), .Y(n40) );
  INVX2 U38 ( .A(n34), .Y(n38) );
  OR2X1 U39 ( .A(n38), .B(load_enable), .Y(n33) );
  INVX2 U40 ( .A(n41), .Y(n36) );
  INVX2 U41 ( .A(n41), .Y(n37) );
  INVX2 U42 ( .A(n41), .Y(n35) );
  INVX2 U43 ( .A(HRESETn), .Y(n41) );
  INVX2 U44 ( .A(array_out[15]), .Y(n42) );
  INVX2 U45 ( .A(array_out[23]), .Y(n43) );
  INVX2 U46 ( .A(data_in[7]), .Y(n44) );
  INVX2 U47 ( .A(array_out[14]), .Y(n45) );
  INVX2 U48 ( .A(array_out[22]), .Y(n46) );
  INVX2 U49 ( .A(data_in[6]), .Y(n47) );
  INVX2 U50 ( .A(array_out[13]), .Y(n48) );
  INVX2 U51 ( .A(array_out[21]), .Y(n49) );
  INVX2 U52 ( .A(data_in[5]), .Y(n50) );
  INVX2 U53 ( .A(array_out[12]), .Y(n51) );
  INVX2 U54 ( .A(array_out[20]), .Y(n52) );
  INVX2 U55 ( .A(data_in[4]), .Y(n53) );
  INVX2 U56 ( .A(array_out[11]), .Y(n54) );
  INVX2 U57 ( .A(array_out[19]), .Y(n55) );
  INVX2 U58 ( .A(data_in[3]), .Y(n56) );
  INVX2 U59 ( .A(array_out[10]), .Y(n57) );
  INVX2 U60 ( .A(array_out[18]), .Y(n58) );
  INVX2 U61 ( .A(data_in[2]), .Y(n59) );
  INVX2 U62 ( .A(array_out[9]), .Y(n60) );
  INVX2 U63 ( .A(array_out[17]), .Y(n61) );
  INVX2 U64 ( .A(data_in[1]), .Y(n62) );
  INVX2 U65 ( .A(array_out[8]), .Y(n63) );
  INVX2 U66 ( .A(array_out[16]), .Y(n64) );
  INVX2 U67 ( .A(data_in[0]), .Y(n65) );
  INVX2 U132 ( .A(HRDATA[7]), .Y(n67) );
  INVX2 U133 ( .A(HRDATA[6]), .Y(n91) );
  INVX2 U134 ( .A(HRDATA[5]), .Y(n132) );
  INVX2 U135 ( .A(HRDATA[4]), .Y(n133) );
  INVX2 U136 ( .A(HRDATA[3]), .Y(n134) );
  INVX2 U137 ( .A(HRDATA[2]), .Y(n135) );
  INVX2 U138 ( .A(HRDATA[1]), .Y(n136) );
  INVX2 U139 ( .A(HRDATA[0]), .Y(n137) );
endmodule


module ahb_master ( HCLK, HRESETn, HREADY, read_enable, write_enable, length, 
        width, source_addr, dest_addr, HRDATA, sobel_result1, sobel_result2, 
        HADDR, pixel_out, HWDATA, HWRITE, transfer_data_complete_r, 
        transfer_data_complete_w, shift_enable_r );
  input [15:0] length;
  input [15:0] width;
  input [31:0] source_addr;
  input [31:0] dest_addr;
  input [31:0] HRDATA;
  input [7:0] sobel_result1;
  input [7:0] sobel_result2;
  output [31:0] HADDR;
  output [7:0] pixel_out;
  output [31:0] HWDATA;
  input HCLK, HRESETn, HREADY, read_enable, write_enable;
  output HWRITE, transfer_data_complete_r, transfer_data_complete_w,
         shift_enable_r;
  wire   transfer_addr_complete_r, end_of_image, addr_enable_r, load_enable_r,
         addr_update_enable_r, shift_enable_w, addr_update_enable_w, plus4_r,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n1, n2, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46;
  wire   [31:0] start_addr;
  wire   [31:0] curr_addr_w;
  wire   [31:0] curr_addr_r;
  tri   [31:0] HADDR;
  tri   HWRITE;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;
  assign HWDATA[31] = 1'b1;
  assign HWDATA[30] = 1'b1;
  assign HWDATA[29] = 1'b1;
  assign HWDATA[28] = 1'b1;
  assign HWDATA[27] = 1'b1;
  assign HWDATA[26] = 1'b1;
  assign HWDATA[25] = 1'b1;
  assign HWDATA[24] = 1'b1;
  assign HWDATA[23] = 1'b1;
  assign HWDATA[22] = 1'b1;
  assign HWDATA[21] = 1'b1;
  assign HWDATA[20] = 1'b1;
  assign HWDATA[19] = 1'b1;
  assign HWDATA[18] = 1'b1;
  assign HWDATA[17] = 1'b1;
  assign HWDATA[16] = 1'b1;
  assign transfer_data_complete_w = 1'b0;

  OAI22X1 U3 ( .A(start_addr[9]), .B(n36), .C(n2), .D(curr_addr_w[9]), .Y(n25)
         );
  OAI22X1 U4 ( .A(start_addr[8]), .B(n39), .C(n2), .D(curr_addr_w[8]), .Y(n26)
         );
  OAI22X1 U5 ( .A(start_addr[7]), .B(n39), .C(n2), .D(curr_addr_w[7]), .Y(n27)
         );
  OAI22X1 U6 ( .A(start_addr[6]), .B(n39), .C(n2), .D(curr_addr_w[6]), .Y(n28)
         );
  OAI22X1 U7 ( .A(start_addr[5]), .B(n39), .C(n2), .D(curr_addr_w[5]), .Y(n29)
         );
  OAI22X1 U8 ( .A(start_addr[4]), .B(n39), .C(n2), .D(curr_addr_w[4]), .Y(n30)
         );
  OAI22X1 U9 ( .A(start_addr[3]), .B(n39), .C(n2), .D(curr_addr_w[3]), .Y(n31)
         );
  OAI22X1 U10 ( .A(start_addr[31]), .B(n39), .C(n2), .D(curr_addr_w[31]), .Y(
        n3) );
  OAI22X1 U11 ( .A(start_addr[30]), .B(n38), .C(n2), .D(curr_addr_w[30]), .Y(
        n4) );
  OAI22X1 U12 ( .A(start_addr[2]), .B(n38), .C(n2), .D(curr_addr_w[2]), .Y(n32) );
  OAI22X1 U13 ( .A(start_addr[29]), .B(n38), .C(n2), .D(curr_addr_w[29]), .Y(
        n5) );
  OAI22X1 U14 ( .A(start_addr[28]), .B(n38), .C(n2), .D(curr_addr_w[28]), .Y(
        n6) );
  OAI22X1 U15 ( .A(start_addr[27]), .B(n38), .C(n2), .D(curr_addr_w[27]), .Y(
        n7) );
  OAI22X1 U16 ( .A(start_addr[26]), .B(n38), .C(n2), .D(curr_addr_w[26]), .Y(
        n8) );
  OAI22X1 U17 ( .A(start_addr[25]), .B(n38), .C(n2), .D(curr_addr_w[25]), .Y(
        n9) );
  OAI22X1 U18 ( .A(start_addr[24]), .B(n37), .C(n2), .D(curr_addr_w[24]), .Y(
        n10) );
  OAI22X1 U19 ( .A(start_addr[23]), .B(n37), .C(n2), .D(curr_addr_w[23]), .Y(
        n11) );
  OAI22X1 U20 ( .A(start_addr[22]), .B(n37), .C(n2), .D(curr_addr_w[22]), .Y(
        n12) );
  OAI22X1 U21 ( .A(start_addr[21]), .B(n37), .C(n2), .D(curr_addr_w[21]), .Y(
        n13) );
  OAI22X1 U22 ( .A(start_addr[20]), .B(n37), .C(n2), .D(curr_addr_w[20]), .Y(
        n14) );
  OAI22X1 U23 ( .A(start_addr[1]), .B(n37), .C(n2), .D(curr_addr_w[1]), .Y(n33) );
  OAI22X1 U24 ( .A(start_addr[19]), .B(n37), .C(n2), .D(curr_addr_w[19]), .Y(
        n15) );
  OAI22X1 U25 ( .A(start_addr[18]), .B(n36), .C(n2), .D(curr_addr_w[18]), .Y(
        n16) );
  OAI22X1 U26 ( .A(start_addr[17]), .B(n36), .C(n2), .D(curr_addr_w[17]), .Y(
        n17) );
  OAI22X1 U27 ( .A(start_addr[16]), .B(n36), .C(n2), .D(curr_addr_w[16]), .Y(
        n18) );
  OAI22X1 U28 ( .A(start_addr[15]), .B(n36), .C(n2), .D(curr_addr_w[15]), .Y(
        n19) );
  OAI22X1 U29 ( .A(start_addr[14]), .B(n36), .C(n2), .D(curr_addr_w[14]), .Y(
        n20) );
  OAI22X1 U30 ( .A(start_addr[13]), .B(n36), .C(n2), .D(curr_addr_w[13]), .Y(
        n21) );
  OAI22X1 U31 ( .A(start_addr[12]), .B(n36), .C(n2), .D(curr_addr_w[12]), .Y(
        n22) );
  OAI22X1 U32 ( .A(start_addr[11]), .B(n35), .C(n2), .D(curr_addr_w[11]), .Y(
        n23) );
  OAI22X1 U33 ( .A(start_addr[10]), .B(n35), .C(n2), .D(curr_addr_w[10]), .Y(
        n24) );
  OAI22X1 U35 ( .A(start_addr[0]), .B(n35), .C(n2), .D(curr_addr_w[0]), .Y(n34) );
  controller_ahb AHB_CONTROLLER ( .HCLK(HCLK), .HRESETn(n45), .HREADY(HREADY), 
        .read_enable(n2), .write_enable(write_enable), 
        .transfer_addr_complete_r(transfer_addr_complete_r), 
        .transfer_data_complete_r(transfer_data_complete_r), 
        .transfer_addr_complete_w(1'b0), .transfer_data_complete_w(1'b0), 
        .end_of_image(end_of_image), .addr_enable_r(addr_enable_r), 
        .load_enable_r(load_enable_r), .shift_enable_r(shift_enable_r), 
        .addr_update_enable_r(addr_update_enable_r), .shift_enable_w(
        shift_enable_w), .addr_update_enable_w(addr_update_enable_w) );
  address_update_w ADDRESS_UPDATE_WRITE ( .HCLK(HCLK), .HRESETn(n45), .length(
        {n43, length[14:9], n41, length[7:0]}), .width(width), .addr(dest_addr), .addr_update_enable_w(addr_update_enable_w), .plus4_r(plus4_r), .curr_addr(
        curr_addr_w) );
  fifo_w WRITE_PIXEL_DATA ( .HCLK(HCLK), .HRESETn(n45), .shift_enable(
        shift_enable_w), .data_out_1(sobel_result1), .data_out_2(sobel_result2), .HWDATA({SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, HWDATA[15:0]}) );
  address_update_r ADDRESS_UPDATE_READ ( .HCLK(HCLK), .HRESETn(n45), .length({
        n43, length[14:9], n41, length[7:0]}), .width(width), .addr(
        source_addr), .addr_update_enable_r(addr_update_enable_r), .curr_addr(
        curr_addr_r), .plus4_r(plus4_r), .end_of_image(end_of_image) );
  get_address_r GET_STARTING_ADDRESS_READ ( .HCLK(HCLK), .HRESETn(n45), 
        .addr_enable_r(addr_enable_r), .curr_addr(curr_addr_r), .length({n43, 
        length[14:9], n41, length[7:0]}), .width(width), .start_addr_r(
        start_addr), .transfer_addr_complete_r(transfer_addr_complete_r) );
  fifo_r SEND_PIXEL_DATA ( .HCLK(HCLK), .HRESETn(n45), .shift_enable(
        shift_enable_r), .load_enable(load_enable_r), .HRDATA(HRDATA), 
        .data_in(pixel_out), .transfer_data_complete_r(
        transfer_data_complete_r) );
  TBUFX1 \HADDR_tri[0]  ( .A(n34), .EN(n1), .Y(HADDR[0]) );
  TBUFX1 \HADDR_tri[31]  ( .A(n3), .EN(n1), .Y(HADDR[31]) );
  TBUFX1 \HADDR_tri[1]  ( .A(n33), .EN(n1), .Y(HADDR[1]) );
  TBUFX1 \HADDR_tri[2]  ( .A(n32), .EN(n1), .Y(HADDR[2]) );
  TBUFX1 \HADDR_tri[3]  ( .A(n31), .EN(n1), .Y(HADDR[3]) );
  TBUFX1 \HADDR_tri[4]  ( .A(n30), .EN(n1), .Y(HADDR[4]) );
  TBUFX1 \HADDR_tri[5]  ( .A(n29), .EN(n1), .Y(HADDR[5]) );
  TBUFX1 \HADDR_tri[6]  ( .A(n28), .EN(n1), .Y(HADDR[6]) );
  TBUFX1 \HADDR_tri[7]  ( .A(n27), .EN(n1), .Y(HADDR[7]) );
  TBUFX1 \HADDR_tri[8]  ( .A(n26), .EN(n1), .Y(HADDR[8]) );
  TBUFX1 \HADDR_tri[9]  ( .A(n25), .EN(n1), .Y(HADDR[9]) );
  TBUFX1 \HADDR_tri[10]  ( .A(n24), .EN(n1), .Y(HADDR[10]) );
  TBUFX1 \HADDR_tri[11]  ( .A(n23), .EN(n1), .Y(HADDR[11]) );
  TBUFX1 \HADDR_tri[12]  ( .A(n22), .EN(n1), .Y(HADDR[12]) );
  TBUFX1 \HADDR_tri[13]  ( .A(n21), .EN(n1), .Y(HADDR[13]) );
  TBUFX1 \HADDR_tri[14]  ( .A(n20), .EN(n1), .Y(HADDR[14]) );
  TBUFX1 \HADDR_tri[15]  ( .A(n19), .EN(n1), .Y(HADDR[15]) );
  TBUFX1 \HADDR_tri[16]  ( .A(n18), .EN(n1), .Y(HADDR[16]) );
  TBUFX1 \HADDR_tri[17]  ( .A(n17), .EN(n1), .Y(HADDR[17]) );
  TBUFX1 \HADDR_tri[18]  ( .A(n16), .EN(n1), .Y(HADDR[18]) );
  TBUFX1 \HADDR_tri[19]  ( .A(n15), .EN(n1), .Y(HADDR[19]) );
  TBUFX1 \HADDR_tri[20]  ( .A(n14), .EN(n1), .Y(HADDR[20]) );
  TBUFX1 \HADDR_tri[21]  ( .A(n13), .EN(n1), .Y(HADDR[21]) );
  TBUFX1 \HADDR_tri[22]  ( .A(n12), .EN(n1), .Y(HADDR[22]) );
  TBUFX1 \HADDR_tri[23]  ( .A(n11), .EN(n1), .Y(HADDR[23]) );
  TBUFX1 \HADDR_tri[24]  ( .A(n10), .EN(n1), .Y(HADDR[24]) );
  TBUFX1 \HADDR_tri[25]  ( .A(n9), .EN(n1), .Y(HADDR[25]) );
  TBUFX1 \HADDR_tri[26]  ( .A(n8), .EN(n1), .Y(HADDR[26]) );
  TBUFX1 \HADDR_tri[27]  ( .A(n7), .EN(n1), .Y(HADDR[27]) );
  TBUFX1 \HADDR_tri[28]  ( .A(n6), .EN(n1), .Y(HADDR[28]) );
  TBUFX1 \HADDR_tri[29]  ( .A(n5), .EN(n1), .Y(HADDR[29]) );
  TBUFX1 \HADDR_tri[30]  ( .A(n4), .EN(n1), .Y(HADDR[30]) );
  TBUFX1 HWRITE_tri ( .A(n2), .EN(n1), .Y(HWRITE) );
  OR2X2 U34 ( .A(n2), .B(write_enable), .Y(n1) );
  INVX4 U36 ( .A(n35), .Y(n2) );
  BUFX2 U37 ( .A(n40), .Y(n35) );
  BUFX2 U38 ( .A(n40), .Y(n36) );
  BUFX2 U39 ( .A(n37), .Y(n39) );
  BUFX2 U40 ( .A(n37), .Y(n38) );
  BUFX2 U41 ( .A(n40), .Y(n37) );
  INVX2 U42 ( .A(n42), .Y(n41) );
  INVX2 U43 ( .A(length[8]), .Y(n42) );
  INVX2 U44 ( .A(read_enable), .Y(n40) );
  INVX2 U45 ( .A(n44), .Y(n43) );
  INVX2 U46 ( .A(length[15]), .Y(n44) );
  INVX2 U47 ( .A(n46), .Y(n45) );
  INVX2 U48 ( .A(HRESETn), .Y(n46) );
endmodule


module flex_counter_NUM_CNT_BITS32_3_DW01_dec_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;
  wire   n10, n15, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75;

  INVX2 U1 ( .A(n74), .Y(SUM[11]) );
  INVX2 U2 ( .A(n71), .Y(SUM[13]) );
  INVX2 U3 ( .A(n68), .Y(SUM[15]) );
  INVX2 U4 ( .A(n65), .Y(SUM[17]) );
  INVX2 U5 ( .A(n62), .Y(SUM[19]) );
  INVX2 U6 ( .A(n57), .Y(SUM[22]) );
  INVX2 U7 ( .A(n54), .Y(SUM[24]) );
  INVX2 U8 ( .A(n51), .Y(SUM[26]) );
  INVX2 U9 ( .A(n48), .Y(SUM[28]) );
  INVX2 U10 ( .A(n59), .Y(n10) );
  INVX2 U11 ( .A(n32), .Y(SUM[9]) );
  INVX2 U12 ( .A(n36), .Y(SUM[7]) );
  INVX2 U13 ( .A(n39), .Y(SUM[5]) );
  INVX2 U14 ( .A(n42), .Y(SUM[3]) );
  INVX2 U15 ( .A(A[2]), .Y(n15) );
  INVX2 U16 ( .A(n61), .Y(SUM[1]) );
  INVX2 U17 ( .A(A[0]), .Y(SUM[0]) );
  INVX2 U18 ( .A(A[4]), .Y(n18) );
  INVX2 U19 ( .A(A[6]), .Y(n19) );
  INVX2 U20 ( .A(A[8]), .Y(n20) );
  INVX2 U21 ( .A(A[10]), .Y(n21) );
  INVX2 U22 ( .A(A[12]), .Y(n22) );
  INVX2 U23 ( .A(A[14]), .Y(n23) );
  INVX2 U24 ( .A(A[16]), .Y(n24) );
  INVX2 U25 ( .A(A[18]), .Y(n25) );
  INVX2 U26 ( .A(A[20]), .Y(n26) );
  INVX2 U27 ( .A(A[21]), .Y(n27) );
  INVX2 U28 ( .A(A[23]), .Y(n28) );
  INVX2 U29 ( .A(A[25]), .Y(n29) );
  INVX2 U30 ( .A(A[27]), .Y(n30) );
  INVX2 U31 ( .A(A[29]), .Y(n31) );
  AOI21X1 U32 ( .A(n33), .B(A[9]), .C(n34), .Y(n32) );
  OAI21X1 U33 ( .A(n35), .B(n20), .C(n33), .Y(SUM[8]) );
  AOI21X1 U34 ( .A(n37), .B(A[7]), .C(n35), .Y(n36) );
  OAI21X1 U35 ( .A(n38), .B(n19), .C(n37), .Y(SUM[6]) );
  AOI21X1 U36 ( .A(n40), .B(A[5]), .C(n38), .Y(n39) );
  OAI21X1 U37 ( .A(n41), .B(n18), .C(n40), .Y(SUM[4]) );
  AOI21X1 U38 ( .A(n43), .B(A[3]), .C(n41), .Y(n42) );
  XOR2X1 U39 ( .A(A[31]), .B(n44), .Y(SUM[31]) );
  NOR2X1 U40 ( .A(A[30]), .B(n45), .Y(n44) );
  XNOR2X1 U41 ( .A(A[30]), .B(n45), .Y(SUM[30]) );
  OAI21X1 U42 ( .A(n46), .B(n15), .C(n43), .Y(SUM[2]) );
  OAI21X1 U43 ( .A(n47), .B(n31), .C(n45), .Y(SUM[29]) );
  NAND2X1 U44 ( .A(n47), .B(n31), .Y(n45) );
  AOI21X1 U45 ( .A(n49), .B(A[28]), .C(n47), .Y(n48) );
  NOR2X1 U46 ( .A(n49), .B(A[28]), .Y(n47) );
  OAI21X1 U47 ( .A(n50), .B(n30), .C(n49), .Y(SUM[27]) );
  NAND2X1 U48 ( .A(n50), .B(n30), .Y(n49) );
  AOI21X1 U49 ( .A(n52), .B(A[26]), .C(n50), .Y(n51) );
  NOR2X1 U50 ( .A(n52), .B(A[26]), .Y(n50) );
  OAI21X1 U51 ( .A(n53), .B(n29), .C(n52), .Y(SUM[25]) );
  NAND2X1 U52 ( .A(n53), .B(n29), .Y(n52) );
  AOI21X1 U53 ( .A(n55), .B(A[24]), .C(n53), .Y(n54) );
  NOR2X1 U54 ( .A(n55), .B(A[24]), .Y(n53) );
  OAI21X1 U55 ( .A(n56), .B(n28), .C(n55), .Y(SUM[23]) );
  NAND2X1 U56 ( .A(n56), .B(n28), .Y(n55) );
  AOI21X1 U57 ( .A(n58), .B(A[22]), .C(n56), .Y(n57) );
  NOR2X1 U58 ( .A(n58), .B(A[22]), .Y(n56) );
  OAI21X1 U59 ( .A(n10), .B(n27), .C(n58), .Y(SUM[21]) );
  NAND2X1 U60 ( .A(n10), .B(n27), .Y(n58) );
  OAI21X1 U61 ( .A(n60), .B(n26), .C(n59), .Y(SUM[20]) );
  NAND2X1 U62 ( .A(n60), .B(n26), .Y(n59) );
  AOI21X1 U63 ( .A(A[0]), .B(A[1]), .C(n46), .Y(n61) );
  AOI21X1 U64 ( .A(n63), .B(A[19]), .C(n60), .Y(n62) );
  NOR2X1 U65 ( .A(n63), .B(A[19]), .Y(n60) );
  OAI21X1 U66 ( .A(n64), .B(n25), .C(n63), .Y(SUM[18]) );
  NAND2X1 U67 ( .A(n64), .B(n25), .Y(n63) );
  AOI21X1 U68 ( .A(n66), .B(A[17]), .C(n64), .Y(n65) );
  NOR2X1 U69 ( .A(n66), .B(A[17]), .Y(n64) );
  OAI21X1 U70 ( .A(n67), .B(n24), .C(n66), .Y(SUM[16]) );
  NAND2X1 U71 ( .A(n67), .B(n24), .Y(n66) );
  AOI21X1 U72 ( .A(n69), .B(A[15]), .C(n67), .Y(n68) );
  NOR2X1 U73 ( .A(n69), .B(A[15]), .Y(n67) );
  OAI21X1 U74 ( .A(n70), .B(n23), .C(n69), .Y(SUM[14]) );
  NAND2X1 U75 ( .A(n70), .B(n23), .Y(n69) );
  AOI21X1 U76 ( .A(n72), .B(A[13]), .C(n70), .Y(n71) );
  NOR2X1 U77 ( .A(n72), .B(A[13]), .Y(n70) );
  OAI21X1 U78 ( .A(n73), .B(n22), .C(n72), .Y(SUM[12]) );
  NAND2X1 U79 ( .A(n73), .B(n22), .Y(n72) );
  AOI21X1 U80 ( .A(n75), .B(A[11]), .C(n73), .Y(n74) );
  NOR2X1 U81 ( .A(n75), .B(A[11]), .Y(n73) );
  OAI21X1 U82 ( .A(n34), .B(n21), .C(n75), .Y(SUM[10]) );
  NAND2X1 U83 ( .A(n34), .B(n21), .Y(n75) );
  NOR2X1 U84 ( .A(n33), .B(A[9]), .Y(n34) );
  NAND2X1 U85 ( .A(n35), .B(n20), .Y(n33) );
  NOR2X1 U86 ( .A(n37), .B(A[7]), .Y(n35) );
  NAND2X1 U87 ( .A(n38), .B(n19), .Y(n37) );
  NOR2X1 U88 ( .A(n40), .B(A[5]), .Y(n38) );
  NAND2X1 U89 ( .A(n41), .B(n18), .Y(n40) );
  NOR2X1 U90 ( .A(n43), .B(A[3]), .Y(n41) );
  NAND2X1 U91 ( .A(n46), .B(n15), .Y(n43) );
  NOR2X1 U92 ( .A(A[1]), .B(A[0]), .Y(n46) );
endmodule


module flex_counter_NUM_CNT_BITS32_3_DW01_inc_0 ( A, SUM );
  input [31:0] A;
  output [31:0] SUM;

  wire   [31:2] carry;

  HAX1 U1_1_30 ( .A(A[30]), .B(carry[30]), .YC(carry[31]), .YS(SUM[30]) );
  HAX1 U1_1_29 ( .A(A[29]), .B(carry[29]), .YC(carry[30]), .YS(SUM[29]) );
  HAX1 U1_1_28 ( .A(A[28]), .B(carry[28]), .YC(carry[29]), .YS(SUM[28]) );
  HAX1 U1_1_27 ( .A(A[27]), .B(carry[27]), .YC(carry[28]), .YS(SUM[27]) );
  HAX1 U1_1_26 ( .A(A[26]), .B(carry[26]), .YC(carry[27]), .YS(SUM[26]) );
  HAX1 U1_1_25 ( .A(A[25]), .B(carry[25]), .YC(carry[26]), .YS(SUM[25]) );
  HAX1 U1_1_24 ( .A(A[24]), .B(carry[24]), .YC(carry[25]), .YS(SUM[24]) );
  HAX1 U1_1_23 ( .A(A[23]), .B(carry[23]), .YC(carry[24]), .YS(SUM[23]) );
  HAX1 U1_1_22 ( .A(A[22]), .B(carry[22]), .YC(carry[23]), .YS(SUM[22]) );
  HAX1 U1_1_21 ( .A(A[21]), .B(carry[21]), .YC(carry[22]), .YS(SUM[21]) );
  HAX1 U1_1_20 ( .A(A[20]), .B(carry[20]), .YC(carry[21]), .YS(SUM[20]) );
  HAX1 U1_1_19 ( .A(A[19]), .B(carry[19]), .YC(carry[20]), .YS(SUM[19]) );
  HAX1 U1_1_18 ( .A(A[18]), .B(carry[18]), .YC(carry[19]), .YS(SUM[18]) );
  HAX1 U1_1_17 ( .A(A[17]), .B(carry[17]), .YC(carry[18]), .YS(SUM[17]) );
  HAX1 U1_1_16 ( .A(A[16]), .B(carry[16]), .YC(carry[17]), .YS(SUM[16]) );
  HAX1 U1_1_15 ( .A(A[15]), .B(carry[15]), .YC(carry[16]), .YS(SUM[15]) );
  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[31]), .B(A[31]), .Y(SUM[31]) );
endmodule


module flex_counter_NUM_CNT_BITS32_3 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [31:0] rollover_val;
  output [31:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32,
         N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46,
         N47, N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60,
         N61, N62, N63, N64, N65, N66, N67, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187, n188, n189, n190, n191, n192, n193, n194, n195, n196, n197,
         n198, n199, n200, n201, n202, n203, n204, n205, n206, n207, n208,
         n209, n210, n211, n212, n213, n214, n215, n216, n217, n218, n219,
         n220, n221, n222, n223, n224, n225, n226, n227, n228, n229, n230,
         n231, n232, n233, n234, n235, n236, n237, n238, n239, n240, n241,
         n242, n243, n244, n245, n246, n247, n248, n249, n250, n251, n252,
         n253, n254, n1, n2, n3, n4, n5, n6, n7, n8, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73;

  DFFSR \count_out_reg[0]  ( .D(n254), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n253), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n252), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n251), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[4]  ( .D(n250), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \count_out_reg[5]  ( .D(n249), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \count_out_reg[6]  ( .D(n248), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \count_out_reg[7]  ( .D(n247), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \count_out_reg[8]  ( .D(n246), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \count_out_reg[9]  ( .D(n245), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR \count_out_reg[10]  ( .D(n244), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[10]) );
  DFFSR \count_out_reg[11]  ( .D(n243), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[11]) );
  DFFSR \count_out_reg[12]  ( .D(n242), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[12]) );
  DFFSR \count_out_reg[13]  ( .D(n241), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[13]) );
  DFFSR \count_out_reg[14]  ( .D(n240), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[14]) );
  DFFSR \count_out_reg[15]  ( .D(n239), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[15]) );
  DFFSR \count_out_reg[16]  ( .D(n238), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[16]) );
  DFFSR \count_out_reg[17]  ( .D(n237), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[17]) );
  DFFSR \count_out_reg[18]  ( .D(n236), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[18]) );
  DFFSR \count_out_reg[19]  ( .D(n235), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[19]) );
  DFFSR \count_out_reg[20]  ( .D(n234), .CLK(clk), .R(n6), .S(1'b1), .Q(
        count_out[20]) );
  DFFSR \count_out_reg[21]  ( .D(n233), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[21]) );
  DFFSR \count_out_reg[22]  ( .D(n232), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[22]) );
  DFFSR \count_out_reg[23]  ( .D(n231), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[23]) );
  DFFSR \count_out_reg[24]  ( .D(n230), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[24]) );
  DFFSR \count_out_reg[25]  ( .D(n229), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[25]) );
  DFFSR \count_out_reg[26]  ( .D(n228), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[26]) );
  DFFSR \count_out_reg[27]  ( .D(n227), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[27]) );
  DFFSR \count_out_reg[28]  ( .D(n226), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[28]) );
  DFFSR \count_out_reg[29]  ( .D(n225), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[29]) );
  DFFSR \count_out_reg[30]  ( .D(n224), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[30]) );
  DFFSR \count_out_reg[31]  ( .D(n223), .CLK(clk), .R(n5), .S(1'b1), .Q(
        count_out[31]) );
  DFFSR rollover_flag_reg ( .D(n222), .CLK(clk), .R(n5), .S(1'b1), .Q(
        rollover_flag) );
  OAI21X1 U70 ( .A(n76), .B(n77), .C(n78), .Y(n222) );
  NAND2X1 U71 ( .A(rollover_flag), .B(n79), .Y(n78) );
  NAND2X1 U72 ( .A(n80), .B(n81), .Y(n77) );
  NOR2X1 U73 ( .A(n82), .B(n83), .Y(n81) );
  NAND3X1 U74 ( .A(n84), .B(n85), .C(n86), .Y(n83) );
  NOR2X1 U75 ( .A(n87), .B(n88), .Y(n86) );
  XNOR2X1 U76 ( .A(n72), .B(N66), .Y(n88) );
  XNOR2X1 U77 ( .A(n73), .B(N67), .Y(n87) );
  XNOR2X1 U78 ( .A(count_out[27]), .B(N63), .Y(n85) );
  XNOR2X1 U79 ( .A(count_out[26]), .B(N62), .Y(n84) );
  NAND3X1 U80 ( .A(n89), .B(n90), .C(n91), .Y(n82) );
  NOR2X1 U81 ( .A(n92), .B(n93), .Y(n91) );
  XNOR2X1 U82 ( .A(n60), .B(N54), .Y(n93) );
  XNOR2X1 U83 ( .A(n61), .B(N55), .Y(n92) );
  XNOR2X1 U84 ( .A(count_out[23]), .B(N59), .Y(n90) );
  NOR2X1 U85 ( .A(n94), .B(n95), .Y(n89) );
  XNOR2X1 U86 ( .A(n51), .B(N45), .Y(n95) );
  XNOR2X1 U87 ( .A(n64), .B(N58), .Y(n94) );
  NOR2X1 U88 ( .A(n96), .B(n97), .Y(n80) );
  NAND3X1 U89 ( .A(n98), .B(n99), .C(n100), .Y(n97) );
  NOR2X1 U90 ( .A(n101), .B(n102), .Y(n100) );
  XNOR2X1 U91 ( .A(n56), .B(N50), .Y(n102) );
  XNOR2X1 U92 ( .A(n57), .B(N51), .Y(n101) );
  XNOR2X1 U93 ( .A(count_out[11]), .B(N47), .Y(n99) );
  XNOR2X1 U94 ( .A(count_out[10]), .B(N46), .Y(n98) );
  NAND3X1 U95 ( .A(n103), .B(n104), .C(n105), .Y(n96) );
  NOR2X1 U96 ( .A(n106), .B(n107), .Y(n105) );
  XNOR2X1 U97 ( .A(n48), .B(N42), .Y(n107) );
  XNOR2X1 U98 ( .A(n49), .B(N43), .Y(n106) );
  XNOR2X1 U99 ( .A(count_out[3]), .B(N39), .Y(n104) );
  XNOR2X1 U100 ( .A(count_out[2]), .B(N38), .Y(n103) );
  NAND2X1 U101 ( .A(n108), .B(n109), .Y(n76) );
  NOR2X1 U102 ( .A(n110), .B(n111), .Y(n109) );
  NAND3X1 U103 ( .A(n112), .B(n113), .C(n114), .Y(n111) );
  NOR2X1 U104 ( .A(n115), .B(n116), .Y(n114) );
  XNOR2X1 U105 ( .A(n70), .B(N64), .Y(n116) );
  XNOR2X1 U106 ( .A(n59), .B(N53), .Y(n115) );
  XNOR2X1 U107 ( .A(count_out[29]), .B(N65), .Y(n113) );
  XNOR2X1 U108 ( .A(count_out[24]), .B(N60), .Y(n112) );
  NAND3X1 U109 ( .A(n117), .B(n118), .C(n119), .Y(n110) );
  NOR2X1 U110 ( .A(n120), .B(n121), .Y(n119) );
  XNOR2X1 U111 ( .A(n58), .B(N52), .Y(n121) );
  XNOR2X1 U112 ( .A(n63), .B(N57), .Y(n120) );
  XNOR2X1 U113 ( .A(count_out[20]), .B(N56), .Y(n118) );
  NOR2X1 U114 ( .A(clear), .B(n79), .Y(n117) );
  NOR2X1 U115 ( .A(n122), .B(n123), .Y(n108) );
  NAND3X1 U116 ( .A(n124), .B(n125), .C(n126), .Y(n123) );
  NOR2X1 U117 ( .A(n127), .B(n128), .Y(n126) );
  XNOR2X1 U118 ( .A(n54), .B(N48), .Y(n128) );
  XNOR2X1 U119 ( .A(n43), .B(N37), .Y(n127) );
  XNOR2X1 U120 ( .A(count_out[13]), .B(N49), .Y(n125) );
  XNOR2X1 U121 ( .A(count_out[8]), .B(N44), .Y(n124) );
  NAND3X1 U122 ( .A(n129), .B(n130), .C(n131), .Y(n122) );
  NOR2X1 U123 ( .A(n132), .B(n133), .Y(n131) );
  XNOR2X1 U124 ( .A(n46), .B(N40), .Y(n133) );
  XNOR2X1 U125 ( .A(n67), .B(N61), .Y(n132) );
  XNOR2X1 U126 ( .A(count_out[5]), .B(N41), .Y(n130) );
  XNOR2X1 U127 ( .A(count_out[0]), .B(N36), .Y(n129) );
  OAI21X1 U128 ( .A(n73), .B(n2), .C(n134), .Y(n223) );
  NAND2X1 U129 ( .A(N35), .B(n4), .Y(n134) );
  OAI21X1 U130 ( .A(n72), .B(n2), .C(n136), .Y(n224) );
  NAND2X1 U131 ( .A(N34), .B(n4), .Y(n136) );
  OAI21X1 U132 ( .A(n71), .B(n2), .C(n137), .Y(n225) );
  NAND2X1 U133 ( .A(N33), .B(n4), .Y(n137) );
  OAI21X1 U134 ( .A(n70), .B(n2), .C(n138), .Y(n226) );
  NAND2X1 U135 ( .A(N32), .B(n4), .Y(n138) );
  OAI21X1 U136 ( .A(n69), .B(n2), .C(n139), .Y(n227) );
  NAND2X1 U137 ( .A(N31), .B(n4), .Y(n139) );
  OAI21X1 U138 ( .A(n68), .B(n2), .C(n140), .Y(n228) );
  NAND2X1 U139 ( .A(N30), .B(n4), .Y(n140) );
  OAI21X1 U140 ( .A(n67), .B(n2), .C(n141), .Y(n229) );
  NAND2X1 U141 ( .A(N29), .B(n4), .Y(n141) );
  OAI21X1 U142 ( .A(n66), .B(n2), .C(n142), .Y(n230) );
  NAND2X1 U143 ( .A(N28), .B(n4), .Y(n142) );
  OAI21X1 U144 ( .A(n65), .B(n2), .C(n143), .Y(n231) );
  NAND2X1 U145 ( .A(N27), .B(n4), .Y(n143) );
  OAI21X1 U146 ( .A(n64), .B(n2), .C(n144), .Y(n232) );
  NAND2X1 U147 ( .A(N26), .B(n4), .Y(n144) );
  OAI21X1 U148 ( .A(n63), .B(n2), .C(n145), .Y(n233) );
  NAND2X1 U149 ( .A(N25), .B(n4), .Y(n145) );
  OAI21X1 U150 ( .A(n62), .B(n2), .C(n146), .Y(n234) );
  NAND2X1 U151 ( .A(N24), .B(n4), .Y(n146) );
  OAI21X1 U152 ( .A(n61), .B(n3), .C(n147), .Y(n235) );
  NAND2X1 U153 ( .A(N23), .B(n4), .Y(n147) );
  OAI21X1 U154 ( .A(n60), .B(n3), .C(n148), .Y(n236) );
  NAND2X1 U155 ( .A(N22), .B(n4), .Y(n148) );
  OAI21X1 U156 ( .A(n59), .B(n3), .C(n149), .Y(n237) );
  NAND2X1 U157 ( .A(N21), .B(n4), .Y(n149) );
  OAI21X1 U158 ( .A(n58), .B(n3), .C(n150), .Y(n238) );
  NAND2X1 U159 ( .A(N20), .B(n4), .Y(n150) );
  OAI21X1 U160 ( .A(n57), .B(n3), .C(n151), .Y(n239) );
  NAND2X1 U161 ( .A(N19), .B(n4), .Y(n151) );
  OAI21X1 U162 ( .A(n56), .B(n3), .C(n152), .Y(n240) );
  NAND2X1 U163 ( .A(N18), .B(n4), .Y(n152) );
  OAI21X1 U164 ( .A(n55), .B(n3), .C(n153), .Y(n241) );
  NAND2X1 U165 ( .A(N17), .B(n4), .Y(n153) );
  OAI21X1 U166 ( .A(n54), .B(n3), .C(n154), .Y(n242) );
  NAND2X1 U167 ( .A(N16), .B(n4), .Y(n154) );
  OAI21X1 U168 ( .A(n53), .B(n3), .C(n155), .Y(n243) );
  NAND2X1 U169 ( .A(N15), .B(n4), .Y(n155) );
  OAI21X1 U170 ( .A(n52), .B(n3), .C(n156), .Y(n244) );
  NAND2X1 U171 ( .A(N14), .B(n4), .Y(n156) );
  OAI21X1 U172 ( .A(n51), .B(n3), .C(n157), .Y(n245) );
  NAND2X1 U173 ( .A(N13), .B(n4), .Y(n157) );
  OAI21X1 U174 ( .A(n50), .B(n3), .C(n158), .Y(n246) );
  NAND2X1 U175 ( .A(N12), .B(n4), .Y(n158) );
  OAI21X1 U176 ( .A(n49), .B(n3), .C(n159), .Y(n247) );
  NAND2X1 U177 ( .A(N11), .B(n4), .Y(n159) );
  OAI21X1 U178 ( .A(n48), .B(n2), .C(n160), .Y(n248) );
  NAND2X1 U179 ( .A(N10), .B(n4), .Y(n160) );
  OAI21X1 U180 ( .A(n47), .B(n3), .C(n161), .Y(n249) );
  NAND2X1 U181 ( .A(N9), .B(n4), .Y(n161) );
  OAI21X1 U182 ( .A(n46), .B(n2), .C(n162), .Y(n250) );
  NAND2X1 U183 ( .A(N8), .B(n4), .Y(n162) );
  OAI21X1 U184 ( .A(n45), .B(n3), .C(n163), .Y(n251) );
  NAND2X1 U185 ( .A(N7), .B(n4), .Y(n163) );
  OAI21X1 U186 ( .A(n44), .B(n2), .C(n164), .Y(n252) );
  NAND2X1 U187 ( .A(N6), .B(n4), .Y(n164) );
  OAI21X1 U188 ( .A(n43), .B(n3), .C(n165), .Y(n253) );
  NAND2X1 U189 ( .A(N5), .B(n4), .Y(n165) );
  OAI21X1 U190 ( .A(n42), .B(n2), .C(n166), .Y(n254) );
  NAND2X1 U191 ( .A(N4), .B(n4), .Y(n166) );
  OAI21X1 U193 ( .A(n168), .B(n169), .C(n8), .Y(n167) );
  NAND2X1 U194 ( .A(n170), .B(n171), .Y(n169) );
  NOR2X1 U195 ( .A(n172), .B(n173), .Y(n171) );
  NAND3X1 U196 ( .A(n174), .B(n175), .C(n176), .Y(n173) );
  NOR2X1 U197 ( .A(n177), .B(n178), .Y(n176) );
  XNOR2X1 U198 ( .A(rollover_val[30]), .B(n72), .Y(n178) );
  XNOR2X1 U199 ( .A(rollover_val[31]), .B(n73), .Y(n177) );
  XNOR2X1 U200 ( .A(count_out[27]), .B(rollover_val[27]), .Y(n175) );
  XNOR2X1 U201 ( .A(count_out[26]), .B(rollover_val[26]), .Y(n174) );
  NAND3X1 U202 ( .A(n179), .B(n180), .C(n181), .Y(n172) );
  NOR2X1 U203 ( .A(n182), .B(n183), .Y(n181) );
  XNOR2X1 U204 ( .A(rollover_val[22]), .B(n64), .Y(n183) );
  XNOR2X1 U205 ( .A(rollover_val[23]), .B(n65), .Y(n182) );
  XNOR2X1 U206 ( .A(count_out[19]), .B(rollover_val[19]), .Y(n180) );
  XNOR2X1 U207 ( .A(count_out[18]), .B(rollover_val[18]), .Y(n179) );
  NOR2X1 U208 ( .A(n184), .B(n185), .Y(n170) );
  NAND3X1 U209 ( .A(n186), .B(n187), .C(n188), .Y(n185) );
  NOR2X1 U210 ( .A(n189), .B(n190), .Y(n188) );
  XNOR2X1 U211 ( .A(rollover_val[14]), .B(n56), .Y(n190) );
  XNOR2X1 U212 ( .A(rollover_val[15]), .B(n57), .Y(n189) );
  XNOR2X1 U213 ( .A(count_out[11]), .B(rollover_val[11]), .Y(n187) );
  XNOR2X1 U214 ( .A(count_out[10]), .B(rollover_val[10]), .Y(n186) );
  NAND3X1 U215 ( .A(n191), .B(n192), .C(n193), .Y(n184) );
  NOR2X1 U216 ( .A(n194), .B(n195), .Y(n193) );
  XNOR2X1 U217 ( .A(rollover_val[6]), .B(n48), .Y(n195) );
  XNOR2X1 U218 ( .A(rollover_val[7]), .B(n49), .Y(n194) );
  XNOR2X1 U219 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n192) );
  XNOR2X1 U220 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n191) );
  NAND2X1 U221 ( .A(n196), .B(n197), .Y(n168) );
  NOR2X1 U222 ( .A(n198), .B(n199), .Y(n197) );
  NAND3X1 U223 ( .A(n200), .B(n201), .C(n202), .Y(n199) );
  NOR2X1 U224 ( .A(n203), .B(n204), .Y(n202) );
  XNOR2X1 U225 ( .A(rollover_val[29]), .B(n71), .Y(n204) );
  XNOR2X1 U226 ( .A(rollover_val[28]), .B(n70), .Y(n203) );
  XNOR2X1 U227 ( .A(count_out[24]), .B(rollover_val[24]), .Y(n201) );
  XNOR2X1 U228 ( .A(count_out[25]), .B(rollover_val[25]), .Y(n200) );
  NAND3X1 U229 ( .A(n205), .B(n206), .C(n207), .Y(n198) );
  NOR2X1 U230 ( .A(n208), .B(n209), .Y(n207) );
  XNOR2X1 U231 ( .A(rollover_val[21]), .B(n63), .Y(n209) );
  XNOR2X1 U232 ( .A(rollover_val[20]), .B(n62), .Y(n208) );
  XNOR2X1 U233 ( .A(count_out[16]), .B(rollover_val[16]), .Y(n206) );
  XNOR2X1 U234 ( .A(count_out[17]), .B(rollover_val[17]), .Y(n205) );
  NOR2X1 U235 ( .A(n210), .B(n211), .Y(n196) );
  NAND3X1 U236 ( .A(n212), .B(n213), .C(n214), .Y(n211) );
  NOR2X1 U237 ( .A(n215), .B(n216), .Y(n214) );
  XNOR2X1 U238 ( .A(rollover_val[13]), .B(n55), .Y(n216) );
  XNOR2X1 U239 ( .A(rollover_val[12]), .B(n54), .Y(n215) );
  XNOR2X1 U240 ( .A(count_out[8]), .B(rollover_val[8]), .Y(n213) );
  XNOR2X1 U241 ( .A(count_out[9]), .B(rollover_val[9]), .Y(n212) );
  NAND3X1 U242 ( .A(n217), .B(n218), .C(n219), .Y(n210) );
  NOR2X1 U243 ( .A(n220), .B(n221), .Y(n219) );
  XNOR2X1 U244 ( .A(rollover_val[5]), .B(n47), .Y(n221) );
  XNOR2X1 U245 ( .A(rollover_val[4]), .B(n46), .Y(n220) );
  XNOR2X1 U246 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n218) );
  XNOR2X1 U247 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n217) );
  NOR2X1 U248 ( .A(clear), .B(count_enable), .Y(n79) );
  flex_counter_NUM_CNT_BITS32_3_DW01_dec_0 sub_56 ( .A(rollover_val), .SUM({
        N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, N56, N55, N54, 
        N53, N52, N51, N50, N49, N48, N47, N46, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  flex_counter_NUM_CNT_BITS32_3_DW01_inc_0 add_54 ( .A(count_out), .SUM({N35, 
        N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, N21, 
        N20, N19, N18, N17, N16, N15, N14, N13, N12, N11, N10, N9, N8, N7, N6, 
        N5, N4}) );
  INVX2 U36 ( .A(n79), .Y(n2) );
  INVX2 U37 ( .A(n79), .Y(n3) );
  INVX2 U38 ( .A(n1), .Y(n4) );
  INVX2 U39 ( .A(n7), .Y(n5) );
  INVX2 U40 ( .A(n7), .Y(n6) );
  OR2X1 U41 ( .A(n79), .B(n167), .Y(n1) );
  INVX2 U42 ( .A(n_rst), .Y(n7) );
  INVX2 U43 ( .A(clear), .Y(n8) );
  INVX2 U44 ( .A(count_out[0]), .Y(n42) );
  INVX2 U45 ( .A(count_out[1]), .Y(n43) );
  INVX2 U46 ( .A(count_out[2]), .Y(n44) );
  INVX2 U47 ( .A(count_out[3]), .Y(n45) );
  INVX2 U48 ( .A(count_out[4]), .Y(n46) );
  INVX2 U49 ( .A(count_out[5]), .Y(n47) );
  INVX2 U50 ( .A(count_out[6]), .Y(n48) );
  INVX2 U51 ( .A(count_out[7]), .Y(n49) );
  INVX2 U52 ( .A(count_out[8]), .Y(n50) );
  INVX2 U53 ( .A(count_out[9]), .Y(n51) );
  INVX2 U54 ( .A(count_out[10]), .Y(n52) );
  INVX2 U55 ( .A(count_out[11]), .Y(n53) );
  INVX2 U56 ( .A(count_out[12]), .Y(n54) );
  INVX2 U57 ( .A(count_out[13]), .Y(n55) );
  INVX2 U58 ( .A(count_out[14]), .Y(n56) );
  INVX2 U59 ( .A(count_out[15]), .Y(n57) );
  INVX2 U60 ( .A(count_out[16]), .Y(n58) );
  INVX2 U61 ( .A(count_out[17]), .Y(n59) );
  INVX2 U62 ( .A(count_out[18]), .Y(n60) );
  INVX2 U63 ( .A(count_out[19]), .Y(n61) );
  INVX2 U64 ( .A(count_out[20]), .Y(n62) );
  INVX2 U65 ( .A(count_out[21]), .Y(n63) );
  INVX2 U66 ( .A(count_out[22]), .Y(n64) );
  INVX2 U67 ( .A(count_out[23]), .Y(n65) );
  INVX2 U68 ( .A(count_out[24]), .Y(n66) );
  INVX2 U69 ( .A(count_out[25]), .Y(n67) );
  INVX2 U192 ( .A(count_out[26]), .Y(n68) );
  INVX2 U249 ( .A(count_out[27]), .Y(n69) );
  INVX2 U250 ( .A(count_out[28]), .Y(n70) );
  INVX2 U251 ( .A(count_out[29]), .Y(n71) );
  INVX2 U252 ( .A(count_out[30]), .Y(n72) );
  INVX2 U253 ( .A(count_out[31]), .Y(n73) );
endmodule


module fill_in_buffer ( clk, n_rst, shift_enable, buffer_clear, read_data, 
    .data_buffer({\data_buffer[11][7] , \data_buffer[11][6] , 
        \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] , 
        \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] , 
        \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] , 
        \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] , 
        \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] , 
        \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] , 
        \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] , 
        \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] , 
        \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] , 
        \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] , 
        \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] , 
        \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] , 
        \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] , 
        \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] , 
        \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] , 
        \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] , 
        \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] , 
        \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] , 
        \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] , 
        \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] , 
        \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] , 
        \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] , 
        \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] , 
        \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] , 
        \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] , 
        \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] , 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] , 
        \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] , 
        \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] , 
        \data_buffer[0][0] }), buffer_full, buffer_empty );
  input [7:0] read_data;
  input clk, n_rst, shift_enable, buffer_clear;
  output \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] ,
         \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] ,
         \data_buffer[11][1] , \data_buffer[11][0] , \data_buffer[10][7] ,
         \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] ,
         \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] ,
         \data_buffer[10][0] , \data_buffer[9][7] , \data_buffer[9][6] ,
         \data_buffer[9][5] , \data_buffer[9][4] , \data_buffer[9][3] ,
         \data_buffer[9][2] , \data_buffer[9][1] , \data_buffer[9][0] ,
         \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] ,
         \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] ,
         \data_buffer[8][1] , \data_buffer[8][0] , \data_buffer[7][7] ,
         \data_buffer[7][6] , \data_buffer[7][5] , \data_buffer[7][4] ,
         \data_buffer[7][3] , \data_buffer[7][2] , \data_buffer[7][1] ,
         \data_buffer[7][0] , \data_buffer[6][7] , \data_buffer[6][6] ,
         \data_buffer[6][5] , \data_buffer[6][4] , \data_buffer[6][3] ,
         \data_buffer[6][2] , \data_buffer[6][1] , \data_buffer[6][0] ,
         \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] ,
         \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] ,
         \data_buffer[5][1] , \data_buffer[5][0] , \data_buffer[4][7] ,
         \data_buffer[4][6] , \data_buffer[4][5] , \data_buffer[4][4] ,
         \data_buffer[4][3] , \data_buffer[4][2] , \data_buffer[4][1] ,
         \data_buffer[4][0] , \data_buffer[3][7] , \data_buffer[3][6] ,
         \data_buffer[3][5] , \data_buffer[3][4] , \data_buffer[3][3] ,
         \data_buffer[3][2] , \data_buffer[3][1] , \data_buffer[3][0] ,
         \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] ,
         \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] ,
         \data_buffer[2][1] , \data_buffer[2][0] , \data_buffer[1][7] ,
         \data_buffer[1][6] , \data_buffer[1][5] , \data_buffer[1][4] ,
         \data_buffer[1][3] , \data_buffer[1][2] , \data_buffer[1][1] ,
         \data_buffer[1][0] , \data_buffer[0][7] , \data_buffer[0][6] ,
         \data_buffer[0][5] , \data_buffer[0][4] , \data_buffer[0][3] ,
         \data_buffer[0][2] , \data_buffer[0][1] , \data_buffer[0][0] ,
         buffer_full, buffer_empty;
  wire   n485, n486, n487, n488, n489, n490, n491, n492, n493, n494, n495,
         n496, n497, n498, n216, n217, n218, n219, n220, n221, n222, n223,
         n224, n225, n226, n227, n228, n229, n230, n231, n232, n233, n234,
         n235, n236, n237, n238, n239, n240, n241, n242, n243, n244, n245,
         n246, n247, n248, n249, n250, n251, n252, n253, n254, n255, n256,
         n257, n258, n259, n260, n261, n262, n263, n264, n265, n266, n267,
         n268, n269, n270, n271, n272, n273, n274, n275, n276, n277, n278,
         n279, n280, n281, n282, n283, n284, n285, n286, n287, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399,
         n400, n401, n402, n403, n404, n405, n406, n407, n408, n409, n410,
         n411, n412, n413, n414, n415, n416, n417, n418, n419, n420, n421,
         n422, n423, n424, n425, n426, n427, n428, n429, n430, n431, n432,
         n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, n443,
         n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454,
         n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n466, n467, n468, n469, n470,
         n471, n472, n473, n474, n475, n476, n477, n478, n479, n480, n481,
         n482, n483, n484;
  wire   [31:0] pixel_count;
  assign buffer_empty = 1'b1;

  DFFSR \data_buffer_reg[0][7]  ( .D(n458), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[0][7] ) );
  DFFSR \data_buffer_reg[11][7]  ( .D(n370), .CLK(clk), .R(n123), .S(1'b1), 
        .Q(\data_buffer[11][7] ) );
  DFFSR \data_buffer_reg[10][7]  ( .D(n378), .CLK(clk), .R(n123), .S(1'b1), 
        .Q(n485) );
  DFFSR \data_buffer_reg[9][7]  ( .D(n386), .CLK(clk), .R(n123), .S(1'b1), .Q(
        n492) );
  DFFSR \data_buffer_reg[8][7]  ( .D(n394), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[8][7] ) );
  DFFSR \data_buffer_reg[7][7]  ( .D(n402), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[7][7] ) );
  DFFSR \data_buffer_reg[6][7]  ( .D(n410), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[6][7] ) );
  DFFSR \data_buffer_reg[5][7]  ( .D(n418), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[5][7] ) );
  DFFSR \data_buffer_reg[4][7]  ( .D(n426), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[4][7] ) );
  DFFSR \data_buffer_reg[3][7]  ( .D(n434), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[3][7] ) );
  DFFSR \data_buffer_reg[2][7]  ( .D(n442), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[2][7] ) );
  DFFSR \data_buffer_reg[1][7]  ( .D(n450), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[1][7] ) );
  DFFSR \data_buffer_reg[0][6]  ( .D(n459), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[0][6] ) );
  DFFSR \data_buffer_reg[11][6]  ( .D(n371), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(\data_buffer[11][6] ) );
  DFFSR \data_buffer_reg[10][6]  ( .D(n379), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(n486) );
  DFFSR \data_buffer_reg[9][6]  ( .D(n387), .CLK(clk), .R(n122), .S(1'b1), .Q(
        n493) );
  DFFSR \data_buffer_reg[8][6]  ( .D(n395), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[8][6] ) );
  DFFSR \data_buffer_reg[7][6]  ( .D(n403), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[7][6] ) );
  DFFSR \data_buffer_reg[6][6]  ( .D(n411), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[6][6] ) );
  DFFSR \data_buffer_reg[5][6]  ( .D(n419), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[5][6] ) );
  DFFSR \data_buffer_reg[4][6]  ( .D(n427), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[4][6] ) );
  DFFSR \data_buffer_reg[3][6]  ( .D(n435), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[3][6] ) );
  DFFSR \data_buffer_reg[2][6]  ( .D(n443), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[2][6] ) );
  DFFSR \data_buffer_reg[1][6]  ( .D(n451), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[1][6] ) );
  DFFSR \data_buffer_reg[0][5]  ( .D(n460), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[0][5] ) );
  DFFSR \data_buffer_reg[11][5]  ( .D(n372), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(\data_buffer[11][5] ) );
  DFFSR \data_buffer_reg[10][5]  ( .D(n380), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(n487) );
  DFFSR \data_buffer_reg[9][5]  ( .D(n388), .CLK(clk), .R(n122), .S(1'b1), .Q(
        n494) );
  DFFSR \data_buffer_reg[8][5]  ( .D(n396), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[8][5] ) );
  DFFSR \data_buffer_reg[7][5]  ( .D(n404), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[7][5] ) );
  DFFSR \data_buffer_reg[6][5]  ( .D(n412), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[6][5] ) );
  DFFSR \data_buffer_reg[5][5]  ( .D(n420), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[5][5] ) );
  DFFSR \data_buffer_reg[4][5]  ( .D(n428), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[4][5] ) );
  DFFSR \data_buffer_reg[3][5]  ( .D(n436), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[3][5] ) );
  DFFSR \data_buffer_reg[2][5]  ( .D(n444), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[2][5] ) );
  DFFSR \data_buffer_reg[1][5]  ( .D(n452), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[1][5] ) );
  DFFSR \data_buffer_reg[0][4]  ( .D(n461), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[0][4] ) );
  DFFSR \data_buffer_reg[11][4]  ( .D(n373), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(\data_buffer[11][4] ) );
  DFFSR \data_buffer_reg[10][4]  ( .D(n381), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(n488) );
  DFFSR \data_buffer_reg[9][4]  ( .D(n389), .CLK(clk), .R(n122), .S(1'b1), .Q(
        n495) );
  DFFSR \data_buffer_reg[8][4]  ( .D(n397), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[8][4] ) );
  DFFSR \data_buffer_reg[7][4]  ( .D(n405), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[7][4] ) );
  DFFSR \data_buffer_reg[6][4]  ( .D(n413), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[6][4] ) );
  DFFSR \data_buffer_reg[5][4]  ( .D(n421), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[5][4] ) );
  DFFSR \data_buffer_reg[4][4]  ( .D(n429), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[4][4] ) );
  DFFSR \data_buffer_reg[3][4]  ( .D(n437), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[3][4] ) );
  DFFSR \data_buffer_reg[2][4]  ( .D(n445), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[2][4] ) );
  DFFSR \data_buffer_reg[1][4]  ( .D(n453), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[1][4] ) );
  DFFSR \data_buffer_reg[0][3]  ( .D(n462), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[0][3] ) );
  DFFSR \data_buffer_reg[11][3]  ( .D(n374), .CLK(clk), .R(n121), .S(1'b1), 
        .Q(\data_buffer[11][3] ) );
  DFFSR \data_buffer_reg[10][3]  ( .D(n382), .CLK(clk), .R(n121), .S(1'b1), 
        .Q(n489) );
  DFFSR \data_buffer_reg[9][3]  ( .D(n390), .CLK(clk), .R(n121), .S(1'b1), .Q(
        n496) );
  DFFSR \data_buffer_reg[8][3]  ( .D(n398), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[8][3] ) );
  DFFSR \data_buffer_reg[7][3]  ( .D(n406), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[7][3] ) );
  DFFSR \data_buffer_reg[6][3]  ( .D(n414), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[6][3] ) );
  DFFSR \data_buffer_reg[5][3]  ( .D(n422), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[5][3] ) );
  DFFSR \data_buffer_reg[4][3]  ( .D(n430), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[4][3] ) );
  DFFSR \data_buffer_reg[3][3]  ( .D(n438), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[3][3] ) );
  DFFSR \data_buffer_reg[2][3]  ( .D(n446), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[2][3] ) );
  DFFSR \data_buffer_reg[1][3]  ( .D(n454), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[1][3] ) );
  DFFSR \data_buffer_reg[0][2]  ( .D(n463), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[0][2] ) );
  DFFSR \data_buffer_reg[11][2]  ( .D(n375), .CLK(clk), .R(n121), .S(1'b1), 
        .Q(\data_buffer[11][2] ) );
  DFFSR \data_buffer_reg[10][2]  ( .D(n383), .CLK(clk), .R(n121), .S(1'b1), 
        .Q(n490) );
  DFFSR \data_buffer_reg[9][2]  ( .D(n391), .CLK(clk), .R(n121), .S(1'b1), .Q(
        n497) );
  DFFSR \data_buffer_reg[8][2]  ( .D(n399), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[8][2] ) );
  DFFSR \data_buffer_reg[7][2]  ( .D(n407), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[7][2] ) );
  DFFSR \data_buffer_reg[6][2]  ( .D(n415), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[6][2] ) );
  DFFSR \data_buffer_reg[5][2]  ( .D(n423), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[5][2] ) );
  DFFSR \data_buffer_reg[4][2]  ( .D(n431), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[4][2] ) );
  DFFSR \data_buffer_reg[3][2]  ( .D(n439), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[3][2] ) );
  DFFSR \data_buffer_reg[2][2]  ( .D(n447), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[2][2] ) );
  DFFSR \data_buffer_reg[1][2]  ( .D(n455), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[1][2] ) );
  DFFSR \data_buffer_reg[0][1]  ( .D(n464), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[0][1] ) );
  DFFSR \data_buffer_reg[11][1]  ( .D(n376), .CLK(clk), .R(n123), .S(1'b1), 
        .Q(\data_buffer[11][1] ) );
  DFFSR \data_buffer_reg[10][1]  ( .D(n384), .CLK(clk), .R(n122), .S(1'b1), 
        .Q(n491) );
  DFFSR \data_buffer_reg[9][1]  ( .D(n392), .CLK(clk), .R(n123), .S(1'b1), .Q(
        n498) );
  DFFSR \data_buffer_reg[8][1]  ( .D(n400), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[8][1] ) );
  DFFSR \data_buffer_reg[7][1]  ( .D(n408), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[7][1] ) );
  DFFSR \data_buffer_reg[6][1]  ( .D(n416), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[6][1] ) );
  DFFSR \data_buffer_reg[5][1]  ( .D(n424), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[5][1] ) );
  DFFSR \data_buffer_reg[4][1]  ( .D(n432), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[4][1] ) );
  DFFSR \data_buffer_reg[3][1]  ( .D(n440), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[3][1] ) );
  DFFSR \data_buffer_reg[2][1]  ( .D(n448), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[2][1] ) );
  DFFSR \data_buffer_reg[1][1]  ( .D(n456), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[1][1] ) );
  DFFSR \data_buffer_reg[0][0]  ( .D(n465), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[0][0] ) );
  DFFSR \data_buffer_reg[11][0]  ( .D(n377), .CLK(clk), .R(n123), .S(1'b1), 
        .Q(\data_buffer[11][0] ) );
  DFFSR \data_buffer_reg[10][0]  ( .D(n385), .CLK(clk), .R(n121), .S(1'b1), 
        .Q(\data_buffer[10][0] ) );
  DFFSR \data_buffer_reg[9][0]  ( .D(n393), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[9][0] ) );
  DFFSR \data_buffer_reg[8][0]  ( .D(n401), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[8][0] ) );
  DFFSR \data_buffer_reg[7][0]  ( .D(n409), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[7][0] ) );
  DFFSR \data_buffer_reg[6][0]  ( .D(n417), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[6][0] ) );
  DFFSR \data_buffer_reg[5][0]  ( .D(n425), .CLK(clk), .R(n123), .S(1'b1), .Q(
        \data_buffer[5][0] ) );
  DFFSR \data_buffer_reg[4][0]  ( .D(n433), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[4][0] ) );
  DFFSR \data_buffer_reg[3][0]  ( .D(n441), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[3][0] ) );
  DFFSR \data_buffer_reg[2][0]  ( .D(n449), .CLK(clk), .R(n122), .S(1'b1), .Q(
        \data_buffer[2][0] ) );
  DFFSR \data_buffer_reg[1][0]  ( .D(n457), .CLK(clk), .R(n121), .S(1'b1), .Q(
        \data_buffer[1][0] ) );
  AND2X2 U100 ( .A(n112), .B(read_data[7]), .Y(n251) );
  AND2X2 U101 ( .A(read_data[6]), .B(n112), .Y(n264) );
  AND2X2 U102 ( .A(read_data[5]), .B(n112), .Y(n276) );
  AND2X2 U103 ( .A(read_data[4]), .B(n112), .Y(n288) );
  AND2X2 U104 ( .A(read_data[3]), .B(n112), .Y(n300) );
  AND2X2 U105 ( .A(read_data[2]), .B(n112), .Y(n312) );
  AND2X2 U106 ( .A(read_data[1]), .B(n112), .Y(n324) );
  AND2X2 U107 ( .A(read_data[0]), .B(n112), .Y(n336) );
  OAI22X1 U227 ( .A(n140), .B(n216), .C(n120), .D(n217), .Y(n370) );
  OAI22X1 U228 ( .A(n216), .B(n152), .C(n120), .D(n218), .Y(n371) );
  OAI22X1 U229 ( .A(n216), .B(n164), .C(n120), .D(n219), .Y(n372) );
  OAI22X1 U230 ( .A(n216), .B(n176), .C(n120), .D(n220), .Y(n373) );
  OAI22X1 U231 ( .A(n216), .B(n188), .C(n120), .D(n221), .Y(n374) );
  OAI22X1 U232 ( .A(n216), .B(n200), .C(n120), .D(n222), .Y(n375) );
  OAI22X1 U233 ( .A(n216), .B(n212), .C(n120), .D(n223), .Y(n376) );
  OAI22X1 U234 ( .A(n216), .B(n474), .C(n120), .D(n224), .Y(n377) );
  OAI21X1 U235 ( .A(n225), .B(n226), .C(n128), .Y(n216) );
  OAI22X1 U236 ( .A(n141), .B(n227), .C(n119), .D(n217), .Y(n378) );
  OAI22X1 U237 ( .A(n153), .B(n227), .C(n119), .D(n218), .Y(n379) );
  OAI22X1 U238 ( .A(n165), .B(n227), .C(n119), .D(n219), .Y(n380) );
  OAI22X1 U239 ( .A(n177), .B(n227), .C(n119), .D(n220), .Y(n381) );
  OAI22X1 U240 ( .A(n189), .B(n227), .C(n119), .D(n221), .Y(n382) );
  OAI22X1 U241 ( .A(n201), .B(n227), .C(n119), .D(n222), .Y(n383) );
  OAI22X1 U242 ( .A(n213), .B(n227), .C(n119), .D(n223), .Y(n384) );
  OAI22X1 U243 ( .A(n475), .B(n227), .C(n119), .D(n224), .Y(n385) );
  OAI21X1 U244 ( .A(n228), .B(n226), .C(n128), .Y(n227) );
  OAI22X1 U245 ( .A(n142), .B(n229), .C(n127), .D(n217), .Y(n386) );
  OAI22X1 U246 ( .A(n154), .B(n229), .C(n127), .D(n218), .Y(n387) );
  OAI22X1 U247 ( .A(n166), .B(n229), .C(n127), .D(n219), .Y(n388) );
  OAI22X1 U248 ( .A(n178), .B(n229), .C(n127), .D(n220), .Y(n389) );
  OAI22X1 U249 ( .A(n190), .B(n229), .C(n127), .D(n221), .Y(n390) );
  OAI22X1 U250 ( .A(n202), .B(n229), .C(n127), .D(n222), .Y(n391) );
  OAI22X1 U251 ( .A(n214), .B(n229), .C(n127), .D(n223), .Y(n392) );
  OAI22X1 U252 ( .A(n476), .B(n229), .C(n127), .D(n224), .Y(n393) );
  OAI21X1 U253 ( .A(n230), .B(n226), .C(n128), .Y(n229) );
  OAI22X1 U254 ( .A(n143), .B(n231), .C(n118), .D(n217), .Y(n394) );
  OAI22X1 U255 ( .A(n155), .B(n231), .C(n118), .D(n218), .Y(n395) );
  OAI22X1 U256 ( .A(n167), .B(n231), .C(n118), .D(n219), .Y(n396) );
  OAI22X1 U257 ( .A(n179), .B(n231), .C(n118), .D(n220), .Y(n397) );
  OAI22X1 U258 ( .A(n191), .B(n231), .C(n118), .D(n221), .Y(n398) );
  OAI22X1 U259 ( .A(n203), .B(n231), .C(n118), .D(n222), .Y(n399) );
  OAI22X1 U260 ( .A(n215), .B(n231), .C(n118), .D(n223), .Y(n400) );
  OAI22X1 U261 ( .A(n477), .B(n231), .C(n118), .D(n224), .Y(n401) );
  OAI21X1 U262 ( .A(n232), .B(n226), .C(n128), .Y(n231) );
  OR2X1 U263 ( .A(n233), .B(pixel_count[2]), .Y(n226) );
  OAI22X1 U264 ( .A(n144), .B(n234), .C(n117), .D(n217), .Y(n402) );
  OAI22X1 U265 ( .A(n156), .B(n234), .C(n117), .D(n218), .Y(n403) );
  OAI22X1 U266 ( .A(n168), .B(n234), .C(n117), .D(n219), .Y(n404) );
  OAI22X1 U267 ( .A(n180), .B(n234), .C(n117), .D(n220), .Y(n405) );
  OAI22X1 U268 ( .A(n192), .B(n234), .C(n117), .D(n221), .Y(n406) );
  OAI22X1 U269 ( .A(n204), .B(n234), .C(n117), .D(n222), .Y(n407) );
  OAI22X1 U270 ( .A(n466), .B(n234), .C(n117), .D(n223), .Y(n408) );
  OAI22X1 U271 ( .A(n478), .B(n234), .C(n117), .D(n224), .Y(n409) );
  OAI21X1 U272 ( .A(n235), .B(n236), .C(n128), .Y(n234) );
  OAI22X1 U273 ( .A(n145), .B(n237), .C(n126), .D(n217), .Y(n410) );
  OAI22X1 U274 ( .A(n157), .B(n237), .C(n126), .D(n218), .Y(n411) );
  OAI22X1 U275 ( .A(n169), .B(n237), .C(n126), .D(n219), .Y(n412) );
  OAI22X1 U276 ( .A(n181), .B(n237), .C(n126), .D(n220), .Y(n413) );
  OAI22X1 U277 ( .A(n193), .B(n237), .C(n126), .D(n221), .Y(n414) );
  OAI22X1 U278 ( .A(n205), .B(n237), .C(n126), .D(n222), .Y(n415) );
  OAI22X1 U279 ( .A(n467), .B(n237), .C(n126), .D(n223), .Y(n416) );
  OAI22X1 U280 ( .A(n479), .B(n237), .C(n126), .D(n224), .Y(n417) );
  OAI21X1 U281 ( .A(n238), .B(n236), .C(n128), .Y(n237) );
  OAI22X1 U282 ( .A(n146), .B(n239), .C(n116), .D(n217), .Y(n418) );
  OAI22X1 U283 ( .A(n158), .B(n239), .C(n116), .D(n218), .Y(n419) );
  OAI22X1 U284 ( .A(n170), .B(n239), .C(n116), .D(n219), .Y(n420) );
  OAI22X1 U285 ( .A(n182), .B(n239), .C(n116), .D(n220), .Y(n421) );
  OAI22X1 U286 ( .A(n194), .B(n239), .C(n116), .D(n221), .Y(n422) );
  OAI22X1 U287 ( .A(n206), .B(n239), .C(n116), .D(n222), .Y(n423) );
  OAI22X1 U288 ( .A(n468), .B(n239), .C(n116), .D(n223), .Y(n424) );
  OAI22X1 U289 ( .A(n480), .B(n239), .C(n116), .D(n224), .Y(n425) );
  OAI21X1 U290 ( .A(n240), .B(n236), .C(n128), .Y(n239) );
  OAI22X1 U291 ( .A(n147), .B(n241), .C(n115), .D(n217), .Y(n426) );
  OAI22X1 U292 ( .A(n159), .B(n241), .C(n115), .D(n218), .Y(n427) );
  OAI22X1 U293 ( .A(n171), .B(n241), .C(n115), .D(n219), .Y(n428) );
  OAI22X1 U294 ( .A(n183), .B(n241), .C(n115), .D(n220), .Y(n429) );
  OAI22X1 U295 ( .A(n195), .B(n241), .C(n115), .D(n221), .Y(n430) );
  OAI22X1 U296 ( .A(n207), .B(n241), .C(n115), .D(n222), .Y(n431) );
  OAI22X1 U297 ( .A(n469), .B(n241), .C(n115), .D(n223), .Y(n432) );
  OAI22X1 U298 ( .A(n481), .B(n241), .C(n115), .D(n224), .Y(n433) );
  OAI21X1 U299 ( .A(n242), .B(n236), .C(n128), .Y(n241) );
  OR2X1 U300 ( .A(n233), .B(pixel_count[3]), .Y(n236) );
  OAI22X1 U301 ( .A(n148), .B(n243), .C(n125), .D(n217), .Y(n434) );
  OAI22X1 U302 ( .A(n160), .B(n243), .C(n125), .D(n218), .Y(n435) );
  OAI22X1 U303 ( .A(n172), .B(n243), .C(n125), .D(n219), .Y(n436) );
  OAI22X1 U304 ( .A(n184), .B(n243), .C(n125), .D(n220), .Y(n437) );
  OAI22X1 U305 ( .A(n196), .B(n243), .C(n125), .D(n221), .Y(n438) );
  OAI22X1 U306 ( .A(n208), .B(n243), .C(n125), .D(n222), .Y(n439) );
  OAI22X1 U307 ( .A(n470), .B(n243), .C(n125), .D(n223), .Y(n440) );
  OAI22X1 U308 ( .A(n482), .B(n243), .C(n125), .D(n224), .Y(n441) );
  OAI21X1 U309 ( .A(n244), .B(n233), .C(n128), .Y(n243) );
  OAI22X1 U310 ( .A(n149), .B(n245), .C(n114), .D(n217), .Y(n442) );
  OAI22X1 U311 ( .A(n161), .B(n245), .C(n114), .D(n218), .Y(n443) );
  OAI22X1 U312 ( .A(n173), .B(n245), .C(n114), .D(n219), .Y(n444) );
  OAI22X1 U313 ( .A(n185), .B(n245), .C(n114), .D(n220), .Y(n445) );
  OAI22X1 U314 ( .A(n197), .B(n245), .C(n114), .D(n221), .Y(n446) );
  OAI22X1 U315 ( .A(n209), .B(n245), .C(n114), .D(n222), .Y(n447) );
  OAI22X1 U316 ( .A(n471), .B(n245), .C(n114), .D(n223), .Y(n448) );
  OAI22X1 U317 ( .A(n483), .B(n245), .C(n114), .D(n224), .Y(n449) );
  OAI21X1 U318 ( .A(n246), .B(n233), .C(n128), .Y(n245) );
  OAI22X1 U319 ( .A(n150), .B(n247), .C(n113), .D(n217), .Y(n450) );
  OAI22X1 U320 ( .A(n162), .B(n247), .C(n113), .D(n218), .Y(n451) );
  OAI22X1 U321 ( .A(n174), .B(n247), .C(n113), .D(n219), .Y(n452) );
  OAI22X1 U322 ( .A(n186), .B(n247), .C(n113), .D(n220), .Y(n453) );
  OAI22X1 U323 ( .A(n198), .B(n247), .C(n113), .D(n221), .Y(n454) );
  OAI22X1 U324 ( .A(n210), .B(n247), .C(n113), .D(n222), .Y(n455) );
  OAI22X1 U325 ( .A(n472), .B(n247), .C(n113), .D(n223), .Y(n456) );
  OAI22X1 U326 ( .A(n484), .B(n247), .C(n113), .D(n224), .Y(n457) );
  OAI21X1 U327 ( .A(n248), .B(n233), .C(n128), .Y(n247) );
  OAI22X1 U328 ( .A(n139), .B(n249), .C(n124), .D(n217), .Y(n458) );
  OAI21X1 U329 ( .A(n250), .B(n251), .C(n128), .Y(n217) );
  AOI21X1 U330 ( .A(n252), .B(n253), .C(n112), .Y(n250) );
  NOR2X1 U331 ( .A(n254), .B(n255), .Y(n253) );
  OAI21X1 U332 ( .A(n238), .B(n145), .C(n256), .Y(n255) );
  AOI22X1 U333 ( .A(\data_buffer[8][7] ), .B(n132), .C(\data_buffer[7][7] ), 
        .D(n134), .Y(n256) );
  OAI21X1 U334 ( .A(n230), .B(n142), .C(n257), .Y(n254) );
  AOI22X1 U335 ( .A(\data_buffer[11][7] ), .B(n135), .C(n485), .D(n131), .Y(
        n257) );
  NOR2X1 U336 ( .A(n258), .B(n259), .Y(n252) );
  OAI21X1 U337 ( .A(n260), .B(n139), .C(n261), .Y(n259) );
  AOI22X1 U338 ( .A(\data_buffer[2][7] ), .B(n130), .C(\data_buffer[1][7] ), 
        .D(n136), .Y(n261) );
  OAI21X1 U339 ( .A(n244), .B(n148), .C(n262), .Y(n258) );
  AOI22X1 U340 ( .A(\data_buffer[5][7] ), .B(n137), .C(\data_buffer[4][7] ), 
        .D(n129), .Y(n262) );
  OAI22X1 U341 ( .A(n151), .B(n249), .C(n124), .D(n218), .Y(n459) );
  OAI21X1 U342 ( .A(n263), .B(n264), .C(n128), .Y(n218) );
  AOI21X1 U343 ( .A(n265), .B(n266), .C(n112), .Y(n263) );
  NOR2X1 U344 ( .A(n267), .B(n268), .Y(n266) );
  OAI21X1 U345 ( .A(n238), .B(n157), .C(n269), .Y(n268) );
  AOI22X1 U346 ( .A(\data_buffer[8][6] ), .B(n132), .C(\data_buffer[7][6] ), 
        .D(n134), .Y(n269) );
  OAI21X1 U347 ( .A(n230), .B(n154), .C(n270), .Y(n267) );
  AOI22X1 U348 ( .A(\data_buffer[11][6] ), .B(n135), .C(n486), .D(n131), .Y(
        n270) );
  NOR2X1 U349 ( .A(n271), .B(n272), .Y(n265) );
  OAI21X1 U350 ( .A(n260), .B(n151), .C(n273), .Y(n272) );
  AOI22X1 U351 ( .A(\data_buffer[2][6] ), .B(n130), .C(\data_buffer[1][6] ), 
        .D(n136), .Y(n273) );
  OAI21X1 U352 ( .A(n244), .B(n160), .C(n274), .Y(n271) );
  AOI22X1 U353 ( .A(\data_buffer[5][6] ), .B(n137), .C(\data_buffer[4][6] ), 
        .D(n129), .Y(n274) );
  OAI22X1 U354 ( .A(n163), .B(n249), .C(n124), .D(n219), .Y(n460) );
  OAI21X1 U355 ( .A(n275), .B(n276), .C(n128), .Y(n219) );
  AOI21X1 U356 ( .A(n277), .B(n278), .C(n112), .Y(n275) );
  NOR2X1 U357 ( .A(n279), .B(n280), .Y(n278) );
  OAI21X1 U358 ( .A(n238), .B(n169), .C(n281), .Y(n280) );
  AOI22X1 U359 ( .A(\data_buffer[8][5] ), .B(n132), .C(\data_buffer[7][5] ), 
        .D(n134), .Y(n281) );
  OAI21X1 U360 ( .A(n230), .B(n166), .C(n282), .Y(n279) );
  AOI22X1 U361 ( .A(\data_buffer[11][5] ), .B(n135), .C(n487), .D(n131), .Y(
        n282) );
  NOR2X1 U362 ( .A(n283), .B(n284), .Y(n277) );
  OAI21X1 U363 ( .A(n260), .B(n163), .C(n285), .Y(n284) );
  AOI22X1 U364 ( .A(\data_buffer[2][5] ), .B(n130), .C(\data_buffer[1][5] ), 
        .D(n136), .Y(n285) );
  OAI21X1 U365 ( .A(n244), .B(n172), .C(n286), .Y(n283) );
  AOI22X1 U366 ( .A(\data_buffer[5][5] ), .B(n137), .C(\data_buffer[4][5] ), 
        .D(n129), .Y(n286) );
  OAI22X1 U367 ( .A(n175), .B(n249), .C(n124), .D(n220), .Y(n461) );
  OAI21X1 U368 ( .A(n287), .B(n288), .C(n128), .Y(n220) );
  AOI21X1 U369 ( .A(n289), .B(n290), .C(n112), .Y(n287) );
  NOR2X1 U370 ( .A(n291), .B(n292), .Y(n290) );
  OAI21X1 U371 ( .A(n238), .B(n181), .C(n293), .Y(n292) );
  AOI22X1 U372 ( .A(\data_buffer[8][4] ), .B(n132), .C(\data_buffer[7][4] ), 
        .D(n134), .Y(n293) );
  OAI21X1 U373 ( .A(n230), .B(n178), .C(n294), .Y(n291) );
  AOI22X1 U374 ( .A(\data_buffer[11][4] ), .B(n135), .C(n488), .D(n131), .Y(
        n294) );
  NOR2X1 U375 ( .A(n295), .B(n296), .Y(n289) );
  OAI21X1 U376 ( .A(n260), .B(n175), .C(n297), .Y(n296) );
  AOI22X1 U377 ( .A(\data_buffer[2][4] ), .B(n130), .C(\data_buffer[1][4] ), 
        .D(n136), .Y(n297) );
  OAI21X1 U378 ( .A(n244), .B(n184), .C(n298), .Y(n295) );
  AOI22X1 U379 ( .A(\data_buffer[5][4] ), .B(n137), .C(\data_buffer[4][4] ), 
        .D(n129), .Y(n298) );
  OAI22X1 U380 ( .A(n187), .B(n249), .C(n124), .D(n221), .Y(n462) );
  OAI21X1 U381 ( .A(n299), .B(n300), .C(n128), .Y(n221) );
  AOI21X1 U382 ( .A(n301), .B(n302), .C(n112), .Y(n299) );
  NOR2X1 U383 ( .A(n303), .B(n304), .Y(n302) );
  OAI21X1 U384 ( .A(n238), .B(n193), .C(n305), .Y(n304) );
  AOI22X1 U385 ( .A(\data_buffer[8][3] ), .B(n132), .C(\data_buffer[7][3] ), 
        .D(n134), .Y(n305) );
  OAI21X1 U386 ( .A(n230), .B(n190), .C(n306), .Y(n303) );
  AOI22X1 U387 ( .A(\data_buffer[11][3] ), .B(n135), .C(n489), .D(n131), .Y(
        n306) );
  NOR2X1 U388 ( .A(n307), .B(n308), .Y(n301) );
  OAI21X1 U389 ( .A(n260), .B(n187), .C(n309), .Y(n308) );
  AOI22X1 U390 ( .A(\data_buffer[2][3] ), .B(n130), .C(\data_buffer[1][3] ), 
        .D(n136), .Y(n309) );
  OAI21X1 U391 ( .A(n244), .B(n196), .C(n310), .Y(n307) );
  AOI22X1 U392 ( .A(\data_buffer[5][3] ), .B(n137), .C(\data_buffer[4][3] ), 
        .D(n129), .Y(n310) );
  OAI22X1 U393 ( .A(n199), .B(n249), .C(n124), .D(n222), .Y(n463) );
  OAI21X1 U394 ( .A(n311), .B(n312), .C(n128), .Y(n222) );
  AOI21X1 U395 ( .A(n313), .B(n314), .C(n112), .Y(n311) );
  NOR2X1 U396 ( .A(n315), .B(n316), .Y(n314) );
  OAI21X1 U397 ( .A(n238), .B(n205), .C(n317), .Y(n316) );
  AOI22X1 U398 ( .A(\data_buffer[8][2] ), .B(n132), .C(\data_buffer[7][2] ), 
        .D(n134), .Y(n317) );
  OAI21X1 U399 ( .A(n230), .B(n202), .C(n318), .Y(n315) );
  AOI22X1 U400 ( .A(\data_buffer[11][2] ), .B(n135), .C(n490), .D(n131), .Y(
        n318) );
  NOR2X1 U401 ( .A(n319), .B(n320), .Y(n313) );
  OAI21X1 U402 ( .A(n260), .B(n199), .C(n321), .Y(n320) );
  AOI22X1 U403 ( .A(\data_buffer[2][2] ), .B(n130), .C(\data_buffer[1][2] ), 
        .D(n136), .Y(n321) );
  OAI21X1 U404 ( .A(n244), .B(n208), .C(n322), .Y(n319) );
  AOI22X1 U405 ( .A(\data_buffer[5][2] ), .B(n137), .C(\data_buffer[4][2] ), 
        .D(n129), .Y(n322) );
  OAI22X1 U406 ( .A(n211), .B(n249), .C(n124), .D(n223), .Y(n464) );
  OAI21X1 U407 ( .A(n323), .B(n324), .C(n128), .Y(n223) );
  AOI21X1 U408 ( .A(n325), .B(n326), .C(n112), .Y(n323) );
  NOR2X1 U409 ( .A(n327), .B(n328), .Y(n326) );
  OAI21X1 U410 ( .A(n238), .B(n467), .C(n329), .Y(n328) );
  AOI22X1 U411 ( .A(\data_buffer[8][1] ), .B(n132), .C(\data_buffer[7][1] ), 
        .D(n134), .Y(n329) );
  OAI21X1 U412 ( .A(n230), .B(n214), .C(n330), .Y(n327) );
  AOI22X1 U413 ( .A(\data_buffer[11][1] ), .B(n135), .C(n491), .D(n131), .Y(
        n330) );
  NOR2X1 U414 ( .A(n331), .B(n332), .Y(n325) );
  OAI21X1 U415 ( .A(n260), .B(n211), .C(n333), .Y(n332) );
  AOI22X1 U416 ( .A(\data_buffer[2][1] ), .B(n130), .C(\data_buffer[1][1] ), 
        .D(n136), .Y(n333) );
  OAI21X1 U417 ( .A(n244), .B(n470), .C(n334), .Y(n331) );
  AOI22X1 U418 ( .A(\data_buffer[5][1] ), .B(n137), .C(\data_buffer[4][1] ), 
        .D(n129), .Y(n334) );
  OAI22X1 U419 ( .A(n473), .B(n249), .C(n124), .D(n224), .Y(n465) );
  OAI21X1 U420 ( .A(n335), .B(n336), .C(n128), .Y(n224) );
  AOI21X1 U421 ( .A(n337), .B(n338), .C(n112), .Y(n335) );
  NOR2X1 U422 ( .A(n339), .B(n340), .Y(n338) );
  OAI21X1 U423 ( .A(n238), .B(n479), .C(n341), .Y(n340) );
  AOI22X1 U424 ( .A(\data_buffer[8][0] ), .B(n132), .C(\data_buffer[7][0] ), 
        .D(n134), .Y(n341) );
  NAND3X1 U425 ( .A(pixel_count[1]), .B(pixel_count[0]), .C(pixel_count[2]), 
        .Y(n235) );
  NAND3X1 U426 ( .A(n133), .B(n138), .C(pixel_count[3]), .Y(n232) );
  NAND3X1 U427 ( .A(pixel_count[1]), .B(n133), .C(pixel_count[2]), .Y(n238) );
  OAI21X1 U428 ( .A(n230), .B(n476), .C(n342), .Y(n339) );
  AOI22X1 U429 ( .A(\data_buffer[11][0] ), .B(n135), .C(\data_buffer[10][0] ), 
        .D(n131), .Y(n342) );
  NAND3X1 U430 ( .A(pixel_count[1]), .B(n133), .C(pixel_count[3]), .Y(n228) );
  NAND3X1 U431 ( .A(pixel_count[1]), .B(pixel_count[0]), .C(pixel_count[3]), 
        .Y(n225) );
  NAND3X1 U432 ( .A(pixel_count[0]), .B(n138), .C(pixel_count[3]), .Y(n230) );
  NOR2X1 U433 ( .A(n343), .B(n344), .Y(n337) );
  OAI21X1 U434 ( .A(n260), .B(n473), .C(n345), .Y(n344) );
  AOI22X1 U435 ( .A(\data_buffer[2][0] ), .B(n130), .C(\data_buffer[1][0] ), 
        .D(n136), .Y(n345) );
  NAND3X1 U436 ( .A(pixel_count[0]), .B(n138), .C(n346), .Y(n248) );
  NAND3X1 U437 ( .A(pixel_count[1]), .B(n133), .C(n346), .Y(n246) );
  OAI21X1 U438 ( .A(n244), .B(n482), .C(n347), .Y(n343) );
  AOI22X1 U439 ( .A(\data_buffer[5][0] ), .B(n137), .C(\data_buffer[4][0] ), 
        .D(n129), .Y(n347) );
  NAND3X1 U440 ( .A(n133), .B(n138), .C(pixel_count[2]), .Y(n242) );
  NAND3X1 U441 ( .A(pixel_count[0]), .B(n138), .C(pixel_count[2]), .Y(n240) );
  NAND3X1 U442 ( .A(pixel_count[1]), .B(pixel_count[0]), .C(n346), .Y(n244) );
  OAI21X1 U443 ( .A(n260), .B(n233), .C(n128), .Y(n249) );
  NAND2X1 U444 ( .A(n348), .B(n349), .Y(n233) );
  NOR2X1 U445 ( .A(n350), .B(n351), .Y(n349) );
  NAND3X1 U446 ( .A(n352), .B(n353), .C(n354), .Y(n351) );
  NOR2X1 U447 ( .A(pixel_count[24]), .B(n355), .Y(n354) );
  OR2X1 U448 ( .A(pixel_count[26]), .B(pixel_count[25]), .Y(n355) );
  NOR2X1 U449 ( .A(pixel_count[30]), .B(pixel_count[29]), .Y(n353) );
  NOR2X1 U450 ( .A(pixel_count[28]), .B(pixel_count[27]), .Y(n352) );
  NAND3X1 U451 ( .A(n356), .B(n357), .C(n358), .Y(n350) );
  NOR2X1 U452 ( .A(pixel_count[31]), .B(n359), .Y(n358) );
  OR2X1 U453 ( .A(pixel_count[5]), .B(pixel_count[4]), .Y(n359) );
  NOR2X1 U454 ( .A(pixel_count[9]), .B(pixel_count[8]), .Y(n357) );
  NOR2X1 U455 ( .A(pixel_count[7]), .B(pixel_count[6]), .Y(n356) );
  NOR2X1 U456 ( .A(n360), .B(n361), .Y(n348) );
  NAND3X1 U457 ( .A(n362), .B(n363), .C(n364), .Y(n361) );
  NOR2X1 U458 ( .A(pixel_count[10]), .B(n365), .Y(n364) );
  OR2X1 U459 ( .A(pixel_count[12]), .B(pixel_count[11]), .Y(n365) );
  NOR2X1 U460 ( .A(pixel_count[16]), .B(pixel_count[15]), .Y(n363) );
  NOR2X1 U461 ( .A(pixel_count[14]), .B(pixel_count[13]), .Y(n362) );
  NAND3X1 U462 ( .A(n366), .B(n367), .C(n368), .Y(n360) );
  NOR2X1 U463 ( .A(pixel_count[17]), .B(n369), .Y(n368) );
  OR2X1 U464 ( .A(pixel_count[19]), .B(pixel_count[18]), .Y(n369) );
  NOR2X1 U465 ( .A(pixel_count[23]), .B(pixel_count[22]), .Y(n367) );
  NOR2X1 U466 ( .A(pixel_count[21]), .B(pixel_count[20]), .Y(n366) );
  NAND3X1 U467 ( .A(n133), .B(n138), .C(n346), .Y(n260) );
  NOR2X1 U468 ( .A(pixel_count[2]), .B(pixel_count[3]), .Y(n346) );
  flex_counter_NUM_CNT_BITS32_3 PIXEL_COUNTER ( .clk(clk), .n_rst(n121), 
        .clear(buffer_clear), .count_enable(n112), .rollover_val({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0}), .count_out(pixel_count), 
        .rollover_flag(buffer_full) );
  INVX2 U108 ( .A(n141), .Y(\data_buffer[10][7] ) );
  INVX1 U109 ( .A(n485), .Y(n141) );
  INVX2 U110 ( .A(n153), .Y(\data_buffer[10][6] ) );
  INVX1 U111 ( .A(n486), .Y(n153) );
  INVX2 U112 ( .A(n165), .Y(\data_buffer[10][5] ) );
  INVX1 U113 ( .A(n487), .Y(n165) );
  INVX2 U114 ( .A(n177), .Y(\data_buffer[10][4] ) );
  INVX1 U115 ( .A(n488), .Y(n177) );
  INVX2 U116 ( .A(n189), .Y(\data_buffer[10][3] ) );
  INVX1 U117 ( .A(n489), .Y(n189) );
  INVX2 U118 ( .A(n201), .Y(\data_buffer[10][2] ) );
  INVX1 U119 ( .A(n490), .Y(n201) );
  INVX2 U120 ( .A(n213), .Y(\data_buffer[10][1] ) );
  INVX1 U121 ( .A(n491), .Y(n213) );
  INVX2 U122 ( .A(n142), .Y(\data_buffer[9][7] ) );
  INVX1 U123 ( .A(n492), .Y(n142) );
  INVX2 U124 ( .A(n154), .Y(\data_buffer[9][6] ) );
  INVX1 U125 ( .A(n493), .Y(n154) );
  INVX2 U126 ( .A(n166), .Y(\data_buffer[9][5] ) );
  INVX1 U127 ( .A(n494), .Y(n166) );
  INVX2 U128 ( .A(n178), .Y(\data_buffer[9][4] ) );
  INVX1 U129 ( .A(n495), .Y(n178) );
  INVX2 U130 ( .A(n190), .Y(\data_buffer[9][3] ) );
  INVX1 U131 ( .A(n496), .Y(n190) );
  INVX2 U132 ( .A(n202), .Y(\data_buffer[9][2] ) );
  INVX1 U133 ( .A(n497), .Y(n202) );
  INVX2 U134 ( .A(n214), .Y(\data_buffer[9][1] ) );
  INVX1 U135 ( .A(n498), .Y(n214) );
  INVX2 U136 ( .A(buffer_clear), .Y(n128) );
  INVX2 U137 ( .A(n111), .Y(n112) );
  INVX2 U138 ( .A(shift_enable), .Y(n111) );
  INVX2 U139 ( .A(n245), .Y(n114) );
  INVX2 U140 ( .A(n231), .Y(n118) );
  INVX2 U141 ( .A(n247), .Y(n113) );
  INVX2 U142 ( .A(n241), .Y(n115) );
  INVX2 U143 ( .A(n239), .Y(n116) );
  INVX2 U144 ( .A(n234), .Y(n117) );
  INVX2 U145 ( .A(n227), .Y(n119) );
  INVX2 U146 ( .A(n216), .Y(n120) );
  BUFX2 U147 ( .A(n_rst), .Y(n123) );
  BUFX4 U148 ( .A(n_rst), .Y(n121) );
  BUFX4 U149 ( .A(n_rst), .Y(n122) );
  INVX2 U150 ( .A(n249), .Y(n124) );
  INVX2 U151 ( .A(n243), .Y(n125) );
  INVX2 U152 ( .A(n237), .Y(n126) );
  INVX2 U153 ( .A(n229), .Y(n127) );
  INVX2 U154 ( .A(n242), .Y(n129) );
  INVX2 U155 ( .A(n246), .Y(n130) );
  INVX2 U156 ( .A(n228), .Y(n131) );
  INVX2 U157 ( .A(n232), .Y(n132) );
  INVX2 U158 ( .A(pixel_count[0]), .Y(n133) );
  INVX2 U159 ( .A(n235), .Y(n134) );
  INVX2 U160 ( .A(n225), .Y(n135) );
  INVX2 U161 ( .A(n248), .Y(n136) );
  INVX2 U162 ( .A(n240), .Y(n137) );
  INVX2 U163 ( .A(pixel_count[1]), .Y(n138) );
  INVX2 U164 ( .A(\data_buffer[0][7] ), .Y(n139) );
  INVX2 U165 ( .A(\data_buffer[11][7] ), .Y(n140) );
  INVX2 U166 ( .A(\data_buffer[8][7] ), .Y(n143) );
  INVX2 U167 ( .A(\data_buffer[7][7] ), .Y(n144) );
  INVX2 U168 ( .A(\data_buffer[6][7] ), .Y(n145) );
  INVX2 U169 ( .A(\data_buffer[5][7] ), .Y(n146) );
  INVX2 U170 ( .A(\data_buffer[4][7] ), .Y(n147) );
  INVX2 U171 ( .A(\data_buffer[3][7] ), .Y(n148) );
  INVX2 U172 ( .A(\data_buffer[2][7] ), .Y(n149) );
  INVX2 U173 ( .A(\data_buffer[1][7] ), .Y(n150) );
  INVX2 U174 ( .A(\data_buffer[0][6] ), .Y(n151) );
  INVX2 U175 ( .A(\data_buffer[11][6] ), .Y(n152) );
  INVX2 U176 ( .A(\data_buffer[8][6] ), .Y(n155) );
  INVX2 U177 ( .A(\data_buffer[7][6] ), .Y(n156) );
  INVX2 U178 ( .A(\data_buffer[6][6] ), .Y(n157) );
  INVX2 U179 ( .A(\data_buffer[5][6] ), .Y(n158) );
  INVX2 U180 ( .A(\data_buffer[4][6] ), .Y(n159) );
  INVX2 U181 ( .A(\data_buffer[3][6] ), .Y(n160) );
  INVX2 U182 ( .A(\data_buffer[2][6] ), .Y(n161) );
  INVX2 U183 ( .A(\data_buffer[1][6] ), .Y(n162) );
  INVX2 U184 ( .A(\data_buffer[0][5] ), .Y(n163) );
  INVX2 U185 ( .A(\data_buffer[11][5] ), .Y(n164) );
  INVX2 U186 ( .A(\data_buffer[8][5] ), .Y(n167) );
  INVX2 U187 ( .A(\data_buffer[7][5] ), .Y(n168) );
  INVX2 U188 ( .A(\data_buffer[6][5] ), .Y(n169) );
  INVX2 U189 ( .A(\data_buffer[5][5] ), .Y(n170) );
  INVX2 U190 ( .A(\data_buffer[4][5] ), .Y(n171) );
  INVX2 U191 ( .A(\data_buffer[3][5] ), .Y(n172) );
  INVX2 U192 ( .A(\data_buffer[2][5] ), .Y(n173) );
  INVX2 U193 ( .A(\data_buffer[1][5] ), .Y(n174) );
  INVX2 U194 ( .A(\data_buffer[0][4] ), .Y(n175) );
  INVX2 U195 ( .A(\data_buffer[11][4] ), .Y(n176) );
  INVX2 U196 ( .A(\data_buffer[8][4] ), .Y(n179) );
  INVX2 U197 ( .A(\data_buffer[7][4] ), .Y(n180) );
  INVX2 U198 ( .A(\data_buffer[6][4] ), .Y(n181) );
  INVX2 U199 ( .A(\data_buffer[5][4] ), .Y(n182) );
  INVX2 U200 ( .A(\data_buffer[4][4] ), .Y(n183) );
  INVX2 U201 ( .A(\data_buffer[3][4] ), .Y(n184) );
  INVX2 U202 ( .A(\data_buffer[2][4] ), .Y(n185) );
  INVX2 U203 ( .A(\data_buffer[1][4] ), .Y(n186) );
  INVX2 U204 ( .A(\data_buffer[0][3] ), .Y(n187) );
  INVX2 U205 ( .A(\data_buffer[11][3] ), .Y(n188) );
  INVX2 U206 ( .A(\data_buffer[8][3] ), .Y(n191) );
  INVX2 U207 ( .A(\data_buffer[7][3] ), .Y(n192) );
  INVX2 U208 ( .A(\data_buffer[6][3] ), .Y(n193) );
  INVX2 U209 ( .A(\data_buffer[5][3] ), .Y(n194) );
  INVX2 U210 ( .A(\data_buffer[4][3] ), .Y(n195) );
  INVX2 U211 ( .A(\data_buffer[3][3] ), .Y(n196) );
  INVX2 U212 ( .A(\data_buffer[2][3] ), .Y(n197) );
  INVX2 U213 ( .A(\data_buffer[1][3] ), .Y(n198) );
  INVX2 U214 ( .A(\data_buffer[0][2] ), .Y(n199) );
  INVX2 U215 ( .A(\data_buffer[11][2] ), .Y(n200) );
  INVX2 U216 ( .A(\data_buffer[8][2] ), .Y(n203) );
  INVX2 U217 ( .A(\data_buffer[7][2] ), .Y(n204) );
  INVX2 U218 ( .A(\data_buffer[6][2] ), .Y(n205) );
  INVX2 U219 ( .A(\data_buffer[5][2] ), .Y(n206) );
  INVX2 U220 ( .A(\data_buffer[4][2] ), .Y(n207) );
  INVX2 U221 ( .A(\data_buffer[3][2] ), .Y(n208) );
  INVX2 U222 ( .A(\data_buffer[2][2] ), .Y(n209) );
  INVX2 U223 ( .A(\data_buffer[1][2] ), .Y(n210) );
  INVX2 U224 ( .A(\data_buffer[0][1] ), .Y(n211) );
  INVX2 U225 ( .A(\data_buffer[11][1] ), .Y(n212) );
  INVX2 U226 ( .A(\data_buffer[8][1] ), .Y(n215) );
  INVX2 U469 ( .A(\data_buffer[7][1] ), .Y(n466) );
  INVX2 U470 ( .A(\data_buffer[6][1] ), .Y(n467) );
  INVX2 U471 ( .A(\data_buffer[5][1] ), .Y(n468) );
  INVX2 U472 ( .A(\data_buffer[4][1] ), .Y(n469) );
  INVX2 U473 ( .A(\data_buffer[3][1] ), .Y(n470) );
  INVX2 U474 ( .A(\data_buffer[2][1] ), .Y(n471) );
  INVX2 U475 ( .A(\data_buffer[1][1] ), .Y(n472) );
  INVX2 U476 ( .A(\data_buffer[0][0] ), .Y(n473) );
  INVX2 U477 ( .A(\data_buffer[11][0] ), .Y(n474) );
  INVX2 U478 ( .A(\data_buffer[10][0] ), .Y(n475) );
  INVX2 U479 ( .A(\data_buffer[9][0] ), .Y(n476) );
  INVX2 U480 ( .A(\data_buffer[8][0] ), .Y(n477) );
  INVX2 U481 ( .A(\data_buffer[7][0] ), .Y(n478) );
  INVX2 U482 ( .A(\data_buffer[6][0] ), .Y(n479) );
  INVX2 U483 ( .A(\data_buffer[5][0] ), .Y(n480) );
  INVX2 U484 ( .A(\data_buffer[4][0] ), .Y(n481) );
  INVX2 U485 ( .A(\data_buffer[3][0] ), .Y(n482) );
  INVX2 U486 ( .A(\data_buffer[2][0] ), .Y(n483) );
  INVX2 U487 ( .A(\data_buffer[1][0] ), .Y(n484) );
endmodule


module mcu ( clk, n_rst, shift_enable_r, transfer_data_complete_r, 
        transfer_data_complete_w, enable_calc, buffer_clear );
  input clk, n_rst, shift_enable_r, transfer_data_complete_r,
         transfer_data_complete_w;
  output enable_calc, buffer_clear;
  wire   \next_state[2] , n9, n11, n13, n15, n16, n17, n18, n19, n20, n4, n5,
         n6, n7, n8, n10, n12;
  wire   [5:0] state;

  DFFSR \state_reg[0]  ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[1]  ( .D(n4), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  DFFSR \state_reg[2]  ( .D(\next_state[2] ), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(state[2]) );
  OAI21X1 U14 ( .A(n9), .B(n12), .C(n11), .Y(\next_state[2] ) );
  NOR2X1 U16 ( .A(state[2]), .B(n7), .Y(n13) );
  NOR2X1 U19 ( .A(n16), .B(n8), .Y(n15) );
  AOI22X1 U21 ( .A(n16), .B(state[0]), .C(n18), .D(n8), .Y(n17) );
  OAI21X1 U22 ( .A(n10), .B(n6), .C(n19), .Y(n18) );
  AOI21X1 U23 ( .A(shift_enable_r), .B(n10), .C(state[2]), .Y(n19) );
  NOR2X1 U24 ( .A(transfer_data_complete_r), .B(state[2]), .Y(n16) );
  NOR2X1 U25 ( .A(n12), .B(n20), .Y(enable_calc) );
  NAND2X1 U26 ( .A(n8), .B(n10), .Y(n20) );
  NOR2X1 U27 ( .A(n7), .B(n12), .Y(buffer_clear) );
  NOR2X1 U31 ( .A(n10), .B(n8), .Y(n9) );
  XOR2X1 U6 ( .A(state[1]), .B(n15), .Y(n4) );
  INVX2 U7 ( .A(n17), .Y(n5) );
  INVX2 U8 ( .A(transfer_data_complete_r), .Y(n6) );
  INVX2 U9 ( .A(n9), .Y(n7) );
  INVX2 U10 ( .A(state[0]), .Y(n8) );
  INVX2 U11 ( .A(state[1]), .Y(n10) );
  INVX2 U12 ( .A(state[2]), .Y(n12) );
  NAND2X1 U13 ( .A(transfer_data_complete_r), .B(n13), .Y(n11) );
endmodule


module gx_block_window1_DW01_sub_3 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window1_DW01_sub_2 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window1_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window1_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window1_DW01_add_2 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window1_DW01_add_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window1_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window1 ( clk, n_rst, .data_buffer({\data_buffer[11][7] , 
        \data_buffer[11][6] , \data_buffer[11][5] , \data_buffer[11][4] , 
        \data_buffer[11][3] , \data_buffer[11][2] , \data_buffer[11][1] , 
        \data_buffer[11][0] , \data_buffer[10][7] , \data_buffer[10][6] , 
        \data_buffer[10][5] , \data_buffer[10][4] , \data_buffer[10][3] , 
        \data_buffer[10][2] , \data_buffer[10][1] , \data_buffer[10][0] , 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] , \data_buffer[8][7] , 
        \data_buffer[8][6] , \data_buffer[8][5] , \data_buffer[8][4] , 
        \data_buffer[8][3] , \data_buffer[8][2] , \data_buffer[8][1] , 
        \data_buffer[8][0] , \data_buffer[7][7] , \data_buffer[7][6] , 
        \data_buffer[7][5] , \data_buffer[7][4] , \data_buffer[7][3] , 
        \data_buffer[7][2] , \data_buffer[7][1] , \data_buffer[7][0] , 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] , \data_buffer[5][7] , 
        \data_buffer[5][6] , \data_buffer[5][5] , \data_buffer[5][4] , 
        \data_buffer[5][3] , \data_buffer[5][2] , \data_buffer[5][1] , 
        \data_buffer[5][0] , \data_buffer[4][7] , \data_buffer[4][6] , 
        \data_buffer[4][5] , \data_buffer[4][4] , \data_buffer[4][3] , 
        \data_buffer[4][2] , \data_buffer[4][1] , \data_buffer[4][0] , 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] , \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] , \data_buffer[1][7] , \data_buffer[1][6] , 
        \data_buffer[1][5] , \data_buffer[1][4] , \data_buffer[1][3] , 
        \data_buffer[1][2] , \data_buffer[1][1] , \data_buffer[1][0] , 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), enable_calc, gx_out_1 );
  output [10:0] gx_out_1;
  input clk, n_rst, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] , enable_calc;
  wire   N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, n1, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, N55, N54, N53, N52, N51, N50, N49, N48,
         N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, n2, n14,
         n16, n18, n20, n22, n24, n26, n28, n30, n32, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76;

  DFFSR \gx_out_1_reg[10]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[10]) );
  DFFSR \gx_out_1_reg[9]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[9]) );
  DFFSR \gx_out_1_reg[8]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[8]) );
  DFFSR \gx_out_1_reg[7]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[7]) );
  DFFSR \gx_out_1_reg[6]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[6]) );
  DFFSR \gx_out_1_reg[5]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[5]) );
  DFFSR \gx_out_1_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[4]) );
  DFFSR \gx_out_1_reg[3]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[3]) );
  DFFSR \gx_out_1_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[2]) );
  DFFSR \gx_out_1_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[1]) );
  DFFSR \gx_out_1_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_1[0]) );
  AOI22X1 U3 ( .A(n14), .B(N56), .C(gx_out_1[0]), .D(n16), .Y(n1) );
  AOI22X1 U5 ( .A(N57), .B(n14), .C(gx_out_1[1]), .D(n16), .Y(n3) );
  AOI22X1 U7 ( .A(N58), .B(n2), .C(gx_out_1[2]), .D(n16), .Y(n4) );
  AOI22X1 U9 ( .A(N59), .B(n2), .C(gx_out_1[3]), .D(n16), .Y(n5) );
  AOI22X1 U11 ( .A(N60), .B(n14), .C(gx_out_1[4]), .D(n16), .Y(n6) );
  AOI22X1 U13 ( .A(N61), .B(n14), .C(gx_out_1[5]), .D(n16), .Y(n7) );
  AOI22X1 U15 ( .A(N62), .B(n14), .C(gx_out_1[6]), .D(n16), .Y(n8) );
  AOI22X1 U17 ( .A(N63), .B(n14), .C(gx_out_1[7]), .D(n16), .Y(n9) );
  AOI22X1 U19 ( .A(N64), .B(n14), .C(gx_out_1[8]), .D(n16), .Y(n10) );
  AOI22X1 U21 ( .A(N65), .B(n14), .C(gx_out_1[9]), .D(n16), .Y(n11) );
  AOI22X1 U23 ( .A(N66), .B(n2), .C(gx_out_1[10]), .D(n16), .Y(n12) );
  gx_block_window1_DW01_sub_3 sub_2_root_sub_0_root_sub_50 ( .A({1'b0, 1'b0, 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] }), .B({1'b0, 1'b0, 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), .CI(1'b0), .DIFF({n47, n48, 
        n49, n50, n51, n52, n53, n54, n55, n56}) );
  gx_block_window1_DW01_sub_2 sub_2_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] }), .B({1'b0, 1'b0, 
        \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] , 
        \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] , 
        \data_buffer[4][1] , \data_buffer[4][0] }), .CI(1'b0), .DIFF({n67, n68, 
        n69, n70, n71, n72, n73, n74, n75, n76}) );
  gx_block_window1_DW01_sub_1 sub_1_root_sub_0_root_sub_50 ( .A({1'b0, 1'b0, 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] }), .B({1'b0, 1'b0, 
        \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] , 
        \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] , 
        \data_buffer[4][1] , \data_buffer[4][0] }), .CI(1'b0), .DIFF({n37, n38, 
        n39, n40, n41, n42, n43, n44, n45, n46}) );
  gx_block_window1_DW01_sub_0 sub_1_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] , 
        \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] , 
        \data_buffer[10][1] , \data_buffer[10][0] }), .B({1'b0, 1'b0, 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] }), .CI(1'b0), .DIFF({n57, n58, 
        n59, n60, n61, n62, n63, n64, n65, n66}) );
  gx_block_window1_DW01_add_2 add_0_root_sub_0_root_sub_50 ( .A({n47, n48, n49, 
        n50, n51, n52, n53, n54, n55, n56}), .B({n37, n38, n39, n40, n41, n42, 
        n43, n44, n45, n46}), .CI(1'b0), .SUM({N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  gx_block_window1_DW01_add_1 add_0_root_sub_0_root_sub_51 ( .A({n67, n68, n69, 
        n70, n71, n72, n73, n74, n75, n76}), .B({n57, n58, n59, n60, n61, n62, 
        n63, n64, n65, n66}), .CI(1'b0), .SUM({N55, N54, N53, N52, N51, N50, 
        N49, N48, N47, N46}) );
  gx_block_window1_DW01_add_0 add_52 ( .A({N45, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}), .B({N55, N55, N54, N53, N52, N51, N50, N49, N48, 
        N47, N46}), .CI(1'b0), .SUM({N66, N65, N64, N63, N62, N61, N60, N59, 
        N58, N57, N56}) );
  INVX2 U2 ( .A(n2), .Y(n16) );
  BUFX2 U4 ( .A(enable_calc), .Y(n2) );
  BUFX2 U6 ( .A(enable_calc), .Y(n14) );
  INVX2 U8 ( .A(n12), .Y(n18) );
  INVX2 U10 ( .A(n11), .Y(n20) );
  INVX2 U12 ( .A(n10), .Y(n22) );
  INVX2 U14 ( .A(n9), .Y(n24) );
  INVX2 U16 ( .A(n8), .Y(n26) );
  INVX2 U18 ( .A(n7), .Y(n28) );
  INVX2 U20 ( .A(n6), .Y(n30) );
  INVX2 U22 ( .A(n5), .Y(n32) );
  INVX2 U24 ( .A(n4), .Y(n34) );
  INVX2 U36 ( .A(n3), .Y(n35) );
  INVX2 U37 ( .A(n1), .Y(n36) );
endmodule


module gx_block_window2_DW01_sub_2 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window2_DW01_add_3 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(SUM[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window2_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gx_block_window2_DW01_add_2 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(SUM[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window2_DW01_add_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window2_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [10:0] carry;

  FAX1 U2_8 ( .A(A[8]), .B(n2), .C(carry[8]), .YC(carry[9]), .YS(DIFF[8]) );
  FAX1 U2_7 ( .A(A[7]), .B(n3), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n4), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n5), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n6), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n7), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n8), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n9), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n10), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n10), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[9]), .Y(DIFF[9]) );
  INVX2 U4 ( .A(B[8]), .Y(n2) );
  INVX2 U5 ( .A(B[7]), .Y(n3) );
  INVX2 U6 ( .A(B[6]), .Y(n4) );
  INVX2 U7 ( .A(B[5]), .Y(n5) );
  INVX2 U8 ( .A(B[4]), .Y(n6) );
  INVX2 U9 ( .A(B[3]), .Y(n7) );
  INVX2 U10 ( .A(B[2]), .Y(n8) );
  INVX2 U11 ( .A(B[1]), .Y(n9) );
  INVX2 U12 ( .A(B[0]), .Y(n10) );
endmodule


module gx_block_window2_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gx_block_window2 ( clk, n_rst, .data_buffer({\data_buffer[11][7] , 
        \data_buffer[11][6] , \data_buffer[11][5] , \data_buffer[11][4] , 
        \data_buffer[11][3] , \data_buffer[11][2] , \data_buffer[11][1] , 
        \data_buffer[11][0] , \data_buffer[10][7] , \data_buffer[10][6] , 
        \data_buffer[10][5] , \data_buffer[10][4] , \data_buffer[10][3] , 
        \data_buffer[10][2] , \data_buffer[10][1] , \data_buffer[10][0] , 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] , \data_buffer[8][7] , 
        \data_buffer[8][6] , \data_buffer[8][5] , \data_buffer[8][4] , 
        \data_buffer[8][3] , \data_buffer[8][2] , \data_buffer[8][1] , 
        \data_buffer[8][0] , \data_buffer[7][7] , \data_buffer[7][6] , 
        \data_buffer[7][5] , \data_buffer[7][4] , \data_buffer[7][3] , 
        \data_buffer[7][2] , \data_buffer[7][1] , \data_buffer[7][0] , 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] , \data_buffer[5][7] , 
        \data_buffer[5][6] , \data_buffer[5][5] , \data_buffer[5][4] , 
        \data_buffer[5][3] , \data_buffer[5][2] , \data_buffer[5][1] , 
        \data_buffer[5][0] , \data_buffer[4][7] , \data_buffer[4][6] , 
        \data_buffer[4][5] , \data_buffer[4][4] , \data_buffer[4][3] , 
        \data_buffer[4][2] , \data_buffer[4][1] , \data_buffer[4][0] , 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] , \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] , \data_buffer[1][7] , \data_buffer[1][6] , 
        \data_buffer[1][5] , \data_buffer[1][4] , \data_buffer[1][3] , 
        \data_buffer[1][2] , \data_buffer[1][1] , \data_buffer[1][0] , 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), enable_calc, gx_out_2 );
  output [10:0] gx_out_2;
  input clk, n_rst, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] , enable_calc;
  wire   N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, n1, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, N55, N54, N53, N52, N51, N50, N49, N48,
         N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, n2, n14,
         n16, n18, n20, n22, n24, n26, n28, n30, n32, n34, n35, n36, n37, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;

  DFFSR \gx_out_2_reg[10]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[10]) );
  DFFSR \gx_out_2_reg[9]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[9]) );
  DFFSR \gx_out_2_reg[8]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[8]) );
  DFFSR \gx_out_2_reg[7]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[7]) );
  DFFSR \gx_out_2_reg[6]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[6]) );
  DFFSR \gx_out_2_reg[5]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[5]) );
  DFFSR \gx_out_2_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[4]) );
  DFFSR \gx_out_2_reg[3]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[3]) );
  DFFSR \gx_out_2_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[2]) );
  DFFSR \gx_out_2_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[1]) );
  DFFSR \gx_out_2_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gx_out_2[0]) );
  AOI22X1 U3 ( .A(n14), .B(N56), .C(gx_out_2[0]), .D(n16), .Y(n1) );
  AOI22X1 U5 ( .A(N57), .B(n14), .C(gx_out_2[1]), .D(n16), .Y(n3) );
  AOI22X1 U7 ( .A(N58), .B(n2), .C(gx_out_2[2]), .D(n16), .Y(n4) );
  AOI22X1 U9 ( .A(N59), .B(n2), .C(gx_out_2[3]), .D(n16), .Y(n5) );
  AOI22X1 U11 ( .A(N60), .B(n14), .C(gx_out_2[4]), .D(n16), .Y(n6) );
  AOI22X1 U13 ( .A(N61), .B(n14), .C(gx_out_2[5]), .D(n16), .Y(n7) );
  AOI22X1 U15 ( .A(N62), .B(n14), .C(gx_out_2[6]), .D(n16), .Y(n8) );
  AOI22X1 U17 ( .A(N63), .B(n14), .C(gx_out_2[7]), .D(n16), .Y(n9) );
  AOI22X1 U19 ( .A(N64), .B(n14), .C(gx_out_2[8]), .D(n16), .Y(n10) );
  AOI22X1 U21 ( .A(N65), .B(n14), .C(gx_out_2[9]), .D(n16), .Y(n11) );
  AOI22X1 U23 ( .A(N66), .B(n2), .C(gx_out_2[10]), .D(n16), .Y(n12) );
  gx_block_window2_DW01_sub_2 sub_2_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] }), .B({1'b0, 1'b0, 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] }), .CI(1'b0), .DIFF({n68, n69, 
        n70, n71, n72, n73, n74, n75, n76, n37}) );
  gx_block_window2_DW01_add_3 add_2_root_sub_0_root_sub_52 ( .A({1'b0, 1'b0, 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] }), .B({1'b0, 1'b0, 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] }), .CI(1'b0), .SUM({
        SYNOPSYS_UNCONNECTED__0, n49, n50, n51, n52, n53, n54, n55, n56, n57})
         );
  gx_block_window2_DW01_sub_1 sub_1_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] , 
        \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] , 
        \data_buffer[7][1] , \data_buffer[7][0] }), .B({1'b0, 1'b0, 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] }), .CI(1'b0), .DIFF({n58, n59, 
        n60, n61, n62, n63, n64, n65, n66, n67}) );
  gx_block_window2_DW01_add_2 add_1_root_sub_0_root_sub_52 ( .A({1'b0, 1'b0, 
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] }), .B({1'b0, 1'b0, 
        \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] , 
        \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] , 
        \data_buffer[7][1] , \data_buffer[7][0] }), .CI(1'b0), .SUM({
        SYNOPSYS_UNCONNECTED__1, n39, n40, n41, n42, n43, n44, n45, n46, n47})
         );
  gx_block_window2_DW01_add_1 add_0_root_sub_0_root_sub_51 ( .A({n68, n69, n70, 
        n71, n72, n73, n74, n75, n76, n37}), .B({n58, n59, n60, n61, n62, n63, 
        n64, n65, n66, n67}), .CI(1'b0), .SUM({N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  gx_block_window2_DW01_sub_0 sub_0_root_sub_0_root_sub_52 ( .A({1'b0, n39, 
        n40, n41, n42, n43, n44, n45, n46, n47}), .B({1'b0, n49, n50, n51, n52, 
        n53, n54, n55, n56, n57}), .CI(1'b0), .DIFF({N55, N54, N53, N52, N51, 
        N50, N49, N48, N47, N46}) );
  gx_block_window2_DW01_add_0 add_53 ( .A({N45, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}), .B({N55, N55, N54, N53, N52, N51, N50, N49, N48, 
        N47, N46}), .CI(1'b0), .SUM({N66, N65, N64, N63, N62, N61, N60, N59, 
        N58, N57, N56}) );
  INVX2 U2 ( .A(n2), .Y(n16) );
  BUFX2 U4 ( .A(enable_calc), .Y(n2) );
  BUFX2 U6 ( .A(enable_calc), .Y(n14) );
  INVX2 U8 ( .A(n12), .Y(n18) );
  INVX2 U10 ( .A(n11), .Y(n20) );
  INVX2 U12 ( .A(n10), .Y(n22) );
  INVX2 U14 ( .A(n9), .Y(n24) );
  INVX2 U16 ( .A(n8), .Y(n26) );
  INVX2 U18 ( .A(n7), .Y(n28) );
  INVX2 U20 ( .A(n6), .Y(n30) );
  INVX2 U22 ( .A(n5), .Y(n32) );
  INVX2 U24 ( .A(n4), .Y(n34) );
  INVX2 U36 ( .A(n3), .Y(n35) );
  INVX2 U37 ( .A(n1), .Y(n36) );
endmodule


module gy_block_window1_DW01_sub_2 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gy_block_window1_DW01_add_3 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(SUM[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window1_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gy_block_window1_DW01_add_2 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(SUM[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window1_DW01_add_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window1_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [10:0] carry;

  FAX1 U2_8 ( .A(A[8]), .B(n2), .C(carry[8]), .YC(carry[9]), .YS(DIFF[8]) );
  FAX1 U2_7 ( .A(A[7]), .B(n3), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n4), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n5), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n6), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n7), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n8), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n9), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n10), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n10), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[9]), .Y(DIFF[9]) );
  INVX2 U4 ( .A(B[8]), .Y(n2) );
  INVX2 U5 ( .A(B[7]), .Y(n3) );
  INVX2 U6 ( .A(B[6]), .Y(n4) );
  INVX2 U7 ( .A(B[5]), .Y(n5) );
  INVX2 U8 ( .A(B[4]), .Y(n6) );
  INVX2 U9 ( .A(B[3]), .Y(n7) );
  INVX2 U10 ( .A(B[2]), .Y(n8) );
  INVX2 U11 ( .A(B[1]), .Y(n9) );
  INVX2 U12 ( .A(B[0]), .Y(n10) );
endmodule


module gy_block_window1_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window1 ( clk, n_rst, .data_buffer({\data_buffer[11][7] , 
        \data_buffer[11][6] , \data_buffer[11][5] , \data_buffer[11][4] , 
        \data_buffer[11][3] , \data_buffer[11][2] , \data_buffer[11][1] , 
        \data_buffer[11][0] , \data_buffer[10][7] , \data_buffer[10][6] , 
        \data_buffer[10][5] , \data_buffer[10][4] , \data_buffer[10][3] , 
        \data_buffer[10][2] , \data_buffer[10][1] , \data_buffer[10][0] , 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] , \data_buffer[8][7] , 
        \data_buffer[8][6] , \data_buffer[8][5] , \data_buffer[8][4] , 
        \data_buffer[8][3] , \data_buffer[8][2] , \data_buffer[8][1] , 
        \data_buffer[8][0] , \data_buffer[7][7] , \data_buffer[7][6] , 
        \data_buffer[7][5] , \data_buffer[7][4] , \data_buffer[7][3] , 
        \data_buffer[7][2] , \data_buffer[7][1] , \data_buffer[7][0] , 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] , \data_buffer[5][7] , 
        \data_buffer[5][6] , \data_buffer[5][5] , \data_buffer[5][4] , 
        \data_buffer[5][3] , \data_buffer[5][2] , \data_buffer[5][1] , 
        \data_buffer[5][0] , \data_buffer[4][7] , \data_buffer[4][6] , 
        \data_buffer[4][5] , \data_buffer[4][4] , \data_buffer[4][3] , 
        \data_buffer[4][2] , \data_buffer[4][1] , \data_buffer[4][0] , 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] , \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] , \data_buffer[1][7] , \data_buffer[1][6] , 
        \data_buffer[1][5] , \data_buffer[1][4] , \data_buffer[1][3] , 
        \data_buffer[1][2] , \data_buffer[1][1] , \data_buffer[1][0] , 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), enable_calc, gy_out_1 );
  output [10:0] gy_out_1;
  input clk, n_rst, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] , enable_calc;
  wire   N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, n1, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, N55, N54, N53, N52, N51, N50, N49, N48,
         N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, n2, n14,
         n16, n18, n20, n22, n24, n26, n28, n30, n32, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n58, n59, n60, n61, n62, n63, n64, n65, n66, n68,
         n69, n70, n71, n72, n73, n74, n75, n76;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;

  DFFSR \gy_out_1_reg[10]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[10]) );
  DFFSR \gy_out_1_reg[9]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[9]) );
  DFFSR \gy_out_1_reg[8]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[8]) );
  DFFSR \gy_out_1_reg[7]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[7]) );
  DFFSR \gy_out_1_reg[6]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[6]) );
  DFFSR \gy_out_1_reg[5]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[5]) );
  DFFSR \gy_out_1_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[4]) );
  DFFSR \gy_out_1_reg[3]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[3]) );
  DFFSR \gy_out_1_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[2]) );
  DFFSR \gy_out_1_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[1]) );
  DFFSR \gy_out_1_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_1[0]) );
  AOI22X1 U3 ( .A(n14), .B(N56), .C(gy_out_1[0]), .D(n16), .Y(n1) );
  AOI22X1 U5 ( .A(N57), .B(n14), .C(gy_out_1[1]), .D(n16), .Y(n3) );
  AOI22X1 U7 ( .A(N58), .B(n2), .C(gy_out_1[2]), .D(n16), .Y(n4) );
  AOI22X1 U9 ( .A(N59), .B(n2), .C(gy_out_1[3]), .D(n16), .Y(n5) );
  AOI22X1 U11 ( .A(N60), .B(n14), .C(gy_out_1[4]), .D(n16), .Y(n6) );
  AOI22X1 U13 ( .A(N61), .B(n14), .C(gy_out_1[5]), .D(n16), .Y(n7) );
  AOI22X1 U15 ( .A(N62), .B(n14), .C(gy_out_1[6]), .D(n16), .Y(n8) );
  AOI22X1 U17 ( .A(N63), .B(n14), .C(gy_out_1[7]), .D(n16), .Y(n9) );
  AOI22X1 U19 ( .A(N64), .B(n14), .C(gy_out_1[8]), .D(n16), .Y(n10) );
  AOI22X1 U21 ( .A(N65), .B(n14), .C(gy_out_1[9]), .D(n16), .Y(n11) );
  AOI22X1 U23 ( .A(N66), .B(n2), .C(gy_out_1[10]), .D(n16), .Y(n12) );
  gy_block_window1_DW01_sub_2 sub_2_root_sub_0_root_sub_50 ( .A({1'b0, 1'b0, 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] }), .B({1'b0, 1'b0, 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), .CI(1'b0), .DIFF({n47, n48, 
        n49, n50, n51, n52, n53, n54, n55, n56}) );
  gy_block_window1_DW01_add_3 add_2_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] }), .B({1'b0, 1'b0, 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] }), .CI(1'b0), .SUM({
        SYNOPSYS_UNCONNECTED__0, n68, n69, n70, n71, n72, n73, n74, n75, n76})
         );
  gy_block_window1_DW01_sub_1 sub_1_root_sub_0_root_sub_50 ( .A({1'b0, 1'b0, 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] }), .B({1'b0, 1'b0, 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] }), .CI(1'b0), .DIFF({n37, n38, 
        n39, n40, n41, n42, n43, n44, n45, n46}) );
  gy_block_window1_DW01_add_2 add_1_root_sub_0_root_sub_51 ( .A({1'b0, 1'b0, 
        \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] , 
        \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] , 
        \data_buffer[10][1] , \data_buffer[10][0] }), .B({1'b0, 1'b0, 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] }), .CI(1'b0), .SUM({
        SYNOPSYS_UNCONNECTED__1, n58, n59, n60, n61, n62, n63, n64, n65, n66})
         );
  gy_block_window1_DW01_add_1 add_0_root_sub_0_root_sub_50 ( .A({n47, n48, n49, 
        n50, n51, n52, n53, n54, n55, n56}), .B({n37, n38, n39, n40, n41, n42, 
        n43, n44, n45, n46}), .CI(1'b0), .SUM({N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  gy_block_window1_DW01_sub_0 sub_0_root_sub_0_root_sub_51 ( .A({1'b0, n58, 
        n59, n60, n61, n62, n63, n64, n65, n66}), .B({1'b0, n68, n69, n70, n71, 
        n72, n73, n74, n75, n76}), .CI(1'b0), .DIFF({N55, N54, N53, N52, N51, 
        N50, N49, N48, N47, N46}) );
  gy_block_window1_DW01_add_0 add_52 ( .A({N45, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}), .B({N55, N55, N54, N53, N52, N51, N50, N49, N48, 
        N47, N46}), .CI(1'b0), .SUM({N66, N65, N64, N63, N62, N61, N60, N59, 
        N58, N57, N56}) );
  INVX2 U2 ( .A(n2), .Y(n16) );
  BUFX2 U4 ( .A(enable_calc), .Y(n2) );
  BUFX2 U6 ( .A(enable_calc), .Y(n14) );
  INVX2 U8 ( .A(n12), .Y(n18) );
  INVX2 U10 ( .A(n11), .Y(n20) );
  INVX2 U12 ( .A(n10), .Y(n22) );
  INVX2 U14 ( .A(n9), .Y(n24) );
  INVX2 U16 ( .A(n8), .Y(n26) );
  INVX2 U18 ( .A(n7), .Y(n28) );
  INVX2 U20 ( .A(n6), .Y(n30) );
  INVX2 U22 ( .A(n5), .Y(n32) );
  INVX2 U24 ( .A(n4), .Y(n34) );
  INVX2 U36 ( .A(n3), .Y(n35) );
  INVX2 U37 ( .A(n1), .Y(n36) );
endmodule


module gy_block_window2_DW01_sub_2 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gy_block_window2_DW01_sub_1 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gy_block_window2_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] DIFF;
  input CI;
  output CO;
  wire   \DIFF[8] , n2, n3, n4, n5, n6, n7, n8, n9;
  wire   [10:0] carry;
  assign DIFF[9] = \DIFF[8] ;
  assign DIFF[8] = \DIFF[8] ;

  FAX1 U2_7 ( .A(A[7]), .B(n2), .C(carry[7]), .YC(carry[8]), .YS(DIFF[7]) );
  FAX1 U2_6 ( .A(A[6]), .B(n3), .C(carry[6]), .YC(carry[7]), .YS(DIFF[6]) );
  FAX1 U2_5 ( .A(A[5]), .B(n4), .C(carry[5]), .YC(carry[6]), .YS(DIFF[5]) );
  FAX1 U2_4 ( .A(A[4]), .B(n5), .C(carry[4]), .YC(carry[5]), .YS(DIFF[4]) );
  FAX1 U2_3 ( .A(A[3]), .B(n6), .C(carry[3]), .YC(carry[4]), .YS(DIFF[3]) );
  FAX1 U2_2 ( .A(A[2]), .B(n7), .C(carry[2]), .YC(carry[3]), .YS(DIFF[2]) );
  FAX1 U2_1 ( .A(A[1]), .B(n8), .C(carry[1]), .YC(carry[2]), .YS(DIFF[1]) );
  OR2X1 U1 ( .A(A[0]), .B(n9), .Y(carry[1]) );
  XNOR2X1 U2 ( .A(n9), .B(A[0]), .Y(DIFF[0]) );
  INVX2 U3 ( .A(carry[8]), .Y(\DIFF[8] ) );
  INVX2 U4 ( .A(B[7]), .Y(n2) );
  INVX2 U5 ( .A(B[6]), .Y(n3) );
  INVX2 U6 ( .A(B[5]), .Y(n4) );
  INVX2 U7 ( .A(B[4]), .Y(n5) );
  INVX2 U8 ( .A(B[3]), .Y(n6) );
  INVX2 U9 ( .A(B[2]), .Y(n7) );
  INVX2 U10 ( .A(B[1]), .Y(n8) );
  INVX2 U11 ( .A(B[0]), .Y(n9) );
endmodule


module gy_block_window2_DW01_add_2 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window2_DW01_add_1 ( A, B, CI, SUM, CO );
  input [9:0] A;
  input [9:0] B;
  output [9:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [9:1] carry;

  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window2_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module gy_block_window2 ( clk, n_rst, .data_buffer({\data_buffer[11][7] , 
        \data_buffer[11][6] , \data_buffer[11][5] , \data_buffer[11][4] , 
        \data_buffer[11][3] , \data_buffer[11][2] , \data_buffer[11][1] , 
        \data_buffer[11][0] , \data_buffer[10][7] , \data_buffer[10][6] , 
        \data_buffer[10][5] , \data_buffer[10][4] , \data_buffer[10][3] , 
        \data_buffer[10][2] , \data_buffer[10][1] , \data_buffer[10][0] , 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] , \data_buffer[8][7] , 
        \data_buffer[8][6] , \data_buffer[8][5] , \data_buffer[8][4] , 
        \data_buffer[8][3] , \data_buffer[8][2] , \data_buffer[8][1] , 
        \data_buffer[8][0] , \data_buffer[7][7] , \data_buffer[7][6] , 
        \data_buffer[7][5] , \data_buffer[7][4] , \data_buffer[7][3] , 
        \data_buffer[7][2] , \data_buffer[7][1] , \data_buffer[7][0] , 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] , \data_buffer[5][7] , 
        \data_buffer[5][6] , \data_buffer[5][5] , \data_buffer[5][4] , 
        \data_buffer[5][3] , \data_buffer[5][2] , \data_buffer[5][1] , 
        \data_buffer[5][0] , \data_buffer[4][7] , \data_buffer[4][6] , 
        \data_buffer[4][5] , \data_buffer[4][4] , \data_buffer[4][3] , 
        \data_buffer[4][2] , \data_buffer[4][1] , \data_buffer[4][0] , 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] , \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] , \data_buffer[1][7] , \data_buffer[1][6] , 
        \data_buffer[1][5] , \data_buffer[1][4] , \data_buffer[1][3] , 
        \data_buffer[1][2] , \data_buffer[1][1] , \data_buffer[1][0] , 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), enable_calc, gy_out_2 );
  output [10:0] gy_out_2;
  input clk, n_rst, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] , enable_calc;
  wire   N56, N57, N58, N59, N60, N61, N62, N63, N64, N65, N66, n1, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, N55, N54, N53, N52, N51, N50, N49, N48,
         N47, N46, N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, n2, n14,
         n16, n18, n20, n22, n24, n26, n28, n30, n32, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66;

  DFFSR \gy_out_2_reg[10]  ( .D(n18), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[10]) );
  DFFSR \gy_out_2_reg[9]  ( .D(n20), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[9]) );
  DFFSR \gy_out_2_reg[8]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[8]) );
  DFFSR \gy_out_2_reg[7]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[7]) );
  DFFSR \gy_out_2_reg[6]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[6]) );
  DFFSR \gy_out_2_reg[5]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[5]) );
  DFFSR \gy_out_2_reg[4]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[4]) );
  DFFSR \gy_out_2_reg[3]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[3]) );
  DFFSR \gy_out_2_reg[2]  ( .D(n34), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[2]) );
  DFFSR \gy_out_2_reg[1]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[1]) );
  DFFSR \gy_out_2_reg[0]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        gy_out_2[0]) );
  AOI22X1 U3 ( .A(n14), .B(N56), .C(gy_out_2[0]), .D(n16), .Y(n1) );
  AOI22X1 U5 ( .A(N57), .B(n14), .C(gy_out_2[1]), .D(n16), .Y(n3) );
  AOI22X1 U7 ( .A(N58), .B(n2), .C(gy_out_2[2]), .D(n16), .Y(n4) );
  AOI22X1 U9 ( .A(N59), .B(n2), .C(gy_out_2[3]), .D(n16), .Y(n5) );
  AOI22X1 U11 ( .A(N60), .B(n14), .C(gy_out_2[4]), .D(n16), .Y(n6) );
  AOI22X1 U13 ( .A(N61), .B(n14), .C(gy_out_2[5]), .D(n16), .Y(n7) );
  AOI22X1 U15 ( .A(N62), .B(n14), .C(gy_out_2[6]), .D(n16), .Y(n8) );
  AOI22X1 U17 ( .A(N63), .B(n14), .C(gy_out_2[7]), .D(n16), .Y(n9) );
  AOI22X1 U19 ( .A(N64), .B(n14), .C(gy_out_2[8]), .D(n16), .Y(n10) );
  AOI22X1 U21 ( .A(N65), .B(n14), .C(gy_out_2[9]), .D(n16), .Y(n11) );
  AOI22X1 U23 ( .A(N66), .B(n2), .C(gy_out_2[10]), .D(n16), .Y(n12) );
  gy_block_window2_DW01_sub_2 r939 ( .A({1'b0, 1'b0, \data_buffer[10][7] , 
        \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] , 
        \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] , 
        \data_buffer[10][0] }), .B({1'b0, 1'b0, \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] }), .CI(1'b0), .DIFF({n37, n48, n50, n60, n62, n63, 
        n64, n65, n66, n38}) );
  gy_block_window2_DW01_sub_1 sub_2_root_sub_0_root_sub_48 ( .A({1'b0, 1'b0, 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] }), .B({1'b0, 1'b0, 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] }), .CI(1'b0), .DIFF({n39, n40, 
        n41, n42, n43, n44, n45, n46, n47, n49}) );
  gy_block_window2_DW01_sub_0 sub_2_root_sub_0_root_sub_49 ( .A({1'b0, 1'b0, 
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] }), .B({1'b0, 1'b0, 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] }), .CI(1'b0), .DIFF({n51, n52, 
        n53, n54, n55, n56, n57, n58, n59, n61}) );
  gy_block_window2_DW01_add_2 add_0_root_sub_0_root_sub_48 ( .A({n39, n40, n41, 
        n42, n43, n44, n45, n46, n47, n49}), .B({n37, n48, n50, n60, n62, n63, 
        n64, n65, n66, n38}), .CI(1'b0), .SUM({N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}) );
  gy_block_window2_DW01_add_1 add_0_root_sub_0_root_sub_49 ( .A({n51, n52, n53, 
        n54, n55, n56, n57, n58, n59, n61}), .B({n37, n48, n50, n60, n62, n63, 
        n64, n65, n66, n38}), .CI(1'b0), .SUM({N55, N54, N53, N52, N51, N50, 
        N49, N48, N47, N46}) );
  gy_block_window2_DW01_add_0 add_50 ( .A({N45, N45, N44, N43, N42, N41, N40, 
        N39, N38, N37, N36}), .B({N55, N55, N54, N53, N52, N51, N50, N49, N48, 
        N47, N46}), .CI(1'b0), .SUM({N66, N65, N64, N63, N62, N61, N60, N59, 
        N58, N57, N56}) );
  INVX2 U2 ( .A(n2), .Y(n16) );
  BUFX2 U4 ( .A(enable_calc), .Y(n2) );
  BUFX2 U6 ( .A(enable_calc), .Y(n14) );
  INVX2 U8 ( .A(n12), .Y(n18) );
  INVX2 U10 ( .A(n11), .Y(n20) );
  INVX2 U12 ( .A(n10), .Y(n22) );
  INVX2 U14 ( .A(n9), .Y(n24) );
  INVX2 U16 ( .A(n8), .Y(n26) );
  INVX2 U18 ( .A(n7), .Y(n28) );
  INVX2 U20 ( .A(n6), .Y(n30) );
  INVX2 U22 ( .A(n5), .Y(n32) );
  INVX2 U24 ( .A(n4), .Y(n34) );
  INVX2 U36 ( .A(n3), .Y(n35) );
  INVX2 U37 ( .A(n1), .Y(n36) );
endmodule


module result_1_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module result_1 ( gx_out_1, gy_out_1, final_out_1 );
  input [10:0] gx_out_1;
  input [10:0] gy_out_1;
  output [7:0] final_out_1;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, \abs_gx_out_1[10] ,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26,
         \abs_gy_out_1[10] , N27, \sum[9] , \sum[8] , \sum[10] , n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, \sub_add_23_b0/carry[10] , \sub_add_23_b0/carry[9] ,
         \sub_add_23_b0/carry[8] , \sub_add_23_b0/carry[7] ,
         \sub_add_23_b0/carry[6] , \sub_add_23_b0/carry[5] ,
         \sub_add_23_b0/carry[4] , \sub_add_23_b0/carry[3] ,
         \sub_add_23_b0/carry[2] , \sub_add_22_b0/carry[10] ,
         \sub_add_22_b0/carry[9] , \sub_add_22_b0/carry[8] ,
         \sub_add_22_b0/carry[7] , \sub_add_22_b0/carry[6] ,
         \sub_add_22_b0/carry[5] , \sub_add_22_b0/carry[4] ,
         \sub_add_22_b0/carry[3] , \sub_add_22_b0/carry[2] , n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n60, n61, n62, n63, n64, n65, n66;
  wire   [10:0] sum;
  assign N4 = gx_out_1[0];
  assign N16 = gy_out_1[0];

  AND2X2 U15 ( .A(N26), .B(n2), .Y(\abs_gy_out_1[10] ) );
  AND2X2 U16 ( .A(N14), .B(n4), .Y(\abs_gx_out_1[10] ) );
  OR2X1 U39 ( .A(sum[7]), .B(N27), .Y(final_out_1[7]) );
  OR2X1 U40 ( .A(N27), .B(sum[6]), .Y(final_out_1[6]) );
  OR2X1 U41 ( .A(N27), .B(sum[5]), .Y(final_out_1[5]) );
  OR2X1 U42 ( .A(N27), .B(sum[4]), .Y(final_out_1[4]) );
  OR2X1 U43 ( .A(N27), .B(sum[3]), .Y(final_out_1[3]) );
  OR2X1 U44 ( .A(N27), .B(sum[2]), .Y(final_out_1[2]) );
  OR2X1 U45 ( .A(N27), .B(sum[1]), .Y(final_out_1[1]) );
  OR2X1 U46 ( .A(N27), .B(sum[0]), .Y(final_out_1[0]) );
  AOI22X1 U47 ( .A(n2), .B(N25), .C(gy_out_1[9]), .D(n1), .Y(n40) );
  AOI22X1 U48 ( .A(N24), .B(gy_out_1[10]), .C(gy_out_1[8]), .D(n1), .Y(n41) );
  AOI22X1 U49 ( .A(N23), .B(gy_out_1[10]), .C(gy_out_1[7]), .D(n1), .Y(n42) );
  AOI22X1 U50 ( .A(N22), .B(n2), .C(gy_out_1[6]), .D(n1), .Y(n43) );
  AOI22X1 U51 ( .A(N21), .B(n2), .C(gy_out_1[5]), .D(n1), .Y(n44) );
  AOI22X1 U52 ( .A(N20), .B(n2), .C(gy_out_1[4]), .D(n1), .Y(n45) );
  AOI22X1 U53 ( .A(N19), .B(n2), .C(gy_out_1[3]), .D(n1), .Y(n46) );
  AOI22X1 U54 ( .A(N18), .B(n2), .C(gy_out_1[2]), .D(n1), .Y(n47) );
  AOI22X1 U55 ( .A(N17), .B(n2), .C(gy_out_1[1]), .D(n1), .Y(n48) );
  AOI22X1 U56 ( .A(N16), .B(n2), .C(N16), .D(n1), .Y(n49) );
  AOI22X1 U57 ( .A(n4), .B(N13), .C(gx_out_1[9]), .D(n3), .Y(n50) );
  AOI22X1 U58 ( .A(N12), .B(gx_out_1[10]), .C(gx_out_1[8]), .D(n3), .Y(n51) );
  AOI22X1 U59 ( .A(N11), .B(gx_out_1[10]), .C(gx_out_1[7]), .D(n3), .Y(n52) );
  AOI22X1 U60 ( .A(N10), .B(n4), .C(gx_out_1[6]), .D(n3), .Y(n53) );
  AOI22X1 U61 ( .A(N9), .B(n4), .C(gx_out_1[5]), .D(n3), .Y(n54) );
  AOI22X1 U62 ( .A(N8), .B(n4), .C(gx_out_1[4]), .D(n3), .Y(n55) );
  AOI22X1 U63 ( .A(N7), .B(n4), .C(gx_out_1[3]), .D(n3), .Y(n56) );
  AOI22X1 U64 ( .A(N6), .B(n4), .C(gx_out_1[2]), .D(n3), .Y(n57) );
  AOI22X1 U65 ( .A(N5), .B(n4), .C(gx_out_1[1]), .D(n3), .Y(n58) );
  AOI22X1 U66 ( .A(N4), .B(n4), .C(N4), .D(n3), .Y(n59) );
  result_1_DW01_add_0 add_24 ( .A({\abs_gx_out_1[10] , n27, n28, n29, n30, n31, 
        n32, n33, n34, n35, n66}), .B({\abs_gy_out_1[10] , n36, n37, n38, n39, 
        n60, n61, n62, n63, n64, n65}), .CI(1'b0), .SUM({\sum[10] , \sum[9] , 
        \sum[8] , sum[7:0]}) );
  INVX2 U3 ( .A(n3), .Y(n4) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(gy_out_1[10]), .Y(n1) );
  INVX2 U6 ( .A(gx_out_1[10]), .Y(n3) );
  XOR2X1 U7 ( .A(n1), .B(\sub_add_23_b0/carry[10] ), .Y(N26) );
  AND2X1 U8 ( .A(n25), .B(\sub_add_23_b0/carry[9] ), .Y(
        \sub_add_23_b0/carry[10] ) );
  XOR2X1 U9 ( .A(\sub_add_23_b0/carry[9] ), .B(n25), .Y(N25) );
  AND2X1 U10 ( .A(n24), .B(\sub_add_23_b0/carry[8] ), .Y(
        \sub_add_23_b0/carry[9] ) );
  XOR2X1 U11 ( .A(\sub_add_23_b0/carry[8] ), .B(n24), .Y(N24) );
  XOR2X1 U13 ( .A(n3), .B(\sub_add_22_b0/carry[10] ), .Y(N14) );
  AND2X1 U14 ( .A(n14), .B(\sub_add_22_b0/carry[9] ), .Y(
        \sub_add_22_b0/carry[10] ) );
  XOR2X1 U17 ( .A(\sub_add_22_b0/carry[9] ), .B(n14), .Y(N13) );
  AND2X1 U18 ( .A(n13), .B(\sub_add_22_b0/carry[8] ), .Y(
        \sub_add_22_b0/carry[9] ) );
  XOR2X1 U19 ( .A(\sub_add_22_b0/carry[8] ), .B(n13), .Y(N12) );
  AND2X1 U20 ( .A(n23), .B(\sub_add_23_b0/carry[7] ), .Y(
        \sub_add_23_b0/carry[8] ) );
  XOR2X1 U21 ( .A(\sub_add_23_b0/carry[7] ), .B(n23), .Y(N23) );
  AND2X1 U22 ( .A(n22), .B(\sub_add_23_b0/carry[6] ), .Y(
        \sub_add_23_b0/carry[7] ) );
  XOR2X1 U23 ( .A(\sub_add_23_b0/carry[6] ), .B(n22), .Y(N22) );
  AND2X1 U24 ( .A(n21), .B(\sub_add_23_b0/carry[5] ), .Y(
        \sub_add_23_b0/carry[6] ) );
  XOR2X1 U25 ( .A(\sub_add_23_b0/carry[5] ), .B(n21), .Y(N21) );
  AND2X1 U26 ( .A(n20), .B(\sub_add_23_b0/carry[4] ), .Y(
        \sub_add_23_b0/carry[5] ) );
  XOR2X1 U27 ( .A(\sub_add_23_b0/carry[4] ), .B(n20), .Y(N20) );
  AND2X1 U28 ( .A(n19), .B(\sub_add_23_b0/carry[3] ), .Y(
        \sub_add_23_b0/carry[4] ) );
  XOR2X1 U29 ( .A(\sub_add_23_b0/carry[3] ), .B(n19), .Y(N19) );
  AND2X1 U30 ( .A(n18), .B(\sub_add_23_b0/carry[2] ), .Y(
        \sub_add_23_b0/carry[3] ) );
  XOR2X1 U31 ( .A(\sub_add_23_b0/carry[2] ), .B(n18), .Y(N18) );
  AND2X1 U32 ( .A(n17), .B(n16), .Y(\sub_add_23_b0/carry[2] ) );
  XOR2X1 U33 ( .A(n16), .B(n17), .Y(N17) );
  AND2X1 U34 ( .A(n12), .B(\sub_add_22_b0/carry[7] ), .Y(
        \sub_add_22_b0/carry[8] ) );
  XOR2X1 U35 ( .A(\sub_add_22_b0/carry[7] ), .B(n12), .Y(N11) );
  AND2X1 U36 ( .A(n11), .B(\sub_add_22_b0/carry[6] ), .Y(
        \sub_add_22_b0/carry[7] ) );
  XOR2X1 U37 ( .A(\sub_add_22_b0/carry[6] ), .B(n11), .Y(N10) );
  AND2X1 U38 ( .A(n10), .B(\sub_add_22_b0/carry[5] ), .Y(
        \sub_add_22_b0/carry[6] ) );
  XOR2X1 U67 ( .A(\sub_add_22_b0/carry[5] ), .B(n10), .Y(N9) );
  AND2X1 U68 ( .A(n9), .B(\sub_add_22_b0/carry[4] ), .Y(
        \sub_add_22_b0/carry[5] ) );
  XOR2X1 U69 ( .A(\sub_add_22_b0/carry[4] ), .B(n9), .Y(N8) );
  AND2X1 U70 ( .A(n8), .B(\sub_add_22_b0/carry[3] ), .Y(
        \sub_add_22_b0/carry[4] ) );
  XOR2X1 U71 ( .A(\sub_add_22_b0/carry[3] ), .B(n8), .Y(N7) );
  AND2X1 U72 ( .A(n7), .B(\sub_add_22_b0/carry[2] ), .Y(
        \sub_add_22_b0/carry[3] ) );
  XOR2X1 U73 ( .A(\sub_add_22_b0/carry[2] ), .B(n7), .Y(N6) );
  AND2X1 U74 ( .A(n6), .B(n5), .Y(\sub_add_22_b0/carry[2] ) );
  XOR2X1 U75 ( .A(n5), .B(n6), .Y(N5) );
  INVX2 U76 ( .A(N4), .Y(n5) );
  INVX2 U77 ( .A(gx_out_1[1]), .Y(n6) );
  INVX2 U78 ( .A(gx_out_1[2]), .Y(n7) );
  INVX2 U79 ( .A(gx_out_1[3]), .Y(n8) );
  INVX2 U80 ( .A(gx_out_1[4]), .Y(n9) );
  INVX2 U81 ( .A(gx_out_1[5]), .Y(n10) );
  INVX2 U82 ( .A(gx_out_1[6]), .Y(n11) );
  INVX2 U83 ( .A(gx_out_1[7]), .Y(n12) );
  INVX2 U84 ( .A(gx_out_1[8]), .Y(n13) );
  INVX2 U85 ( .A(gx_out_1[9]), .Y(n14) );
  INVX2 U86 ( .A(N16), .Y(n16) );
  INVX2 U87 ( .A(gy_out_1[1]), .Y(n17) );
  INVX2 U88 ( .A(gy_out_1[2]), .Y(n18) );
  INVX2 U89 ( .A(gy_out_1[3]), .Y(n19) );
  INVX2 U90 ( .A(gy_out_1[4]), .Y(n20) );
  INVX2 U91 ( .A(gy_out_1[5]), .Y(n21) );
  INVX2 U92 ( .A(gy_out_1[6]), .Y(n22) );
  INVX2 U93 ( .A(gy_out_1[7]), .Y(n23) );
  INVX2 U94 ( .A(gy_out_1[8]), .Y(n24) );
  INVX2 U95 ( .A(gy_out_1[9]), .Y(n25) );
  OR2X1 U96 ( .A(\sum[9] ), .B(\sum[8] ), .Y(n26) );
  OR2X1 U97 ( .A(\sum[10] ), .B(n26), .Y(N27) );
  INVX2 U98 ( .A(n50), .Y(n27) );
  INVX2 U99 ( .A(n51), .Y(n28) );
  INVX2 U100 ( .A(n52), .Y(n29) );
  INVX2 U101 ( .A(n53), .Y(n30) );
  INVX2 U102 ( .A(n54), .Y(n31) );
  INVX2 U103 ( .A(n55), .Y(n32) );
  INVX2 U104 ( .A(n56), .Y(n33) );
  INVX2 U105 ( .A(n57), .Y(n34) );
  INVX2 U106 ( .A(n58), .Y(n35) );
  INVX2 U107 ( .A(n40), .Y(n36) );
  INVX2 U108 ( .A(n41), .Y(n37) );
  INVX2 U109 ( .A(n42), .Y(n38) );
  INVX2 U110 ( .A(n43), .Y(n39) );
  INVX2 U111 ( .A(n44), .Y(n60) );
  INVX2 U112 ( .A(n45), .Y(n61) );
  INVX2 U113 ( .A(n46), .Y(n62) );
  INVX2 U114 ( .A(n47), .Y(n63) );
  INVX2 U115 ( .A(n48), .Y(n64) );
  INVX2 U116 ( .A(n49), .Y(n65) );
  INVX2 U117 ( .A(n59), .Y(n66) );
endmodule


module result_2_DW01_add_0 ( A, B, CI, SUM, CO );
  input [10:0] A;
  input [10:0] B;
  output [10:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [10:1] carry;

  FAX1 U1_10 ( .A(A[10]), .B(B[10]), .C(carry[10]), .YS(SUM[10]) );
  FAX1 U1_9 ( .A(A[9]), .B(B[9]), .C(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  FAX1 U1_8 ( .A(A[8]), .B(B[8]), .C(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  FAX1 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  FAX1 U1_6 ( .A(A[6]), .B(B[6]), .C(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  FAX1 U1_5 ( .A(A[5]), .B(B[5]), .C(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  FAX1 U1_4 ( .A(A[4]), .B(B[4]), .C(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  FAX1 U1_3 ( .A(A[3]), .B(B[3]), .C(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  FAX1 U1_2 ( .A(A[2]), .B(B[2]), .C(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  FAX1 U1_1 ( .A(A[1]), .B(B[1]), .C(n1), .YC(carry[2]), .YS(SUM[1]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module result_2 ( gx_out_2, gy_out_2, final_out_2 );
  input [10:0] gx_out_2;
  input [10:0] gy_out_2;
  output [7:0] final_out_2;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, \abs_gx_out_2[10] ,
         N16, N17, N18, N19, N20, N21, N22, N23, N24, N25, N26,
         \abs_gy_out_2[10] , N27, \sum[9] , \sum[8] , \sum[10] , n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, \sub_add_24_b0/carry[10] , \sub_add_24_b0/carry[9] ,
         \sub_add_24_b0/carry[8] , \sub_add_24_b0/carry[7] ,
         \sub_add_24_b0/carry[6] , \sub_add_24_b0/carry[5] ,
         \sub_add_24_b0/carry[4] , \sub_add_24_b0/carry[3] ,
         \sub_add_24_b0/carry[2] , \sub_add_23_b0/carry[10] ,
         \sub_add_23_b0/carry[9] , \sub_add_23_b0/carry[8] ,
         \sub_add_23_b0/carry[7] , \sub_add_23_b0/carry[6] ,
         \sub_add_23_b0/carry[5] , \sub_add_23_b0/carry[4] ,
         \sub_add_23_b0/carry[3] , \sub_add_23_b0/carry[2] , n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n60, n61, n62, n63, n64, n65, n66;
  wire   [10:0] sum;
  assign N4 = gx_out_2[0];
  assign N16 = gy_out_2[0];

  AND2X2 U15 ( .A(N26), .B(n2), .Y(\abs_gy_out_2[10] ) );
  AND2X2 U16 ( .A(N14), .B(n4), .Y(\abs_gx_out_2[10] ) );
  OR2X1 U39 ( .A(sum[7]), .B(N27), .Y(final_out_2[7]) );
  OR2X1 U40 ( .A(N27), .B(sum[6]), .Y(final_out_2[6]) );
  OR2X1 U41 ( .A(N27), .B(sum[5]), .Y(final_out_2[5]) );
  OR2X1 U42 ( .A(N27), .B(sum[4]), .Y(final_out_2[4]) );
  OR2X1 U43 ( .A(N27), .B(sum[3]), .Y(final_out_2[3]) );
  OR2X1 U44 ( .A(N27), .B(sum[2]), .Y(final_out_2[2]) );
  OR2X1 U45 ( .A(N27), .B(sum[1]), .Y(final_out_2[1]) );
  OR2X1 U46 ( .A(N27), .B(sum[0]), .Y(final_out_2[0]) );
  AOI22X1 U47 ( .A(n2), .B(N25), .C(gy_out_2[9]), .D(n1), .Y(n40) );
  AOI22X1 U48 ( .A(N24), .B(gy_out_2[10]), .C(gy_out_2[8]), .D(n1), .Y(n41) );
  AOI22X1 U49 ( .A(N23), .B(gy_out_2[10]), .C(gy_out_2[7]), .D(n1), .Y(n42) );
  AOI22X1 U50 ( .A(N22), .B(n2), .C(gy_out_2[6]), .D(n1), .Y(n43) );
  AOI22X1 U51 ( .A(N21), .B(n2), .C(gy_out_2[5]), .D(n1), .Y(n44) );
  AOI22X1 U52 ( .A(N20), .B(n2), .C(gy_out_2[4]), .D(n1), .Y(n45) );
  AOI22X1 U53 ( .A(N19), .B(n2), .C(gy_out_2[3]), .D(n1), .Y(n46) );
  AOI22X1 U54 ( .A(N18), .B(n2), .C(gy_out_2[2]), .D(n1), .Y(n47) );
  AOI22X1 U55 ( .A(N17), .B(n2), .C(gy_out_2[1]), .D(n1), .Y(n48) );
  AOI22X1 U56 ( .A(N16), .B(n2), .C(N16), .D(n1), .Y(n49) );
  AOI22X1 U57 ( .A(n4), .B(N13), .C(gx_out_2[9]), .D(n3), .Y(n50) );
  AOI22X1 U58 ( .A(N12), .B(gx_out_2[10]), .C(gx_out_2[8]), .D(n3), .Y(n51) );
  AOI22X1 U59 ( .A(N11), .B(gx_out_2[10]), .C(gx_out_2[7]), .D(n3), .Y(n52) );
  AOI22X1 U60 ( .A(N10), .B(n4), .C(gx_out_2[6]), .D(n3), .Y(n53) );
  AOI22X1 U61 ( .A(N9), .B(n4), .C(gx_out_2[5]), .D(n3), .Y(n54) );
  AOI22X1 U62 ( .A(N8), .B(n4), .C(gx_out_2[4]), .D(n3), .Y(n55) );
  AOI22X1 U63 ( .A(N7), .B(n4), .C(gx_out_2[3]), .D(n3), .Y(n56) );
  AOI22X1 U64 ( .A(N6), .B(n4), .C(gx_out_2[2]), .D(n3), .Y(n57) );
  AOI22X1 U65 ( .A(N5), .B(n4), .C(gx_out_2[1]), .D(n3), .Y(n58) );
  AOI22X1 U66 ( .A(N4), .B(n4), .C(N4), .D(n3), .Y(n59) );
  result_2_DW01_add_0 add_25 ( .A({\abs_gx_out_2[10] , n27, n28, n29, n30, n31, 
        n32, n33, n34, n35, n66}), .B({\abs_gy_out_2[10] , n36, n37, n38, n39, 
        n60, n61, n62, n63, n64, n65}), .CI(1'b0), .SUM({\sum[10] , \sum[9] , 
        \sum[8] , sum[7:0]}) );
  INVX2 U3 ( .A(n3), .Y(n4) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(gy_out_2[10]), .Y(n1) );
  INVX2 U6 ( .A(gx_out_2[10]), .Y(n3) );
  XOR2X1 U7 ( .A(n1), .B(\sub_add_24_b0/carry[10] ), .Y(N26) );
  AND2X1 U8 ( .A(n25), .B(\sub_add_24_b0/carry[9] ), .Y(
        \sub_add_24_b0/carry[10] ) );
  XOR2X1 U9 ( .A(\sub_add_24_b0/carry[9] ), .B(n25), .Y(N25) );
  AND2X1 U10 ( .A(n24), .B(\sub_add_24_b0/carry[8] ), .Y(
        \sub_add_24_b0/carry[9] ) );
  XOR2X1 U11 ( .A(\sub_add_24_b0/carry[8] ), .B(n24), .Y(N24) );
  XOR2X1 U13 ( .A(n3), .B(\sub_add_23_b0/carry[10] ), .Y(N14) );
  AND2X1 U14 ( .A(n14), .B(\sub_add_23_b0/carry[9] ), .Y(
        \sub_add_23_b0/carry[10] ) );
  XOR2X1 U17 ( .A(\sub_add_23_b0/carry[9] ), .B(n14), .Y(N13) );
  AND2X1 U18 ( .A(n13), .B(\sub_add_23_b0/carry[8] ), .Y(
        \sub_add_23_b0/carry[9] ) );
  XOR2X1 U19 ( .A(\sub_add_23_b0/carry[8] ), .B(n13), .Y(N12) );
  AND2X1 U20 ( .A(n23), .B(\sub_add_24_b0/carry[7] ), .Y(
        \sub_add_24_b0/carry[8] ) );
  XOR2X1 U21 ( .A(\sub_add_24_b0/carry[7] ), .B(n23), .Y(N23) );
  AND2X1 U22 ( .A(n22), .B(\sub_add_24_b0/carry[6] ), .Y(
        \sub_add_24_b0/carry[7] ) );
  XOR2X1 U23 ( .A(\sub_add_24_b0/carry[6] ), .B(n22), .Y(N22) );
  AND2X1 U24 ( .A(n21), .B(\sub_add_24_b0/carry[5] ), .Y(
        \sub_add_24_b0/carry[6] ) );
  XOR2X1 U25 ( .A(\sub_add_24_b0/carry[5] ), .B(n21), .Y(N21) );
  AND2X1 U26 ( .A(n20), .B(\sub_add_24_b0/carry[4] ), .Y(
        \sub_add_24_b0/carry[5] ) );
  XOR2X1 U27 ( .A(\sub_add_24_b0/carry[4] ), .B(n20), .Y(N20) );
  AND2X1 U28 ( .A(n19), .B(\sub_add_24_b0/carry[3] ), .Y(
        \sub_add_24_b0/carry[4] ) );
  XOR2X1 U29 ( .A(\sub_add_24_b0/carry[3] ), .B(n19), .Y(N19) );
  AND2X1 U30 ( .A(n18), .B(\sub_add_24_b0/carry[2] ), .Y(
        \sub_add_24_b0/carry[3] ) );
  XOR2X1 U31 ( .A(\sub_add_24_b0/carry[2] ), .B(n18), .Y(N18) );
  AND2X1 U32 ( .A(n17), .B(n16), .Y(\sub_add_24_b0/carry[2] ) );
  XOR2X1 U33 ( .A(n16), .B(n17), .Y(N17) );
  AND2X1 U34 ( .A(n12), .B(\sub_add_23_b0/carry[7] ), .Y(
        \sub_add_23_b0/carry[8] ) );
  XOR2X1 U35 ( .A(\sub_add_23_b0/carry[7] ), .B(n12), .Y(N11) );
  AND2X1 U36 ( .A(n11), .B(\sub_add_23_b0/carry[6] ), .Y(
        \sub_add_23_b0/carry[7] ) );
  XOR2X1 U37 ( .A(\sub_add_23_b0/carry[6] ), .B(n11), .Y(N10) );
  AND2X1 U38 ( .A(n10), .B(\sub_add_23_b0/carry[5] ), .Y(
        \sub_add_23_b0/carry[6] ) );
  XOR2X1 U67 ( .A(\sub_add_23_b0/carry[5] ), .B(n10), .Y(N9) );
  AND2X1 U68 ( .A(n9), .B(\sub_add_23_b0/carry[4] ), .Y(
        \sub_add_23_b0/carry[5] ) );
  XOR2X1 U69 ( .A(\sub_add_23_b0/carry[4] ), .B(n9), .Y(N8) );
  AND2X1 U70 ( .A(n8), .B(\sub_add_23_b0/carry[3] ), .Y(
        \sub_add_23_b0/carry[4] ) );
  XOR2X1 U71 ( .A(\sub_add_23_b0/carry[3] ), .B(n8), .Y(N7) );
  AND2X1 U72 ( .A(n7), .B(\sub_add_23_b0/carry[2] ), .Y(
        \sub_add_23_b0/carry[3] ) );
  XOR2X1 U73 ( .A(\sub_add_23_b0/carry[2] ), .B(n7), .Y(N6) );
  AND2X1 U74 ( .A(n6), .B(n5), .Y(\sub_add_23_b0/carry[2] ) );
  XOR2X1 U75 ( .A(n5), .B(n6), .Y(N5) );
  INVX2 U76 ( .A(N4), .Y(n5) );
  INVX2 U77 ( .A(gx_out_2[1]), .Y(n6) );
  INVX2 U78 ( .A(gx_out_2[2]), .Y(n7) );
  INVX2 U79 ( .A(gx_out_2[3]), .Y(n8) );
  INVX2 U80 ( .A(gx_out_2[4]), .Y(n9) );
  INVX2 U81 ( .A(gx_out_2[5]), .Y(n10) );
  INVX2 U82 ( .A(gx_out_2[6]), .Y(n11) );
  INVX2 U83 ( .A(gx_out_2[7]), .Y(n12) );
  INVX2 U84 ( .A(gx_out_2[8]), .Y(n13) );
  INVX2 U85 ( .A(gx_out_2[9]), .Y(n14) );
  INVX2 U86 ( .A(N16), .Y(n16) );
  INVX2 U87 ( .A(gy_out_2[1]), .Y(n17) );
  INVX2 U88 ( .A(gy_out_2[2]), .Y(n18) );
  INVX2 U89 ( .A(gy_out_2[3]), .Y(n19) );
  INVX2 U90 ( .A(gy_out_2[4]), .Y(n20) );
  INVX2 U91 ( .A(gy_out_2[5]), .Y(n21) );
  INVX2 U92 ( .A(gy_out_2[6]), .Y(n22) );
  INVX2 U93 ( .A(gy_out_2[7]), .Y(n23) );
  INVX2 U94 ( .A(gy_out_2[8]), .Y(n24) );
  INVX2 U95 ( .A(gy_out_2[9]), .Y(n25) );
  OR2X1 U96 ( .A(\sum[9] ), .B(\sum[8] ), .Y(n26) );
  OR2X1 U97 ( .A(\sum[10] ), .B(n26), .Y(N27) );
  INVX2 U98 ( .A(n50), .Y(n27) );
  INVX2 U99 ( .A(n51), .Y(n28) );
  INVX2 U100 ( .A(n52), .Y(n29) );
  INVX2 U101 ( .A(n53), .Y(n30) );
  INVX2 U102 ( .A(n54), .Y(n31) );
  INVX2 U103 ( .A(n55), .Y(n32) );
  INVX2 U104 ( .A(n56), .Y(n33) );
  INVX2 U105 ( .A(n57), .Y(n34) );
  INVX2 U106 ( .A(n58), .Y(n35) );
  INVX2 U107 ( .A(n40), .Y(n36) );
  INVX2 U108 ( .A(n41), .Y(n37) );
  INVX2 U109 ( .A(n42), .Y(n38) );
  INVX2 U110 ( .A(n43), .Y(n39) );
  INVX2 U111 ( .A(n44), .Y(n60) );
  INVX2 U112 ( .A(n45), .Y(n61) );
  INVX2 U113 ( .A(n46), .Y(n62) );
  INVX2 U114 ( .A(n47), .Y(n63) );
  INVX2 U115 ( .A(n48), .Y(n64) );
  INVX2 U116 ( .A(n49), .Y(n65) );
  INVX2 U117 ( .A(n59), .Y(n66) );
endmodule


module overall_edge_det ( clk, n_rst, .data_buffer({\data_buffer[11][7] , 
        \data_buffer[11][6] , \data_buffer[11][5] , \data_buffer[11][4] , 
        \data_buffer[11][3] , \data_buffer[11][2] , \data_buffer[11][1] , 
        \data_buffer[11][0] , \data_buffer[10][7] , \data_buffer[10][6] , 
        \data_buffer[10][5] , \data_buffer[10][4] , \data_buffer[10][3] , 
        \data_buffer[10][2] , \data_buffer[10][1] , \data_buffer[10][0] , 
        \data_buffer[9][7] , \data_buffer[9][6] , \data_buffer[9][5] , 
        \data_buffer[9][4] , \data_buffer[9][3] , \data_buffer[9][2] , 
        \data_buffer[9][1] , \data_buffer[9][0] , \data_buffer[8][7] , 
        \data_buffer[8][6] , \data_buffer[8][5] , \data_buffer[8][4] , 
        \data_buffer[8][3] , \data_buffer[8][2] , \data_buffer[8][1] , 
        \data_buffer[8][0] , \data_buffer[7][7] , \data_buffer[7][6] , 
        \data_buffer[7][5] , \data_buffer[7][4] , \data_buffer[7][3] , 
        \data_buffer[7][2] , \data_buffer[7][1] , \data_buffer[7][0] , 
        \data_buffer[6][7] , \data_buffer[6][6] , \data_buffer[6][5] , 
        \data_buffer[6][4] , \data_buffer[6][3] , \data_buffer[6][2] , 
        \data_buffer[6][1] , \data_buffer[6][0] , \data_buffer[5][7] , 
        \data_buffer[5][6] , \data_buffer[5][5] , \data_buffer[5][4] , 
        \data_buffer[5][3] , \data_buffer[5][2] , \data_buffer[5][1] , 
        \data_buffer[5][0] , \data_buffer[4][7] , \data_buffer[4][6] , 
        \data_buffer[4][5] , \data_buffer[4][4] , \data_buffer[4][3] , 
        \data_buffer[4][2] , \data_buffer[4][1] , \data_buffer[4][0] , 
        \data_buffer[3][7] , \data_buffer[3][6] , \data_buffer[3][5] , 
        \data_buffer[3][4] , \data_buffer[3][3] , \data_buffer[3][2] , 
        \data_buffer[3][1] , \data_buffer[3][0] , \data_buffer[2][7] , 
        \data_buffer[2][6] , \data_buffer[2][5] , \data_buffer[2][4] , 
        \data_buffer[2][3] , \data_buffer[2][2] , \data_buffer[2][1] , 
        \data_buffer[2][0] , \data_buffer[1][7] , \data_buffer[1][6] , 
        \data_buffer[1][5] , \data_buffer[1][4] , \data_buffer[1][3] , 
        \data_buffer[1][2] , \data_buffer[1][1] , \data_buffer[1][0] , 
        \data_buffer[0][7] , \data_buffer[0][6] , \data_buffer[0][5] , 
        \data_buffer[0][4] , \data_buffer[0][3] , \data_buffer[0][2] , 
        \data_buffer[0][1] , \data_buffer[0][0] }), shift_enable_r, 
        transfer_data_complete_r, transfer_data_complete_w, final_out_1, 
        final_out_2, buffer_clear );
  output [7:0] final_out_1;
  output [7:0] final_out_2;
  input clk, n_rst, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] , shift_enable_r, transfer_data_complete_r,
         transfer_data_complete_w;
  output buffer_clear;
  wire   enable_calc;
  wire   [10:0] gx_out_1;
  wire   [10:0] gx_out_2;
  wire   [10:0] gy_out_1;
  wire   [10:0] gy_out_2;

  mcu control ( .clk(clk), .n_rst(n_rst), .shift_enable_r(shift_enable_r), 
        .transfer_data_complete_r(transfer_data_complete_r), 
        .transfer_data_complete_w(transfer_data_complete_w), .enable_calc(
        enable_calc), .buffer_clear(buffer_clear) );
  gx_block_window1 gx1 ( .clk(clk), .n_rst(n_rst), .data_buffer({
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] , \data_buffer[10][7] , 
        \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] , 
        \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] , 
        \data_buffer[10][0] , \data_buffer[9][7] , \data_buffer[9][6] , 
        \data_buffer[9][5] , \data_buffer[9][4] , \data_buffer[9][3] , 
        \data_buffer[9][2] , \data_buffer[9][1] , \data_buffer[9][0] , 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] , \data_buffer[7][7] , 
        \data_buffer[7][6] , \data_buffer[7][5] , \data_buffer[7][4] , 
        \data_buffer[7][3] , \data_buffer[7][2] , \data_buffer[7][1] , 
        \data_buffer[7][0] , \data_buffer[6][7] , \data_buffer[6][6] , 
        \data_buffer[6][5] , \data_buffer[6][4] , \data_buffer[6][3] , 
        \data_buffer[6][2] , \data_buffer[6][1] , \data_buffer[6][0] , 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] , \data_buffer[4][7] , 
        \data_buffer[4][6] , \data_buffer[4][5] , \data_buffer[4][4] , 
        \data_buffer[4][3] , \data_buffer[4][2] , \data_buffer[4][1] , 
        \data_buffer[4][0] , \data_buffer[3][7] , \data_buffer[3][6] , 
        \data_buffer[3][5] , \data_buffer[3][4] , \data_buffer[3][3] , 
        \data_buffer[3][2] , \data_buffer[3][1] , \data_buffer[3][0] , 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] , \data_buffer[1][7] , 
        \data_buffer[1][6] , \data_buffer[1][5] , \data_buffer[1][4] , 
        \data_buffer[1][3] , \data_buffer[1][2] , \data_buffer[1][1] , 
        \data_buffer[1][0] , \data_buffer[0][7] , \data_buffer[0][6] , 
        \data_buffer[0][5] , \data_buffer[0][4] , \data_buffer[0][3] , 
        \data_buffer[0][2] , \data_buffer[0][1] , \data_buffer[0][0] }), 
        .enable_calc(enable_calc), .gx_out_1(gx_out_1) );
  gx_block_window2 gx2 ( .clk(clk), .n_rst(n_rst), .data_buffer({
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] , \data_buffer[10][7] , 
        \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] , 
        \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] , 
        \data_buffer[10][0] , \data_buffer[9][7] , \data_buffer[9][6] , 
        \data_buffer[9][5] , \data_buffer[9][4] , \data_buffer[9][3] , 
        \data_buffer[9][2] , \data_buffer[9][1] , \data_buffer[9][0] , 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] , \data_buffer[7][7] , 
        \data_buffer[7][6] , \data_buffer[7][5] , \data_buffer[7][4] , 
        \data_buffer[7][3] , \data_buffer[7][2] , \data_buffer[7][1] , 
        \data_buffer[7][0] , \data_buffer[6][7] , \data_buffer[6][6] , 
        \data_buffer[6][5] , \data_buffer[6][4] , \data_buffer[6][3] , 
        \data_buffer[6][2] , \data_buffer[6][1] , \data_buffer[6][0] , 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] , \data_buffer[4][7] , 
        \data_buffer[4][6] , \data_buffer[4][5] , \data_buffer[4][4] , 
        \data_buffer[4][3] , \data_buffer[4][2] , \data_buffer[4][1] , 
        \data_buffer[4][0] , \data_buffer[3][7] , \data_buffer[3][6] , 
        \data_buffer[3][5] , \data_buffer[3][4] , \data_buffer[3][3] , 
        \data_buffer[3][2] , \data_buffer[3][1] , \data_buffer[3][0] , 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] , \data_buffer[1][7] , 
        \data_buffer[1][6] , \data_buffer[1][5] , \data_buffer[1][4] , 
        \data_buffer[1][3] , \data_buffer[1][2] , \data_buffer[1][1] , 
        \data_buffer[1][0] , \data_buffer[0][7] , \data_buffer[0][6] , 
        \data_buffer[0][5] , \data_buffer[0][4] , \data_buffer[0][3] , 
        \data_buffer[0][2] , \data_buffer[0][1] , \data_buffer[0][0] }), 
        .enable_calc(enable_calc), .gx_out_2(gx_out_2) );
  gy_block_window1 gy1 ( .clk(clk), .n_rst(n_rst), .data_buffer({
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] , \data_buffer[10][7] , 
        \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] , 
        \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] , 
        \data_buffer[10][0] , \data_buffer[9][7] , \data_buffer[9][6] , 
        \data_buffer[9][5] , \data_buffer[9][4] , \data_buffer[9][3] , 
        \data_buffer[9][2] , \data_buffer[9][1] , \data_buffer[9][0] , 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] , \data_buffer[7][7] , 
        \data_buffer[7][6] , \data_buffer[7][5] , \data_buffer[7][4] , 
        \data_buffer[7][3] , \data_buffer[7][2] , \data_buffer[7][1] , 
        \data_buffer[7][0] , \data_buffer[6][7] , \data_buffer[6][6] , 
        \data_buffer[6][5] , \data_buffer[6][4] , \data_buffer[6][3] , 
        \data_buffer[6][2] , \data_buffer[6][1] , \data_buffer[6][0] , 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] , \data_buffer[4][7] , 
        \data_buffer[4][6] , \data_buffer[4][5] , \data_buffer[4][4] , 
        \data_buffer[4][3] , \data_buffer[4][2] , \data_buffer[4][1] , 
        \data_buffer[4][0] , \data_buffer[3][7] , \data_buffer[3][6] , 
        \data_buffer[3][5] , \data_buffer[3][4] , \data_buffer[3][3] , 
        \data_buffer[3][2] , \data_buffer[3][1] , \data_buffer[3][0] , 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] , \data_buffer[1][7] , 
        \data_buffer[1][6] , \data_buffer[1][5] , \data_buffer[1][4] , 
        \data_buffer[1][3] , \data_buffer[1][2] , \data_buffer[1][1] , 
        \data_buffer[1][0] , \data_buffer[0][7] , \data_buffer[0][6] , 
        \data_buffer[0][5] , \data_buffer[0][4] , \data_buffer[0][3] , 
        \data_buffer[0][2] , \data_buffer[0][1] , \data_buffer[0][0] }), 
        .enable_calc(enable_calc), .gy_out_1(gy_out_1) );
  gy_block_window2 gy2 ( .clk(clk), .n_rst(n_rst), .data_buffer({
        \data_buffer[11][7] , \data_buffer[11][6] , \data_buffer[11][5] , 
        \data_buffer[11][4] , \data_buffer[11][3] , \data_buffer[11][2] , 
        \data_buffer[11][1] , \data_buffer[11][0] , \data_buffer[10][7] , 
        \data_buffer[10][6] , \data_buffer[10][5] , \data_buffer[10][4] , 
        \data_buffer[10][3] , \data_buffer[10][2] , \data_buffer[10][1] , 
        \data_buffer[10][0] , \data_buffer[9][7] , \data_buffer[9][6] , 
        \data_buffer[9][5] , \data_buffer[9][4] , \data_buffer[9][3] , 
        \data_buffer[9][2] , \data_buffer[9][1] , \data_buffer[9][0] , 
        \data_buffer[8][7] , \data_buffer[8][6] , \data_buffer[8][5] , 
        \data_buffer[8][4] , \data_buffer[8][3] , \data_buffer[8][2] , 
        \data_buffer[8][1] , \data_buffer[8][0] , \data_buffer[7][7] , 
        \data_buffer[7][6] , \data_buffer[7][5] , \data_buffer[7][4] , 
        \data_buffer[7][3] , \data_buffer[7][2] , \data_buffer[7][1] , 
        \data_buffer[7][0] , \data_buffer[6][7] , \data_buffer[6][6] , 
        \data_buffer[6][5] , \data_buffer[6][4] , \data_buffer[6][3] , 
        \data_buffer[6][2] , \data_buffer[6][1] , \data_buffer[6][0] , 
        \data_buffer[5][7] , \data_buffer[5][6] , \data_buffer[5][5] , 
        \data_buffer[5][4] , \data_buffer[5][3] , \data_buffer[5][2] , 
        \data_buffer[5][1] , \data_buffer[5][0] , \data_buffer[4][7] , 
        \data_buffer[4][6] , \data_buffer[4][5] , \data_buffer[4][4] , 
        \data_buffer[4][3] , \data_buffer[4][2] , \data_buffer[4][1] , 
        \data_buffer[4][0] , \data_buffer[3][7] , \data_buffer[3][6] , 
        \data_buffer[3][5] , \data_buffer[3][4] , \data_buffer[3][3] , 
        \data_buffer[3][2] , \data_buffer[3][1] , \data_buffer[3][0] , 
        \data_buffer[2][7] , \data_buffer[2][6] , \data_buffer[2][5] , 
        \data_buffer[2][4] , \data_buffer[2][3] , \data_buffer[2][2] , 
        \data_buffer[2][1] , \data_buffer[2][0] , \data_buffer[1][7] , 
        \data_buffer[1][6] , \data_buffer[1][5] , \data_buffer[1][4] , 
        \data_buffer[1][3] , \data_buffer[1][2] , \data_buffer[1][1] , 
        \data_buffer[1][0] , \data_buffer[0][7] , \data_buffer[0][6] , 
        \data_buffer[0][5] , \data_buffer[0][4] , \data_buffer[0][3] , 
        \data_buffer[0][2] , \data_buffer[0][1] , \data_buffer[0][0] }), 
        .enable_calc(enable_calc), .gy_out_2(gy_out_2) );
  result_1 res1 ( .gx_out_1(gx_out_1), .gy_out_1(gy_out_1), .final_out_1(
        final_out_1) );
  result_2 res2 ( .gx_out_2(gx_out_2), .gy_out_2(gy_out_2), .final_out_2(
        final_out_2) );
endmodule


module top_level ( clk, n_rst, HWRITE_S, HREADY_M, HREADY_S, HADDR_S, HRDATA_M, 
        HWDATA_S, HWRITE_M, HADDR_M, HWDATA_M );
  input [31:0] HADDR_S;
  input [31:0] HRDATA_M;
  input [31:0] HWDATA_S;
  output [31:0] HADDR_M;
  output [31:0] HWDATA_M;
  input clk, n_rst, HWRITE_S, HREADY_M, HREADY_S;
  output HWRITE_M;
  wire   read_enable, write_enable, transfer_data_complete_r, shift_enable_r,
         buffer_clear, \data_buffer[11][7] , \data_buffer[11][6] ,
         \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] ,
         \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] ,
         \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] ,
         \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] ,
         \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] ,
         \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] ,
         \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] ,
         \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] ,
         \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] ,
         \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] ,
         \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] ,
         \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] ,
         \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] ,
         \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] ,
         \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] ,
         \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] ,
         \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] ,
         \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] ,
         \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] ,
         \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] ,
         \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] ,
         \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] ,
         \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] ,
         \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] ,
         \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] ,
         \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] ,
         \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] ,
         \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] ,
         \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] ,
         \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] ,
         \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] ,
         \data_buffer[0][0] ;
  wire   [15:0] length;
  wire   [15:0] width;
  wire   [31:0] source_addr;
  wire   [31:0] dest_addr;
  wire   [7:0] final_out_1;
  wire   [7:0] final_out_2;
  wire   [7:0] pixel_out;
  tri   HWRITE_M;
  tri   [31:0] HADDR_M;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;
  assign HWDATA_M[31] = 1'b1;
  assign HWDATA_M[30] = 1'b1;
  assign HWDATA_M[29] = 1'b1;
  assign HWDATA_M[28] = 1'b1;
  assign HWDATA_M[27] = 1'b1;
  assign HWDATA_M[26] = 1'b1;
  assign HWDATA_M[25] = 1'b1;
  assign HWDATA_M[24] = 1'b1;
  assign HWDATA_M[23] = 1'b1;
  assign HWDATA_M[22] = 1'b1;
  assign HWDATA_M[21] = 1'b1;
  assign HWDATA_M[20] = 1'b1;
  assign HWDATA_M[19] = 1'b1;
  assign HWDATA_M[18] = 1'b1;
  assign HWDATA_M[17] = 1'b1;
  assign HWDATA_M[16] = 1'b1;

  ahb_slave AHB_SLAVE_PROTOCOL ( .HCLK(clk), .HRESETn(n_rst), .HREADY(HREADY_S), .HWRITE(HWRITE_S), .HWDATA(HWDATA_S), .HADDR(HADDR_S), .length(length), 
        .width(width), .source_addr(source_addr), .dest_addr(dest_addr), 
        .read_enable(read_enable), .write_enable(write_enable) );
  ahb_master AHB_MASTER_PROTOCOL ( .HCLK(clk), .HRESETn(n_rst), .HREADY(
        HREADY_M), .read_enable(read_enable), .write_enable(write_enable), 
        .length(length), .width(width), .source_addr(source_addr), .dest_addr(
        dest_addr), .HRDATA(HRDATA_M), .sobel_result1(final_out_1), 
        .sobel_result2(final_out_2), .HADDR(HADDR_M), .pixel_out(pixel_out), 
        .HWDATA({SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, HWDATA_M[15:0]}), 
        .HWRITE(HWRITE_M), .transfer_data_complete_r(transfer_data_complete_r), 
        .shift_enable_r(shift_enable_r) );
  fill_in_buffer DATA_BUFFER ( .clk(clk), .n_rst(n_rst), .shift_enable(
        shift_enable_r), .buffer_clear(buffer_clear), .read_data(pixel_out), 
        .data_buffer({\data_buffer[11][7] , \data_buffer[11][6] , 
        \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] , 
        \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] , 
        \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] , 
        \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] , 
        \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] , 
        \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] , 
        \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] , 
        \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] , 
        \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] , 
        \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] , 
        \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] , 
        \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] , 
        \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] , 
        \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] , 
        \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] , 
        \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] , 
        \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] , 
        \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] , 
        \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] , 
        \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] , 
        \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] , 
        \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] , 
        \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] , 
        \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] , 
        \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] , 
        \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] , 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] , 
        \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] , 
        \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] , 
        \data_buffer[0][0] }) );
  overall_edge_det EDGE_DETECTION_MODULE ( .clk(clk), .n_rst(n_rst), 
        .data_buffer({\data_buffer[11][7] , \data_buffer[11][6] , 
        \data_buffer[11][5] , \data_buffer[11][4] , \data_buffer[11][3] , 
        \data_buffer[11][2] , \data_buffer[11][1] , \data_buffer[11][0] , 
        \data_buffer[10][7] , \data_buffer[10][6] , \data_buffer[10][5] , 
        \data_buffer[10][4] , \data_buffer[10][3] , \data_buffer[10][2] , 
        \data_buffer[10][1] , \data_buffer[10][0] , \data_buffer[9][7] , 
        \data_buffer[9][6] , \data_buffer[9][5] , \data_buffer[9][4] , 
        \data_buffer[9][3] , \data_buffer[9][2] , \data_buffer[9][1] , 
        \data_buffer[9][0] , \data_buffer[8][7] , \data_buffer[8][6] , 
        \data_buffer[8][5] , \data_buffer[8][4] , \data_buffer[8][3] , 
        \data_buffer[8][2] , \data_buffer[8][1] , \data_buffer[8][0] , 
        \data_buffer[7][7] , \data_buffer[7][6] , \data_buffer[7][5] , 
        \data_buffer[7][4] , \data_buffer[7][3] , \data_buffer[7][2] , 
        \data_buffer[7][1] , \data_buffer[7][0] , \data_buffer[6][7] , 
        \data_buffer[6][6] , \data_buffer[6][5] , \data_buffer[6][4] , 
        \data_buffer[6][3] , \data_buffer[6][2] , \data_buffer[6][1] , 
        \data_buffer[6][0] , \data_buffer[5][7] , \data_buffer[5][6] , 
        \data_buffer[5][5] , \data_buffer[5][4] , \data_buffer[5][3] , 
        \data_buffer[5][2] , \data_buffer[5][1] , \data_buffer[5][0] , 
        \data_buffer[4][7] , \data_buffer[4][6] , \data_buffer[4][5] , 
        \data_buffer[4][4] , \data_buffer[4][3] , \data_buffer[4][2] , 
        \data_buffer[4][1] , \data_buffer[4][0] , \data_buffer[3][7] , 
        \data_buffer[3][6] , \data_buffer[3][5] , \data_buffer[3][4] , 
        \data_buffer[3][3] , \data_buffer[3][2] , \data_buffer[3][1] , 
        \data_buffer[3][0] , \data_buffer[2][7] , \data_buffer[2][6] , 
        \data_buffer[2][5] , \data_buffer[2][4] , \data_buffer[2][3] , 
        \data_buffer[2][2] , \data_buffer[2][1] , \data_buffer[2][0] , 
        \data_buffer[1][7] , \data_buffer[1][6] , \data_buffer[1][5] , 
        \data_buffer[1][4] , \data_buffer[1][3] , \data_buffer[1][2] , 
        \data_buffer[1][1] , \data_buffer[1][0] , \data_buffer[0][7] , 
        \data_buffer[0][6] , \data_buffer[0][5] , \data_buffer[0][4] , 
        \data_buffer[0][3] , \data_buffer[0][2] , \data_buffer[0][1] , 
        \data_buffer[0][0] }), .shift_enable_r(shift_enable_r), 
        .transfer_data_complete_r(transfer_data_complete_r), 
        .transfer_data_complete_w(1'b0), .final_out_1(final_out_1), 
        .final_out_2(final_out_2), .buffer_clear(buffer_clear) );
endmodule

