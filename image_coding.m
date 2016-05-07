% Parameters:
% imgpath - path to image. E.g. 'Desktop\test.jpg'
% thres - the quantization threshold. Any values within a block that are less than thres will be set to zero
% block_size - dividing the picture into blocks of (block_size^2) pixels. The values are typically: 2, 4, 8, 16, 32, 64, etc.

function y = image_coding(imgpath, thres, block_size)

% Validate block size
if mod(block_size, 2) > 0 
    error('block_size must be 2^n!');
end

% Read image
try
    % If image is RGB
    gray_image = rgb2gray(imread(imgpath));
catch
    % If image is already gray
    gray_image = imread(imgpath);
end
  
% Get width and height of image
[width, height] = size(gray_image);

% Validate width and height
if width ~= height
    error('Width and height must be equal!');
end

% Validate that picture is divisible by block_size
if mod(width, block_size) == 0
    loop = width/block_size;
else
    error(strcat('Width or height of picture is not divisible by (', int2str(block_size), ')!'));
end

% Perform segmentation
string = strcat('Divide picture into: (', int2str(loop), 'x', int2str(loop), ') blocks of (', int2str(block_size.^2),') pixels!');
disp(string);
param(1:1, 1:loop) = block_size;
blocks = mat2cell(gray_image, param, param);

% Set threshold
threshold = thres;

tic;
[width, height] = size(blocks);
for i = 1:width
   for j = 1:height
      % Run dct2 algorithm on every block{}
      current = blocks{i,j};
      current = dct2(current);
      
      % Quantize with threshold
      current(abs(current) < threshold) = 0;
      
      % Convert it back using inverse dct2
      blocks{i,j} = idct2(current);
   end
end

compressed = cell2mat(blocks);
toc; % Measure elapsed time to carry out compression

% Display original and compressed pictures
figure('Name', 'Original Picture');
imshow(gray_image);
figure('Name', 'Compressed Picture');
imshow(compressed, [0 255]);

% Write compressed picture
imwrite(compressed, gray, 'compressed.jpg');

y = 1;
