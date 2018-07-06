close all
clear all
clc

%% initialize variables - You can play around with these
% complexity of this implementation is O(nkpd), where n = loops, k =
% centroids, p = points, d = dimensionality

% how many points to generate (default 1000)
points = 1000;

% how many centroids you want (default 4)
k_centroids = 4;

% the maximum number of loops to run the algorithm (default 10000)
loops = 10000;

% The next variables will manually group the points into 4 clusters
% how much you want to spread the clusters (values must be >= 1)
bot_right_spread = 2; % this will shift a bunch of points to the bottom right
top_left_spread = 2; % this will shift a bunch of points to the top left
top_right_spread = 2; % this will shift points to the top right

% density of each cluster (must be between 0 and 1 and add to <= 1)
bot_right_density = 0.25; % how dense you want the bottom right cluster to be
top_left_density = 0.25; % how dense you want the top left cluster to be
top_right_density = 0.25; % how dense you want the top right cluster to be

%% Initialize the variables using your settings

%generate the points
P = (randn(points, 2)+10).* 10;
[n, m] = size(P);
Gprev = zeros(1, n);

%separate the points
for i=1:n
    x = rand;
    if x <= bot_right_density
        P(i, 1) = P(i,1) * bot_right_spread;
    end
    if x > bot_right_density && x <= bot_right_density + top_left_density
        P(i, 2) = P(i, 2) * top_left_spread;
    end
    if x > bot_right_density + top_left_density && x <= bot_right_density + top_left_density + top_right_density
        P(i, :) = P(i, :) .* top_right_spread;
    end
end

% randomly select the centroids
C = zeros(k_centroids, 2);
centroids = randperm(points, k_centroids);
for k = 1:k_centroids
    C(k,:) = P(centroids(k), :);
end

%% perform the k-means algorithm
for loop = 1:loops
    update = 0;
    [G, D] = deal(Inf(1, n));
    %for each centroid
    for k = 1:k_centroids
        % for each point
        for i = 1:n
            % calculate the distance between the current centroid and the point
            temp = sqrt(sum((C(k, :) - P(i, :)) .^ 2));
            
            %if this distance is smaller than the current distance
            if temp < D(i)
                
                %save this distance as the current distance
                D(i) = temp;
                %group this point into the current cluster
                G(i) = k;
            end
        end
    end
    
    %if the clusters of the points have not changed, then break
    if isequal(G, Gprev)
        break
    end
    Gprev = G;
    
    %update the centroids
    %for every centroid
    for k = 1:k_centroids
        %move the centroid to the mean of every point in its group
        
        %first, take the sum of all the points in the cluster
        %and count the number of points in the cluster as well
        count = 0;
        total = zeros(1,2);
        for i = 1:n
            if G(i) == k
                total = total + P(i, :);
                count = count + 1;
            end
        end
        
        %take the average of the total points and move the centroid there
        %the count>0 clause is just there to avoid dividing by zero and
        %will likely not be activated ever but it is good to have
        if count > 0
            C(k, :) = total ./ count;
        end
    end
end

%% plot it
grid on
hold on

scatter(P(:, 1), P(:, 2), 15, G, 'filled')
scatter(C(:, 1), C(:, 2), 50, [1,0,0], 'filled', 'd')