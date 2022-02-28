function yV = zscoreTransform(xV)
    xV=xV(:);
    mx=mean(xV);
    xsd=std(xV);
    yV=(xV-mx)/xsd;
end

