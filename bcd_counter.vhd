Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bcd_counter1 is
  port(EN, LD, UP, CLR, CLK : in std_logic;
       D		: in std_logic_vector(3 downto 0);
       CO		: out std_logic;
       Q		: out std_logic_vector(3 downto 0));
end bcd_counter1;

architecture Equations of bcd_counter1 is
  -- Signal to hold the integer count
  signal COUNT : unsigned(3 downto 0); 
  signal Co_tmp : std_logic := '0';
  signal input : std_logic_vector(1 downto 0);
begin
  -- Initialize carry out
  -- concat LD and EN into single input
  input <= LD&EN;
  process(CLK, CLR) 
  begin 
    -- Check for CLR and reset counter async.
    if(CLR = '0') then
      COUNT <= to_unsigned(0, COUNT'length);
    end if;
    
    if(CLK'EVENT and CLK='1') then

      if(input="11") then -- load
        COUNT <= unsigned(D); -- load
      elsif(input="01" and UP='1') then -- increment
        if(COUNT=9) then
          COUNT <= to_unsigned(0, COUNT'length);
          Co_tmp <= '1';
        else
          COUNT <= COUNT+1;
          Co_tmp <= '0';
        end if;
      elsif(input="01" and UP='0') then -- decrement
        if(COUNT=0) then
          COUNT <= to_unsigned(9, COUNT'length);
          Co_tmp <= '1';
        else
          COUNT <= COUNT-1;
          Co_tmp <= '0';
        end if;
      end if;
	
    end if;

    end process;
    Q <= std_logic_vector(COUNT);
    CO <= Co_tmp;
end Equations;
