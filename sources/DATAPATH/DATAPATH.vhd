----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:47:22 04/21/2020 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
	port
		(
			-- the inputs that we need are the basically the inputs of the first stage so the inputs of the if_stage
			Clk : in std_logic;
			Reset : in std_logic;
			PC_sel : in std_logic;
			PC_LdEn : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			ImmExt : in std_logic_vector(1 downto 0);
			RF_WrEn : in std_logic;
			RF_WrData_sel : in std_logic;
			RF_B_sel : in std_logic;
			ALU_Bin_sel : in std_logic;
			ALU_func: in std_logic_vector(3 downto 0);
			ByteOp : in std_logic;
			Mem_WrEn : in std_logic;
			--MEM_RdData : in std_logic_vector(31 downto 0);
			MM_RdData: in std_logic_vector (31 downto 0);
			Pc_Instr : out std_logic_vector(31 downto 0);
			MM_Addr : out std_logic_vector(31 downto 0);
			ALU_zero: out std_logic;
			MM_WrData: out std_logic_vector(31 downto 0)
		);
end DATAPATH;

architecture Structural of DATAPATH is


-- begining of the structure of datapath
component If_stage
	port
		(
			PC_Immed : in std_logic_vector(31 downto 0);
			PC_sel : in std_logic;
			PC_LdEn : in std_logic;
			Reset : in std_logic;
			Clk : in std_logic;
			Pc : out std_logic_vector(31 downto 0)
		);
end component;

-- we continue with the dec stage. 
component DECSTAGE
Port 
   (
      Instr : in  STD_LOGIC_VECTOR (31 downto 0);
      RF_WrEn : in  STD_LOGIC;
      ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
      MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
      RF_WrData_sel : in  STD_LOGIC;
      RF_B_sel : in  STD_LOGIC;
      ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
      Clk : in  STD_LOGIC;
      Rst : in std_logic;
      Immed : out  STD_LOGIC_VECTOR (31 downto 0);
      RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
		RF_B : out  STD_LOGIC_VECTOR (31 downto 0)
    );
end component;


-- next is the exstage. 
component EXSTAGE
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
end component;


-- last is the memstage that is so fucking idiotic.
component mem_stage
port 
    ( 
			ByteOp : in  STD_LOGIC;
			ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			MM_RdData : in std_logic_vector (31 downto 0);				
			MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
			MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
			MEM_DataOut : out std_logic_vector(31 downto 0)
	);
end component;


-- the signals that we use
-- exstage signals
signal aluout: std_logic_vector (31 downto 0); -- will keep the alu result that we will get in the exstage
--mem stage signal
signal memout: std_logic_vector (31 downto 0); -- signal that comes from the memory 
-- decstagesignals
signal immediate : std_logic_vector (31 downto 0); -- will keep the immiade from the decstage
signal rfa : std_logic_vector (31 downto 0); -- register a 
signal rfb : std_logic_vector (31 downto 0); -- register b

begin



-- now we begin the synthesis

ifstagepart : If_stage
	port map 
			( 
				PC_Immed => immediate, -- comes from DECSTAGE
            PC_sel => PC_sel, -- input (control)
            PC_LdEn => PC_LdEn, -- input (control)
            Reset => Reset,  -- reset
            Clk => Clk, -- clock 
				Pc => Pc_Instr -- output of dp, goes to the ram 
			);
			
decstagepart: DECSTAGE
	port map
			( 
				Instr => Instr, -- input (control)
				RF_WrEn => RF_WrEn, -- input. (control)
				ALU_out => aluout, -- exstage result
				MEM_out => memout, -- memory data out
				RF_WrData_sel => RF_WrData_sel, -- input (control) 
				RF_B_sel => RF_B_sel, --input (control)
				ImmExt => ImmExt, -- input (control)
				Clk => Clk, -- clock 
				Rst => Reset, -- reset
				Immed => immediate, -- goes to if stage and exstage
				RF_A => rfa, -- result of the first register of rf goes to exstage
				RF_B => rfb -- result of the second register of rf goes to exstage and memstage
			);

exstagepart : EXSTAGE
	port map
			(
				RF_A => rfa, -- first register (comes from decstage)
				RF_B => rfb, -- second register (comes from decstage)
				Immed => immediate, -- comes from decstage
				ALU_Bin_sel => ALU_Bin_sel, -- input (control)
				ALU_func => ALU_func, --input(control)
				ALU_out => aluout, -- result of the alu. goes to decstage and memstage
				ALU_zero => ALU_zero -- indication of zero. goes to control as an output
			);

memstagepart : mem_stage
	port map 
			(
				ByteOp => ByteOp,  -- indication of word/byte. input(control)
				ALU_MEM_Addr => aluout, -- comes from exstage and declares the address of the data stage
				MEM_DataIn => rfb, -- input that might be stored in the memory (comes from decstage)
				MM_RdData => MM_RdData, 
				MM_Addr => MM_Addr, -- address that will go to ram (goes as an output to the ram section)
				MM_WrData => MM_WrData, -- output that goes to ram
				MEM_DataOut => memout -- the result of the loaded info that goes to decstage
			);

end Structural;

