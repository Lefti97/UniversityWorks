LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all ;

ENTITY shift4 IS
PORT ( 
D : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
Enable : IN STD_LOGIC ;
Load : IN STD_LOGIC ;
Sin : IN STD_LOGIC ;
Clock : IN STD_LOGIC ;
Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) ) ;
END shift4 ;

architecture behavioural of shift4 is
    SIGNAL Qt : STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
    PROCESS (Clock)
    BEGIN
        IF rising_edge(Clock) THEN
            IF Load = '1' THEN
                Qt <= D ;
            ELSIF Enable = '1' THEN
                Qt(0) <= Qt(1);
                Qt(1) <= Qt(2);
                Qt(2) <= Qt(3);
                Qt(3) <= Sin;
            END IF ;
        END IF ;
    END PROCESS;
    Q <= Qt;
end behavioural;