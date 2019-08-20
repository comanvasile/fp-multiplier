----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2019 11:15:58 AM
-- Design Name: 
-- Module Name: FPMultiplier - Behavioral
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

entity FPMultiplier is
Port ( CE : in std_logic;
           Clk  :   in  STD_LOGIC;
           X    :   in  STD_LOGIC_VECTOR (31 downto 0);
           Y    :   in  STD_LOGIC_VECTOR (31 downto 0);
           P    :   out STD_LOGIC_VECTOR (31 downto 0);
      ErrorFlag : out STD_LOGIC);
end FPMultiplier;

architecture Behavioral of FPMultiplier is

signal exp_intern,exp_intern1,exp_intern2,exp_intern4: std_logic_vector(8 downto 0) := (others => '0');
signal exp_out : std_logic_vector (7 downto 0) := (others => '0');
signal C2_127: std_logic_vector (8 downto 0) := "110000001";
signal carry_intern,carry_intern1 : std_logic := '0';
signal mantisa1, mantisa2: std_logic_vector (23 downto 0) := (others => '0');
signal mantisa_out : std_logic_vector (22 downto 0) := (others => '0');
signal mantisa_to_normalize: std_logic_vector (47 downto 0) := (others => '0');
signal overflow : std_logic := '0';
begin
--select exponents
    exp_intern1 <= '0' & X(30 downto 23);
    exp_intern2 <= '0' & Y(30 downto 23);
--compute sign
   P(31) <= X(31) xor Y(31);
--add exponents than add bias(-127)
    add_exp   :   entity WORK.Adder generic map(9) port map(exp_intern1, exp_intern2, '0', exp_intern, carry_intern);
    add_bias :   entity WORK.Adder generic map(9) port map(exp_intern, C2_127, carry_intern, exp_intern4, carry_intern1);
--select mantisa
    mantisa1 <= '1' & X(22 downto 0);
    mantisa2 <= '1' & Y(22 downto 0);
--multypli mansite
    multiply_mantise   :   entity WORK.Multiplier generic map (n => 24) port map(mantisa1, mantisa2, mantisa_to_normalize);
--normalize result
    normalize       :   entity WORK.normalizeExpMan port map (CE,Clk, exp_intern4, mantisa_to_normalize, exp_out, mantisa_out, overflow);
--put result in P
P(30 downto 23) <= exp_out;
P(22 downto 0)  <= mantisa_out;
ErrorFlag <= overflow;


end Behavioral;
