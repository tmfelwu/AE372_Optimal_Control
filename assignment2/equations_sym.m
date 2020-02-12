syms a M g Sw Cl Cd gamma Tw alpha lambda1 lambda2 lambda3 lambda4 t 
denom = Sw * M^2 * Cl - cos(gamma) + Tw * sin(alpha);
H = (a * M) / (g* denom) + lambda1 * M  *((- Sw * M^2 * Cd - sin(gamma) + Tw* cos(alpha))/denom) ...
    + (lambda2 * a* M) /(g *denom) ...
    + (lambda3 * a^2 * M^2 * sin(gamma))/(g * denom) ...
    + (lambda4 * a^2 * M^2 * cos(gamma))/(g * denom);

diff(H,M)
diff(H,t)
diff(H,lambda1)
diff(H,lambda2)
diff(H,alpha)