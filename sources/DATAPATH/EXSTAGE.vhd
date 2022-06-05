----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:43:47 04/06/2020 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
	port
		(
			RF_A : in std_logic_vector(31 downto 0);
			RF_B : in std_logic_vector(31 downto 0);
			Immed : in std_logic_vector(31 downto 0);
			ALU_Bin_sel : in std_logic;
			ALU_func : in std_logic_vector(3 downto 0);
			ALU_out : out std_logic_vector(31 downto 0);
			ALU_zero : out std_logic
		);
end EXSTAGE;

architecture Structural of EXSTAGE is

-- declare the components
component Mux32bit2to1
	port 
		( 
			A : in  STD_LOGIC_VECTOR (31 downto 0);
         B : in  STD_LOGIC_VECTOR (31 downto 0);
         SEL : in  STD_LOGIC;
         X : out  STD_LOGIC_VECTOR (31 downto 0)
		);
end component;

component ALU 
	port
		(
			A : in  STD_LOGIC_VECTOR(31 downto 0);
         B : in  STD_LOGIC_VECTOR(31 downto 0);
         Op : in  STD_LOGIC_VECTOR(3 downto 0);
         ZeroOut : out  STD_LOGIC;
         Outp : out  STD_LOGIC_VECTOR(31 downto 0);
         Cout : out  STD_LOGIC;
         Ovf : out  STD_LOGIC
		);
end component;


-- temp signals
signal tempmux : std_logic_vector(31 downto 0);

begin


-- starting to create the stage
mux : Mux32bit2to1
	port map
			(
				A => RF_B,
				B => Immed,
				SEL => ALU_Bin_sel,
				X => tempmux
			);

-- now we want the ALU
praxis : ALU
	port map
			(
				A => RF_A,
				B => tempmux,
				Op => ALU_func,
				ZeroOut => ALU_zero,
				Outp => ALU_out,
				Cout => open,
				Ovf => open
			);
end Structural;

