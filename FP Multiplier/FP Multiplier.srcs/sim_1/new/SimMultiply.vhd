----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2019 11:17:26 AM
-- Design Name: 
-- Module Name: SimMultiply - Behavioral
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

entity SimMultiply is
--  Port ( );
end SimMultiply;

 architecture Behavioral of SimMultiply is

signal Clk: std_logic;
signal CE:  std_logic := '0';      
signal X :   std_logic_vector (31 downto 0) := (others => '0');
signal Y :   std_logic_vector (31 downto 0) := (others => '0');
signal P :   std_logic_vector (31 downto 0):= (others => '0');
signal ErrorFlag: std_logic := '0';
constant clk_period : time := 1 ns;

begin
    DUT: entity WORK.FPMultiplier port map(CE,Clk,X,Y,P,ErrorFlag);
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
