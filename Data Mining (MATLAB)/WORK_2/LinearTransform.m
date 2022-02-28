function yV = LinearTransform(xV)
    xV=xV(:);
    xmin=min(xV);
    xmax=max(xV);
    d=xmax-xmin;
    yV=(xV-xmin)/d;
end

