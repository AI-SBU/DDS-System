-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : DDS_with_Frequency_Selection
-- Author      : Asif
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Asif\OneDrive\SBU\Fifth Semester\ESE382\Labs\LAB10\lab10\compile\edge_det.vhd
-- Generated   : Wed Apr 24 02:15:26 2019
-- From        : C:\Users\Asif\OneDrive\SBU\Fifth Semester\ESE382\Labs\LAB10\lab10\src\edge_det.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;

entity edge_det is
  port(
       clk : in STD_LOGIC;
       pos : in STD_LOGIC;
       rst_bar : in STD_LOGIC;
       sig : in STD_LOGIC;
       sig_edge : out STD_LOGIC
  );
end edge_det;

architecture edgy of edge_det is

---- Architecture declarations -----
type state is (state_a, state_b, state_c);



---- Signal declarations used on the diagram ----

signal next_state : state;
signal present_state : state;

begin

---- Processes ----

nxt_state : process (present_state,sig)
                       begin
                         if pos = '1' then
                            case present_state is 
                              when state_a => 
                                 if sig = '1' then
                                    next_state <= state_a;
                                 else 
                                    next_state <= state_b;
                                 end if;
                              when state_b => 
                                 if sig = '0' then
                                    next_state <= state_b;
                                 else 
                                    next_state <= state_c;
                                 end if;
                              when state_c => 
                                 if sig = '1' then
                                    next_state <= state_a;
                                 else 
                                    next_state <= state_b;
                                 end if;
                            end case;
                         else 
                            case present_state is 
                              when state_a => 
                                 if sig = '0' then
                                    next_state <= state_a;
                                 else 
                                    next_state <= state_b;
                                 end if;
                              when state_b => 
                                 if sig = '1' then
                                    next_state <= state_b;
                                 else 
                                    next_state <= state_c;
                                 end if;
                              when state_c => 
                                 if sig = '1' then
                                    next_state <= state_b;
                                 else 
                                    next_state <= state_a;
                                 end if;
                            end case;
                         end if;
                       end process;
                      

outputs : process (present_state)
                       begin
                         case present_state is 
                           when state_c => 
                              sig_edge <= '1';
                           when state_a | state_b => 
                              sig_edge <= '0';
                         end case;
                       end process;
                      

state_reg : process (clk,rst_bar)
                       begin
                         if rst_bar = '0' then
                            present_state <= state_a;
                         elsif rising_edge(clk) then
                            present_state <= next_state;
                         end if;
                       end process;
                      

end edgy;
