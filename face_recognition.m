function [min_dist output_img_index] = face_recognition(image_path, m, A, eigenfaces, pr_img)
  %TODO
  % citesc o matrice de test
  testMatrix = double(rgb2gray(imread(image_path)));
  vect = [];
  [lineNo colNo] = size(testMatrix);
  
  % construiesc in vector coloana cu valorile matricei
  for i = 1 : lineNo
    for j = 1 : colNo
      vect = [vect; testMatrix(i, j)];
    endfor
  endfor
  % calculez proiectia imaginii de test
  M = vect - m;
  PrTestImg = eigenfaces' * M;
  
  [lineNo colNo] = size(pr_img);
  % initializez distanta minima cu Inf si indexul cu 0, apoi calculez
  % distanta minima parcurgand coloanele matricei
  min_dist = Inf;
  output_img_index = 0;
  for i = 1 : colNo
    dist = norm(PrTestImg(:, 1) - pr_img(:, i));
    if dist < min_dist
      min_dist = dist;
      output_img_index = i;
    endif
  endfor
end