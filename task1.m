function A_k = task1(image, k)
  %TODO
  % citesc imaginea sub forma de matrice
  imgMatrix = double(imread(image));
  
  % aplic functia de descompunere a valorilor singulare
  [U S V] = svd(imgMatrix);
  [lineNo colNo] = size(S);
  % se compreseaza imaginea in functie de valoarea lui k
  SAux = S;
  SAux(k + 1 : lineNo, :) = 0;
  SAux(:, k + 1 : colNo) = 0;
  
  % compunerea lui A_k
  A_k = U * SAux * V';
end