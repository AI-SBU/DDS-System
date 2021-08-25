-------------------------------------------------------------------------------
--
-- Title       : SquareWave
-- Design      : DDS_with_Frequency_Selection
-- Author      : Asif
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Asif\OneDrive\SBU\Fifth Semester\ESE382\Labs\lab10\src\SquareWave.vhd
-- Generated   : Wed May  1 03:16:36 2019
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library ieee;	
use ieee.std_logic_1164.all;	
use ieee.numeric_std.all;

entity sqwave is	
	generic (
		a : positive := 6;
		m : positive := 7 
		);
		
	port(
	clk : in std_logic;
	rst_bar : in std_logic; 
	d : in std_logic_vector(a-1 downto 0);
	q : out	 std_logic
	);

end sqwave;

architecture squareWavy of sqwave is
signal count : integer range  0 to 2**a - 1; 
signal high : std_logic;
begin
	process(clk, rst_bar)
	variable halfway : std_logic_vector(a-1 downto 0);
	begin 
		if rst_bar = '0' then
			count <= 0;
			high <= '0';
			halfway := (others => '1');
			halfway := halfway(0) & halfway(a-1 downto 1);
		elsif rising_edge(clk) then	
			if count + to_integer(unsigned(d)) >= 2**a then
				count <= 0;
				high <= '1';
			else 
				count <= count + to_integer(unsigned(d)); 
				high <= '0';
				end if;
			end if;	   
		q <= high;
	end process; 

end squareWavy;	
