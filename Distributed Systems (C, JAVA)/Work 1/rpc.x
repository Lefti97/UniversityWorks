struct nX{
    int n;
    int X<>;
};

struct nXY{
    int n;
    int X<>;
    int Y<>;
};

struct nXYr{
    int n;
    int X<>;
    int Y<>;
    float r;
};

struct float_array{
    float arr<>;
};

program xMeasure_PROG{
    version xMeasure_VERS{
        float xMeasure(nX) = 1;
    } = 1;
} = 0x20000000;

program xyInnerProd_PROG{
    version xyInnerProd_VERS{
        int xyInnerProd(nXY) = 1;
    } = 1;
} = 0x20001000;

program xyAvg_PROG{
    version xyAvg_VERS{
        struct float_array xyAvg(nXY) = 1;
    } = 1;
} = 0x20002000;

program xyRProd_PROG{
    version xyRProd_VERS{
        struct float_array xyRProd(nXYr) = 1;
    } = 1;
} = 0x20003000;