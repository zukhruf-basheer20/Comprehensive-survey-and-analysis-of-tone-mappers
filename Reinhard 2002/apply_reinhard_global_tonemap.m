function result = apply_reinhard_global_tonemap(hdr_map, a)     % Consider adding white.
    fprintf('== Applying Reinhard Global Tonemap (a = %.3f) ==\n', a);
    % Constants.
    [height, width, num_channels] = size(hdr_map);
    num_pixels = height * width;
    delta = 0.0001;
    luminance_map = compute_luminance_map(hdr_map);

    % Compute the key of the image.
    %        1
    % key = --- exp{\sum_{x,y} (log(delta + L_{w}(x, y)))}
    %        N
    
    key = exp((1 / num_pixels) * sum(sum(log(delta + luminance_map))));     

   
    scaled_luminance = (a / key) * luminance_map;

    
    display_luminance = scaled_luminance ./ (1 + scaled_luminance);

    % Get the final image.
    result = apply_tonemap(hdr_map, luminance_map, display_luminance);
end