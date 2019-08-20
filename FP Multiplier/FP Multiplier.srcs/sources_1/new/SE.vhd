----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2019 03:42:21 PM
-- Design Name: 
-- Module Name: SE - Behavioral
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

entity SE is
Port ( X : in STD_LOGIC;
           Y : in STD_LOGIC;
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           S : out STD_LOGIC);
end SE;

architecture Behavioral of SE is
begin
 Tout <= (X and Y) or (Tin and (X or Y));
 S <= Tin xor (X xor Y);



end Behavioral;
