----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2019 03:50:44 PM
-- Design Name: 
-- Module Name: Multiplier - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
generic(N : natural);
    Port (X :   in std_logic_vector (N-1 downto 0);
          Y :   in std_logic_vector (N-1 downto 0);
          P :   out std_logic_vector (2*N-1 downto 0));
end Multiplier;

architecture Behavioral of Multiplier is

type type1 is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
type type2 is array(N-1 downto 0) of std_logic_vector(N downto 0);
type type3 is array(N-2 downto 0) of std_logic_vector(N downto 0);
signal  PP  :   type1;
signal  S   :   type2;
signal  T   :   type3;
begin
--------------initializare produse partiale---------
    ppartial_l  :   for i in 0 to n-1 generate
        ppartial_c  :   for j in 0 to n-1 generate
            PP(i)(j) <= X(j) and Y(i);
        end generate;
    end generate;
---------------initializare S(0,i)-------------------
    init_S_linie_0: for i in n-1 downto 0 generate
        S(0)(i) <=  X(i) and Y(0);
    end generate;
    S(0)(n) <= '0';
----------------initializare T(i,0)-------------------
    init_T_coloana_0: for i in 0 to n-2 generate
        T(i)(0) <= '0';
    end generate;
----------------initializare S(i,n)-------------------
    init_S_coloana_n: for i in 1 to n-1 generate
        S(i)(n) <=  T(i-1)(n);
    end generate;
-----------------generare sumatoare-------------------
    gen_linii:  for i in 0 to n-2 generate
        gen_coloane:    for j in 0 to n-1 generate
            sumator_elem:   entity WORK.SE port map(S(i)(j+1),PP(i+1)(j),T(i)(j),T(i)(j+1),S(i+1)(j));
        end generate gen_coloane;
    end generate gen_linii;
---------gen produs LOW--------------------------------
    gen_produs_LOW: for i in n-1 downto 0 generate
        P(i) <= S(i)(0);
    end generate;
----------gen produs HIGH-------------------------------
    gen_produs_HIGH: for i in n downto 1 generate
        P(i+n-1) <= S(n-1)(i);
    end generate;
---------------------------------------------------------


end Behavioral;
