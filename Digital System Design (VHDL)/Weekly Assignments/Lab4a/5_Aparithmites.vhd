LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all ;

ENTITY upcount IS PORT (
Clear, Clock : IN STD_LOGIC ;
Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END upcount ;

architecture behavioral of upcount is
    signal count: STD_LOGIC_VECTOR(1 DOWNTO 0);
begin
    process(Clear,Clock)
    begin
        if Clear = '1' then
            count <= "00";
        elsif Clock 'event and Clock = '1' then
            count <= count + 1;
        end if;
    end process;
    Q <= count;
end behavioral;