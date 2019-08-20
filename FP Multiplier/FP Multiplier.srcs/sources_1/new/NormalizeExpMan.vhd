----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2019 04:06:20 PM
-- Design Name: 
-- Module Name: NormalizeExpMan - Behavioral
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

entity NormalizeExpMan is
Port (
            CE          :   in  std_logic;      
            Clk         :   in  std_logic;
            Exponent    :   in  std_logic_vector (8 downto 0);
            Mantisa     :   in  std_logic_vector (47 downto 0);
            ExpOut      :   out std_logic_vector (7 downto 0);
            MantisaOut  :   out std_logic_vector (22 downto 0);
            OverFlow    :   out std_logic);
end NormalizeExpMan;

architecture Behavioral of NormalizeExpMan is

 signal carry: std_logic := '0';
 signal increment: std_logic_vector (7 downto 0) := (others => '0');
begin
    normalize: process(Clk,CE,Mantisa)
    begin
        if(rising_edge(Clk)) then
            if(CE = '1') then
                if(Mantisa(47) = '0') then
                    MantisaOut <= Mantisa(45 downto 23);
                else
                    MantisaOut <= Mantisa(46 downto 24);
                    increment <= "00000001";
                end if;
            end if;     
         end if;   
      end process;
      Add_increment_to_exp: entity WORK.Adder generic map(8) port map(Exponent(7 downto 0),increment,'0',ExpOut,carry);
      OverFlow <= Exponent(8) xor carry;


end Behavioral;
