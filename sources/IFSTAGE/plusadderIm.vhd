----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:28 04/05/2020 
-- Design Name: 
-- Module Name:    plusadderIm - Behavioral 
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity plusadderIm is
	port(
			input1: in std_logic_vector(31 downto 0);
			input2: in std_logic_vector(31 downto 0);
			result : out std_logic_vector(31 downto 0)
		  );
end plusadderIm;

architecture Behavioral of plusadderIm is

begin


result <= input1 + input2;

end Behavioral;

