function result = apply_durand_tonemap(directory, hdr_map, dR, gamma)
    % Compute the intensity by averaging the color channels.
    intensity = mean(hdr_map, 3);

    % Compute the chrominance channels.  (R/I, G/I, B/I)
    red_channel = hdr_map(:,:,1);
    green_channel = hdr_map(:,:,2);
    blue_channel = hdr_map(:,:,3);

    chrominance_red = red_channel ./ intensity;
    chrominance_green = green_channel ./ intensity;
    chrominance_blue = blue_channel ./ intensity;

    % Compute the log intensity.  L = log_{2}(I)
    log_intensity = log2(intensity);    % TODO: Handle cases when intensity is zero!

    % Filter the log intensity with a bilateral filter.  B = bf(L)
    base = apply_bilateral_filter(log_intensity, 5, 15, 15);

    % Compute the detail layer.  D = L - B
    detail_layer = log_intensity - base;

    % Apply an offset and a scale to the base.  B' = (B-o) * s
    % o = max(B) and s = dR / (max(B) - min(B)).  dR = [2, 8].
    offset = max(max(base));
    scale = dR / (max(max(base)) - min(min(base)));
    modified_base = (base - offset) * scale;

    % Reconstruct the log intensity.  O = 2^(B' + D)
    reconstructed_intensity = pow2(modified_base + detail_layer);

    % Put back the colors:  R', G', B' = O * (R/I, G/I, B/I)
    result(:,:,1) = reconstructed_intensity .* chrominance_red;
    result(:,:,2) = reconstructed_intensity .* chrominance_green;
    result(:,:,3) = reconstructed_intensity .* chrominance_blue;

    % Apply gamma compression.  Try result^0.5 (gamma = 0.5) or use simple global intensity scaling.
    result = result .^ gamma;
    
    % Plot results.
%     plot_results(directory, intensity, detail_layer);
end

function plot_results(directory, intensity, detail_layer)
    h1 = figure;
    imagesc(intensity);
    set(h1,'PaperUnits','inches','PaperPosition',[0 0 5 3]);
    saveas(h1, ['output/' directory '_intensity.jpg']);
    
    h2 = figure;
    imshow(detail_layer);
    set(h2,'PaperUnits','inches','PaperPosition',[0 0 5 3]);
    saveas(h2, ['output/' directory '_detail_layer.jpg']);
end