%clear
i = 1;
ampdif = zeros(64, 1); angdif = zeros(64, 1); locdif = zeros(64, 1);
for i = 1:16
    load(strcat('thalamus_source',int2str(i),'.mat'))
    ampdif(i,:) = amplitude_difference(50);
    angdif(i,:) = angle_difference(50);
    locdif(i,:) = location_difference(50);
    clear('amplitude_difference', 'angle_difference', 'location_difference');
end

j = 0;
for i = 17:2:32
        load(strcat('thalamus_source',int2str(i - j),'.mat'))
        ampdif(i,:) = amplitude_difference(50);
        ampdif(i+1,:) = amplitude_difference(50);
        angdif(i,:) = angle_difference(50);
        angdif(i+1,:) = amplitude_difference(50);
        locdif(i,:) = location_difference(50);
        locdif(i+1,:) = amplitude_difference(50);
        j = j + 1;
        clear('amplitude_difference', 'angle_difference', 'location_difference');
end

for i = 33:48
    load(strcat('thalamus_source',int2str(i - 8),'.mat'))
    ampdif(i,:) = amplitude_difference(50);
    angdif(i,:) = angle_difference(50);
    locdif(i,:) = location_difference(50);
    clear('amplitude_difference', 'angle_difference', 'location_difference');
end

j = 0;
for i = 49:2:64
    load(strcat('thalamus_source',int2str(i - 8 - j),'.mat'))
    ampdif(i,:) = amplitude_difference(50);
    ampdif(i+1,:) = amplitude_difference(50);
    angdif(i,:) = angle_difference(50);
    angdif(i+1,:) = amplitude_difference(50);
    locdif(i,:) = location_difference(50)
    locdif(i+1,:) = amplitude_difference(50);
    j = j + 1;
    clear('amplitude_difference', 'angle_difference', 'location_difference');
end

beta = 1.5;
theta0 = [10^-5, 10^-9];
hyperprior = [1, 2];
noise = [0.02, 0.05];
Theta0 = zeros(64,1);
Hyperprior = zeros(64,1);
Beta = repmat(beta, 64,1);
Noise = zeros(64,1);
datatype(1:32,1) = 1;
datatype(33:64,1) = 2;
syn = zeros(64, 1);
for i = 1:32:33
    syn(i:i+7,:) = 1;    
    syn(i+8:i+15,:) = 2;
end    
for i = 1:2:15  
    syn(i+16,:) = 3;
    syn(i+17,:) = 4;
    syn(i+48,:) = 3;
    syn(i+49,:) = 4;
end
for i = 1:8:57
    Theta0(i:i+3,:) = repmat(theta0(1), 4, 1);
    Theta0(i+4:i+7,:) = repmat(theta0(2), 4, 1);
end
for i = 1:4:61
    Hyperprior(i:i+1,:) = repmat(hyperprior(1), 2, 1);
    Hyperprior(i+2:i+3,:) = repmat(hyperprior(2), 2, 1);
end
for i = 1:2:63
    Noise(i,:) = noise(1);
    Noise(i+1,:) = noise(2);
end
% 1. amplitude difference, 2. angle difference, 3. location difference, 4.Beta 
% 5. Hyperprior(1. gamma 2. inverse gamma) 6. Noise(0.02 0.05) 7. localization (1. thalamus 2. somatosensory 3. thalamus_pair 4. somatosensory_pair)
X2 = [ampdif(:), angdif(:), locdif(:), Beta(:), Hyperprior(:), Noise(:), syn(:)];
Y2 = Theta0(:);
% load('X');
% load('Y');
data2 = [X2,Y2];
Y21 = X2(:,7);
Y22 = X2(:,5);
Y23 = X2(:,6);
