----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2017 10:04:25 PM
-- Design Name: 
-- Module Name: simIEEE754_Mul - Behavioral
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

entity simIEEE754_Mul is
--  Port ( );
end simIEEE754_Mul;

architecture Behavioral of simIEEE754_Mul is

signal Clk: std_logic;
signal CE:  std_logic := '0';      
signal X :   std_logic_vector (31 downto 0) := (others => '0');
signal Y :   std_logic_vector (31 downto 0) := (others => '0');
signal P :   std_logic_vector (31 downto 0):= (others => '0');
signal ErrorFlag: std_logic := '0';
constant clk_period : time := 1 ns;

begin
    DUT: entity WORK.IEEE754_multiplyer port map(CE,Clk,X,Y,P,ErrorFlag);
    test: process
    begin
    CE <= '1';
        X <="10111110100110011001100110011010";-- -0.3
        Y <="01000011111110100010000000000000";-- +500.25
     wait for 50 ns;
        wait;
    end process;
    clk_process :process
       begin
            Clk <= '0';
            wait for clk_period/2;  --for 0.5 ns signal is '0'.
            Clk <= '1';
            wait for clk_period/2;  --for next 0.5 ns signal is '1'.
       end process;
end Behavioral;
