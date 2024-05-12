function weights = compute_weights()
    fprintf('== Computing weights ==\n');
    weights = 1:256;
    weights = min(weights, 256 - weights);
end