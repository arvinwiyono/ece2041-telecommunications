function y = image_coding(img_path, t)

% Read image
gray_image = imread(img_path);
% imshow(gray_image);

% Perform segmentation
[width, height] = size(gray_image);
loop = width/8;

if width == height
    string = strcat('Width and height are equal. Divide picture into: ', int2str(loop), 'x', int2str(loop), ' blocks of 64 pixels!');
    disp(string);
    param(1:1, 1:loop) = 8;
    blocks = mat2cell(gray_image, param, param);
else
    error('Width and height must be equal!');
end

threshold = t;

% Run dct2 algorithm on every blockB{}
[width, height] = size(blocks);
for i = 1:width
   for j = 1:height
      current = blocks{i,j};
      current = dct2(current);
      current(abs(current) < threshold) = 0;
%       Convert it back using inverse dct2
      blocks{i,j} = idct2(current);
   end
end

compressed = cell2mat(blocks);

% Display original and compressed pictures
% Now try to run inverse dct2
figure('Name', 'Original Picture');
imshow(gray_image);
figure('Name', 'Compressed Picture');
imshow(compressed, [0 255]);
y = 1;