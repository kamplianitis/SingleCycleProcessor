----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:50:23 04/23/2020 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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



-- in general 
-- PC_sel: 0: pc = pc + 4   1:pc = pc + 4 + (SignExtend(Imm) << 2)
-- PC_LdEn : control signal for pc change
-- ImmExt: control signal for immidiate
-- 	   00: zero fill
-- 	   01: shift left and zero fill
--     10: sign extend
-- 	   11: shift left 2 bit and sign extend	  	 		
-- RF_WrEn: RF write enable
-- RF_WrData_sel: what RF writes
--             0: ALU 
--             1: MEMORY 
-- RF_B_sel: second address input for RF 
--        0: rt(Instr(15-11))
--        1: rd(Instr(20-16))
-- ALU_Bin_sel: second input of ALU
--           0: RF_B
--           1: Immed
-- ALU_func: funcion of ALU 
-- ByteOp: 0:byte 1:word 
-- Mem_WrEn: control signal for mrmory write

entity Control is
	port 
		(
			-- inputs 
			Rst : in std_logic;
			Clk : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			ALU_zero : in std_logic;
			-- outputs
			PC_sel : out std_logic;
			PC_LdEn : out std_logic;
			ImmExt : out std_logic_vector(1 downto 0);
			RF_WrEn : out std_logic;
			RF_WrData_sel : out std_logic;
			RF_B_sel : out std_logic;
			ALU_Bin_sel : out std_logic;
			ALU_func: out std_logic_vector(3 downto 0);
			ByteOp : out std_logic;
			Mem_WrEn : out std_logic
		);
end Control;

architecture Behavioral of Control is

type state is(resetstate, checkstate);
signal curstate, nextstate : state;

begin

	process(curstate, Instr , ALU_zero, nextstate)
		begin -- begin the fsm structure with the reset state that will keep up until the reset be gone
			case curstate is 
				when resetstate =>
					PC_sel <= '0';
					PC_LdEn <= '0';
					ImmExt <="00";
					RF_WrEn <='0';
					RF_WrData_sel <= '0';
					RF_B_sel <= '0';
					ALU_Bin_sel <='0';
					ALU_func <= "0000";
					ByteOp <='0';
					Mem_WrEn <= '0';
					nextstate <= checkstate;
				when checkstate => -- checks the instruction that we take case we dont have reset enabled
					if(Instr(31 downto 26) = "100000") then -- that means that we have to check the fucntion bacause we are in AlU
						PC_sel <= '0'; -- it's the same for every func in that case
						PC_LdEn <= '1'; -- we always want to write in the Pc reg
						ImmExt <="00"; -- we just make 16 bits of zero 32 bits of zero
						RF_WrEn <='1'; -- we have to write in the registers
						RF_B_sel <= '0'; -- rt register 
						RF_WrData_sel <= '0'; -- all the data comes from ALU
						ALU_Bin_sel <='0'; -- we need always the RF_B when we are in ALU
						ByteOp <='0';  -- we dont care about it
						Mem_WrEn <= '0'; -- we don't mess up with the memory in that stage
						if(Instr(5 downto 0) = "110000") then -- check the func
							ALU_func <= "0000"; -- add case
						elsif Instr(5 downto 0) = "110001" then 
							ALU_func <= "0001"; -- sub case
						elsif Instr(5 downto 0) = "110010" then 
							ALU_func <= "0010"; -- and case
						elsif Instr(5 downto 0) = "110011" then 
							ALU_func <= "0011"; -- or case
						elsif Instr(5 downto 0) = "110100" then 
							ALU_func <= "0100"; -- not case 
						elsif Instr(5 downto 0) = "110101" then 
							ALU_func <= "0101"; -- nand case
						elsif Instr(5 downto 0) = "110110" then 
							ALU_func <= "0110"; -- nor case 
						elsif Instr(5 downto 0) = "111000" then 
							ALU_func <= "1000"; -- sra case
						elsif Instr(5 downto 0) = "111001" then 
							ALU_func <= "1001"; -- srl
						elsif Instr(5 downto 0) = "111010" then 
							ALU_func <= "1010"; -- sll
						elsif Instr(5 downto 0) = "111100" then 
							ALU_func <= "1100"; -- rol
						elsif Instr(5 downto 0) = "111101" then 
							ALU_func <= "1101"; --ror 
						else
							nextstate <= checkstate;
						end if;
						nextstate <= checkstate;
					elsif Instr(31 downto 26) = "111000" then -- li
						PC_sel <='0'; -- pc +4 
						PC_LdEn <='1'; -- always want to to next instruction
						ImmExt <="10"; -- sign extend
						RF_WrEn <='1'; -- we want to write in the rf
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- dont care basically 
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "1111"; -- 1111 for Rf B
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; -- we don't use memory
					elsif Instr(31 downto 26) = "111001" then -- lui			
						PC_sel <='0'; -- pc +4 
						PC_LdEn <='1';  --  always want to to next instruction
						ImmExt <="01"; -- shift left and zero filling 
						RF_WrEn <='1'; -- wanna write to the registers
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- dont care cause we will take the immediate
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "1111"; -- 1111 for Rf B
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
					elsif Instr(31 downto 26) = "110000" then -- addi		
						PC_sel <='0'; -- pc +4 
						PC_LdEn <='1'; -- always want to to next instruction
						ImmExt <="10"; -- sign extend
						RF_WrEn <='1'; -- wanna write to the registers
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- dont care
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "0000"; -- add
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
					elsif Instr(31 downto 26) = "110010" then -- nandi 	
						PC_sel <='0'; -- pc +4
						PC_LdEn <='1'; -- always want to to next instruction
						ImmExt <="00"; -- zero filling
						RF_WrEn <='1'; -- wanna write to the registers
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- dont care
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "0101"; -- NAND
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
					elsif Instr(31 downto 26) = "110011" then -- ori 	
						PC_sel <='0'; -- no extend
						PC_LdEn <='1'; -- no pc 
						ImmExt <="00"; -- zero filling
						RF_WrEn <='1'; --
						RF_WrData_sel <= '0'; -- memory only for load
						RF_B_sel <= '1'; -- dont care
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "0011"; -- OR
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
					elsif Instr(31 downto 26) = "111111" then -- b 	
						-- we dont want to write alu out on memory
						PC_sel <='1'; -- pc + 4 + Imm
						PC_LdEn <='1'; -- always want to to next instruction
						ImmExt <="11"; -- shift left 2 and  sign extend
						RF_WrEn <='0'; -- we dont use RF
						RF_WrData_sel <= '0'; -- dont care
						RF_B_sel <= '0'; -- dont care
						ALU_Bin_sel <= '1'; -- immediate
						ALU_func <= "0000"; --
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
					elsif Instr(31 downto 26) = "000000" then -- beq
						PC_LdEn <='1'; -- 
						ImmExt <="11"; -- shift left 2 and  sign extend
						RF_WrEn <='0'; -- we just want to make a comparison 
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- rd
						ALU_Bin_sel <= '0'; -- immediate
						ALU_func <= "0001"; -- '-'
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --

						if ALU_zero = '0' then
							 PC_sel <='0'; --  pc = pc + 4 
						else 
							 PC_sel <='1'; -- pc = pc + 4 + (SignExtend(Imm) << 2)
						end if;
					elsif Instr(31 downto 26) = "000001" then -- bne
						PC_LdEn <='1'; -- 
						ImmExt <="11"; -- shift left 2 and  sign extend
						RF_WrEn <='0'; -- dont write
						RF_WrData_sel <= '0'; -- ALU
						RF_B_sel <= '1'; -- rd
						ALU_Bin_sel <= '0'; -- to make the comparison
						ALU_func <= "0001"; -- '-'
						ByteOp <= '0'; -- dont care
						Mem_WrEn <= '0'; --
						if ALU_zero = '0' then
							 PC_sel <='1'; -- pc = pc + 4 + (SignExtend(Imm) << 2)
						else 
							 PC_sel <='0'; -- pc = pc + 4
						end if;
				elsif Instr(31 downto 26) = "000011" then -- lb
							PC_sel <='0'; -- 
							PC_LdEn <='1'; -- 
							ImmExt <="10"; --  SignExtend(Imm)
							RF_WrEn <='1'; -- RF writes
							RF_WrData_sel <= '1'; -- load from memory
							RF_B_sel <= '1'; -- rd
							ALU_Bin_sel <= '1'; -- immed
							ALU_func <= "0000"; -- add
							ByteOp <= '1'; -- byte
							Mem_WrEn <= '0'; -- 	

				elsif Instr(31 downto 26) = "000111" then -- sb
							PC_sel <='0'; -- pc = pc 
							PC_LdEn <='1'; -- 
							ImmExt <="10"; --  SignExtend(Imm)
							RF_WrEn <='0'; -- RF wont write
							RF_WrData_sel <= '0'; -- load from ALU
							RF_B_sel <= '1'; -- rd
							ALU_Bin_sel <= '1'; -- immediate
							ALU_func <= "0000"; -- 1111 for RF_B
							ByteOp <= '1'; -- byte
							Mem_WrEn <= '1'; -- store

				elsif Instr(31 downto 26) = "001111" then -- lw
							PC_sel <='0'; -- 
							PC_LdEn <='1'; -- 
							ImmExt <="10"; --  SignExtend(Imm)
							RF_WrEn <='1'; -- RF writes
							RF_WrData_sel <= '1'; -- load from memory
							RF_B_sel <= '1'; -- dont care
							ALU_Bin_sel <= '1'; -- immed
							ALU_func <= "0000"; -- add
							ByteOp <= '0'; -- word
							Mem_WrEn <= '0'; -- 

				elsif Instr(31 downto 26) = "011111" then -- sw
							PC_sel <='0'; -- pc = pc + 4
							PC_LdEn <='1'; -- 
							ImmExt <="10"; --  SignExtend(Imm)
							RF_WrEn <='0'; -- RF wont write
							RF_WrData_sel <= '0'; -- load from ALU
							RF_B_sel <= '1'; -- rd
							ALU_Bin_sel <= '1'; -- RF_B
							ALU_func <= "0000"; --+ 
							ByteOp <= '0'; -- word
							Mem_WrEn <= '1'; -- store
				else 
					nextstate<= checkstate;
				end if;
				nextstate<= checkstate;
		end case;
	end process;
	
	process(Clk,Rst,curstate)
		begin	
				if(Rst ='1') then 
					curstate <= resetstate;
				elsif(Clk' Event and Clk = '1') then 
					curstate <= nextstate;
				else 
					curstate <= curstate;
				end if;
	end process;
end Behavioral;


