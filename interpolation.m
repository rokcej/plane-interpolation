% Funkcija interpolation(V, len) izrise podatke iz matrike V (indeksi vrstic
% predstavljajo y vrednosti, indeksi stolpcev pa x vrednosti) in nato izrise
% se sliko interpolacijske ploskve, kjer je vsak kvadrat iz mreze matrike V
% razdeljen na len x len tock
%
% Avtor: Rok Cej
function interpolation(V, len)
  % Velikost matrike V
  [n, m] = size(V);
  % Velikost interpolacijske matrike
  nInt = (n-1)*(len-1) + 1; 
  mInt = (m-1)*(len-1) + 1;
  
  % Vrednosti X in Y
  X = linspace(1, m, mInt);
  Y = linspace(1, n, nInt);
  % Pripravimo matriko Z
  Z = zeros(nInt, mInt);
  
  % 3D matrika data hrani vrednosti funkcije ter njenih parcialnih odvodov
  % po x ter y za vse tocke iz matrike V
  data = zeros(n, m, 3);
  for i = 1:n % y
    for j = 1:m % x
      % Vrednost
      data(i, j, 1) = V(i, j);
      
      % Parcialni odvod po x
      if (j < m && j > 1) % Splosni primer
        data(i, j, 2) = (V(i, j+1) - V(i, j-1))/2;
      elseif (j < m) % Robna tocka
        data(i, j, 2) = V(i, j+1) - V(i, j);
      elseif (j > 1) % Robna tocka
        data(i, j, 2) = V(i, j) - V(i, j-1);
      endif
      
      % Parcialni odvod po y
      if (i < n && i > 1) % Splosni primer
        data(i, j, 3) = (V(i+1, j) - V(i-1, j))/2;
      elseif (i < n) % Robna tocka
        data(i, j, 3) = V(i+1, j) - V(i, j);
      elseif (i > 1) % Robna tocka
        data(i, j, 3) = V(i, j) - V(i-1, j);
      endif
    endfor
  endfor
  
  % Izracun interpoliranih podatkov
  for i = 1:n-1
    for j = 1:m-1
      % Indeks kvadrata, ki ga bomo interpolirali
      iInt = (i-1)*(len-1) + 1;
      jInt = (j-1)*(len-1) + 1;
      
      Z(iInt:iInt+len-1, jInt:jInt+len-1) = interpolationFunction(data(i:i+1, j:j+1, :), len);
    endfor
  endfor
  
  % Min in max vrednosti na z osi za lepsi izris
  zMin = min(min(min(V)), min(min(Z))) - 1;
  zMax = max(max(max(V)), max(max(Z))) + 1;
  
  % Izris originalnih podatkov
  figure(1);
  clf;
  surf(V);
  axis([1, m, 1, n, zMin, zMax]);
  
  % Izris interpoliranih podatkov
  figure(2);
  clf;
  surf(X, Y, Z);
  axis([1, m, 1, n, zMin, zMax]);
endfunction
