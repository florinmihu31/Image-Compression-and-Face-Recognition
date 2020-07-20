function task5()
  %TODO
  A = double(imread(image));
  [lineNo colNo] = size(A);
  k = [1 : 19, 20 : 20 : 99, 100 : 30 : min(lineNo, colNo)];
  
  % Primul grafic
  [A_k S] = task3(image, k);
  values = diag(S);
  figure;
  plot(values);
  
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
  comprRate = [];
  
  for i = 1 : length(k)
    comprRate = [comprRate (2 * k(i) + 1) / colNo];
  endfor
  
  figure(4);
  plot(k, comprRate);
end