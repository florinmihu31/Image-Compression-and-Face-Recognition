function task2()
  %TODO
  A = double(imread(image));
  [lineNo colNo] = size(A);
  k = [1 : 19, 20 : 20 : 99, 100 : 30 : min(lineNo, colNo)];

  % Primul grafic
  [U S V] = svd(A);
   
  [m n] = size(S);
  % algoritm de sortare in ordine descrescatoare
  for i = 1 : min(m ,n) - 1
    for j = i + 1 : min(m, n)
      if S(i, i) < S(j, j)
        tmp = S(i, i);
        S(i, i) = S(j, j);
        S(j, j) = tmp;
      endif
    endfor
  endfor
  figure;
  plot(S);
  
  % Al doilea grafic
  s = 0;
  s1 = 0;
  info = [];
  
  for i = 1 : min(lineNo, colNo)
    s = s + S(i, i);
  endfor
  
  for i = 1 : length(k)
    s1 = 0;
    for j = 1 : k(i)
      s1 = s1 + S(j, j);
    endfor
    info = [info s1 / s];
  endfor
  figure(2);
  plot(k, info);
  
  % Al treilea grafic
  err = [];
  for i = 1 : length(k)
    A_k = task1(image, k(i));
    sum = 0;
    for j = 1 : lineNo
      for l = 1 : colNo
        sum = sum + (A(j, l) - A_k(j, l)) * (A(j, l) - A_k(j, l));
      endfor
    endfor
    err = [err sum / (lineNo * colNo)];
  endfor
  figure(3);
  plot(k, err);
  
  % Al patrulea grafic
  sum = 0;
  comprRate = [];
  
  for i = 1 : length(k)
    sum = lineNo * k(i) + colNo * k(i) + k(i);
    comprRate = [comprRate sum / (lineNo * colNo)];
  endfor
  
  figure(4);
  plot(k, comprRate);
end