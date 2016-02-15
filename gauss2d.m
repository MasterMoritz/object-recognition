% 2d gaussian
function mat = gauss2d(gsize, sigma, center)
[R,C] = ndgrid(1:gsize(1), 1:gsize(2));
mat = gaussC(R,C, sigma, center);

% compute the gaussian
function val = gaussC(x, y, sigma, center)
xc = center(1);
yc = center(2);
exponent = ((x-xc).^2 + (y-yc).^2)./(2*sigma);
val       = (exp(-exponent));
