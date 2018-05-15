% Funkcija Z = interpolationFunction(data, len) vrne len x len enakomerno
% razporejenih vrednosti funkcije v kvadratu [0,1]x[0,1]
%
% Data je 3D matrika, ki vsebuje vrednosti funkcije ter njenih parcialnih
% odvodov za vsa 4 oglisca kvadrata, kjer prva dimenzija predstavlja y indeks,
% druga dimenzija x indeks, tretja dimenzija pa ima na prvem mestu vrednost,
% na drugem parcialni odvod funkcije po x, na tretjem pa parcialni odvod po y 
%
% Avtor: Rok Cej
function Z = interpolationFunction(data, len)
  % Polinom
  p = @(x) 2*x^3 + -3*x^2 + 1;
  
  % Utezi
  wa = @(x,y) p(x)*p(y);
  wb = @(x,y) (1-p(x))*p(y);
  wc = @(x,y) p(x)*(1-p(y));
  wd = @(x,y) (1-p(x))*(1-p(y));
  
  % Pomozne funkcije  
  fa = @(x,y) data(1,1,1) + data(1,1,2)*x + data(1,1,3)*y;
  fb = @(x,y) data(1,2,1) + data(1,2,2)*(x-1) + data(1,2,3)*y;
  fc = @(x,y) data(2,1,1) + data(2,1,2)*x + data(2,1,3)*(y-1);
  fd = @(x,y) data(2,2,1) + data(2,2,2)*(x-1) + data(2,2,3)*(y-1);
  
  % Funkcija f
  f = @(x,y) fa(x,y)*wa(x,y) + fb(x,y)*wb(x,y) + fc(x,y)*wc(x,y)+ fd(x,y)*wd(x,y);
  
  Z = zeros(len, len);
  for i = 1:len % y indices
    for j = 1:len % x indices
      x = (j-1)/(len-1);
      y = (i-1)/(len-1);
      Z(i, j) = f(x, y);
    endfor
  endfor
endfunction
