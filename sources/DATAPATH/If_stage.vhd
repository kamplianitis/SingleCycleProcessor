----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:09:34 04/05/2020 
-- Design Name: 
-- Module Name:    If_stage - Behavioral 
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

entity If_stage is
	port
		(
			PC_Immed : in std_logic_vector(31 downto 0);
			PC_sel : in std_logic;
			PC_LdEn : in std_logic;
			Reset : in std_logic;
			Clk : in std_logic;
			Pc : out std_logic_vector(31 downto 0)
		);
end If_stage;

architecture Structural of If_stage is
-- now we get all the components


--first the pc
component Reg
	port
		(
			Clk : in std_logic;
			Rst : in std_logic;
			WE : in std_logic;
			Datain : in std_logic_vector(31 downto 0);
			Dataout: out std_logic_vector(31 downto 0)
		);
end component;
				
-- the mux
component Pc_mux
	port
		(
			inputplusI : in std_logic_vector(31 downto 0);
			input : in std_logic_vector (31 downto 0);
			sel : in std_logic;
			output : out std_logic_vector(31 downto 0)
		);
end component;

-- now the adders

component plus4adder
	port
		(
			reginput : in std_logic_vector(31 downto 0);
			result : out std_logic_vector(31 downto 0)
		);
end component;

component plusadderIm
	port
		(
			input1: in std_logic_vector(31 downto 0);
			input2: in std_logic_vector(31 downto 0);
			result : out std_logic_vector(31 downto 0)
		 );
end component;

-- now we begin the build up

-- the temp signals that we need
signal tempresult4 : std_logic_vector(31 downto 0);
signal tempresult : std_logic_vector(31 downto 0);
signal pcinput : std_logic_vector (31 downto 0);
signal Pc_out : std_logic_vector(31 downto 0);

begin

-- we begin the process with the plus 4 addition

add4 : plus4adder
	port map 
			(
				reginput => Pc_out,
				result => tempresult4 -- we need the result to go on the mux that we'll create later
			);

-- now the other adder
addIm : plusadderIm
	port map 
			(
				input1 => PC_Immed,
				input2 => tempresult4, -- this is a signal that keeps the output of the Pc_register (hint in the next lines)
				result => tempresult
			);
			
-- now we have to do the mux
pcmux : Pc_mux
	port map 
			(
				inputplusI => tempresult,
				input => tempresult4,
				sel => PC_sel,
				output => pcinput
			);
			
pcr : Reg
	port map
			(
				Clk => Clk,
				Rst => Reset,
				WE => PC_LdEn,
				Datain => pcinput,
				Dataout => Pc_out
			);
			
Pc <= Pc_out;
end Structural;

