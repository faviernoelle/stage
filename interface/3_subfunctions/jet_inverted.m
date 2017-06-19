function G =  jet_inverted(m)

% Same as jet with color inverted (high value = blue, low values = red)


% Same code as jet 
if nargin < 1
   m = size(get(gcf,'colormap'),1);
end
n = ceil(m/4);
u = [(1:1:n)/n ones(1,n-1) (n:-1:1)/n]';
g = ceil(n/2) - (mod(m,4)==1) + (1:length(u))';
r = g + n;
b = g - n;
g(g>m) = [];
r(r>m) = [];
b(b<1) = [];
J = zeros(m,3);
J(r,1) = u(1:length(r));
J(g,2) = u(1:length(g));
J(b,3) = u(end-length(b)+1:end);

% Modification to invert the color
G=zeros(m,3) ;
for i=1:length(J)
    G(i,:) = J(end-i+1,:) ;
end




