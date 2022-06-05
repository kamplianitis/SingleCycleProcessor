----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:11 04/05/2020 
-- Design Name: 
-- Module Name:    Littlecloud - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Littlecloud is
    port 
		( 
			Din : in  STD_LOGIC_VECTOR (15 downto 0);
			Immed : out  STD_LOGIC_VECTOR (31 downto 0);
			OpCode : in  STD_LOGIC_VECTOR (1 downto 0)
		);
end Littlecloud;

architecture Behavioral of Littlecloud is

signal temp : STD_LOGIC_VECTOR (31 downto 0);


begin

	process(OpCode, Din)
		begin

	if (OpCode="00") then --zero filling
        temp(31 downto 16) <= (others => '0');
        temp(15 downto 0) <= Din; 
    elsif (OpCode="01") then -- shift left and zero fill
        temp(31 downto 16) <= Din;
        temp(15 downto 0) <= (others => '0');
    elsif (OpCode="10")    then --sign extend
        temp(31 downto 16) <= (others => Din(15));
        temp(15 downto 0) <= Din;
    else  -- shift left 2 bit and sign extend
        temp(31 downto 18) <= (others => Din(15));
        temp(17 downto 2) <= Din;
        temp(1 downto 0) <= "00";
    end if;
	end process;	

Immed <= temp;

end Behavioral;

