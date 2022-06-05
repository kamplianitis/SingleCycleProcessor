----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:46:03 04/19/2020 
-- Design Name: 
-- Module Name:    mem_stage - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_stage is
    port ( 
				ByteOp : in  STD_LOGIC;
				ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
				MM_RdData : in std_logic_vector (31 downto 0);
				MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
				MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataOut : out std_logic_vector(31 downto 0)
			 );
end mem_stage;

architecture Behavioral of mem_stage is

-- as we're told we do not need to use logic in every signal there. The signals that we will use are the byteOp, the alu adddress and the mm datain

-- the temp signals that we will use 
signal temp4 : std_logic_vector(31 downto 0);
signal mmwrite : std_logic_vector(31 downto 0);
signal temp : std_logic_vector(31 downto 0); -- we need that to make this so that we accomplish taking the last 8 bits of the input 
signal tentwofour : std_logic_vector(31 downto 0); -- the adding value
signal load : std_logic_vector(31 downto 0);

begin
temp <= "00000000000000000000000011111111"; -- byte operation
tentwofour <= "00000000000000000000010000000000"; -- 1024

--we make the process to see if we need to give a 
process(ByteOp, MEM_DataIn, MM_RdData, temp)
	begin
		if (ByteOp = '0') then -- if the byteOp is zero means that i just need to push the whole info in the memory and then the memory decides what to do with it 
			mmwrite <= MEM_DataIn;
			load <= MM_RdData;
		else -- this means that we have a byte and that means that i have to zerofill the input from 31 to 8 and keep the rest of the inputs 
			-- so i need to take the datain and keep only the last 8 digits
			mmwrite <= MEM_DataIn AND temp;
			load <= MM_RdData and temp;
		end if;
end process;



-- in the end i have to pass the mmwrite in the mm data
MM_WrData <= mmwrite;
MEM_DataOut <= load;


-- the first thing that we need to do is to set up the right address
MM_Addr <= ALU_MEM_Addr + tentwofour;
end Behavioral;

