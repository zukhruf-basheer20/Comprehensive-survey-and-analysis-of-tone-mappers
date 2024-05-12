function result = apply_tonemap(hdr_img, luminance_map, display_luminance)
    [height, width, num_channels] = size(hdr_img);
    result = zeros(height, width, num_channels);
    for ch = 1 : num_channels
        result(:,:,ch) = ((hdr_img(:,:,ch) ./ luminance_map)) .* display_luminance;
    end
end