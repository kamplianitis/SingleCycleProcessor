----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:27:23 03/27/2020 
-- Design Name: 
-- Module Name:    Registr - Behavioral 
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

entity Reg is
	port
		(
			Clk : in std_logic;
			Rst : in std_logic;
			WE : in std_logic;
			Datain : in std_logic_vector(31 downto 0);
			Dataout: out std_logic_vector(31 downto 0)
		);
end Reg;

architecture Behavioral of Reg is

begin
	
	process 
		begin 
			wait until Clk'Event and Clk='1'; --clock palm
			if (Rst = '1') then -- synchronus reset (we can make it asycronus by making another if)
				Dataout <= "00000000000000000000000000000000";
			elsif(WE = '1') then 
				Dataout <= Datain;
			end if ;
	end process;
end Behavioral;

