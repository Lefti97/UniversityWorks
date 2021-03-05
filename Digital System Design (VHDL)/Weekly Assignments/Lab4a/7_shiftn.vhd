LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY shiftn IS
    GENERIC ( N : INTEGER := 8 ) ;
        PORT ( 
            D      : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
            Enable : IN  STD_LOGIC ;
            Load   : IN  STD_LOGIC ;
            Sin    : IN  STD_LOGIC ;
            Clock  : IN  STD_LOGIC ;
            Q      : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
END shiftn ;

ARCHITECTURE behavioral OF shiftn IS
    SIGNAL Qt: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
    PROCESS (Clock)
    BEGIN
        IF rising_edge(Clock) THEN
            IF Load = '1' THEN
                Qt <= D ;
            ELSIF Enable = '1' THEN
                Genbits: FOR i IN 0 TO N-2 LOOP
                    Qt(i) <= Qt(i+1) ;
                END LOOP ;
                Qt(N-1) <= Sin ;
            END IF;
        END IF ;
    END PROCESS ;
    Q <= Qt;
END behavioral;