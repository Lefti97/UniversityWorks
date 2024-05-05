b = [1 1 1];             % Αριθμητής
a = poly([0 -0.4 -0.5]); % Απλοποιημένος παρανομαστής

[r, p, c] = residue(b, a); % Βρίσκουμε τα απλά κλάσματα της συνάρτησης

%  Εκτύπωση των απλών κλασμάτων
fprintf('X(z) = ');
for i = 1:length(r)
    if p(i) < 0
        str = '(z+' + string(-p(i)) + ')';
    elseif p(i) > 0
        str = '(z-' + string(p(i)) + ')';
    else
        str = 'z';
    end
    fprintf('(%f/%s)', r(i), str);
    if i ~= length(r)
       fprintf(' + ');
    end
end
