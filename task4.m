function [A_k S] = task4(image, k)
  %TODO
  miu = [];
  
  % citesc imaginea sub forma de matrice
  A = double(imread(image));
  
  [lineNo colNo] = size(A);
  
  % calculez media fiecarei linii si o pun intr-un vector nou
  % modific coloanele matricei in functie de miu obtinut la pasul curent
  for i = 1 : lineNo
    miu_i = mean(A(i, :));
    miu = [miu; miu_i];
    A(i, :) = A(i, :) - miu_i;
  endfor
  
  % obtin matricea Z si aflu valorile ei singulare
  Z = (1 / (colNo - 1)) * A * A';
  [V S] = eig(Z);
  % initializez o noua matrice W si adaug primele k valori din V in aceasta
  W = zeros(lineNo, k);
  for i = 1 : k
    W(:, i) = V(:, i);
  endfor
  
  % calculez Y si, respectiv, A_k
  Y = W' * A;
  A_k = W * Y + miu;
endfunction