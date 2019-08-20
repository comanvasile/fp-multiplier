----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2019 03:35:45 PM
-- Design Name: 
-- Module Name: Adder - Behavioral
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

entity Adder is
 generic( N : natural);
     Port (X   :   in  std_logic_vector    (N-1 downto 0);
           Y   :   in  std_logic_vector    (N-1 downto 0);
           CarryIn:in  std_logic;
           S: out std_logic_vector   (N-1 downto 0);
           CarryOut: out std_logic);
end Adder;

architecture Behavioral of Adder is
signal carry : std_logic_vector(n downto 0) := (others => '0');
begin
    carry(0) <= CarryIn;
    GenerateSum: for i in 0 to n-1 generate
        SE : entity WORK.SE port map(X(i),Y(i),carry(i),carry(i+1),S(i));
    end generate;
    CarryOut <= carry(N);

end Behavioral;
