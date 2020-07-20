function [m A eigenfaces pr_img] = eigenface_core(database_path)
  %TODO
  % citesc directorul dat ca parametru si retin numarul imaginilor citite
  images = readdir(database_path);
  images = images(3 : end);
  count = length(images);
  T = [];
  
  % parcurg fiecare poza din director
  for i = 1 : count
    path = strcat(database_path, '/', int2str(i), '.jpg');
    image = double(rgb2gray(imread(path)));
    [lineNo colNo] = size(image);
    % construiesc vectorul coloana cu fiecare valoare a matricei
    vect = [];    
    for j = 1 : lineNo
      for k = 1 : colNo
        vect = [vect; image(j, k)];
      endfor
    endfor
    % construiesc matricea T
    T(:, i) = vect;
  endfor
  
  [lineNo colNo] = size(T);
  % construiesc vectorul mediilor aritmetice
  m = [];
  for i = 1 : lineNo
    m = [m; mean(T(i, :))];
  endfor
  
  A = T - m;
  % construiesc o matrice auxiliara si aplic DVS pe aceasta
  aux = A' * A;
  [U S Vaux] = svd(aux);
  [p q] = size(S);
  V = [];
  col = 1;
  % construiesc o matrice V ce contine vectorii proprii corespunzatori valorilor
  % proprii mai mari decat 1
  for i = 1 : p
    if S(i, i) > 1
      V(:, col) = Vaux(:, i);
      col = col + 1;
    endif
  endfor
  
  % calculez matricea de proiectii ale imaginilor
  eigenfaces = A * V;
  pr_img = eigenfaces' * A;
end